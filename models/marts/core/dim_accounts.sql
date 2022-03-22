with accounts as (

    select * from {{ ref('stg_balance')}}
),

currentinterest as (

    select current_balance*cast(int_rate as decimal)/100 as current_interest, name
    from {{ ref('stg_balance')}}
),

netinflowoutflow as (

    select account_id, sum(amount) as net_inflow_outflow
    from {{ ref('stg_transactions')}}
    group by account_id
),

final as (

    select accounts.account_id, accounts.name, accounts.official_name, accounts.type, accounts.current_balance, accounts.available_balance,
    accounts.balances_limit, currentinterest.current_interest, netinflowoutflow.net_inflow_outflow
    from accounts
    full join currentinterest on currentinterest.name=accounts.name
    full join netinflowoutflow on netinflowoutflow.account_id=accounts.account_id
)

select * from final