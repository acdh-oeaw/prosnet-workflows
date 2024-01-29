# Documentation for `poetry-black.yml` workflow

[poetry-black.yml](../.github/workflows/poetry-black.yml) is a reusable GitHub workflow for the [Black](https://black.readthedocs.io/en/stable/) code formatter for Python.


## How to use

Create a new workflow file in all repositories whose files should get formatted with Black.

The following example config runs Black on all pull requests:

```yml
name: Run Black code formatter

on: pull_request

jobs:
  poetry-black:
    uses: acdh-oeaw/prosnet-workflows/.github/workflows/poetry-black.yml@RELEASE_VERSION
    with:
      src: "."
```

### Required settings

* `RELEASE_VERSION` needs to be set to a valid prosnet-workflows [release tag](https://github.com/acdh-oeaw/prosnet-workflows/releases), branch name or SHA.
* `src` refers to the path from which Black will work its way down the hierarchical file structure. The example uses `"."`, the current working directory, which may serve you best. Only change it if you need Black to start from a different directory instead.


### Optional settings

The following optional variables can be added to the `with` section of the config:

* `python-version`: The Python version for which to set up Poetry, which is used to run Black. For APIS projects, the prosnet-workflows default should work best.
* `options`: Arguments with which to run `poetry run black`, see Black [command line options](https://black.readthedocs.io/en/stable/usage_and_configuration/the_basics.html#command-line-options). If you set this variable, it will override the prosnet-workflows defaults.

**Other configurations**

The `name` of your workflow can be whatever makes sense to you. It's how the workflow will show up in the "Actions" tab.
