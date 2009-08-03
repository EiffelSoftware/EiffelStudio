note
	description: "Tests for EV_VIEWPORT"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_VIEWPORT

inherit
	TEST_VISION2

feature -- Test routines

	viewport_item_size
			-- Checks if the an item in a viewport is resized to the correct size:
			-- By default an item inside a viewport should expand to take on the size of the viewport
		local
			viewport: EV_VIEWPORT
			button: EV_BUTTON
			window: EV_TITLED_WINDOW
		do
			create window

			create viewport
			create button.make_with_text ("Button")
			viewport.extend (button)
			window.extend (viewport)

			assert ("width_correct: " + button.width.out + " instead of " + viewport.width.out, button.width = viewport.width)
			assert ("height_correct ", button.height = viewport.height)
		end

end
