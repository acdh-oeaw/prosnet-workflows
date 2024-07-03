# Documentation for `gitlint.yml` workflow

[gitlint.yml](https://github.com/acdh-oeaw/prosnet-workflows/.github/workflows/gitlint.yml) is a reusable GitHub workflow for linting Git commit messages with [Gitlint](https://jorisroovers.com/gitlint/latest/).


## How to use

Create a new workflow file in all repositories whose Git commit messages should get linted with Gitlint.

The following example config runs the workflow on all pull requests which target the containing repository's default branch:

```yml
name: Run Gitlint

on: 
  pull_request:

jobs:
  gitlint:
    uses: acdh-oeaw/prosnet-workflows/.github/workflows/gitlint.yml@RELEASE_VERSION
    with:
      basebranch: ${{ github.event.repository.default_branch }}
```


### Required settings

* `RELEASE_VERSION` needs to be set to a valid prosnet-workflows [release tag](https://github.com/acdh-oeaw/prosnet-workflows/releases), branch name or SHA.

### Optional settings

The following optional variables can be added to the `with` section:

* `arguments`:
* `basebranch`:
* `comment`:
* `contrib`:
* `ignore`:
