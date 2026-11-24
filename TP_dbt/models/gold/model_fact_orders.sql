
{{ config(
    materialized='table',
    schema='gold',

    pre_hook="
        INSERT INTO training.dbt_logs
        (model_name, action, inserted_at)
        VALUES ('{{this}}', 'start', CURRENT_TIMESTAMP)
    ",

    post_hook="
        INSERT INTO training.dbt_logs
        (model_name, action, inserted_at)
       VALUES ('{{this}}', 'end', CURRENT_TIMESTAMP)
    "
) }}


SELECT  o.customerid,
    o.employeeid,
    o.storeid,
    o.status, 
    o.orderid,
    Count(o.orderid ) AS NbCommandes ,
     SUM(oi.quantity*oi.unitprice) SommeCommande
FROM bronze.orderitems AS oi
JOIN bronze.orders AS o ON oi.orderid = o.orderid
GROUP BY  o.customerid, o.employeeid, o.storeid , o.status
