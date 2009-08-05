note
	description: "Tests for NS_TIMER."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_NS_TIMER

inherit
	EQA_TEST_SET

	EXECUTION_ENVIRONMENT

feature -- Test routines

	simple_timer
			-- If timers do not work, this test will not terminate.
		local
			timer: NS_TIMER
			flag: BOOLEAN_REF
			application: NS_APPLICATION
			ms_passed: INTEGER
		do
			create application.make
			create flag
			create timer.scheduled_timer (1.0, agent (a_flag: BOOLEAN_REF)
				do
					a_flag.set_item (True)
				end (flag), Void, False)
			from
				ms_passed := 0
			until
				flag.item or ms_passed > 1100
			loop
				sleep (100_000_000) -- 100ms
				ms_passed := ms_passed + 100
				application.process_events
			end
			assert ("Timer did not fire!", flag.item)
		end

end
