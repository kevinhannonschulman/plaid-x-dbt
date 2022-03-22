with balance as (

    select * from {{ ref('stg_balance')}}
),

annual as (

    select FORMAT_DATETIME('%B', DATETIME (date)) as month, amount, category, merchant_name, transaction_id, account_id
    from {{ ref('stg_transactions')}}
    where category NOT IN ('Transfer', 'Payment')
    group by month, amount, category, merchant_name, transaction_id, account_id
),

final as (

    select balance.account_id, balance.name, annual.month, annual.amount, annual.category, annual.merchant_name, annual.transaction_id,
    from balance

    join annual on annual.account_id = balance.account_id
)

select * from final
order by amount desc