# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a dbt project for modeling B2B SaaS billing and subscription data. The data flows through:
Seeds → Sources → Staging → Marts (Dimensions & Facts) → Analysis

## Essential Commands

```bash
# Always use uv run prefix for dbt commands
uv run dbt parse              # Parse project
uv run dbt build              # Run and test all models
uv run dbt run                # Run models without tests
uv run dbt test               # Run tests only
uv run dbt run -s model_name  # Run specific model
uv run dbt test -s model_name # Test specific model

# Code formatting (run before commits)
uv run sqlfmt models/         # Format SQL files
uv run sqlfmt models/ --check # Check formatting without changes

# Development setup
uv pip install -e .           # Install dependencies
```

## Architecture

**Data Layers:**
- **Seeds** (`/seeds/`): CSV sample data files
- **Staging** (`/models/staging/`): Light transformations, schema: `stg_dbt`
- **Marts** (`/models/marts/`): Business logic layer, schema: `mart_dbt`
  - `dim/`: Dimension tables (customers, plans)
  - `fct/`: Fact tables (invoices, transactions, subscriptions)
- **Analysis** (`/models/analysis/`): Business metrics, schema: `analysis_dbt`

**Key Relationships:**
- Customers have invoices and subscriptions
- Invoices contain line items and transactions
- Subscriptions link customers to plans with events tracking lifecycle

## Testing Approach

- All models have schema tests (unique, not_null, relationships)
- Custom data tests in `/tests/` validate calculations
- Database constraints enforced via dbt_constraints package
- Run `uv run dbt test` after model changes

## Development Guidelines

- Format SQL with sqlfmt before committing
- Document all models in corresponding .yml files
- Add appropriate tests for new models
- Avoid searching in `.venv` directory
- Ensure models run successfully before committing changes
