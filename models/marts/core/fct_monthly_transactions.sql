with transactions as (
    select * from {{ ref('stg_transactions') }}
),

monthly as (

    select
      FORMAT_DATETIME('%B', DATETIME (date)) as month, sum(amount) as amount, category, subcategory
      from transactions
      group by month, category, subcategory
      order by month
)

select * from monthly