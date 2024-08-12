# Documentation for `poetry-ruff.yml` workflow

[poetry-ruff.yml](../.github/workflows/poetry-ruff.yml) is a reusable GitHub workflow for the [Ruff](https://docs.astral.sh/ruff/) linter and code formatter for Python.


## How to use

The Ruff workflow can be used for either [linting](https://docs.astral.sh/ruff/linter/) or [formatting](https://docs.astral.sh/ruff/formatter/) – or both.

If you need only one of these, create one new workflow file in all repositories whose files should get inspected by Ruff. If you need both, create two separate new workflow files.

Ruff differentiates between formatting and linting based on arguments with which it is called. When not configured otherwise, the parent Prosnet workflow defaults to _linting_.


The following example config runs the [Ruff linter](https://docs.astral.sh/ruff/formatter/) on all pull requests:

```yml
name: Run Ruff linter

on: pull_request

jobs:
  ruff-linter:
    uses: acdh-oeaw/prosnet-workflows/.github/workflows/poetry-ruff.yml@RELEASE_VERSION
    with:
      src: "."
```


This second examples runs the [Ruff formatter](https://docs.astral.sh/ruff/formatter/) on all PRs:

```yml
name: Run Ruff formatter

on: pull_request

jobs:
  ruff-formatter:
    uses: acdh-oeaw/prosnet-workflows/.github/workflows/poetry-ruff.yml@RELEASE_VERSION
    with:
      src: "."
      options: "format --check"
```

### Required settings

* `RELEASE_VERSION` needs to be set to a valid prosnet-workflows [release tag](https://github.com/acdh-oeaw/prosnet-workflows/releases), branch name or SHA.
* `src` refers to the path from which Ruff will work its way down the hierarchical file structure. The example uses `"."`, the current working directory, which may serve you best. Only change it if you need Ruff to start from a different directory instead.


### Optional settings

The following optional variables can be added to the `with` section of the config:

* `options`: Arguments with which to run `poetry run ruff`. Default is `check`, which runs Ruff as linter. Set this explicitly to override the default, e.g. use `format` to run Ruff as code formatter. See the Ruff [linter](https://docs.astral.sh/ruff/linter/) and [formatter](https://docs.astral.sh/ruff/formatter/) docs for details on more fine-grained settings.
* `python-version`: The Python version for which to set up Poetry, which is used to run Ruff. For APIS projects, the prosnet-workflows default should work best.

### Additional notes

If you use two Ruff workflows in the same repository, take care to use different `name`s, job names and file names for easier differentiation between the workflows and individual workflow runs.
