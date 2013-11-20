note
	description : "Objects that ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_CHARACTER_8_OUTPUT_STREAM

inherit
	XML_OUTPUT_STREAM
		redefine
			put_string_32_escaped
		end

feature -- Output character

	put_character_32 (c: CHARACTER_32)
		do
			if c.is_character_8 then
				put_character_8 (c.to_character_8)
			else
				check is_valid_as_character_8: False end
			end
		end

	put_string_32 (a_string_32: READABLE_STRING_32)
			-- Write `a_string_32' to ouput stream
		do
			if a_string_32.is_valid_as_string_8 then
				put_string_8 (a_string_32.to_string_8)
			else
				check is_valid_as_string_8: False end
			end
		end

	put_string_32_escaped (a_string_32: READABLE_STRING_32)
		do
			put_string_8 (xml_escaped_string (a_string_32))
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
