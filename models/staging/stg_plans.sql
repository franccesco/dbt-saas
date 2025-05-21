select
    plan_id as plan_external_id,
    name as plan_name,
    interval_count,
    interval_unit
from {{ source('public', 'plans') }}
