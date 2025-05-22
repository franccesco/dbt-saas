with
    validation as (
        select
            recurring_revenue_cents + onetime_revenue_cents as expected,
            total_revenue_cents
        from {{ ref("analysis_monthly_revenue") }}
    )
select *
from validation
where expected != total_revenue_cents
