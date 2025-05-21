with
    invoices as (select * from {{ ref("stg_invoices") }}),
    line_items as (
        select
            invoice_external_id,
            count(*) as line_item_count,
            sum(amount_in_cents) as total_amount_in_cents,
            sum(discount_amount) as total_discount_in_cents,
            sum(tax_amount) as total_tax_in_cents
        from {{ ref("stg_invoice_line_items") }}
        group by invoice_external_id
    ),
    transactions as (
        select
            invoice_external_id,
            count(*) as total_transactions,
            sum(
                case when transaction_result = 'successful' then 1 else 0 end
            ) as successful_transactions
        from {{ ref("stg_transactions") }}
        group by invoice_external_id
    )
select
    i.invoice_external_id as invoice_id,
    i.customer_external_id as customer_id,
    i.currency,
    li.line_item_count,
    li.total_amount_in_cents,
    li.total_discount_in_cents,
    li.total_tax_in_cents,
    tr.total_transactions,
    tr.successful_transactions,
    null as days_until_due,
    i.invoiced_date,
    i.due_date
from invoices i
left join line_items li on i.invoice_external_id = li.invoice_external_id
left join transactions tr on i.invoice_external_id = tr.invoice_external_id
