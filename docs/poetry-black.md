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


## Workflow triggers

If your project requires pull requests for all changes and Black does not need to run on any and every change pushed to your repository, it may make sense to limit the [`on`](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#on) keyword to `pull_request`.

When `on` is used with more than one event and multiple of these events coincide, they will trigger multiple workflows in parallel. See [GitHub workflow syntax docs](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#using-multiple-events).

To further limit event triggers to only specific files, the `path` keyword can be used like so:

```yml
on:
  pull_request:
    paths:
      - "**.py"
```
