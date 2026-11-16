
{{ config(materialized='view', schema = 'bronze') }}


SELECT
    *,
    CASE
        WHEN status = '01' THEN 'En cours'
        WHEN status = '02' THEN 'Terminée'
        WHEN status = '03' THEN 'Annulée'
        ELSE 'Inconnu'
    END AS StatusDescription
FROM bronze.orders