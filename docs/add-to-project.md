# Documentation for `add-to-project.yml` workflow

[add-to-project.yml](../.github/workflows/add-to-project.yml) is a reusable GitHub workflow which adds a repository's issues and/or PRs to a GitHub Project.

It only works for [v2 projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/about-projects), not [classic projects](https://docs.github.com/en/issues/organizing-your-work-with-project-boards/managing-project-boards/about-project-boards).

## How to use

To reuse the workflow, create a new workflow file in each repository whose tickets should get auto-added to your project.

Example config for adding every newly opened issue:


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
      PROJECT_NUM: ${{ vars.GH_PROJECT_NUM }}
```

### Required settings

* `RELEASE_VERSION` needs to be set to a valid prosnet-workflows [release tag](https://github.com/acdh-oeaw/prosnet-workflows/releases), branch name or SHA.
* `ADD_TO_PROJECT_TOKEN` refers to a personal access token which you need to store in your repository's **actions secrets**. In the example, the secret it gets set to is assumed to have the same name (`secrets.ADD_TO_PROJECT_TOKEN`).
* `PROJECT_NUM` needs to be set to the _number_ of the GitHub Project within the organisation (the last segment in the URL https://github.com/orgs/YOUR-ORG/projects/X/; not the same as the project ID). It's an integer, and in the example was saved in an _actions variable_ named `GH_PROJECT_NUM`.



### Optional settings

Optional additional variables include:
* `project-org`: The name of the organisation account which owns the project. Only needed for projects which belong to a different organisation than [acdh-oeaw](https://github.com/orgs/acdh-oeaw/).
* `labeled`: A comma-separated list of labels to limit the tickets to which the workflow should be applied.
* `label-operator`: The operator to use with `labeled`. Can be one of: `AND`, `OR`, `NOT` (defaults to `OR`).

To include any of the optional settings, add them after the project number under the `with` keyword at the end of your config:

```yml
...
    with:
      PROJECT_NUM: ...
      labeled: "bug, feature, feature-request"
```

For more details and examples on how to customise the action, see 
[actions/add-to-project](https://github.com/actions/add-to-project).


**Other configurations**

The `name` of your workflow can be whatever makes sense to you. It's how the workflow will show up in the "Actions" tab. 


## Credentials

### GitHub Personal Access Token

You need a personal access token to make use of this workflow.

It needs to be created by/for the GitHub organisation account to which the project belongs and should be a **_fine-grained_ access token** rather than a classic token for more restrictive permission settings.

A fine-grained token needs _write_ permissions for _organization projects_ as well as _read_ permissions for _issues_. Limit read access to only relevant repositories by choosing the "Only select repositories" option during token creation.


### Actions variables and secrets

The personal access token ought to be added to the executing repository's **actions secrets** for safekeeping. Point `ADD_TO_PROJECT_TOKEN` to it.

The project number referred to by `PROJECT_NUM` is a less sensible piece of data; it can go into the repository's **actions variables** (or perhaps even directly into the workflow file).


## Background information

The new GitHub Projects include a neat built-in ["auto-add" workflow](https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project/adding-items-automatically) which can be used to automatically add repository items to a project.

For free GitHub accounts, however, this feature is limited to only one repository. This means that for projects which track tickets across multiple repositories, all remaining issues/PRs need to be added manually, which can easily lead to tickets _not_ getting added by accident.

The original **actions/add-to-project** workflow this reusable workflow builds on fixes this problem.
