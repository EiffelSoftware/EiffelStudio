note
	description: "Summary description for {UTF_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UTF_CONVERTER

feature -- Conversion

	utf_32_string_to_utf_8_string_8 (s: STRING_32): STRING_8
		do
			Result := s.out
		ensure
			class
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
