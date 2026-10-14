LAB ?=
PYTHON ?= python3
TIMEOUT ?= 1800

CI_EXTRA :=

PRE_COMMIT_CONFIG := .config/.pre-commit-config.yaml
NOTEBOOKS = $(sort $(wildcard $(if $(LAB),$(LAB),lab*)/lab*.ipynb))
NBCONVERT = $(PYTHON) -m jupyter nbconvert --to notebook --execute \
	--ExecutePreprocessor.timeout=$(TIMEOUT)

export PYTHONPYCACHEPREFIX := $(CURDIR)/build/pycache

-include .config/local.mk

.DEFAULT_GOAL := help

.PHONY: help setup run test format lint ci clean

help:
	@echo "make run      LAB=labN   execute labN/labN.ipynb into build/artifacts/notebooks"
	@echo "make test                execute every notebook into build/artifacts/notebooks"
	@echo "make format              apply all formatters"
	@echo "make lint                pre-commit hooks"
	@echo "make ci                  everything CI runs"
	@echo "make clean               remove build outputs"

setup:
	pre-commit install -c $(PRE_COMMIT_CONFIG)

run:
	@test -n "$(LAB)" || (echo "LAB is required" >&2; exit 2)
	$(MAKE) test LAB=$(LAB)

test:
	@test -n "$(NOTEBOOKS)" || (echo "no notebooks found" >&2; exit 2)
	mkdir -p build/artifacts/notebooks
	$(NBCONVERT) --output-dir build/artifacts/notebooks $(NOTEBOOKS)

format:
	-pre-commit run -c $(PRE_COMMIT_CONFIG) --all-files

lint:
	pre-commit run -c $(PRE_COMMIT_CONFIG) --all-files --show-diff-on-failure

ci: lint test $(CI_EXTRA)

clean:
	rm -rf build
