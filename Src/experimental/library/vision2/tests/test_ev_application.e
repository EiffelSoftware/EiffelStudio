note
	description: "Tests for EV_APPLICATION"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_APPLICATION

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

feature -- Test routines

	test_idle_action_called
			-- Checks if idle actions are called correctly
		note
			testing: "execution/isolated"
		do
			run_test (agent idle_action_called)
		end

feature {NONE} -- Actual Test

	idle_action_called
		local
			flag: CELL [BOOLEAN]
		do
			if attached application as l_appl then
				create flag.put (False)
				l_appl.add_idle_action_kamikaze (agent flag.put (True))
				l_appl.process_events
				assert ("Idle actions called", flag.item)
			else
				assert ("Application not initialized.", False)
			end
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
