note

	description: "[
			Abstract definition of positions in XML documents

			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
		]"
	date: "$Date$"
	revision: "$Revision$"

class XML_POSITION

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_source: like source_name; a_byte_index, a_column, a_line: INTEGER)
			-- Create a new position.
		require
			a_byte_index_positive: a_byte_index >= 0
			a_column_positive: a_column >= 0
			a_line_positive: a_line >= 0
		do
			source_name := a_source
			byte_index := a_byte_index
			column := a_column
			line := a_line
		ensure
			source_set: a_source = source_name or else
					((a_source /= Void and attached source_name as n) and then 
					 (a_source.same_string (n)))
			byte_index_set: byte_index = a_byte_index
			column_set: column = a_column
			line_set: line = a_line
		end

feature -- Access

	source_name: detachable STRING_32
			-- Name of source.

	byte_index: INTEGER
			-- Byte index of token in stream

	column: INTEGER
			-- Column of token in stream

	line: INTEGER
			-- Row of token in stream

	row: like line
			-- Alias for `line'
		do
			Result := line
		end

feature -- Output

	to_string_32: STRING_32
			-- Textual representation
		do
			create Result.make_empty
			Result.append_string ({STRING_32} "line: ")
			Result.append_integer (line)
			Result.append_string ({STRING_32} " column: ")
			Result.append_integer (column)
			Result.append_string ({STRING_32} " byte_index: ")
			Result.append_integer (byte_index)
			if attached source_name as n then
				Result.append_string ({STRING_32} " -> ")
				Result.append_string (n)
			end
		end

feature -- Status report

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := to_string_32
		end

invariant
	byte_index_positive: byte_index >= 0
	column_positive: column >= 0
	line_positive: line >= 0

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
