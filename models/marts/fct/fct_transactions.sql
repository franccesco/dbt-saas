select
    transaction_external_id as transaction_id,
    invoice_external_id as invoice_id,
    transaction_type,
    transaction_result,
    transaction_date,
    (transaction_result = 'successful')::boolean as was_successful
from {{ ref("stg_transactions") }}
