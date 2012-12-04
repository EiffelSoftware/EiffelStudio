note
	description: "Error for invalid regexps."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_REGEXP

inherit
	CONF_ERROR_PARSE
		rename
			make as make_parse
		redefine
			text
		end
create
	make

feature {NONE} -- Initialization

	make (a_regexp: STRING)
			-- Create.
		do
			regexp := a_regexp
		end

feature -- Access

	text: STRING_32
			-- Error text.
		do
			if file /= Void then
				Result := {STRING_32} "Parse error in " + file + {STRING_32} ": Invalid regexp: " + regexp
			else
				Result := {STRING_32} "Parse error: Invalid regexp: " + regexp
			end
		end

feature {NONE} -- Implementation

	regexp: STRING;
		-- Incorrect regular expression.

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
