{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}
{{log("Incremental model started", info=Ture)}} -- doesn't work
WITH src_reviews AS (
    SELECT * FROM {{ref("src_reviews")}}
)

SELECT
{{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} as review_id,
 * FROM src_reviews
WHERE review_text IS NOT NULL  
{% if is_incremental() %}
    {% if var("start_date", False) and var("end_date", False)%}
        {{ log('Loading ' ~ this ~ 'incrementally (start_date: ' ~ var("start_date")~', end_date: ' ~ var("end_date"), info=True)}}
        AND review_date >= '{{ var("start_date") }}'
        AND review_date < '{{ var("end_date") }}'
    {% else %}
    AND review_date > (SELECT max(review_date) FROM {{this}})
    {{ log('Loading' ~ this ~ ' incrementally (all missing dates)', info=True)}}
    {% endif %}
{% endif %}

{{log("Incremental model ended", info=True)}}