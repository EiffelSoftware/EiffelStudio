note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEMPLATE_STRUCTURE_ACTION_HTMLENTITIES

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
			process_htmlentities
		end

feature {NONE} -- Implementation

	process_htmlentities
		local
			item_output: STRING
			utf: UTF_CONVERTER
			s32: READABLE_STRING_32
		do
			s32 := utf.utf_8_string_8_to_string_32 (foreach_iteration_string (inside_text, False))

			item_output := (create {HTML_ENCODER}).encoded_string (s32)
			set_forced_output (item_output)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
