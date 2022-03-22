with transactions as (

    select * from {{ ref ('stg_transactions')}}
),

YTD as (

    select EXTRACT(YEAR FROM date) as year, merchant_name, category, sum(amount) as yearly_total
    from transactions
    where category NOT IN ('Transfer', 'Payment')
    group by year, merchant_name, category
    order by merchant_name
)

select * from YTD