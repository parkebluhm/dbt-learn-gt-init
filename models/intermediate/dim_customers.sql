with customers as (

    select  customer_id,
            first_name,
            last_name
    from    {{ ref('stg_jaffle_shop__customers') }}

),

orders as (
    select  customer_id,
            order_id,
            order_date,
            amount
    from    {{ ref('fct_orders') }}    
),

customer_orders as (

    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
         sum(amount) as lifetime_value
    from orders

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        co.first_order_date,
        co.most_recent_order_date,
        coalesce(co.number_of_orders, 0) as number_of_orders,
        co.lifetime_value

    from customers

    left join customer_orders co using (customer_id)

)


select * from final
