# Documentation for `add-to-project.yml` workflow

[add-to-project.yml](../.github/workflows/add-to-project.yml) is a reusable GitHub workflow which adds a repository's issues and/or PRs to a GitHub Project.

Note that the workflow can only be used with new GitHub [Projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/about-projects), not [projects (classic)](https://docs.github.com/en/issues/organizing-your-work-with-project-boards/managing-project-boards/about-project-boards).

## How to use

Create a new workflow file in each repository whose tickets should get auto-added to your project.

The following example config adds every newly opened issue:


```yml
name: Add repository issues to VERY-FINE-PROJECT 

on:
  issues:
    types:
      - opened

jobs:
  add-to-project:
    uses: acdh-oeaw/prosnet-workflows/.github/workflows/add-to-project.yml@RELEASE_VERSION
    secrets:
      ADD_TO_PROJECT_TOKEN: ${{ secrets.ADD_TO_PROJECT_TOKEN }}
    with:
      PROJECT_NUM: 0
```

### Required settings

* `RELEASE_VERSION` needs to be set to a valid prosnet-workflows [release tag](https://github.com/acdh-oeaw/prosnet-workflows/releases), branch name or SHA.
* `ADD_TO_PROJECT_TOKEN` points to the personal access token which grants access to the relevant project (see below). The example assumes the token to be stored in the form of an identically named actions secret (hence `secrets.ADD_TO_PROJECT_TOKEN`).
* `PROJECT_NUM` needs to be set to the _number_ of the GitHub Project within the organisation, i.e. the last segment in the URL https://github.com/orgs/YOUR-ORG/projects/X/ (not the same as the project _ID_). Replace `0` in the example with a valid integer.


### Optional settings

The following optional variables can be added to the `with` section of the config:

* `project-org`: The name of the organisation account which owns the project. Only needed for projects which belong to a different organisation than [acdh-oeaw](https://github.com/orgs/acdh-oeaw/).
* `labeled`: A comma-separated list of labels to limit which tickets should be considered.
* `label-operator`: The operator to use with `labeled`. Can be one of: `AND`, `OR`, `NOT` (defaults to `OR`).


For more information on how to customise the action further, see [actions/add-to-project](https://github.com/actions/add-to-project).


## Credentials

The workflow requires a personal access token to be set to work.

Create a new [fine-grained access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#fine-grained-personal-access-tokens) for the GitHub organization under which the GitHub Project exists with:
* **write** permissions for _organization projects_,
* **read** permissions for _issues_,

and limit its access to only relevant repositories via the "Only select repositories" option.

Next, add the token as a new **actions secret** to every repository in which the workflow will run. Make sure the secret's name matches whatever `ADD_TO_PROJECT_TOKEN` in the workflow config points to. (Note: unlike variables, secrets cannot retroactively be modified in any way.)


## Relevancy of this workflow vs. built-in workflow

GitHub Projects come with a neat ["auto-add" workflow](https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project/adding-items-automatically) built in, along with several other workflows.

However, on free GitHub accounts, this feature is limited to a single repository per project. Meaning for projects which track issues/PRs across multiple repositories, all remaining tickets will have to be added manually.

The **actions/add-to-project** workflow which this reusable workflow builds on fixes this problem.
