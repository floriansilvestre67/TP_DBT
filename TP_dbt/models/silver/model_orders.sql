
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
    CASE
        WHEN status = '01' THEN 'En cours'
        WHEN status = '02' THEN 'Terminée'
        WHEN status = '03' THEN 'Annulée'
        ELSE 'Inconnu'
    END AS StatusDescription
FROM bronze.orders