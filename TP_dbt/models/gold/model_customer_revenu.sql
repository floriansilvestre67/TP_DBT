
{{ config(materialized='table', schema = 'gold') }}


SELECT  fo.customerid,
    c.name,
    SUM(fo.SommeCommande) as revenue_gen
FROM gold.model_fact_orders AS fo
JOIN bronze.model_customers AS c ON c.customerid = fo.customerid
GROUP BY  fo.customerid
