{% macro generate_profit_model(table_source, eur_rate=1) %}

SELECT
    sales_date,
    SUM(quantity_sold * unit_sell_price) AS total_revenue,
    SUM(quantity_sold * unit_purchase_cost) AS total_cost,
    SUM(quantity_sold * unit_sell_price)
      - SUM(quantity_sold * unit_purchase_cost) AS total_profit,

    ROUND(
        (
            SUM(quantity_sold * unit_sell_price)
            - SUM(quantity_sold * unit_purchase_cost)
        ) * {{ eur_rate }},
        2
    ) AS total_profit_eur

FROM {{ source('training', table_source) }}

GROUP BY sales_date

{% endmacro %}