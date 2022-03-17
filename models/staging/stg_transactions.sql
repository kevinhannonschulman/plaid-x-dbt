with transactions as (
    
    select account_id, split(category, '/ ')[safe_offset(0)] as category, split(category, '/ ')[safe_offset(1)] as subcategory,
    amount, date, name, merchant_name, transaction_id
    from {{ source('plaid_sandbox', 'transactions')}}
)

select * from transactions