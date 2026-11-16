
{{ config(materialized='view', schema = 'bronze') }}


SELECT * , CONCAT(UPPER(lastname), ' ', firstname) as name
FROM bronze.customers
