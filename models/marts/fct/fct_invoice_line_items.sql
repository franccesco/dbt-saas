select
    external_id as line_item_id,
    invoice_external_id as invoice_id,
    subscription_external_id,
    subscription_set_external_id,
    plan as plan_id,
    type,
    discount_code,
    description,
    account_code,
    transaction_fees_currency,
    discount_description,
    proration_type,
    amount_in_cents,
    quantity,
    discount_amount,
    tax_amount,
    transaction_fee,
    event_order,
    amount_in_cents
    - coalesce(discount_amount, 0)
    + coalesce(tax_amount, 0) as net_amount_in_cents,
    proration,
    balance_transfer,
    service_period_start,
    service_period_end
from {{ ref("stg_invoice_line_items") }}
