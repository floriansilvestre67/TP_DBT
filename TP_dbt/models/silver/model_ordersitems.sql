
{{ config(materialized='view', schema = 'bronze') }}


SELECT
    *,
    (quantity * unitprice) AS TotalPrice
FROM bronze.orderitems