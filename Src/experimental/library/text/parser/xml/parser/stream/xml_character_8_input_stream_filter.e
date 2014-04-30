note
	description: "Summary description for {XML_CHARACTER_8_INPUT_STREAM_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_CHARACTER_8_INPUT_STREAM_FILTER

inherit
	XML_INPUT_STREAM

feature -- Change

	set_source (src: like source)
		do
			source := src
		end

feature -- Access

	source: XML_CHARACTER_8_INPUT_STREAM

feature -- Access		

	name: READABLE_STRING_32
		do
			Result := source.name
		end

feature -- Status report

	end_of_input: BOOLEAN
			-- Has the end of input stream been reached?
			-- i.e: cursor is out of stream range.
		do
			Result := source.end_of_input
		end

	is_open_read: BOOLEAN
			-- Can items be read from input stream?
		do
			Result := source.is_open_read
		end

feature -- Access

	index: INTEGER
			-- Current position in the input stream
		do
			Result := source.index
		end

	line: INTEGER
			-- Current line number
		do
			Result := source.line
		end

	column: INTEGER
			-- Current column number
		do
			Result := source.column
		end

	last_character_code: NATURAL_32
			-- Last read character
		deferred
		end

feature -- Basic operation

	read_character_code
			-- Read a character's code
			-- and keep it in `last_character_code'
		deferred
		end

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
