note
	description: "Summary description for {XML_STRING_OUTPUT_STREAM}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_STRING_OUTPUT_STREAM

inherit
	XML_OUTPUT_STREAM

create
	make, make_empty

feature {NONE} -- Initialization

	make_empty
			-- Create a blank stream.
		do
			create string.make_empty
		end

	make (a_string: STRING)
			-- Create current stream for file `a_string'
		require
			a_string_attached: a_string /= Void
		do
			string := a_string
		ensure
			shared: string = a_string
		end

feature -- Access

	name: STRING = "string"
			-- Name of current stream

	string: STRING
			-- Target for the stream

feature -- Status report

	is_open_write: BOOLEAN =True

feature -- Basic operation

	flush
			-- Flush buffered data to disk.
		do
		end

feature -- Output

	put_character (c: CHARACTER)
		do
			string.append_character (c)
		end

	put_string (a_string: STRING)
			-- Write `a_string' to output stream.
		do
			string.append (a_string)
		end

invariant
	string_attached: string /= Void

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
