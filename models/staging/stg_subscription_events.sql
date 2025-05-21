select
    external_id,
    customer_external_id,
    subscription_external_id,
    event_type,
    retracted_event_id,
    date,
    effective_date,
    plan_external_id,
    currency,
    amount_in_cents,
    quantity
from {{ source('public', 'subscription_events') }}
