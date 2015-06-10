note
	description: "Input stream for NULL connector based on string body (in memory)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_NULL_STRING_INPUT_STREAM

inherit
	WGI_NULL_INPUT_STREAM

create
	make

feature {NONE} -- Initialization

	make (s: READABLE_STRING_8)
		do
			body := s
			index := 1
			count := s.count
			last_string := ""
		end

	body: READABLE_STRING_8

	index: INTEGER

	count: INTEGER

feature -- Input

	read_character
			-- Read the next character in input stream.
			-- Make the result available in `last_character'
		do
			last_character := body[index]
			index := index + 1
		end

	read_string (nb: INTEGER)
			-- Read the next `nb' characters and
			-- make the string result available in `last_string'
		local
			e: INTEGER
		do
			e := (index + nb).min (count)
			last_string := body.substring (index, e)
			index := e + 1
		end

feature -- Access

	last_string: STRING_8

	last_character: CHARACTER_8

feature -- Status report

	is_open_read: BOOLEAN
			-- Can items be read from input stream?
		do
			Result := True
		end

	end_of_input: BOOLEAN
			-- Has the end of input stream been reached?
		do
			Result := index > count
		end

invariant

note
	copyright: "2011-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
