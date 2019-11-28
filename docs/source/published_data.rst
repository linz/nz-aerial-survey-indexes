.. _published_data:


Published Data
================================

The data described below represents aerial surveys data openly available on the LINZ Data Service:

- NZ Imagery Survey Index, https://data.linz.govt.nz/layer/95677

- NZ Elevation Survey Index, https://data.linz.govt.nz/layer/104252


Schema: {{ schema_gen_aerial_lds["name"] }}
--------------------------------------------------------

Description: {{ schema_gen_aerial_lds["comment"] }}


{% for item in schema_tab_aerial_lds  %}
.. _table-name-{{item.table_nam}}:

Table: {{ item.table_nam }}
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	
Description: {{ item.table_comment }}

		{% for table in item.table_columns %}{%  for column in table %}{{ column }}{% endfor %}
		{% endfor %}
	      
		

{% endfor %}