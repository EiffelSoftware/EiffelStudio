note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEMPLATE_STRUCTURE_ACTION_NL2BR

inherit
	TEMPLATE_STRUCTURE_ACTION
		redefine
			process
		end

create {TEMPLATE_STRUCTURE_ACTION_FACTORY}
	make

feature -- Output

	process
		do
			Precursor
			process_nl2br
		end

feature {NONE} -- Implementation

	process_nl2br
		local
			item_output: like foreach_iteration_string
		do
			item_output := foreach_iteration_string (inside_text, False)
			item_output.replace_substring_all ("%R%N", "<br/>%N")
			item_output.replace_substring_all ("%N", "<br/>%N")
			if parameters.has (tab_param_id) then
				if attached parameters.item (tab_param_id) as vn and then vn.is_case_insensitive_equal (yes_value_id) then
					item_output.replace_substring_all ("%T", "&nbsp;&nbsp;&nbsp;&nbsp;")
				end
			end

			set_forced_output (item_output)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
