note
	description: "Tests for EV_WINDOW"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_WINDOW

inherit
	TEST_VISION2
	
feature -- Test routines

	resize_action_called
			-- Checks if resize actions are called correctly
		do
			run_test (agent
			do
				flag := False
				window.resize_actions.extend_kamikaze (agent (x, y, width, height: INTEGER) do
					flag := True
				end)

				window.set_size (100, 100)
				application.process_events

				assert ("Resize action called", flag)

				--assert ("text_correct: '" + l_button.text + "' instead of " + "'Button'", l_button.text.is_equal ("Button"))
			end)
		end

	flag: BOOLEAN
		
end
