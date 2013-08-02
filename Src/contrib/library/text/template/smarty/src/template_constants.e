note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_CONSTANTS

feature {NONE} -- Constants

	if_op_id: STRING = "if"
	if_unless_id: STRING = "unless"
	include_op_id: STRING = "include"
	nl2br_op_id: STRING = "nl2br"
	htmlentities_op_id: STRING = "htmlentities"
	literal_op_id: STRING = "literal"
	foreach_op_id: STRING = "foreach"
	assign_op_id: STRING = "assign"

	condition_param_id: STRING = "condition"
	isset_param_id: STRING = "isset"
	isempty_param_id: STRING = "isempty"
	literal_param_id: STRING = "literal"
	file_param_id: STRING = "file"
	name_param_id: STRING = "name"
	tab_param_id: STRING = "tab"
	value_param_id: STRING = "value"
	expression_param_id: STRING = "expression"
	from_param_id: STRING = "from"
	item_param_id: STRING = "item"
	key_param_id: STRING = "key"

	yes_value_id: STRING = "yes"
	no_value_id: STRING = "no"

note
	copyright: "2011-2013, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
