# dbt SaaS Analytics

This repository contains a small dbt project used to model sample SaaS billing data. Seed CSV files located under the `seeds/` directory create source tables such as `customers`, `invoices` and `invoice_line_items`. An entity relationship diagram for these seeds is shown below for convenience.

### Seed Entity Relationship Diagram

```mermaid
erDiagram
    customers {
        string external_id PK
        string company
        string country
        string state
        string city
        string zip
        date lead_created_at
        date free_trial_started_at
    }
    contacts {
        string customer_external_id FK
        string first_name
        string last_name
        string email
        string position
        string title
        string phone
        string linkedin
        string twitter
        string note
    }
    invoices {
        string invoice_external_id PK
        string customer_external_id FK
        date invoiced_date
        date due_date
        string currency
    }
    invoice_line_items {
        string invoice_external_id FK
        string external_id
        string subscription_external_id
        string subscription_set_external_id
        string type
        int amount_in_cents
        string plan
        date service_period_start
        date service_period_end
        int quantity
        bool proration
        string discount_code
        int discount_amount
        int tax_amount
        string description
        int transaction_fee
        string account_code
        string transaction_fees_currency
        string discount_description
        int event_order
        bool balance_transfer
        string proration_type
    }
    transactions {
        string invoice_external_id FK
        string external_id PK
        string type
        string result
        date date
    }
    manual_subscriptions {
        string external_id PK
        string subscription_external_id
        string customer_external_id FK
        string plan_external_id FK
        date date
        date effective_date
        string event_type
        string currency
        int amount_in_cents
        int quantity
        bool report_cash_flow
    }
    subscription_events {
        string customer_external_id FK
        string subscription_external_id
        string external_id PK
        string event_type
        string retracted_event_id
        date date
        date effective_date
        string plan_external_id FK
        string currency
        int amount_in_cents
        int quantity
    }
    plans {
        string plan_id PK
        string name
        int interval_count
        string interval_unit
    }

    customers ||--o{ contacts: "has"
    customers ||--o{ invoices: "has"
    customers ||--o{ manual_subscriptions: "has"
    customers ||--o{ subscription_events: "has"
    invoices ||--o{ invoice_line_items: "has"
    invoices ||--o{ transactions: "has"
    plans ||--o{ manual_subscriptions: "referenced by"
    plans ||--o{ subscription_events: "referenced by"
```

The core models live in the `models/` folder:

- `models/staging/` – staging models built directly from the seed tables.
- `models/marts/dim/` – dimension tables.
- `models/marts/fct/` – fact tables.

The project relies on the [`dbt_constraints`](https://github.com/Snowflake-Labs/dbt_constraints) package for database constraints and uses [`uv`](https://github.com/astral-sh/uv) as the Python package manager.

## Development setup

1. **Install dependencies**

   ```bash
   uv pip install -e .
   ```

   The command above reads `pyproject.toml` and installs dbt and other tools into a virtual environment under `.venv`.

2. **Activate the virtual environment**

   ```bash
   source .venv/bin/activate
   ```

3. **Database connection**

   By default the project uses a local PostgreSQL instance as configured in `profiles.yml`.
   The `.devcontainer/` folder contains everything needed to run this project in
   VS Code or any editor that supports dev containers. Opening the repository in
   a dev container automatically starts a PostgreSQL service alongside Python so
   you can run dbt commands without additional setup.

## Running dbt

All dbt commands should be executed through `uv run`:

```bash
uv run dbt parse       # parse project
uv run dbt build       # run and test models
```

SQL models and YAML files can be formatted with:

```bash
uv run sqlfmt models/
```

## Guidelines for building models

- Place new staging models in `models/staging/` and use seed sources declared in `models/sources/_models.yml`.
- Dimensions and facts belong under `models/marts/` (`dim/` and `fct/` subfolders).
- Document columns and add tests in the corresponding YAML files.
- Keep SQL style consistent by running `uv run sqlfmt models/` before committing.
- Ensure models run successfully with `uv run dbt build` and update any documentation when changes are made.
