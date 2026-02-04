# Data Engineering Zoomcamp - UV Environment
# Common tasks for managing the UV environment and running various tools

.PHONY: help setup sync-all sync-dev sync-week1 sync-week2 sync-week3 sync-week4 sync-week5 sync-week6 
.PHONY: jupyter lab test format lint clean reset-env check-env

# Default target
help:
	@echo "Data Engineering Zoomcamp UV Environment"
	@echo ""
	@echo "Available commands:"
	@echo "  setup        - Initial setup (sync base dependencies)"
	@echo "  sync-all     - Install all dependencies"
	@echo "  sync-dev     - Install development dependencies only"
	@echo "  sync-week1   - Docker & Terraform week"
	@echo "  sync-week2   - Workflow Orchestration (Prefect)"
	@echo "  sync-week3   - Data Warehouse (BigQuery)"
	@echo "  sync-week4   - Analytics Engineering (dbt)"
	@echo "  sync-week5   - Batch Processing (Spark)"
	@echo "  sync-week6   - Streaming (Kafka)"
	@echo "  jupyter      - Start Jupyter Lab"
	@echo "  lab          - Alias for jupyter"
	@echo "  test         - Run tests"
	@echo "  format       - Format code with Black"
	@echo "  lint         - Lint code with Ruff"
	@echo "  clean        - Clean cache and temporary files"
	@echo "  reset-env    - Reset virtual environment"
	@echo "  check-env    - Show environment information"

# Setup and sync targets
setup:
	@echo "Setting up UV environment with base dependencies..."
	uv sync

sync-all:
	@echo "Installing all dependencies..."
	uv sync --group dev --group docker --group orchestration --group warehouse --group analytics --group batch --group streaming

sync-dev:
	@echo "Installing development dependencies..."
	uv sync --group dev

sync-week1:
	@echo "Setting up Week 1: Docker & Terraform..."
	uv sync --group docker --group dev

sync-week2:
	@echo "Setting up Week 2: Workflow Orchestration..."
	uv sync --group orchestration --group dev

sync-week3:
	@echo "Setting up Week 3: Data Warehouse..."
	uv sync --group warehouse --group dev

sync-week4:
	@echo "Setting up Week 4: Analytics Engineering..."
	uv sync --group analytics --group dev

sync-week5:
	@echo "Setting up Week 5: Batch Processing..."
	uv sync --group batch --group dev
	@echo "Note: You may need to install Apache Spark separately"

sync-week6:
	@echo "Setting up Week 6: Streaming..."
	uv sync --group streaming --group dev

# Development tools
jupyter:
	@echo "Starting Jupyter Lab..."
	uv run jupyter lab

lab: jupyter

test:
	@echo "Running tests..."
	uv run pytest

format:
	@echo "Formatting code with Black..."
	uv run black .

lint:
	@echo "Linting code with Ruff..."
	uv run ruff check .

# Maintenance
clean:
	@echo "Cleaning cache and temporary files..."
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type f -name ".coverage" -delete
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".ruff_cache" -exec rm -rf {} +

reset-env:
	@echo "Resetting virtual environment..."
	rm -rf .venv
	uv sync

check-env:
	@echo "Environment information:"
	@echo "UV version: $(shell uv --version)"
	@echo "Python version: $(shell uv run python --version)"
	@echo "Virtual environment: $(PWD)/.venv"
	@echo ""
	@echo "Installed packages:"
	uv tree --depth 1