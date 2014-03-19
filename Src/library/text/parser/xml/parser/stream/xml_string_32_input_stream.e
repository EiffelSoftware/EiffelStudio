note
	description: "Summary description for {XML_STRING_32_INPUT_STREAM}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_STRING_32_INPUT_STREAM

inherit
	XML_INPUT_STREAM

create
	make,
	make_empty

feature {NONE} -- Initialization

	make (a_string: READABLE_STRING_32)
		do
			source := a_string
			count := a_string.count
			start
		end

	make_empty
		do
			make ({STRING_32} "")
		end

feature -- Access

	name: STRING_32 = "STRING"
			-- Name of current stream

feature -- Status report

	count: INTEGER

	end_of_input: BOOLEAN
			-- <Precursor>

	is_open_read: BOOLEAN
			-- Can items be read from input stream?
		do
			Result := True
		end

feature -- Access

	index: INTEGER
		do
			Result := source_index - 1
		end

	line: INTEGER

	column: INTEGER

	last_character_code: NATURAL_32
		do
			Result := last_character.natural_32_code
		end

	last_character: CHARACTER_32

feature -- Basic operation

	read_character_code
		do
			read_character
		end

	read_character
		local
			c: like last_character
		do
			if source_index > count then
				end_of_input := True
			else
				c := source.item (source_index)
				source_index := source_index + 1

				if last_character = '%N' then
					line := line + 1
					column := 0
				else
					column := column + 1
				end
				last_character := c
			end
		end

	start
		do
			source_index := 1
			end_of_input := source_index > count
			line := 1
			column := 0
		end

	close
		do
		end

feature {NONE} -- Implementation

	source_index: INTEGER

	source: READABLE_STRING_32

invariant
	source_attached: source /= Void

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
