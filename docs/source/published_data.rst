.. _published_data:


Published Data
================================

The data described below represents imagery surveys data openly available on the LINZ Data Service:
https://data.linz.govt.nz

Data Model
--------------------------------

Needs content.


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