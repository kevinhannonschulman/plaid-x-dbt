with balance as (

    select account_id, name, official_name, type, balances_current as current_balance
    from {{ source('plaid_sandbox', 'balance')}}
)

select * from balance