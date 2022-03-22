with balance as (
    select * from {{ ref('stg_balance')}}
)

select balances_limit - current_balance
from balance
where name='Plaid Credit Card' and (balances_limit - current_balance) <= 0