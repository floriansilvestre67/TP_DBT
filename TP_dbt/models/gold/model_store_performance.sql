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