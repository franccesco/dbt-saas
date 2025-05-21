select
    external_id as manual_subscription_event_id,
    subscription_external_id,
    customer_external_id as customer_id,
    plan_external_id as plan_id,
    event_type,
    currency,
    amount_in_cents,
    quantity,
    effective_date - date as days_until_effective,
    report_cash_flow,
    date as event_date,
    effective_date
from {{ ref("stg_manual_subscriptions") }}
