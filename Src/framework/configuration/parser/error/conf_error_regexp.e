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

	CONF_INTERFACE_CONSTANTS
		undefine
			out
		end

create
	make

feature {NONE} -- Initialization

	make (a_regexp: READABLE_STRING_GENERAL; d: READABLE_STRING_GENERAL; p: INTEGER)
			-- Create an error for a regular expression `a_regexp' with description `d' and position `p'.
		do
			regexp := a_regexp
			message := d
			position := p
		ensure
			regexp_set: regexp = a_regexp
			message_set: message = d
			position_set: position = p
		end

feature -- Access

	text: STRING_32
			-- Error text.
		do
			Result := conf_interface_names.e_parse_invalid_regexp (regexp, file, message, position)
		end

feature {NONE} -- Implementation

	regexp: READABLE_STRING_GENERAL
			-- Incorrect regular expression.

	position: INTEGER
			-- Error position.

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
