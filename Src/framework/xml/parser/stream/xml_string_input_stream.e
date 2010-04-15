note
	description: "Summary description for {XML_STRING_INPUT_STREAM}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_STRING_INPUT_STREAM

inherit
	XML_INPUT_STREAM

create
	make,
	make_empty

feature {NONE} -- Initialization

	make (a_string: READABLE_STRING_8)
		do
			source := a_string
			count := a_string.count
		end

	make_empty
		do
			make ("")
		end

feature -- Status report

	count: INTEGER

	end_of_input: BOOLEAN
		do
			Result := source_index = count
		end

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

	last_character: CHARACTER

feature -- Basic operation

	read_character
		local
			c: CHARACTER
		do
			c := source.item (source_index)
			source_index := source_index + 1

			if last_character = '%N' then
				line := line + 1
				column := 0
			else
				column := column + 1
			end
			column := 0
			last_character := c
		end

	rewind
		do
			source_index := source_index - 1
			last_character := source.item (source_index)
		end

	start
		do
			source_index := 1
			line := 1
			column := 1
		end

	close
		do
		end

feature {NONE} -- Implementation

	source_index: INTEGER

	source: STRING

invariant
	source_attached: source /= Void

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
