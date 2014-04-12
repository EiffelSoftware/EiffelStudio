note
	description: "Summary description for {AUTOTEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUTOTEST

create
	make

feature {NONE} -- Initialization

	make
		local
			t: TEST_UTF_CONVERTER
		do
				-- Use this as a place holder to manually run some tests outside of
				-- EiffelStudio.
			create t
			t.test_invalid_utf_8
			t.test_invalid_utf_16
			t.test_utf_16_with_escape_character
			t.test_utf_32_with_escape_character_for_utf_16
			t.test_utf_32_with_escape_character_for_utf_8
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
