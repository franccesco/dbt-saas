select
    external_id as subscription_event_id,
    customer_external_id as customer_id,
    subscription_external_id,
    event_type,
    retracted_event_id,
    date as event_date,
    effective_date,
    plan_external_id as plan_id,
    currency,
    amount_in_cents,
    quantity,
    effective_date - date as days_until_effective
from {{ ref("stg_subscription_events") }}
