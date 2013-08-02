note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEMPLATE_STRUCTURE_ACTION_LITERAL

inherit
	TEMPLATE_STRUCTURE_ACTION
		redefine
			process,
			is_literal_action
		end

create {TEMPLATE_STRUCTURE_ACTION_FACTORY}
	make

feature -- Output

	process
		do
			Precursor
			process_literal
		end

feature {NONE} -- Implementation

	is_literal_action: BOOLEAN = True

	process_literal
		require
			is_literal_action
		do
			set_forced_output (inside_text)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
