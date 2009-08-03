note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_APPLICATION

inherit
	TEST_VISION2

feature -- Test routines

	flag: BOOLEAN

	idle_action_called
			-- Checks if idle actions are called correctly
		do
			flag := False
			app.add_idle_action_kamikaze (agent do
				flag := True
			end)

			app.process_events

			assert ("Idle actions called", flag)
		end

end
