select
    external_id as customer_external_id,
    company,
    country,
    state,
    city,
    zip,
    lead_created_at,
    free_trial_started_at
from {{ source('public', 'customers') }}
