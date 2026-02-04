# Standardized Python Repository Setup Guide with UV

This guide walks you through setting up a modern, standardized Python repository using UV for dependency management. This template can be replicated for any Python project.

## Prerequisites

- Git installed
- UV installed (`curl -LsSf https://astral.sh/uv/install.sh | sh` or `brew install uv`)
- Python 3.11+ available on your system

## Step-by-Step Setup

### 1. Initialize Repository Structure

```bash
# Create project directory
mkdir my-python-project
cd my-python-project

# Initialize git
git init

# Create standard directory structure
mkdir -p src/my_python_project
mkdir -p tests
mkdir -p docs
mkdir -p scripts
mkdir -p config
mkdir -p data/{raw,processed,external}
mkdir -p notebooks

# Create essential files
touch README.md
touch CHANGELOG.md
touch LICENSE
touch .env.template
```

### 2. Create pyproject.toml Configuration

```bash
# Create pyproject.toml with comprehensive configuration
cat > pyproject.toml << 'EOF'
[project]
name = "my-python-project"
version = "0.1.0"
description = "A brief description of your project"
readme = "README.md"
license = {file = "LICENSE"}
authors = [
    {name = "Your Name", email = "your.email@example.com"},
]
maintainers = [
    {name = "Your Name", email = "your.email@example.com"},
]
keywords = ["python", "project"]
classifiers = [
    "Development Status :: 4 - Beta",
    "Intended Audience :: Developers",
    "License :: OSI Approved :: MIT License",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.11",
    "Programming Language :: Python :: 3.12",
]
requires-python = ">=3.11"
dependencies = [
    "click>=8.0.0",
    "pydantic>=2.0.0",
    "python-dotenv>=1.0.0",
]

[project.optional-dependencies]
# Optional dependencies for different use cases
api = [
    "fastapi>=0.100.0",
    "uvicorn>=0.20.0",
]
data = [
    "pandas>=2.0.0",
    "numpy>=1.24.0",
    "polars>=0.20.0",
]
ml = [
    "scikit-learn>=1.3.0",
    "mlflow>=2.0.0",
]

[dependency-groups]
# Development dependencies
dev = [
    "pytest>=7.0.0",
    "pytest-cov>=4.0.0",
    "pytest-mock>=3.10.0",
    "black>=23.0.0",
    "ruff>=0.1.0",
    "mypy>=1.5.0",
    "pre-commit>=3.0.0",
]

# Documentation
docs = [
    "mkdocs>=1.5.0",
    "mkdocs-material>=9.0.0",
    "mkdocstrings[python]>=0.20.0",
]

# Testing
test = [
    "pytest>=7.0.0",
    "pytest-cov>=4.0.0",
    "pytest-mock>=3.10.0",
    "pytest-xdist>=3.0.0",
    "tox>=4.0.0",
]

# All optional dependencies
all = ["my-python-project[api,data,ml]"]

[project.urls]
Homepage = "https://github.com/username/my-python-project"
Repository = "https://github.com/username/my-python-project.git"
Documentation = "https://username.github.io/my-python-project/"
Changelog = "https://github.com/username/my-python-project/blob/main/CHANGELOG.md"
Issues = "https://github.com/username/my-python-project/issues"

[project.scripts]
# Console scripts (CLI commands)
my-project = "my_python_project.cli:main"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

# Hatch build configuration
[tool.hatch.build.targets.wheel]
packages = ["src/my_python_project"]

[tool.hatch.version]
path = "src/my_python_project/__init__.py"

# Development tools configuration
[tool.black]
line-length = 88
target-version = ['py311']
include = '\.pyi?$'
exclude = '''
/(
    \.eggs
  | \.git
  | \.hg
  | \.mypy_cache
  | \.tox
  | \.venv
  | _build
  | buck-out
  | build
  | dist
)/
'''

[tool.ruff]
target-version = "py311"
line-length = 88
select = [
    "E",  # pycodestyle errors
    "W",  # pycodestyle warnings
    "F",  # pyflakes
    "I",  # isort
    "B",  # flake8-bugbear
    "C4", # flake8-comprehensions
    "UP", # pyupgrade
]
ignore = [
    "E501",  # line too long, handled by black
    "B008",  # do not perform function calls in argument defaults
]
exclude = [
    ".bzr",
    ".direnv",
    ".eggs",
    ".git",
    ".hg",
    ".mypy_cache",
    ".nox",
    ".pants.d",
    ".ruff_cache",
    ".svn",
    ".tox",
    ".venv",
    "__pypackages__",
    "_build",
    "buck-out",
    "build",
    "dist",
    "node_modules",
    "venv",
]

[tool.ruff.per-file-ignores]
"__init__.py" = ["F401"]
"tests/**/*" = ["S101", "D"]

[tool.mypy]
python_version = "3.11"
check_untyped_defs = true
disallow_any_generics = true
disallow_incomplete_defs = true
disallow_untyped_defs = true
no_implicit_optional = true
no_implicit_reexport = true
strict_equality = true
warn_redundant_casts = true
warn_return_any = true
warn_unreachable = true
warn_unused_configs = true
warn_unused_ignores = true

[[tool.mypy.overrides]]
module = ["tests.*"]
disallow_untyped_defs = false

[tool.pytest.ini_options]
minversion = "7.0"
addopts = [
    "--cov=src/my_python_project",
    "--cov-report=term-missing",
    "--cov-report=html",
    "--cov-report=xml",
    "--strict-markers",
    "--strict-config",
    "--disable-warnings",
]
testpaths = ["tests"]
filterwarnings = [
    "error",
    "ignore::UserWarning",
    "ignore::DeprecationWarning",
]
markers = [
    "slow: marks tests as slow (deselect with '-m \"not slow\"')",
    "integration: marks tests as integration tests",
    "unit: marks tests as unit tests",
]

[tool.coverage.run]
source = ["src"]
branch = true
omit = [
    "*/tests/*",
    "*/test_*.py",
    "*/__main__.py",
]

[tool.coverage.report]
exclude_lines = [
    "pragma: no cover",
    "def __repr__",
    "if self.debug:",
    "if settings.DEBUG",
    "raise AssertionError",
    "raise NotImplementedError",
    "if 0:",
    "if __name__ == .__main__.:",
    "class .*\\bProtocol\\):",
    "@(abc\\.)?abstractmethod",
]
show_missing = true
skip_covered = false

[tool.coverage.html]
directory = "htmlcov"
EOF
```

