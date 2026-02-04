# UV Environment Setup for Data Engineering Zoomcamp

This document provides guidance on using UV (Universal Python Package Installer) for managing dependencies in this data engineering repository.

## Overview

UV is a fast Python package resolver and installer that helps manage dependencies more efficiently than pip. This repository is configured to support all modules in the Data Engineering Zoomcamp using UV.

## Basic Commands

### Environment Management
```bash
# Sync base dependencies (always run first)
uv sync

# Sync with specific dependency groups
uv sync --group dev                    # Development tools only
uv sync --group streaming              # Streaming dependencies  
uv sync --group warehouse              # Data warehouse tools
uv sync --group analytics             # dbt and analytics tools
uv sync --group orchestration         # Prefect workflow tools

# Sync multiple groups
uv sync --group dev --group streaming

# Add new dependencies
uv add pandas numpy                    # Add to main dependencies
uv add --group dev pytest            # Add to dev group
uv add --group streaming kafka-python # Add to streaming group
```

### Running Scripts
```bash
# Run Python scripts using the virtual environment
uv run python script.py

# Run specific programs
uv run jupyter lab                     # Start Jupyter Lab
uv run pytest                         # Run tests
uv run black .                         # Format code
uv run ruff check .                    # Lint code
```

### Working with Jupyter
```bash
# Install Jupyter kernel for the environment
uv run python -m ipykernel install --user --name data-engineering-zoomcamp

# Start Jupyter Lab
uv run jupyter lab
```

## Week-by-Week Setup

### Week 1: Docker & Terraform
```bash
uv sync --group docker
# Docker commands work with system Docker installation
```

### Week 2: Workflow Orchestration
```bash
uv sync --group orchestration
uv run python flows/your_flow.py
```

### Week 3: Data Warehouse
```bash
uv sync --group warehouse
# Work with BigQuery and dbt
```

### Week 4: Analytics Engineering
```bash
uv sync --group analytics
uv run dbt run
uv run dbt test
```

### Week 5: Batch Processing
```bash
uv sync --group batch
# Note: For PySpark, you may need additional setup
# Install Spark separately: https://spark.apache.org/downloads.html
```

### Week 6: Streaming
```bash
uv sync --group streaming
uv run python streaming_script.py
```

## Environment Information

The UV environment is configured to use Python >= 3.11 and includes:

**Base Dependencies:**
- pandas, numpy - Data processing
- psycopg2-binary, sqlalchemy - Database connectivity  
- jupyter, ipykernel - Notebook support
- click, tqdm, requests - Utilities

**Development Tools:**
- pytest - Testing
- black - Code formatting
- ruff - Fast linting
- pgcli - PostgreSQL CLI

## Troubleshooting

### Virtual Environment Location
UV creates a virtual environment at `.venv/` in the project root.

### Activate Environment Manually (if needed)
```bash
source .venv/bin/activate  # On macOS/Linux
# or 
.venv\Scripts\activate     # On Windows
```

### Reset Environment
```bash
rm -rf .venv
uv sync
```

### Add Missing Dependencies
```bash
# Add to main dependencies
uv add package-name

# Add to specific group
uv add --group streaming package-name
```

### Check Environment Status
```bash
uv tree           # Show dependency tree
uv list           # List installed packages
```

## Integration with IDEs

### VS Code
1. Open the repository in VS Code
2. Select Python interpreter: `.venv/bin/python`
3. Install Python extension if not already installed

### PyCharm
1. File → Settings → Project → Python Interpreter
2. Add interpreter → Existing environment
3. Select `.venv/bin/python`

## Best Practices

1. **Always run `uv sync` after pulling changes** that might have updated `pyproject.toml`
2. **Use dependency groups** to install only what you need for each week
3. **Pin versions** for production-like stability
4. **Use `uv run`** instead of activating the environment manually
5. **Commit `uv.lock`** to ensure reproducible environments across team members