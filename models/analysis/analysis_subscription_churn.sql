with
    events as (
        select event_date, event_type from {{ ref("fct_manual_subscriptions") }}
    ),
    agg as (
        select
            date_trunc('month', event_date)::date as month,
            count(
                case when event_type = 'manual_subscription_started' then 1 end
            ) as subscription_starts,
            count(
                case when event_type = 'manual_subscription_cancelled' then 1 end
            ) as subscription_cancellations
        from events
        group by 1
    )

select
    month,
    subscription_starts,
    subscription_cancellations,
    subscription_starts - subscription_cancellations as net_subscriptions
from agg
order by month
