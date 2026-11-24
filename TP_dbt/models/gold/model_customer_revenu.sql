
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



SELECT  fo.customerid,
    c.name,
    SUM(fo.SommeCommande) as revenue_gen
FROM gold.model_fact_orders AS fo
JOIN bronze.model_customers AS c ON c.customerid = fo.customerid
GROUP BY  fo.customerid
