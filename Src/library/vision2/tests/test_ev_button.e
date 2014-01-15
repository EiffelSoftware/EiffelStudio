note
	description: "Tests for EV_BUTTON"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_BUTTON

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

feature -- Test routines

	button_set_text
			-- Set the text and reads it again.
		note
			testing: "execution/isolated"
		local
			l_button: EV_BUTTON
		do
			create l_button
			l_button.set_text ("Button")

			assert ("text_correct: '" + l_button.text + "' instead of " + "'Button'", l_button.text.is_equal ("Button"))
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
