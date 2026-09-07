# HiSpark mirror sync

The central workflow in [`HiSpark/.github`](https://github.com/HiSpark/.github)
synchronizes every public repository under
[`GitCode/HiSpark`](https://gitcode.com/HiSpark) to the repository with the same
name under [`GitHub/HiSpark`](https://github.com/HiSpark).

- Schedule: every 6 hours and manual dispatch.
- Source of truth: GitCode.
- Scope: branches, tags, commit history, and Git LFS objects.
- New public GitCode repositories: reported for manual creation on GitHub.
- Excluded: `hi_aiot_solution_vendor` because GitHub rejected files above its
  normal Git push limit.

The workflow compares remote references before cloning, so unchanged
repositories finish without transferring repository objects. When a repository
has changed, GitCode branches and tags are updated on GitHub. GitHub-only
branches and tags are preserved.

A repository-limited GitHub App supplies cross-repository write access. The App
has only **Contents: read and write** permission and is installed only on mirror
repositories.
