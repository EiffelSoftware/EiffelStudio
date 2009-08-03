note
	description: "Tests for EV_BUTTON"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_BUTTON

inherit
	VISION2_TEST_SET

feature -- Test routines

	button_set_text
			-- Set the text and reads it again.
		local
			l_button: EV_BUTTON
		do
			create l_button
			l_button.set_text ("Button")

			assert ("text_correct: '" + l_button.text + "' instead of " + "'Button'", l_button.text.is_equal ("Button"))
		end

end
