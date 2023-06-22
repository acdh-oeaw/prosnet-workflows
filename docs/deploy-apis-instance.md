# `deploy-apis-instance.yml`

Deploy an APIS instance on the default cluster. Use like this:

```yml
name: deploy
on:
  push:

jobs:
  deploy:
    uses: acdh-oeaw/prosnet-workflows/.github/workflows/deploy-apis-instance.yml@dev
    secrets: inherit
```

The repository running this workflow has to contain two things:
* a `pyproject.toml` file 
* a `wsgi.py` file

The `pyproject.toml` file should contain the definition of your APIS setup, i.e. something like this:
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
installed. In this case this should also be part of the repository - but it
could also be located somewhere else.

The `wsgi.py` is used by gunicorn to start the APIS instance. A simple one could look like this (which is basically the default from Djangos `startproject`):

```python
import os
from django.core.wsgi import get_wsgi_application
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'apis_ontology.settings.server_settings')
application = get_wsgi_application()
```

For the workflow to work, you have to set some environment variables and secrets in the repository (*Settings* -> *Secrets and variables* -> *Actions*):

Variables:
* `APP_NAME`
* `KUBE_NAMESPACE`
* `PUBLIC_URL`
* `SERVICE_ID`
