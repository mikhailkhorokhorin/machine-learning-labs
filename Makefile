LAB ?=
ifeq ($(OS),Windows_NT)
PYTHON ?= python
else
PYTHON ?= python3
endif
TIMEOUT ?= 1800

CI_EXTRA :=

PRE_COMMIT_CONFIG := .config/.pre-commit-config.yaml
MKDIR = $(PYTHON) -c "import pathlib, sys; [pathlib.Path(p).mkdir(parents=True, exist_ok=True) for p in sys.argv[1:]]"
RMDIR = $(PYTHON) -c "import shutil, sys; [shutil.rmtree(p, ignore_errors=True) for p in sys.argv[1:]]"
NOTEBOOKS = $(sort $(wildcard $(if $(LAB),$(LAB),lab*)/solution.ipynb))
NBCONVERT = $(PYTHON) -m jupyter nbconvert --to notebook --execute \
	--ExecutePreprocessor.timeout=$(TIMEOUT)

define execute
$(MKDIR) build/artifacts/notebooks/$(patsubst %/,%,$(dir $(1)))
$(NBCONVERT) --output-dir build/artifacts/notebooks/$(patsubst %/,%,$(dir $(1))) $(1)

endef

export PYTHONPYCACHEPREFIX := $(CURDIR)/build/pycache

-include .config/local.mk

.DEFAULT_GOAL := help

.PHONY: help setup run test format lint ci clean

help:
	@echo "make run      LAB=labN   execute labN/solution.ipynb into build/artifacts/notebooks/labN"
	@echo "make test                execute every notebook into build/artifacts/notebooks"
	@echo "make format              apply all formatters"
	@echo "make lint                pre-commit hooks"
	@echo "make ci                  everything CI runs"
	@echo "make clean               remove build outputs"

setup:
	pre-commit install -c $(PRE_COMMIT_CONFIG)

run:
	@$(if $(LAB),,$(error LAB is required: make run LAB=lab1))
	$(MAKE) test LAB=$(LAB)

test:
	@$(if $(NOTEBOOKS),,$(error no notebooks found))
	$(foreach notebook,$(NOTEBOOKS),$(call execute,$(notebook)))

format:
	-pre-commit run -c $(PRE_COMMIT_CONFIG) --all-files

lint:
	pre-commit run -c $(PRE_COMMIT_CONFIG) --all-files --show-diff-on-failure

ci: lint test $(CI_EXTRA)

clean:
	$(RMDIR) build
