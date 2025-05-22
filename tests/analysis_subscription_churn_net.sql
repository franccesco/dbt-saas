with
    validation as (
        select
            subscription_starts - subscription_cancellations as expected,
            net_subscriptions
        from {{ ref("analysis_subscription_churn") }}
    )
select *
from validation
where expected != net_subscriptions
