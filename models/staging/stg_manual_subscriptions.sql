select
    external_id,
    subscription_external_id,
    customer_external_id,
    plan_external_id,
    date,
    effective_date,
    event_type,
    currency,
    amount_in_cents,
    quantity,
    report_cash_flow
from {{ source("public", "manual_subscriptions") }}
