with orders as (
    select  order_id,
            order_date,
            customer_id
    from    {{ref('stg_jaffle_shop__orders')}}
),

pmt as (
    select  order_id,
            status,
            amount
    from    {{ref('stg_stripe__payments')}}
),

order_payments as (
    select  order_id,
            sum(case when status = 'success' then amount end) as amount
    from    pmt
    group by 1
)

select  o.order_id,
        o.customer_id,
        o.order_date,
        coalesce(p.amount,0) as amount
from    orders o 
        left join pmt p using (order_id)
            