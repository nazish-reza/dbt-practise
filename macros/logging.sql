{% macro learn_logging() %}
   {{ log(" This is logging.", info=True) }}
{% endmacro %}

{% macro lopper() %}
    {% for i in ["Nazish", "Sazish"]%}
        {{ log("My name is " ~ i, info=True) }}
    {% endfor %}
{% endmacro %}