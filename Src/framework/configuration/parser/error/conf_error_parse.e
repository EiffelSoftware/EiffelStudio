note
	description: "Parse parse error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_PARSE

inherit
	CONF_ERROR

create
	default_create,
	make

feature {NONE} -- Initialization

	make (a_message: READABLE_STRING_GENERAL)
			-- Create.
		require
			a_message_not_void: a_message /= Void
		do
			message := a_message
		end

feature -- Access

	message: detachable READABLE_STRING_GENERAL
			-- Error text.

	file: detachable STRING_32
			-- File with error.

	row: INTEGER
			-- Row of error.

	column: INTEGER;
			-- Column of error.

	parse_mode: INTEGER
			-- Parse mode  (xml or Ace or ..)

	text: STRING_32
			-- Error text.
		do
			create Result.make_from_string ({STRING_32} "Parse error")
			inspect parse_mode
			when Parse_mode_xml then
				Result.append ({STRING_32} " (XML syntax) ")
			when Parse_mode_ace then
				Result.append ({STRING_32} " (ACE syntax) ")
			else
			end
			if attached file as l_file then
				Result.append ({STRING_32} " in " + l_file + {STRING_32} " (line ")
				Result.append_integer (row)
				Result.append ({STRING_32} ", column ")
				Result.append_integer (column)
				Result.append_character (')')
			end
			if attached message as msg then
				Result.append ({STRING_32} ": ")
				Result.append_string_general (msg)
			end
		end

feature -- Update

	reset_parse_mode
			-- Set parse mode as unknown
		do
			parse_mode := Parse_mode_unknown
		end

	set_xml_parse_mode
			-- Set parse mode as Xml
		do
			parse_mode := Parse_mode_xml
		end

	set_ace_parse_mode
			-- Set parse mode as Xml	
		do
			parse_mode := Parse_mode_ace
		end

	set_position (a_file: like file; a_row: like row; a_column: like column)
			-- Set position of an error.
		do
			file := a_file
			row := a_row
			column := a_column
		end

	set_message (a_message: like message)
			-- Set the extended error message to `a_message'.
		do
			message := a_message
		end

feature {NONE} -- Implementation

	Parse_mode_unknown: INTEGER = 0
	Parse_mode_xml: INTEGER = 1
	Parse_mode_ace: INTEGER = 2

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
