note
	description: "Summary description for {XML_NULL_OUTPUT_STREAM}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_NULL_OUTPUT_STREAM

inherit
	XML_OUTPUT_STREAM

create
	make

feature {NONE} -- Initialization

	make
			-- Create null stream
		do
		end

feature -- Status report

	is_open_write: BOOLEAN = True

feature -- Basic operation

	flush
			-- Flush buffered data to stream.
		do
		end

feature -- Output

	put_character_8 (c: CHARACTER_8)
		do
		end

	put_string_8 (a_string: READABLE_STRING_8)
			-- Write `a_string' to output stream.
		do
		end

	put_character_32 (c: CHARACTER_32)
		do
		end

	put_string_32 (a_string: READABLE_STRING_32)
			-- Write `a_string' to output stream.
		do
		end

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
