select
    plan_external_id as plan_id,
    plan_name,
    interval_count,
    interval_unit,
    interval_count || ' ' || interval_unit as plan_interval
from {{ ref("stg_plans") }}
