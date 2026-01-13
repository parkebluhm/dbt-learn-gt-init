    select
        ID as payment_id, 
        ORDERID as order_id, 
        PAYMENTMETHOD as payment_mathod, 
        status, 
        amount / 100 as amount,
        _ingested_at

    from {{source('stripe','payments')}}