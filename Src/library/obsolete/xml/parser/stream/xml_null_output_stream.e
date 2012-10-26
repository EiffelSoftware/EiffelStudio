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

feature -- Access

	name: STRING = "null"
			-- Name of current stream

feature -- Status report

	is_open_write: BOOLEAN = True

feature -- Basic operation

	flush
			-- Flush buffered data to stream.
		do
		end

feature -- Output

	put_character (c: CHARACTER)
		do
		end

	put_string (a_string: STRING)
			-- Write `a_string' to output stream.
		do
		end

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