### 3. Create Package Structure

```bash
# Create main package with __init__.py
cat > src/my_python_project/__init__.py << 'EOF'
"""My Python Project - A template for standardized Python projects."""

__version__ = "0.1.0"
__author__ = "Your Name"
__email__ = "your.email@example.com"
__description__ = "A brief description of your project"

# Package-level imports
from .core import main_function
from .config import settings

__all__ = ["main_function", "settings"]
EOF

# Create core module
cat > src/my_python_project/core.py << 'EOF'
"""Core functionality for the project."""

import logging
from typing import Any, Dict, Optional

logger = logging.getLogger(__name__)


def main_function(data: Dict[str, Any], config: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
    """Main function that does something useful.
    
    Args:
        data: Input data to process
        config: Optional configuration parameters
        
    Returns:
        Dict containing processed results
    """
    logger.info("Processing data with main_function")
    
    # Your core logic here
    result = {"status": "success", "processed": True, "data": data}
    
    if config:
        result["config"] = config
        
    return result
EOF

# Create configuration module
cat > src/my_python_project/config.py << 'EOF'
"""Configuration management for the project."""

import os
from pathlib import Path
from typing import Optional

from dotenv import load_dotenv
from pydantic import BaseSettings, Field

# Load environment variables from .env file
load_dotenv()


class Settings(BaseSettings):
    """Application settings loaded from environment variables."""
    
    # Application settings
    app_name: str = Field(default="My Python Project", env="APP_NAME")
    debug: bool = Field(default=False, env="DEBUG")
    log_level: str = Field(default="INFO", env="LOG_LEVEL")
    
    # Database settings
    database_url: Optional[str] = Field(default=None, env="DATABASE_URL")
    
    # API settings
    api_host: str = Field(default="localhost", env="API_HOST")
    api_port: int = Field(default=8000, env="API_PORT")
    
    # Directories
    data_dir: Path = Field(default=Path("data"), env="DATA_DIR")
    output_dir: Path = Field(default=Path("output"), env="OUTPUT_DIR")
    
    class Config:
        """Pydantic configuration."""
        env_file = ".env"
        env_file_encoding = "utf-8"


# Global settings instance
settings = Settings()
EOF

# Create CLI module
cat > src/my_python_project/cli.py << 'EOF'
"""Command-line interface for the project."""

import logging
from pathlib import Path
from typing import Optional

import click

from .config import settings
from .core import main_function

# Configure logging
logging.basicConfig(
    level=getattr(logging, settings.log_level.upper()),
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
)
logger = logging.getLogger(__name__)


@click.group()
@click.version_option()
@click.option("--debug/--no-debug", default=False, help="Enable debug mode")
@click.pass_context
def cli(ctx: click.Context, debug: bool) -> None:
    """My Python Project CLI."""
    ctx.ensure_object(dict)
    ctx.obj["DEBUG"] = debug
    if debug:
        logger.setLevel(logging.DEBUG)


@cli.command()
@click.option("--input-file", "-i", type=click.Path(exists=True, path_type=Path), help="Input file")
@click.option("--output-file", "-o", type=click.Path(path_type=Path), help="Output file")
@click.pass_context
def process(ctx: click.Context, input_file: Optional[Path], output_file: Optional[Path]) -> None:
    """Process data using the main function."""
    logger.info("Starting data processing")
    
    # Example data
    data = {"example": "data", "from_file": str(input_file) if input_file else None}
    
    result = main_function(data)
    
    if output_file:
        # In a real project, you'd write the result to the file
        logger.info(f"Would write result to {output_file}")
    
    click.echo(f"Processing completed: {result}")


def main() -> None:
    """Entry point for the CLI."""
    cli()


if __name__ == "__main__":
    main()
EOF

# Create utils module
mkdir -p src/my_python_project/utils
cat > src/my_python_project/utils/__init__.py << 'EOF'
"""Utilities package."""

from .helpers import setup_logging, validate_file_path

__all__ = ["setup_logging", "validate_file_path"]
EOF

cat > src/my_python_project/utils/helpers.py << 'EOF'
"""Helper functions and utilities."""

import logging
from pathlib import Path
from typing import Union


def setup_logging(level: str = "INFO", format_string: str = None) -> None:
    """Set up logging configuration.
    
    Args:
        level: Log level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
        format_string: Optional custom format string
    """
    if format_string is None:
        format_string = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    
    logging.basicConfig(
        level=getattr(logging, level.upper()),
        format=format_string,
        datefmt="%Y-%m-%d %H:%M:%S",
    )


def validate_file_path(file_path: Union[str, Path], must_exist: bool = True) -> Path:
    """Validate and convert file path to Path object.
    
    Args:
        file_path: File path as string or Path
        must_exist: Whether the file must exist
        
    Returns:
        Validated Path object
        
    Raises:
        FileNotFoundError: If must_exist=True and file doesn't exist
        ValueError: If path is invalid
    """
    path = Path(file_path)
    
    if must_exist and not path.exists():
        raise FileNotFoundError(f"File not found: {path}")
    
    return path
EOF
```

