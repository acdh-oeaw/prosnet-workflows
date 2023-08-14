# `deploy-apis-instance.yml`

Deploy an APIS instance on the default cluster. Use like this:

```yml
name: deploy
on:
  push:
    # Run deployment only on pushes to main, not other branches
    branches: [main]
    # Allows you to run this workflow manually from the Actions tab or through HTTP API
    workflow_dispatch:

jobs:
  deploy:
    uses: acdh-oeaw/prosnet-workflows/.github/workflows/deploy-apis-instance.yml@v0.0.1
    secrets: inherit
```
It uses the [APIS Base Container](https://github.com/acdh-oeaw/apis-base-container/) for deployment.

The repository running this workflow has to contain one file:
* a `pyproject.toml` file 

The `pyproject.toml` file should contain the definition of your APIS setup, i.e. something like this (this is **only an example**!):
```toml
[tool.poetry]
name = "some-apis-instance"
version = "0.1.0"
description = "Some APIS instance"
authors = ["Jane Doe"]
license = "MIT"
packages = [{include = "apis_ontology"}]

[tool.poetry.dependencies]
python = ">=3.11,<3.12"
django = ">=4.1,<4.2"
apis-core = { git = "https://github.com/acdh-oeaw/apis-core-rdf.git", branch = "main"  }
webpage = { git = "https://github.com/acdh-oeaw/apis-webpage.git", branch = "main" }

[build-system]
requires = ["poetry-core>=1.0.0"]
build-backend = "poetry.core.masonry.api"
```

The `pyprojec.toml` above lists a package `apis_ontology` that should be
installed. In this example it points to a folder, therefore this folder should
also be part of the repository - but it could also be located somewhere else.
Its a Python module like any other, with the limitation that is has to called
`apis_ontology` (thats a bug in `apis_core` that waits to be fixed...)


For the workflow to work, you have to set some environment variables and secrets in the repository (*Settings* -> *Secrets and variables* -> *Actions*):

Variables needed for deployment to work:
* `APP_NAME`: The name of your instance - you can set it to whatever, the suggestion is to use the application name without the `apis-instance-` prefix
* `KUBE_NAMESPACE`: The namespace your application should be deployed to - has to exist in rancher
* `PUBLIC_URL`: The endpoint your service should listen to
* `SERVICE_ID`: This is the services issue ID in the internal redmine - you have to create that service issue beforehand
* `DJANGO_SETTINGS_MODULE`: This points to your Django settings. There is no default. See [the upstream documentation for details](https://docs.djangoproject.com/en/4.2/topics/settings/#envvar-DJANGO_SETTINGS_MODULE)
