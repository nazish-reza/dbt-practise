WITH src_hosts AS (
    SELECT * FROM {{ref("src_hosts")}}
)

SELECT 
    host_id,
    NVL(
        host_name,
        'Anonymous'
    )
    is_superhost,
    created_at,
    updated_at
FROM src_hosts