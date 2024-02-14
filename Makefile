# Makefile for Py runtime environs
DEVOPS_DOMAIN = "dev.azure.com"
DEVOPS_ORGANISATION = "bowdata"
VIRTUALENV_NAME = ".venv"

#.ONESHELL:

develop:
#	python -m pip install -U pip
#	pip install virtualenv
#	virtualenv $(VIRTUALENV_NAME)
#	source $(VIRTUALENV_NAME)/bin/activate
	pip install -U pip setuptools
	pip install poetry
	pip install artifacts-keyring
	git config --global url."https://$(DEVOPS_ORGANISATION)\:$(AZURE_DEVOPS_PAT)\@$(DEVOPS_DOMAIN)/$(DEVOPS_ORGANISATION)".insteadOf "https://$(DEVOPS_ORGANISATION)\@$(DEVOPS_DOMAIN)/$(DEVOPS_ORGANISATION)"
	poetry source add --priority=supplemental bowdata "https://pkgs.$(DEVOPS_DOMAIN)/$(DEVOPS_ORGANISATION)/_packaging/$(DEVOPS_ORGANISATION)/pypi/simple/"
	poetry cache clear --no-interaction --all .
	poetry install --no-cache --with dev

lint:
	poetry install --only lint
	poetry run python -c "import os; a = 1 if os.path.exists('test-reports') else os.makedirs('test-reports')"
	poetry run flake8 src/ --docstring-convention google --show-source --format xml --output-file test-reports/lint-results.xml --exit-zero
	poetry run flake8 src/ --docstring-convention google

test:
	poetry cache clear --no-interaction --all .
	poetry install --no-cache --with test
	poetry export -f requirements.txt --output frozen_requirements.txt
	poetry run python -c "import os; a = 1 if os.path.exists('test-reports') else os.makedirs('test-reports')"
	poetry run pytest -rs tests --junitxml=test-reports/test-results.xml

setup_version:
	poetry init

build:
	poetry build

publish:
	poetry publish

docs:
	poetry install --only docs
	poetry run python -c "import os; a = 1 if os.path.exists('docs/source') else os.makedirs('docs/source')"
	poetry run python -c "import os; a = 1 if os.path.exists('docs/html') else os.makedirs('docs/html')"
	poetry run python -m sphinx -b html -a docs/source docs/html

.PHONY: setup_version develop lint test build release docs
