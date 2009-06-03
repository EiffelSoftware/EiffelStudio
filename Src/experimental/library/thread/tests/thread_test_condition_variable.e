note
	description: "[
		Unit tests for {CONDITION_VARIABLE}
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_TEST_CONDITION_VARIABLE

inherit
	THREAD_TEST_SET

feature -- Test routines

	test_001_cond_timedwait_failure
			-- A system performing repeated calls to the C underlying routine `pthread_cond_timedwait' may
			-- fail because the timeout is improperly specified.

			-- Note: Copy of eweasel test thread001.
		note
			testing: "covers/{CONDITION_VARIABLE}.wait_with_timeout"
		local
			l_mutex: MUTEX
			l_cond: CONDITION_VARIABLE
			l_wt: WORKER_THREAD
		do
			create l_mutex.make
			create l_cond.make

			create l_wt.make (
				agent (a_mutex: MUTEX; a_cond: CONDITION_VARIABLE)
					local
						i: NATURAL
						b: BOOLEAN
					do
						from
							a_mutex.lock
							i := 1
						until
							i > 1000
						loop
							b := a_cond.wait_with_timeout (a_mutex, 10)
							i := i + 1
						end
						a_mutex.unlock
					end (l_mutex, l_cond))

			l_wt.launch
			l_wt.join_all
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
