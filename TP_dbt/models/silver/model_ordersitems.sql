
{{ config(
    materialized='view',
    schema='bronze',

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
    *,
    (quantity * unitprice) AS TotalPrice
FROM bronze.orderitems