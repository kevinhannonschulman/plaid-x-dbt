with balance as (

    select account_id, name, official_name, regexp_extract(official_name, r"([0-9.]+)") as int_rate, type, 
    balances_current as current_balance, balances_available as available_balance, balances_limit
    from {{ source('plaid_sandbox', 'balance')}}
)

select * from balance