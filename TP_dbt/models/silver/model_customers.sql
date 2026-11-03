
{{ config(materialized='view') }}


SELECT * , CONCAT(UPPER(firstname), ' ', lastname) as name
FROM bronze.customers
