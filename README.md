This an example project for continuous delivery of Python libraries on Azure DevOps. We use `poetry` as the Python environment manager and `Make` as the environment automation tool.

'''Assumptions'''

- The user establishes an Azure DevOps Pipeline and sets the PAT as an environment variable.
- Python and Make are installed.


'''Setting Up For Development'''

Write `make develop`


'''Expected Behaviour'''

On Git push, the Azure DevOps Pipeline will run lint, test and build stages, capturing the Python wheel as an artefact.


'''Notes on `templates`'''

Here we illustrate a templating approach to compose reusable Azure DevOps code.

