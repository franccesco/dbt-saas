select
    customer_external_id,
    first_name,
    last_name,
    email,
    position,
    title,
    phone,
    linkedin,
    twitter,
    note
from {{ source("public", "contacts") }}
