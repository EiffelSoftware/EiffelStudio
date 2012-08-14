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
			flag: BOOLEAN_REF
		do
			flag := (False).to_reference
			application.add_idle_action_kamikaze (agent (a_flag: BOOLEAN_REF) do
				a_flag.set_item (True)
			end (flag))

			application.process_events

			assert ("Idle actions called", flag.item)
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
