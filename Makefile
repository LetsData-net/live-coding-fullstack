SHELL := /bin/bash

VENV ?= .venv
PYTHON ?= python3
PIP := $(VENV)/bin/pip

FRONTEND_DIR := frontend
DB_PATH ?= db.sqlite
DB_INIT_SQL ?= sql/init.sql

.PHONY: install install-python install-frontend db-reset db-init backend frontend dev up

install: install-python install-frontend db-reset

install-python:
	$(PYTHON) -m venv "$(VENV)"
	"$(PIP)" install -r requirements.txt

install-frontend:
	cd "$(FRONTEND_DIR)" && npm ci

db-reset:
	rm -f "$(DB_PATH)"
	sqlite3 "$(DB_PATH)" < "$(DB_INIT_SQL)"

db-init:
	@if [ ! -f "$(DB_PATH)" ]; then \
		sqlite3 "$(DB_PATH)" < "$(DB_INIT_SQL)"; \
	else \
		echo "DB already exists at $(DB_PATH). Use 'make db-reset' to recreate."; \
	fi

backend:
	"$(VENV)/bin/uvicorn" main:app --reload --port 8000

frontend:
	cd "$(FRONTEND_DIR)" && npm run dev

dev:
	$(MAKE) -j2 backend frontend

up: install dev
