with
    base as (
        select
            customer_external_id as customer_id,
            company,
            country,
            state,
            city,
            zip,
            lead_created_at,
            free_trial_started_at
        from {{ ref("stg_customers") }}
    )

select
    customer_id,
    company,
    country,
    state,
    city,
    zip,
    free_trial_started_at - lead_created_at as days_to_free_trial,
    lead_created_at,
    free_trial_started_at
from base