### 4. Create Test Structure

```bash
# Create test structure
cat > tests/__init__.py << 'EOF'
"""Test package."""
EOF

cat > tests/conftest.py << 'EOF'
"""Pytest configuration and fixtures."""

import pytest
from pathlib import Path
from typing import Dict, Any

from my_python_project.config import Settings


@pytest.fixture
def sample_data() -> Dict[str, Any]:
    """Sample data for testing."""
    return {
        "id": 1,
        "name": "test",
        "values": [1, 2, 3, 4, 5],
        "metadata": {"created": "2024-01-01", "type": "test"}
    }


@pytest.fixture
def test_settings() -> Settings:
    """Test settings with overrides."""
    return Settings(
        app_name="Test App",
        debug=True,
        log_level="DEBUG",
        data_dir=Path("tests/data"),
        output_dir=Path("tests/output"),
    )


@pytest.fixture
def temp_file(tmp_path: Path) -> Path:
    """Create a temporary file for testing."""
    file_path = tmp_path / "test_file.txt"
    file_path.write_text("test content")
    return file_path
EOF

cat > tests/test_core.py << 'EOF'
"""Tests for core functionality."""

import pytest
from typing import Dict, Any

from my_python_project.core import main_function


def test_main_function_basic(sample_data: Dict[str, Any]) -> None:
    """Test main function with basic data."""
    result = main_function(sample_data)
    
    assert result["status"] == "success"
    assert result["processed"] is True
    assert result["data"] == sample_data


def test_main_function_with_config(sample_data: Dict[str, Any]) -> None:
    """Test main function with configuration."""
    config = {"option1": "value1", "option2": True}
    result = main_function(sample_data, config)
    
    assert result["status"] == "success"
    assert result["processed"] is True
    assert result["data"] == sample_data
    assert result["config"] == config


def test_main_function_empty_data() -> None:
    """Test main function with empty data."""
    result = main_function({})
    
    assert result["status"] == "success"
    assert result["processed"] is True
    assert result["data"] == {}
EOF

cat > tests/test_utils.py << 'EOF'
"""Tests for utility functions."""

import pytest
from pathlib import Path

from my_python_project.utils.helpers import validate_file_path


def test_validate_file_path_existing(temp_file: Path) -> None:
    """Test validate_file_path with existing file."""
    result = validate_file_path(temp_file)
    assert result == temp_file


def test_validate_file_path_nonexistent() -> None:
    """Test validate_file_path with non-existent file."""
    with pytest.raises(FileNotFoundError):
        validate_file_path("nonexistent_file.txt")


def test_validate_file_path_string_input(temp_file: Path) -> None:
    """Test validate_file_path with string input."""
    result = validate_file_path(str(temp_file))
    assert result == temp_file


def test_validate_file_path_no_existence_check() -> None:
    """Test validate_file_path without existence check."""
    result = validate_file_path("any_file.txt", must_exist=False)
    assert isinstance(result, Path)
    assert result.name == "any_file.txt"
EOF
```

