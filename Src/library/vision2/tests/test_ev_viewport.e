note
	description: "Tests for EV_VIEWPORT"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_VIEWPORT

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

feature -- Test routines

	test_viewport_item_size
			-- Checks if the an item in a viewport is resized to the correct size:
			-- By default an item inside a viewport should expand to take on the size of the viewport
		note
			testing: "execution/isolated"
		do
			run_test (agent viewport_item_size)
		end

feature {NONE} -- Actual Test

	viewport_item_size
		local
			viewport: EV_VIEWPORT
			button: EV_BUTTON
			window: EV_TITLED_WINDOW
		do
			create window.make_with_title ("Test window")
			window.set_size (100, 100)

			create viewport
			create button.make_with_text ("Button")
			viewport.extend (button)
			window.extend (viewport)

			assert ("width_correct: " + button.width.out + " instead of " + viewport.width.out, button.width = viewport.width)
			assert ("height_correct ", button.height = viewport.height)
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
