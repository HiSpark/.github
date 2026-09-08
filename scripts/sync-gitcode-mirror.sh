#!/usr/bin/env bash
set -euo pipefail

repository="${1:?repository name is required}"
owner="${GITHUB_OWNER:-HiSpark}"

retry() {
  local attempt=1
  local max_attempts=4
  local delay=10

  until "$@"; do
    if (( attempt >= max_attempts )); then
      echo "Command failed after ${max_attempts} attempts: $*" >&2
      return 1
    fi
    echo "Command failed; retrying in ${delay}s (attempt $((attempt + 1))/${max_attempts}): $*" >&2
    sleep "${delay}"
    attempt=$((attempt + 1))
    delay=$((delay * 2))
  done
}

case "${repository}" in
  hi_aiot_solution|hi_aiot_solution_vendor)
    echo "Skipping ${repository}: GitCode contains regular Git blobs above GitHub's 100 MB file limit."
    exit 0
    ;;
esac

source_url="https://gitcode.com/HiSpark/${repository}.git"
target_url="https://github.com/${owner}/${repository}.git"
work_dir="${RUNNER_TEMP:-/tmp}/hispark-mirror-${repository}"
source_refs="${work_dir}.source-refs"
target_refs="${work_dir}.target-refs"

rm -rf "${work_dir}" "${source_refs}" "${target_refs}"
trap 'rm -rf "${work_dir}" "${source_refs}" "${target_refs}"' EXIT

retry git -c http.version=HTTP/1.1 ls-remote --heads --tags "${source_url}" \
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

gh auth setup-git
retry git -c http.version=HTTP/1.1 ls-remote --heads --tags "${target_url}" \
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

git init --bare "${work_dir}"
git -C "${work_dir}" remote add source "${source_url}"
git -C "${work_dir}" remote add github "${target_url}"

retry git -C "${work_dir}" -c http.version=HTTP/1.1 fetch --force --prune --no-tags source \
  '+refs/heads/*:refs/heads/*' \
  '+refs/tags/*:refs/tags/*'

retry git -C "${work_dir}" -c http.version=HTTP/1.1 fetch --force --no-tags --filter=blob:none github \
  '+refs/heads/*:refs/mirror/github/heads/*' \
  '+refs/tags/*:refs/mirror/github/tags/*'

has_lfs=false
mapfile -t source_commits < <(
  git -C "${work_dir}" for-each-ref --format='%(objectname)' refs/heads refs/tags \
    | LC_ALL=C sort -u
)
mapfile -t source_ref_names < <(
  git -C "${work_dir}" for-each-ref --format='%(refname)' refs/heads refs/tags \
    | LC_ALL=C sort -u
)
while IFS= read -r commit; do
  if git -C "${work_dir}" show "${commit}:.gitattributes" 2>/dev/null | grep -q 'filter=lfs'; then
    has_lfs=true
    break
  fi
done < <(printf '%s\n' "${source_commits[@]}")

if [[ "${has_lfs}" == true ]]; then
  git -C "${work_dir}" lfs install --local
  # Restrict LFS scans to GitCode refs. The GitHub preservation refs are a
  # partial clone and intentionally omit blobs, so scanning every local ref
  # makes Git LFS report "Could not scan for Git LFS files".
  if ! retry git -C "${work_dir}" lfs fetch source "${source_ref_names[@]}"; then
    git -C "${work_dir}" lfs logs last || true
    exit 1
  fi
  if ! retry git -C "${work_dir}" lfs push github "${source_ref_names[@]}"; then
    git -C "${work_dir}" lfs logs last || true
    exit 1
  fi
fi

retry git -C "${work_dir}" -c http.version=HTTP/1.1 push --force github \
  'refs/heads/*:refs/heads/*' \
  'refs/tags/*:refs/tags/*'

retry git -c http.version=HTTP/1.1 ls-remote --heads --tags "${target_url}" \
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
