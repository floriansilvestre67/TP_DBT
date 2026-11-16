{{ config(materialized='table', schema='gold') }}

SELECT
    fo.storeid,
    s.SalesTarget,
    SUM(fo.SommeCommande) AS revenue_actuel
FROM gold.model_fact_orders AS fo
JOIN bronze.salestarget AS s
    ON s.StoreID = fo.storeid
GROUP BY
    fo.storeid,
    s.SalesTarget