### 5. Create .gitignore

```bash
cat > .gitignore << 'EOF'
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/
cover/

# Translations
*.mo
*.pot

# Django stuff:
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal

# Flask stuff:
instance/
.webassets-cache

# Scrapy stuff:
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
.pybuilder/
target/

# Jupyter Notebook
.ipynb_checkpoints

# IPython
profile_default/
ipython_config.py

# pyenv
.python-version

# pipenv
Pipfile.lock

# poetry
poetry.lock

# pdm
.pdm.toml
.pdm-python
.pdm-build/

# PEP 582
__pypackages__/

# Celery stuff
celerybeat-schedule
celerybeat.pid

# SageMath parsed files
*.sage.py

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# Pyre type checker
.pyre/

# pytype static type analyzer
.pytype/

# Cython debug symbols
cython_debug/

# PyCharm
.idea/

# VS Code
.vscode/
!.vscode/settings.json.template

# UV
.uv/
uv.lock

# macOS
.DS_Store

# Windows
Thumbs.db
ehthumbs.db
Desktop.ini

# Project specific
data/raw/*
data/processed/*
!data/raw/.gitkeep
!data/processed/.gitkeep
output/
logs/
temp/
*.tmp

# Secrets and credentials
*.pem
*.key
*secret*
*credential*
EOF
```

### 6. Initialize UV Environment

```bash
# Initialize UV project and virtual environment
uv sync --group dev

# Install the project in editable mode
uv pip install -e .

# Or use UV's add command to make it editable
uv add --editable .
```

### 7. Create Development Configuration Files

```bash
# Pre-commit configuration
cat > .pre-commit-config.yaml << 'EOF'
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      - id: check-toml
      - id: debug-statements

  - repo: https://github.com/psf/black
    rev: 23.9.1
    hooks:
      - id: black
        language_version: python3

  - repo: https://github.com/charliermarsh/ruff-pre-commit
    rev: v0.1.0
    hooks:
      - id: ruff
        args: [--fix, --exit-non-zero-on-fix]

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.5.1
    hooks:
      - id: mypy
        additional_dependencies: [pydantic, python-dotenv, click]
EOF

# Environment template
cat > .env.template << 'EOF'
# Application Configuration
APP_NAME=My Python Project
DEBUG=false
LOG_LEVEL=INFO

# Database
DATABASE_URL=postgresql://user:password@localhost/dbname

# API Configuration
API_HOST=localhost
API_PORT=8000

# Directories
DATA_DIR=data
OUTPUT_DIR=output

# External Services
# API_KEY=your_api_key_here
# THIRD_PARTY_URL=https://api.example.com
EOF

# VS Code settings template
mkdir -p .vscode
cat > .vscode/settings.json.template << 'EOF'
{
    "python.interpreter.path": ".venv/bin/python",
    "python.linting.enabled": true,
    "python.linting.ruffEnabled": true,
    "python.formatting.provider": "black",
    "python.testing.pytestEnabled": true,
    "python.testing.pytestArgs": ["tests"],
    "files.exclude": {
        "**/__pycache__": true,
        "**/*.pyc": true,
        ".pytest_cache": true,
        ".mypy_cache": true,
        ".ruff_cache": true,
        "htmlcov": true
    },
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
        "source.organizeImports": true
    }
}
EOF
```

### 8. Create Makefile for Automation

