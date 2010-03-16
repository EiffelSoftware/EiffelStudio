note
	description: "Tests for EV_APPLICATION"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_APPLICATION

inherit
	VISION2_TEST_SET

feature -- Test routines

	idle_action_called
			-- Checks if idle actions are called correctly
		local
			flag: BOOLEAN_REF
		do
			flag := (False).to_reference
			application.add_idle_action_kamikaze (agent (a_flag: BOOLEAN_REF) do
				a_flag.set_item (True)
			end (flag))

			application.process_events

			assert ("Idle actions called", flag.item)
		end

end
