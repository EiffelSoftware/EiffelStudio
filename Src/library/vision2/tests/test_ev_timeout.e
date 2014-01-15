note
	description: "Teste for EV_TIMEOUT"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EV_TIMEOUT

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

feature -- Test routines

	test_basic_timer
			-- Registers an EV_TIMOUT with a one second interval and checks its actions are called.
		note
			testing: "execution/isolated"
		do
			run_test (agent basic_timer)
		end

	test_repeated_timer
			-- Registers an EV_TIMOUT and checks if it is called repeatedly (and more or less on timely)
		note
			testing: "execution/isolated"
		do
			run_test (agent repeated_timer)
		end

feature {NONE} -- Actual Test

	basic_timer
			-- Registers an EV_TIMOUT with a one second interval and checks its actions are called.
		local
			timeout: EV_TIMEOUT
			flag: BOOLEAN_REF
			ms_passed: INTEGER
		do
			if attached application as l_appl then
				create timeout.make_with_interval (1000)
				from
					create flag
					timeout.actions.extend (agent (a_flag: BOOLEAN_REF)
						do
							a_flag.set_item (True)
						end (flag))
					ms_passed := 0
				until
					flag.item or ms_passed > 1000
				loop
					l_appl.sleep (100)
					l_appl.process_events
					ms_passed := ms_passed + 100
				end
				assert ("Timeout actions not called!", flag.item)
			else
				assert ("Application not initialized", False)
			end
		end

	repeated_timer
			-- Registers an EV_TIMOUT and checks if it is called repeatedly (and more or less on timely)
		local
			timeout: EV_TIMEOUT
			counter: INTEGER_REF
			ms_passed: INTEGER
		do
			if attached application as l_appl then
				create timeout.make_with_interval (200)
				from
					create counter
					timeout.actions.extend (agent (a_counter: INTEGER_REF)
						do
							a_counter.set_item (a_counter.item + 1)
						end (counter))
				until
					counter.item = 5 or ms_passed > 1000
				loop
					l_appl.sleep (20)
					l_appl.process_events
					ms_passed := ms_passed + 20
				end
				assert ("Timeout actions called " + counter.item.out + " instead of 5 times!", counter.item = 5)
			else
				assert ("Application not initialized", False)
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
