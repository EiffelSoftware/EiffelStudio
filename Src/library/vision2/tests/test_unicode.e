note
	description: "Tests for Unicode text"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_UNICODE

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

feature -- Test routines

	button_set_surrogate_text
			-- Set the text and reads it again.
		note
			testing: "execution/isolated"
		local
			l_button: EV_BUTTON
			l_string: STRING_32
		do
			create l_button
			create l_string.make (3)
				-- Surrogate pair code point
			l_string.append_code (0x10000)
			l_string.append_code (0x1D11E)
			l_string.append_code (0x10FFFD)
			l_button.set_text (l_string)

			assert ("Surrogate pair code point correct", l_button.text.is_equal (l_string) and then l_button.text.count = l_string.count)
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
