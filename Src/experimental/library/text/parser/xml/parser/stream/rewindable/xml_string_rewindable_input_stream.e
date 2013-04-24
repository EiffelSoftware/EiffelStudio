note
	description: "Summary description for {XML_STRING_REWINDABLE_INPUT_STREAM}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_STRING_REWINDABLE_INPUT_STREAM

inherit
	XML_STRING_INPUT_STREAM
		redefine
			start, read_character
		end

	XML_REWINDABLE_INPUT_STREAM

create
	make,
	make_empty

feature -- Basic operation

	read_character
		local
			c: CHARACTER
		do
			c := source.item (source_index)
			source_index := source_index + 1


			if last_character = '%N' then
				line := line + 1
				previous_line_count := column
				column := 0
			else
				column := column + 1
			end
			last_character := c

			end_of_input := source_index > count
		end

	start
		do
			Precursor
			previous_line_count := 0
		end

	rewind
		do
			source_index := source_index - 1
			last_character := source.item (source_index)
			if last_character = '%N' then
				line := line - 1
				column := previous_line_count
				previous_line_count := 0 --| if we rewind more than one line, too bad
			else
				column := column - 1
			end
			end_of_input := source_index > count
		end

feature {NONE} -- Implementation

	previous_line_count: INTEGER
			-- Keep previous line's length
			-- to set the `column' during `rewind'

;note
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