```bash
cat > Makefile << 'EOF'
.PHONY: help setup sync install test test-cov lint format type-check clean build docs serve-docs pre-commit

# Default target
help:
	@echo "Available commands:"
	@echo "  setup        - Initial project setup"
	@echo "  sync         - Sync dependencies with uv"
	@echo "  install      - Install project in editable mode"
	@echo "  test         - Run tests"
	@echo "  test-cov     - Run tests with coverage report"
	@echo "  lint         - Run ruff linter"
	@echo "  format       - Format code with black and ruff"
	@echo "  type-check   - Run mypy type checker"
	@echo "  clean        - Clean cache and build artifacts"
	@echo "  build        - Build the package"
	@echo "  docs         - Build documentation"
	@echo "  serve-docs   - Serve documentation locally"
	@echo "  pre-commit   - Run pre-commit hooks"

setup:
	@echo "Setting up project..."
	uv sync --group dev --group docs --group test
	uv run pre-commit install
	cp .env.template .env
	cp .vscode/settings.json.template .vscode/settings.json

sync:
	uv sync

install:
	uv pip install -e .

test:
	uv run pytest

test-cov:
	uv run pytest --cov-report=html --cov-report=term

lint:
	uv run ruff check .

format:
	uv run black .
	uv run ruff check --fix .

type-check:
	uv run mypy src/

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	rm -rf build/ dist/ .coverage htmlcov/ .pytest_cache/ .mypy_cache/ .ruff_cache/

build:
	uv build

docs:
	uv run mkdocs build

serve-docs:
	uv run mkdocs serve

pre-commit:
	uv run pre-commit run --all-files
EOF
```

### 9. Create Documentation Structure

```bash
# Create basic README
cat > README.md << 'EOF'
# My Python Project

A brief description of what this project does.

## Installation

### Using UV (Recommended)

```bash
# Clone the repository
git clone https://github.com/username/my-python-project.git
cd my-python-project

# Set up the environment
make setup
```

### Manual Installation

```bash
# Install UV if you haven't already
curl -LsSf https://astral.sh/uv/install.sh | sh

# Sync dependencies
uv sync --group dev

# Install the project in editable mode
uv pip install -e .
```

## Usage

### Command Line Interface

```bash
# Basic usage
uv run my-project --help

# Process data
uv run my-project process --input-file data/input.txt --output-file output/result.txt
```

### Python API

```python
from my_python_project import main_function, settings

# Use the main function
result = main_function({"key": "value"})
print(result)
```

## Development

### Setup Development Environment

```bash
make setup
```

### Running Tests

```bash
make test           # Run all tests
make test-cov       # Run tests with coverage
```

### Code Quality

```bash
make format         # Format code
make lint          # Run linter
make type-check    # Run type checker
```

### Building and Documentation

```bash
make build         # Build the package
make docs          # Build documentation
make serve-docs    # Serve docs locally
```

## Project Structure

```
my-python-project/
├── src/
│   └── my_python_project/
│       ├── __init__.py
│       ├── cli.py
│       ├── config.py
│       ├── core.py
│       └── utils/
├── tests/
├── docs/
├── data/
├── notebooks/
├── scripts/
├── pyproject.toml
└── README.md
```

## Configuration

Copy `.env.template` to `.env` and modify as needed:

```bash
cp .env.template .env
```

## License

MIT License - see LICENSE file for details.
EOF

# Create changelog
cat > CHANGELOG.md << 'EOF'
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project structure
- Basic CLI interface
- Configuration management
- Test suite
- Documentation setup

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.1.0] - 2024-01-01

### Added
- Initial release
EOF

# Create data directory structure
mkdir -p data/{raw,processed,external}
touch data/raw/.gitkeep
touch data/processed/.gitkeep
touch data/external/.gitkeep
```

### 10. Final Setup and Verification

```bash
# Run initial setup
make setup

# Verify installation
uv run my-project --help

# Run tests
make test

# Check code quality
make lint
make type-check

# Build the package
make build

# Initialize git and make first commit
git add .
git commit -m "Initial project setup with UV"
```

## Key Benefits of This Structure

1. **Standardized Layout**: Consistent project structure across all Python projects
2. **Modern Tooling**: Uses UV for fast dependency management
3. **Editable Installation**: Project installs in development mode automatically
4. **Comprehensive Testing**: Pre-configured pytest with coverage
5. **Code Quality**: Black, Ruff, and MyPy configured out of the box
6. **Documentation Ready**: MkDocs configuration included
7. **Pre-commit Hooks**: Automated code quality checks
8. **Environment Management**: Proper .env handling and VS Code integration
9. **CLI Ready**: Click-based CLI pre-configured
10. **Type Safe**: Full type annotations and checking

## Customization

To adapt this template for your specific project:

1. Replace `my-python-project` and `my_python_project` with your actual project name
2. Update author information in `pyproject.toml`
3. Modify dependencies based on your needs
4. Adjust the CLI commands in `cli.py`
5. Update the README with project-specific information
6. Customize the configuration in `config.py`

This template provides a solid foundation that can be replicated for any Python project, ensuring consistency and best practices across all your repositories.