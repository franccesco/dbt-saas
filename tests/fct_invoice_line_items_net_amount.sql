with
    validation as (
        select
            net_amount_in_cents,
            amount_in_cents
            - coalesce(discount_amount, 0)
            + coalesce(tax_amount, 0) as expected
        from {{ ref("fct_invoice_line_items") }}
    )
select *
from validation
where net_amount_in_cents != expected
