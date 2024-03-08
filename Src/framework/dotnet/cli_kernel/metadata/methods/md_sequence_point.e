note
	description: "Summary description for {MD_SEQUENCE_POINT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_SEQUENCE_POINT

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_il_offset, a_start_line, a_start_column, a_end_line, a_end_column: INTEGER_32)
		do
			il_offset := a_il_offset
			start_line := a_start_line
			start_column := a_start_column
			end_line := a_end_line
			end_column := a_end_column
		end

feature -- Access

	il_offset: INTEGER_32
	start_line: INTEGER_32
	start_column: INTEGER_32
	end_line: INTEGER_32
	end_column: INTEGER_32

feature -- Status report

	debug_output: STRING_8
		do
			create Result.make (10)
			Result.append_character ('#')
			Result.append_integer (il_offset)
			Result.append_character ('[')
			Result.append_integer (start_line)
			Result.append_character (':')
			Result.append_integer (start_column)
			Result.append_character (' ')
			Result.append_integer (end_line)
			Result.append_character (':')
			Result.append_integer (end_column)
			Result.append_character (']')
		end

end
