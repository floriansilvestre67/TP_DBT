SELECT
    storeid,
    SUM(SommeCommande) AS revenu_total
FROM {{ ref('model_fact_orders') }}
GROUP BY storeid
ORDER BY revenu_total DESC