note
	description: "Summary description for {XML_CHARACTER_8_INPUT_STREAM}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_CHARACTER_8_INPUT_STREAM

inherit
	XML_INPUT_STREAM

feature -- Access

	last_character_code: NATURAL_32
			-- Last read character code
		do
			Result := last_character.natural_32_code
		end

	last_character: CHARACTER_8
			-- Last read character
		deferred
		end

feature -- Basic operation

	read_character_code
			-- Read a character's code
			-- and keep it in `last_character_code'
		do
			read_character
		end

	read_character
			-- Read a character
			-- and keep it in `last_character'
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
