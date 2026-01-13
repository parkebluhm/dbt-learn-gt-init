    select
        ID as payment_id, 
        ORDERID as order_id, 
        PAYMENTMETHOD as payment_mathod, 
        status, 
        amount / 100 as amount,
        created

    from {{source('stripe','payments')}}