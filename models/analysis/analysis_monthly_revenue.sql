with
    line_items as (
        select li.net_amount_in_cents, li.type, i.invoiced_date
        from {{ ref("fct_invoice_line_items") }} li
        left join {{ ref("fct_invoices") }} i on li.invoice_id = i.invoice_id
    )

select
    date_trunc('month', invoiced_date)::date as month,
    sum(
        case when type = 'Subscription' then net_amount_in_cents else 0 end
    ) as recurring_revenue_cents,
    sum(
        case when type != 'Subscription' then net_amount_in_cents else 0 end
    ) as onetime_revenue_cents,
    sum(net_amount_in_cents) as total_revenue_cents
from line_items
group by 1
order by 1
