select invoice_external_id, customer_external_id, invoiced_date, due_date, currency
from {{ source("public", "invoices") }}
