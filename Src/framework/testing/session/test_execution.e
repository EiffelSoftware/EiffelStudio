note
	description: "[
		Implementation of {TEST_EXECUTION_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXECUTION

inherit
	TEST_EXECUTION_I

	TEST_SESSION
		undefine
			new_record
		redefine
			make
		end

	ROTA_PARALLEL_TASK_I [TEST_EXECUTOR_I [TEST_I]]
		redefine
			step,
			remove_task
		end

	TEST_SUITE_OBSERVER
		redefine
			on_test_removed
		end

	DISPOSABLE_SAFE

	TEST_RESULT_FORMATTER

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- Initizialize `Current'.
		do
			Precursor (a_test_suite)
			test_suite.test_suite_connection.connect_events (Current)

				-- Task data structures
			create tasks.make (10)

				-- Test data structures
			create test_queues.make (1)
			create running_test_map.make (10)
			create group_map.make (10)
			create available_executors.make

				-- create events
			create test_running_event
			create test_executed_event
			create test_removed_event
		end

feature -- Access

	progress: REAL
			-- <Precursor>
		do
			if initial_test_count > 0 then
				Result := ((initial_test_count - test_count - running_test_map.count.as_natural_32)/initial_test_count).truncated_to_real
			else
				Result := {REAL_32} 1.0
			end
		end

	running_tests: ARRAYED_LIST [TEST_I]
			-- <Precursor>
		do
			create Result.make (running_test_map.count)
			running_test_map.current_keys.do_all (agent Result.force (?))
		end

	queued_tests: ARRAYED_LIST [TEST_I]
			-- <Precursor>
		local
			l_group_map: HASH_TABLE [SEARCH_TABLE [TEST_I], NATURAL_64]
		do
			create Result.make (test_count.as_integer_32)
			test_queues.linear_representation.do_all (
				agent (a_set: TEST_EXECUTION_QUEUE; a_list: like queued_tests)
					local
						l_sets: HASH_TABLE [SEARCH_TABLE [TEST_I], NATURAL_64]
					do
						l_sets := a_set.group_map
						l_sets.linear_representation.do_all (
							agent (a_linear: SEARCH_TABLE [TEST_I]; a_l: like queued_tests)
								do
									a_linear.linear_representation.do_all (agent a_l.force)
								end (?, a_list))
					end (?, Result))
		end

	sleep_time: NATURAL
			-- <Precursor>
		do
			Result := 10
		end

	initial_test_count: NATURAL
			-- <Precursor>

feature -- Access: connection point

	execution_connection: EVENT_CONNECTION_I [TEST_EXECUTION_OBSERVER, TEST_EXECUTION_I]
			-- <Precursor>
		local
			l_cache: like execution_connection_cache
		do
			l_cache := execution_connection_cache
			if l_cache = Void then
				l_cache := create {EVENT_CHAINED_CONNECTION [TEST_EXECUTION_OBSERVER, TEST_EXECUTION_I, TEST_SESSION_OBSERVER, TEST_SESSION_I]}.make
					(agent (an_observer: TEST_EXECUTION_OBSERVER): ARRAY [TUPLE [EVENT_TYPE [TUPLE], PROCEDURE [ANY, TUPLE]]]
						do
							Result := <<
								[test_running_event, agent an_observer.on_test_running],
								[test_executed_event, agent an_observer.on_test_executed],
								[test_removed_event, agent an_observer.on_test_aborted]
							>>
						end,
					connection)
				execution_connection_cache := l_cache
			end
			Result := l_cache
		end

feature {NONE} -- Access: task

	tasks: ARRAYED_LIST [like new_task_data]
			-- <Precursor>

feature {NONE} -- Access: testing

	test_count: NATURAL
			-- Current number of tests in `test_queues'

	test_queues: HASH_TABLE [TEST_EXECUTION_QUEUE, STRING]
			-- Table mapping instantiated test executors to their corresponding queue of tests to be ran
			--
			-- key: type name of executor
			-- valud: test queue for executor

	available_executors: LINKED_LIST [TEST_EXECUTOR_I [TEST_I]]
			-- List of executor which are currently available

	running_test_map: HASH_TABLE [TUPLE [executor: TEST_EXECUTOR_I [TEST_I]; group: NATURAL_64], TEST_I]
			-- Table mapping tests currently being run to their corresponding executor
			--
			-- key: Test being run.
			-- value: Executor running test.

	group_map: HASH_TABLE [like running_groups, READABLE_STRING_GENERAL]
			-- Table mapping execution group name to an identifier represented by a single {NATURAL_64} bit
			--
			-- Note: the finite bit count for a identifier represents an limitations on how many groups can
			--       be defined.
			--
			-- key: Group name
			-- value: Group identifier

	running_groups: NATURAL_64
			-- Bit pattern indicating what execution groups are currently running in `running_test_map'

feature -- Status report

	is_test_running (a_test: TEST_I): BOOLEAN
			-- <Precursor>
		do
			Result := running_test_map.has (a_test)
		ensure then
			result_implies_in_map: Result implies running_test_map.has (a_test)
		end

	is_test_queued (a_test: TEST_I): BOOLEAN
			-- <Precursor>
		do
			if attached queue_for_test (a_test) as l_set then
				Result := l_set.has_test (a_test)
			end
		end

	is_debugging: BOOLEAN
			-- <Precursor>

feature {NONE} -- Status report

	has_availability_changed: BOOLEAN
			-- Has `available_executors' or state of `running_groups' changed since last call to `step'?

	has_launched_test: BOOLEAN
			-- Has last call to `launch_test' actually launched a test?

	one_per_step: BOOLEAN = False
			-- <Precursor>

	has_reported_first_result: BOOLEAN
			-- Has `Current' reported any results yet?

feature -- Status setting

	start
			-- <Precursor>
		do
				-- Mappings in `group_map' no longer needed
			group_map.wipe_out
			initial_test_count := test_count
			has_reported_first_result := False

			if has_availability_changed then
					-- This means tests have actually been queued before launching `Current'
				append_output (agent (a_formatter: TEXT_FORMATTER)
					do
						a_formatter.process_basic_text ("Executing " + initial_test_count.out + " tests")
						a_formatter.add_new_line
						a_formatter.add_new_line
					end, True)
				launch_available_executors
			end
		end

	queue_test (a_test: TEST_I)
			-- <Precursor>
		local
			l_groups: TAG_SEARCH_TABLE
			l_group_name: READABLE_STRING_GENERAL
			l_group, l_new_group: NATURAL_64
			l_group_map: like group_map
			l_queue: detachable TEST_EXECUTION_QUEUE
			l_executor: TEST_EXECUTOR_I [TEST_I]
		do
				-- Compute group identifier for `a_test'
			if test_suite.is_interface_usable and then test_suite.tag_tree.has_item (a_test) then
				l_groups := test_suite.tag_tree.item_suffixes (group_prefix, a_test)
				from
					l_groups.start
					l_group_map := group_map
				until
					l_groups.after
				loop
					l_group_name := l_groups.item_for_iteration
					l_group_map.search (l_group_name)
					if l_group_map.found then
						l_group := l_group.bit_or (l_group_map.found_item)
					elseif l_group_map.count < 64 then
						l_new_group := ({NATURAL_64} 1).bit_shift_left (l_group_map.count)
						l_group := l_group.bit_or (l_new_group)
						l_group_map.force (l_new_group, l_group_name)
					else
							-- If we exceeded the max number of groups, we simply set the bit patterns to ones so the
							-- test will always be executed by itself.
						l_group := l_group.max_value
					end
					l_groups.forth
				end
			end

				-- Find/create executor
			l_queue := queue_for_test (a_test)
			if l_queue = Void then
				l_executor := a_test.new_executor (Current)
				create l_queue.make (l_executor)
				test_queues.force (l_queue, l_executor.generator)
				available_executors.force (l_executor)
				has_availability_changed := True
			end

				-- Add test to executor set
			l_queue.add_test (a_test, l_group)
			test_count := test_count + 1
		end

	abort_test (a_test: TEST_I)
			-- <Precursor>
		local
			l_executor: TEST_EXECUTOR_I [TEST_I]
			l_group_map: HASH_TABLE [SEARCH_TABLE [TEST_I], NATURAL_64]
			l_test_set: SEARCH_TABLE [TEST_I]
		do
			if is_test_running (a_test) then
				remove_running_test (a_test, create {EQA_EMPTY_RESULT}.make ("User abort", Void))
			else
				remove_queued_test (a_test, Void)
			end
		end

	step
			-- <Precursor>
		do
			Precursor
			if has_availability_changed then
				launch_available_executors
			end
			if has_next_step then
				proceeded_event.publish ([Current])
			end
		end

	set_debugging (a_debugging: like is_debugging)
			-- <Precursor>
		do
			is_debugging := a_debugging
		end

feature {TEST_EXECUTOR_I} -- Status setting

	report_result (a_test: TEST_I; a_result: EQA_RESULT)
			-- <Precursor>
		do
			remove_running_test (a_test, a_result)
		end

feature {NONE} -- Element change

	remove_queued_test (a_test: TEST_I; a_result: detachable EQA_RESULT)
			-- Remove test still waiting in queue. If a result is provided, it will be considered executed
			-- and the result is added to `record'. Otherwise it is simply removed.
			--
			-- `a_test': Queued test to be removed.
			-- `a_result': Optional result to be added to record.
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_test_running: is_test_queued (a_test)
			a_result_attached_implies_running: a_result /= Void implies has_next_step
		local
			l_queue: like queue_for_test
			l_map: HASH_TABLE [SEARCH_TABLE [TEST_I], NATURAL_64]
		do
			l_queue := queue_for_test (a_test)
			check has_queue: l_queue /= Void end
			l_map := l_queue.group_map
			from
				l_map.start
			until
				l_map.after
			loop
				l_map.item_for_iteration.remove (a_test)
				if l_map.item_for_iteration.is_empty then
					l_map.remove (l_map.key_for_iteration)
				else
					l_map.forth
				end
			end
			if l_map.is_empty then
				test_queues.remove (l_queue.executor.generator)
			end
			test_count := test_count - 1
			if a_result /= Void then
				publish_test_result (a_test, a_result)
			else
				test_removed_event.publish ([Current, a_test])
			end
		ensure
			test_removed: not has_test (a_test)
			result_added: a_result /= Void implies (record.has_result_for_test (a_test) and then
				record.result_for_test (a_test) = a_result)
		end

	remove_running_test (a_test: TEST_I; a_result: EQA_RESULT)
			-- Add result for running test to record and inform observers after removing the test.
			--
			-- `a_test': Currently running test.
			-- `a_result': Obtained result for `a_test'.
		require
			a_test_attached: a_test /= Void
			a_result_attached: a_result /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_test_running: is_test_running (a_test)
		local
			l_map: like running_test_map
			l_executor: TEST_EXECUTOR_I [TEST_I]
		do
			l_map := running_test_map
			l_map.search (a_test)
			check found: l_map.found end
			running_groups := running_groups.bit_xor (l_map.found_item.group)
			l_executor := l_map.found_item.executor
			l_map.remove (a_test)
			if l_executor.is_interface_usable and then l_executor.is_running_test (a_test) then
				l_executor.abort_test (a_test)
			end

			publish_test_result (a_test, a_result)

				-- Add executor back to `available_executors' if there are still tests queued
			if l_executor.is_interface_usable and then l_executor.is_available and then test_queues.has (l_executor.generator) then
				if not available_executors.has (l_executor) then
					available_executors.force (l_executor)
				end
				has_availability_changed := True
			end
		ensure
			test_removed: not has_test (a_test)
			result_added: record.has_result_for_test (a_test) and then
				record.result_for_test (a_test) = a_result
		end

	publish_test_result (a_test: TEST_I; a_result: EQA_RESULT)
			-- Add result to record and call observers.
			--
			-- `a_test': Test for which result should be added.
			-- `a_result': Result for `a_test'.
		require
			a_test_attached: a_test /= Void
			a_result_attached: a_result /= Void
			a_test_usable: a_test.is_interface_usable
			running: has_next_step
			test_removed: not has_test (a_test)
		local
			l_test_suite: like test_suite
		do
			record.add_result (a_test, a_result)
			append_output (agent print_test_result (?, a_test, a_result), not has_reported_first_result)
			has_reported_first_result := True
			test_executed_event.publish ([Current, a_test, a_result])
		ensure
			result_added: record.has_result_for_test (a_test) and then
				record.result_for_test (a_test) = a_result
		end

feature {NONE} -- Basic operations

	remove_task (a_force: BOOLEAN)
			-- <Precursor>
		local
			l_abort: BOOLEAN
			l_executor: TEST_EXECUTOR_I [TEST_I]
		do
			l_executor := tasks.item_for_iteration.task
			if not test_queues.has (l_executor.generator) then
				l_executor.dispose
			end

				-- If there are still tests queued for `l_executor', it should already be in added to
				-- `available_executors' if it properly reported a result for the last test assigned to it.
				-- Even if test was aborted it was added since this is also done in `remove_running_test'.
				--
				-- The only thing we need to do here is clean everything up if it is the last executor being
				-- removed and no further tests should/must be executed.
			if tasks.count = 1 and (a_force or test_queues.is_empty) then
				if not running_test_map.is_empty then
					if a_force then
						running_tests.do_all (
							agent (a_test: TEST_I)
								do
									report_result (a_test, create {EQA_EMPTY_RESULT}.make ("User abort", Void))
								end)
					else
						running_tests.do_all (
							agent (a_test: TEST_I)
								do
									report_result (a_test, create {EQA_EMPTY_RESULT}.make ("No result", Void))
								end)
					end
					check running_test_map_empty: running_test_map.is_empty end
				end
				check running_groups_reset: running_groups = 0 end
				if not test_queues.is_empty then
					queued_tests.do_all (agent remove_queued_test (?, Void))
					check test_queues_empty: test_queues.is_empty end
				end
				clean_record
				initial_test_count := 0
				test_count := 0
				append_output (agent (a_formatter: TEXT_FORMATTER)
					do
						a_formatter.add_new_line
						a_formatter.process_basic_text ("Execution complete")
						a_formatter.add_new_line
					end, True)
			end
			Precursor (a_force)
		end

	print_test_result (a_formatter: TEXT_FORMATTER; a_test: TEST_I; a_result: EQA_RESULT)
			-- Print formatted output for new test result
		require
			a_formatter_attached: a_formatter /= Void
			a_test_attached: a_test /= Void
			a_result_attached: a_result /= Void
		do
			a_test.print_test (a_formatter)
			a_formatter.process_basic_text (": ")
			print_result (a_formatter, a_result)
			a_formatter.add_new_line
			if not a_result.is_pass then
				print_result_details (a_formatter, a_result, 1)
			end
		end

feature {TEST_SUITE_S} -- Events

	on_test_removed (a_test_suite: TEST_SUITE_S; a_test: TEST_I)
			-- <Precursor>
		do
			if is_test_running (a_test) then
				abort_test (a_test)
			elseif is_test_queued (a_test) then
				remove_queued_test (a_test, Void)
			end
		end

feature {NONE} -- Events

	test_running_event: EVENT_TYPE [TUPLE [session: TEST_EXECUTION_I; test: TEST_I]]
			-- <Precursor>

	test_executed_event: EVENT_TYPE [TUPLE [session: TEST_EXECUTION_I; test: TEST_I; test_result: EQA_RESULT]]
			-- <Precursor>

	test_removed_event: EVENT_TYPE [TUPLE [session: TEST_EXECUTION_I; test: TEST_I]]
			-- <Precursor>

feature {NONE} -- Implementation

	launch_available_executors
			-- Launch tests for any available executors, provided a different test of the same group is not
			-- being executed.
		require
			availability_changed: has_availability_changed
		local
			l_executors: LINKED_LIST [TEST_EXECUTOR_I [TEST_I]]
			l_executor, l_first: detachable TEST_EXECUTOR_I [TEST_I]
			l_queue: TEST_EXECUTION_QUEUE
			l_queues: like test_queues
			l_remove: BOOLEAN
		do
			has_availability_changed := False
			from
				l_queues := test_queues
				l_executors := available_executors
				l_executors.start
			until
				l_executors.after
			loop
				l_executor := l_executors.item_for_iteration
				if l_first = l_executor then
						-- We have reached the first executor again so it's time to return
					l_executors.go_i_th (l_executors.count + 1)
				else
					if l_first = Void then
						l_first := l_executor
					end
					l_queues.search (l_executor.generator)
					check found: l_queues.found end
					l_queue := l_queues.found_item
					l_executors.remove
					launch_test (l_queue)
					if has_launched_test then
						test_count := test_count - 1
						if l_queue.group_map.is_empty then
								-- Queue already removed by `launch_test'
						elseif l_executor.is_available then
								-- If test has been launched but executor is still available, we move executor to end of
								-- list so others will be checked first the next time around
							available_executors.force (l_executor)
							has_availability_changed := True
						end
					else
						available_executors.force (l_executor)
					end
				end
			end
		end

	launch_test (a_queue: TEST_EXECUTION_QUEUE)
			-- Launch a single test in given queue.
			--
			-- `a_queue': Queue in which tests should be launched.
		require
			a_queue_attached: a_queue /= Void
			queue_not_empty: not a_queue.group_map.is_empty
			executor_available: a_queue.executor.is_available
		local
			l_executor: TEST_EXECUTOR_I [TEST_I]
			l_groups: HASH_TABLE [SEARCH_TABLE [TEST_I], NATURAL_64]
			l_set: SEARCH_TABLE [TEST_I]
			l_group: NATURAL_64
			l_test: TEST_I
		do
			has_launched_test := False
			l_executor := a_queue.executor
			l_groups := a_queue.group_map
			from
				l_groups.start
			until
				l_groups.after or has_launched_test
			loop
				l_group := l_groups.key_for_iteration
				if l_group.bit_and (running_groups) = 0 then
					l_set := l_groups.item_for_iteration
					check not_empty: not l_set.is_empty end
					l_set.start
					l_test := l_set.item_for_iteration
					l_set.remove (l_test)
					if l_set.is_empty then
						l_groups.remove (l_group)
						if l_groups.is_empty then
							test_queues.remove (a_queue.executor.generator)
						end
					end
					if not l_executor.has_next_step then
							-- This means it has not been in `tasks' yet
						append_task (l_executor)
					end
					running_groups := running_groups.bit_or (l_group)
					running_test_map.force ([l_executor, l_group], l_test)
					l_executor.run_test (l_test)

						-- We need to check if is actually running since the executor might have already reported
						-- the result.
					if is_test_running (l_test) then
						test_running_event.publish ([Current, l_test])
					end
					has_launched_test := True
				else
					l_groups.forth
				end
			end
		end

	queue_for_test (a_test: TEST_I): detachable TEST_EXECUTION_QUEUE
			-- Corresponding queue for test if already initialized.
		require
			a_test_attached: a_test /= Void
			a_test_usable: a_test.is_interface_usable
		local
			l_sets: like test_queues
		do
			from
				l_sets := test_queues
				l_sets.start
			until
				l_sets.after or Result /= Void
			loop
				if l_sets.item_for_iteration.executor.is_test_compatible (a_test) then
					Result := l_sets.item_for_iteration
				else
					l_sets.forth
				end
			end
		ensure
			valid_result: Result /= Void implies Result.executor.is_test_compatible (a_test)
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				test_queues.linear_representation.do_all (
					agent (a_set: TEST_EXECUTION_QUEUE)
						do
							a_set.executor.dispose
						end)
			end
		end

feature {NONE} -- Constants

	group_prefix: STRING = "execution/serial"
			-- Prefix for execution group tags

invariant
	test_suite_attached: test_suite /= Void
	test_queues_attached: test_queues /= Void
	available_executors_attached: available_executors /= Void
	running_test_map_attached: running_test_map /= Void
	group_map_attached: group_map /= Void
	available_executors_valid: available_executors.for_all (
		agent (a_executor: TEST_EXECUTOR_I [TEST_I]): BOOLEAN
			do
				Result := a_executor.is_interface_usable and then a_executor.is_available and then
					test_queues.has (a_executor.generator)
			end)
	availability_changed_implies_available_executors: has_availability_changed implies not available_executors.is_empty
--	test_queues_valid: test_queues.for_all_with_key (
--		agent (a_queue: TEST_EXECUTION_QUEUE; a_key: STRING): BOOLEAN
--			do
--				Result := a_queue.executor.generator.same_string (a_key) and not a_queue.group_map.is_empty
--			end)
	group_map_has_power_of_twos: group_map.linear_representation.for_all (
		agent (a_value: like running_groups): BOOLEAN
			do
				Result := a_value > 0 and (a_value - 1).bit_and (a_value) = 0
			end)

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
