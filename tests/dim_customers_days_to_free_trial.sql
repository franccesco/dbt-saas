with
    validation as (
        select days_to_free_trial, free_trial_started_at - lead_created_at as expected
        from {{ ref("dim_customers") }}
    )
select *
from validation
where days_to_free_trial != expected
