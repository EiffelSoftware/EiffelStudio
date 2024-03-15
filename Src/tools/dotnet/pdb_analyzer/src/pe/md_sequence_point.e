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

	make (a_il_offset, a_start_line, a_start_column, a_end_line, a_end_column: NATURAL_32)
		do
			il_offset := a_il_offset
			start_line := a_start_line
			start_column := a_start_column
			end_line := a_end_line
			end_column := a_end_column
		end

feature -- Access

	il_offset: NATURAL_32
	start_line: NATURAL_32
	start_column: NATURAL_32
	end_line: NATURAL_32
	end_column: NATURAL_32

feature -- Status report

	debug_output: STRING_8
		local
			hex: STRING
		do
			create Result.make (10)
			Result.append_character ('#')
			hex := il_offset.to_hex_string
			from

			until
				hex.count <= 1 or hex[1] /= '0'
			loop
				hex.remove_head (1)
			end
			Result.append (hex)
			Result.append_character ('[')
			Result.append_natural_32 (start_line)
			Result.append_character (':')
			Result.append_natural_32 (start_column)
			Result.append_character (' ')
			Result.append_natural_32 (end_line)
			Result.append_character (':')
			Result.append_natural_32 (end_column)
			Result.append_character (']')
		end

end
