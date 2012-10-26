note
	description: "Summary description for {XML_INPUT_STREAM}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_INPUT_STREAM

feature -- Status report

	name_is_valid_as_string_8: BOOLEAN
			-- Is associated name a valid string_8 value?
		deferred
		end

feature -- Access		

	name: STRING_8
			-- Name of current stream
		require
			name_is_valid_as_string_8: name_is_valid_as_string_8
		deferred
		end

	name_32: READABLE_STRING_32
		deferred
		end

feature -- Status report

	end_of_input: BOOLEAN
			-- Has the end of input stream been reached?
		deferred
		end

	is_open_read: BOOLEAN
			-- Can items be read from input stream?
		deferred
		end

feature -- Access

	index: INTEGER
			-- Current position in the input stream
		deferred
		end

	line: INTEGER
			-- Current line number
		deferred
		end

	column: INTEGER
			-- Current column number
		deferred
		end

	last_character_code: NATURAL_32
			-- Last read character
		deferred
		end

feature -- Basic operation

	read_character_code
			-- Read a character's code
			-- and keep it in `last_character_code'
		require
			not_end_of_input: not end_of_input
		deferred
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
