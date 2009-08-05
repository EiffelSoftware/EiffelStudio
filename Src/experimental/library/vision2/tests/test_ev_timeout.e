note
	description: "Teste for EV_TIMEOUT"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EV_TIMEOUT

inherit
	VISION2_TEST_SET

feature -- Test routines

	basic_timer
			-- Registers an EV_TIMOUT with a one second interval and checks its actions are called.
		local
			timeout: EV_TIMEOUT
			flag: BOOLEAN_REF
			ms_passed: INTEGER
		do
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
				application.sleep (100)
				application.process_events
				ms_passed := ms_passed + 100
			end
			assert ("Timeout actions not called!", flag.item)
		end

	repeated_timer
			-- Registers an EV_TIMOUT and checks if it is called repeatedly (and more or less on timely)
		local
			timeout: EV_TIMEOUT
			counter: INTEGER_REF
			ms_passed: INTEGER
		do
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
				application.sleep (20)
				application.process_events
				ms_passed := ms_passed + 20
			end
			assert ("Timeout actions called " + counter.item.out + " instead of 5 times!", counter.item = 5)
		end

end
