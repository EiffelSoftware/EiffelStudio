note
	description: "[
		Integration tests addressing basic test queueing and execution.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual", "covers/{TEST_EXECUTION}"

class
	TET_TEST_BASIC_EXECUTION

inherit
	TET_TEST_SET
		redefine
			on_prepare,
			on_task_step,
			new_test
		end

feature {NONE} -- Initialization

	on_prepare
			-- <Precursor>
		do
			random.start
			fill_test_suite (100)
		end

feature -- Test routines

	test_basic_execution
			-- New test routine
		local
			l_execution: TEST_EXECUTION
			l_count: INTEGER
			l_executor: TET_EXECUTOR_MOCK [TET_TEST_MOCK]
		do
			create l_execution.make (test_suite, False)
			l_execution.connection.connect_events (Current)

			from
				tests.start
			until
				tests.after
			loop
				l_execution.queue_test (tests.item_for_iteration)
				tests.forth
			end

			test_suite.launch_session (l_execution)

			l_execution.connection.disconnect_events (Current)

			assert_test_suite

			from
				executors.start
			until
				executors.after
			loop
				l_executor := executors.item_for_iteration
				l_count := l_count + l_executor.running_test_count
				executors.forth
			end

			assert ("all_tests_run", l_count = tests.count)
		end

feature {NONE} -- Events

	on_task_step (a_task: ROTA_TIMED_TASK_I)
			-- <Precursor>
		do
			assert ("finite_execution", rota_step_count < max_rota_steps)
			rota_step_count := rota_step_count + 1
		end

feature {NONE} -- Access

	max_rota_steps: NATURAL = 10000

	rota_step_count: NATURAL

	serial_groups: ARRAY [STRING]
		once
			Result := << "", "group1", "group2", "group3" >>
		end

	random: RANDOM
		once
			create Result.make
		end

feature {NONE}	-- Factory

	new_test: TET_TEST_MOCK
		local
			l_rand, l_pattern, i: INTEGER
		do
			random.forth
			l_rand := random.item_for_iteration
			if l_rand \\ 2 = 0 then
				create {TET_TEST_MOCK_COUNT_A} Result.make (Current)
			else
				create {TET_TEST_MOCK_COUNT_B} Result.make (Current)
			end

			if l_rand \\ 3 = 0 then
				from
					l_pattern := 4
					i := serial_groups.lower
				until
					i > serial_groups.upper
				loop
					if l_rand.bit_and (l_pattern) /= 0 then
						Result.serial_groups.force (serial_groups.item (i))
					end
					l_pattern := l_pattern*2
					i := i + 1
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


