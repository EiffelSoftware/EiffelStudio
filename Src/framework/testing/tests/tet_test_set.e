note
	description: "[
			Common ancestor for testing framework tests.
			
			The provided functionality in the class is mostly to initialize a test suite with a number of
			{TEST_I} instances.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TET_TEST_SET

inherit
	EQA_TEST_SET
		rename
			on_prepare as on_prepare_test,
			on_clean as on_clean_test
		redefine
			on_prepare_test,
			on_clean_test
		end

	DISPOSABLE_SAFE
		undefine
			default_create
		end

	TEST_SUITE_OBSERVER
		undefine
			default_create
		redefine
			on_test_added
		end

	TEST_EXECUTION_OBSERVER
		undefine
			default_create
		redefine
			on_test_running,
			on_test_executed
		end

	ROTA_S
		undefine
			default_create
		end

feature {NONE} -- Initialization

	frozen on_prepare_test
			-- <Precursor>
		do
			create tasks.make (10)
			create task_run_event
			create task_finished_event
			create task_removed_event

				-- Register `Current' as a ROTA_S service
			register_service ({ROTA_S}, Current)

			on_prepare
		end

	on_prepare
		do
		end

	register_service (a_type: TYPE [SERVICE_I]; a_service: SERVICE_I)
		local
			l_service: SERVICE_CONSUMER [SERVICE_CONTAINER_S]
		do
			create l_service
			if attached l_service.service as s then
				s.register (a_type, a_service, True)
			end
		end

feature -- Access

	connection: EVENT_CONNECTION [ROTA_OBSERVER, ROTA_S]
			-- <Precursor>
		do
			create Result.make (
				agent (an_observer: ROTA_OBSERVER): ARRAY [TUPLE [EVENT_TYPE [TUPLE], PROCEDURE]]
					do
						Result := <<
							[task_run_event, agent an_observer.on_task_run],
							[task_finished_event, agent an_observer.on_task_finished],
							[task_removed_event, agent an_observer.on_task_remove]
						>>
					end)
		end

feature {TET_MOCK} -- Access: execution

	tests: SEARCH_TABLE [TET_TEST_MOCK]
			-- Instantiated tests
		once
			create Result.make (1000)
		end

	executors: ARRAYED_LIST [TET_EXECUTOR_MOCK [TET_TEST_MOCK]]
			-- Instantiated executors
		once
			create Result.make (10)
		end

feature {NONE} -- Access: rota

	tasks: ARRAYED_LIST [ROTA_TIMED_TASK_I]

	task_run_event: EVENT_TYPE [TUPLE [ROTA_S, ROTA_TIMED_TASK_I]]

	task_finished_event: EVENT_TYPE [TUPLE [ROTA_S, ROTA_TIMED_TASK_I]]

	task_removed_event: EVENT_TYPE [TUPLE [ROTA_S, ROTA_TIMED_TASK_I]]

feature {NONE} -- Access: test suite

	test_suite: TEST_SUITE_S
		local
			l_service_consumer: SERVICE_CONSUMER [TEST_SUITE_S]
		do
			create l_service_consumer
			Result := l_service_consumer.service
			if not attached Result then
				create {TEST_SUITE} Result.make
				Result.test_suite_connection.connect_events (Current)
				register_service ({TEST_SUITE_S}, Result)
			end
		end

feature -- Status report

	has_task (a_task: ROTA_TIMED_TASK_I): BOOLEAN
		do
			Result := tasks.has (a_task)
		end

feature {NONE} -- Query

	assert_test_suite
		local
			l_count, l_execute_count, l_fail_count, l_pass_count: NATURAL
			l_test: TET_TEST_MOCK
			l_stats: TEST_STATISTICS_I
		do
			from
				tests.start
			until
				tests.after
			loop
				l_test := tests.item_for_iteration
				assert ("test_suite_has_test " + L_test.name,
					test_suite.has_test (l_test.name))

				l_count := l_count + 1
				if attached l_test.last_result as l_result then
					l_execute_count := l_execute_count + 1
					if l_result.is_fail then
						l_fail_count := l_fail_count + 1
					elseif l_result.is_pass then
						l_pass_count := l_pass_count + 1
					end
				end
				tests.forth
			end
			l_stats := test_suite.statistics
			assert ("valid_test_count", l_stats.test_count = l_count)

		-- Following is not supported by TEST_STATISTICS as long it was not able to load stats from the EIFGENs
		--	assert ("valid_execute_count", l_stats.executed_test_count = l_execute_count)
		--	assert ("valid_fail_count", l_stats.failing_test_count = l_fail_count)
		--	assert ("valid_pass_count", l_stats.passing_test_count = l_pass_count)
		end

feature -- Basic operations

	run_task (a_task: ROTA_TIMED_TASK_I)
			-- <Precursor>
		local
			l_task: ROTA_TIMED_TASK_I
		do
			tasks.force (a_task)
			if tasks.count = 1 then
				from
				until
					tasks.is_empty
				loop
					if tasks.off then
						tasks.start
					elseif tasks.item_for_iteration.has_next_step then
						l_task := tasks.item_for_iteration
						tasks.forth
						l_task.step
						on_task_step (l_task)
					else
						tasks.remove
					end
				end
			end
		end

feature {NONE} -- Basic operations

	fill_test_suite (a_count: NATURAL)
			-- Fill test suite with tests.
		local
			i: NATURAL
			l_test: TET_TEST_MOCK
			l_groups: TAG_SEARCH_TABLE
			l_tag: READABLE_STRING_32
		do
			assert_test_suite

			from
			until
				i = a_count
			loop
				l_test := new_test
				test_suite.add_test (l_test)
				l_groups := l_test.serial_groups
				from
					l_groups.start
				until
					l_groups.after
				loop
					if l_groups.item_for_iteration.is_empty then
						l_tag := {STRING_32} "execution/serial"
					else
						l_tag := {STRING_32} "execution/serial/" + l_groups.item_for_iteration
					end
					test_suite.tag_tree.add_tag (l_test, l_tag)
					l_groups.forth
				end
				assert ("test_added", tests.has (l_test))
				i := i + 1
			end

			assert_test_suite
		end

feature -- Events

	on_test_running (a_session: TEST_EXECUTION_I; a_test: TEST_I)
		do
			if attached {TET_TEST_MOCK_COUNT} a_test as l_test then
				assert ("test_has_next_step", l_test.has_next_step)
			else
				assert ("not_a_mock_test", False)
			end
		end

	on_test_executed (a_session: TEST_EXECUTION_I; a_test: TEST_I; a_result: TEST_RESULT_I)
		do
			if attached {TET_TEST_MOCK_COUNT} a_test as l_test then
				assert ("test_has_result", l_test.has_result)
				assert ("reported_correct_result", l_test.last_result = a_result)
			else
				assert ("not_a_mock_test", False)
			end
		end

feature {NONE} -- Events

	on_task_step (a_task: ROTA_TIMED_TASK_I)
			-- Called when some task performs a step.
		do
		end

feature {TEST_SUITE_S} -- Events

	on_test_added (a_test_suite: TEST_SUITE_S; a_test: TEST_I)
		do
			if attached {TET_TEST_MOCK} a_test as l_test then
				assert ("test_not_added_yet", not tests.has (l_test))
				tests.force (l_test)
			else
				assert ("not_a_mock_test", False)
			end
		end

feature {NONE} -- Factory

	new_test: TET_TEST_MOCK
		local
			l_result: detachable like new_test
		do
			check redefined: l_result /= Void end
			Result := l_result
		end

feature {NONE} -- Clean up

	frozen on_clean_test
			-- <Precursor>
		local
			l_service: SERVICE_CONSUMER [SERVICE_CONTAINER_S]
		do
			on_clean
			tests.wipe_out
			executors.wipe_out
			create l_service
			l_service.service.revoke ({TEST_SUITE_S}, True)
			l_service.service.revoke ({ROTA_S}, True)
		end

	on_clean
			-- Reset any test specific data.
		do

		end

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
