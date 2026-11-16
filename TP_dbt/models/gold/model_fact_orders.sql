
{{ config(materialized='table', schema = 'gold') }}


SELECT  o.customerid,
    o.employeeid,
    o.storeid,
    o.status, 
    Count(o.orderid ) AS NbCommandes ,
     SUM(oi.quantity*oi.unitprice) SommeCommande
FROM bronze.orderitems AS oi
JOIN bronze.orders AS o ON oi.orderid = o.orderid
GROUP BY  o.customerid, o.employeeid, o.storeid , o.status
