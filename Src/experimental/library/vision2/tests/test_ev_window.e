note
	description: "Tests for EV_WINDOW"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_WINDOW

inherit
	VISION2_TEST_SET

feature -- Test routines

	resize_action_called
			-- Checks if resize actions are called correctly
		local
			window: EV_TITLED_WINDOW
			flag: BOOLEAN_REF
		do
			create window

			flag := (False).to_reference
			window.resize_actions.extend_kamikaze (agent (a_flag: BOOLEAN_REF; x, y, width, height: INTEGER) do
				a_flag.set_item (True)
			end (flag, ?, ?, ?, ?))

			window.set_size (100, 100)
			application.process_events

			assert ("Resize action called", flag.item)
		end

end
