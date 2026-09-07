#!/usr/bin/env bash
set -euo pipefail

repository="${1:?repository name is required}"
owner="${GITHUB_OWNER:-HiSpark}"

if [[ "${repository}" == "hi_aiot_solution_vendor" ]]; then
  echo "Skipping ${repository}: GitHub rejected files above the normal push limit."
  exit 0
fi

source_url="https://gitcode.com/HiSpark/${repository}.git"
target_url="https://github.com/${owner}/${repository}.git"
work_dir="${RUNNER_TEMP:-/tmp}/hispark-mirror-${repository}"
source_refs="${work_dir}.source-refs"
target_refs="${work_dir}.target-refs"

rm -rf "${work_dir}" "${source_refs}" "${target_refs}"
trap 'rm -rf "${work_dir}" "${source_refs}" "${target_refs}"' EXIT

git ls-remote --heads --tags "${source_url}" \
  | awk '$2 !~ /\^\{\}$/ {print}' \
  | LC_ALL=C sort > "${source_refs}"

if [[ ! -s "${source_refs}" ]]; then
  echo "Source returned no branches or tags; refusing to modify GitHub."
  exit 1
fi

if ! gh api "repos/${owner}/${repository}" >/dev/null 2>&1; then
  echo "GitHub repository ${owner}/${repository} does not exist; create it manually."
  exit 1
fi

git ls-remote --heads --tags "${target_url}" \
  | awk '$2 !~ /\^\{\}$/ {print}' \
  | LC_ALL=C sort > "${target_refs}"

needs_sync=false
while read -r source_sha source_ref; do
  target_sha="$(awk -v ref="${source_ref}" '$2 == ref {print $1}' "${target_refs}")"
  if [[ "${source_sha}" != "${target_sha}" ]]; then
    needs_sync=true
    break
  fi
done < "${source_refs}"

if [[ "${needs_sync}" == false ]]; then
  echo "${repository} is already synchronized."
  exit 0
fi

gh auth setup-git
git init --bare "${work_dir}"
git -C "${work_dir}" remote add source "${source_url}"
git -C "${work_dir}" remote add github "${target_url}"

git -C "${work_dir}" fetch --force --no-tags --filter=blob:none github \
  '+refs/heads/*:refs/mirror/github/heads/*' \
  '+refs/tags/*:refs/mirror/github/tags/*'

git -C "${work_dir}" fetch --force --prune --no-tags source \
  '+refs/heads/*:refs/heads/*' \
  '+refs/tags/*:refs/tags/*'

has_lfs=false
while IFS= read -r commit; do
  if git -C "${work_dir}" show "${commit}:.gitattributes" 2>/dev/null | grep -q 'filter=lfs'; then
    has_lfs=true
    break
  fi
done < <(git -C "${work_dir}" for-each-ref --format='%(objectname)' refs/heads refs/tags)

if [[ "${has_lfs}" == true ]]; then
  git -C "${work_dir}" lfs install --local
  git -C "${work_dir}" lfs fetch --all source
  git -C "${work_dir}" lfs push --all github
fi

git -C "${work_dir}" push --force github \
  'refs/heads/*:refs/heads/*' \
  'refs/tags/*:refs/tags/*'

git ls-remote --heads --tags "${target_url}" \
  | awk '$2 !~ /\^\{\}$/ {print}' \
  | LC_ALL=C sort > "${target_refs}"

while read -r source_sha source_ref; do
  target_sha="$(awk -v ref="${source_ref}" '$2 == ref {print $1}' "${target_refs}")"
  if [[ "${source_sha}" != "${target_sha}" ]]; then
    echo "Verification failed for ${source_ref}: source=${source_sha}, target=${target_sha:-missing}"
    exit 1
  fi
done < "${source_refs}"
echo "${repository} synchronized and verified."
