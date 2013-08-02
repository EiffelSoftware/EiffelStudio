note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_STRUCTURE_ACTION_FACTORY

inherit
	TEMPLATE_CONSTANTS

feature -- Access

	new_action (an: STRING): TEMPLATE_STRUCTURE_ACTION
		require
			an_not_empty: an /= Void and then not an.is_empty
		local
			lan: STRING
		do
			lan := an.as_lower
			if lan.is_equal (foreach_op_id) then
				create {TEMPLATE_STRUCTURE_ACTION_FOREACH} Result.make
			elseif lan.is_equal (assign_op_id) then
				create {TEMPLATE_STRUCTURE_ACTION_ASSIGN} Result.make
			elseif lan.is_equal (literal_op_id) then
				create {TEMPLATE_STRUCTURE_ACTION_LITERAL} Result.make
			elseif lan.is_equal (nl2br_op_id)  then
				create {TEMPLATE_STRUCTURE_ACTION_NL2BR} Result.make
			elseif lan.is_equal (htmlentities_op_id)  then
				create {TEMPLATE_STRUCTURE_ACTION_HTMLENTITIES} Result.make
			elseif
							lan.is_equal (if_op_id)
					or else lan.is_equal (if_unless_id)
					or else lan.is_equal (include_op_id)
			then
				create {TEMPLATE_STRUCTURE_ACTION_GENERIC} Result.make
			else
				create {TEMPLATE_STRUCTURE_ACTION_CUSTOM_ACTION} Result.make
			end
			Result.set_action_name (an)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
