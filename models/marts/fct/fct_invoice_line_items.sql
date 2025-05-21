select
    invoice_external_id as invoice_id,
    external_id as line_item_id,
    subscription_external_id,
    subscription_set_external_id,
    type,
    amount_in_cents,
    plan as plan_id,
    service_period_start,
    service_period_end,
    quantity,
    proration,
    discount_code,
    discount_amount,
    tax_amount,
    description,
    transaction_fee,
    account_code,
    transaction_fees_currency,
    discount_description,
    event_order,
    balance_transfer,
    proration_type,
    amount_in_cents
    - coalesce(discount_amount, 0)
    + coalesce(tax_amount, 0) as net_amount_in_cents
from {{ ref("stg_invoice_line_items") }}
