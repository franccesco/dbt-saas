select
    external_id as transaction_external_id,
    invoice_external_id,
    type as transaction_type,
    result as transaction_result,
    date as transaction_date
from {{ source('public', 'transactions') }}
