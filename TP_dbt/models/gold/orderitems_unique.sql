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


{{ dbt_utils.deduplicate(
    relation=ref('model_ordersitems'),
    partition_by='orderitemid',
    order_by='updated_at desc'
) }}