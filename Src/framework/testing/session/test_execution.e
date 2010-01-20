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

	ROTA_PARALLEL_TASK_I [TEST_EXECUTOR_QUEUE]
		redefine
			step,
			remove_task
		end

	TEST_SUITE_OBSERVER
		redefine
			on_test_removed
		end

	DISPOSABLE_SAFE

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
			create queues.make (1)
			create running_test_map.make (10)
			create group_map.make (10)

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
				Result := ((initial_test_count - queued_test_count - running_test_count)/initial_test_count).truncated_to_real
			else
				Result := {REAL_32} 1.0
			end
		end

	running_tests: ARRAYED_LIST [TEST_I]
			-- <Precursor>
		local
			l_map: like running_test_map
		do
			l_map := running_test_map
			create Result.make (l_map.count)
			from
				l_map.start
			until
				l_map.after
			loop
				Result.force (l_map.key_for_iteration)
				l_map.forth
			end
		end

	queued_tests: ARRAYED_LIST [TEST_I]
			-- <Precursor>
		local
			l_queues: like queues
		do
			create Result.make (queued_test_count.to_integer_32)

			l_queues := queues
			from
				l_queues.start
			until
				l_queues.after
			loop
				l_queues.item_for_iteration.append_queued_tests (Result)
				l_queues.forth
			end
		end

	sleep_time: NATURAL
			-- <Precursor>
			--
			-- TODO: make variable
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

feature {TEST_EXECUTOR_QUEUE} -- Access

	running_groups: NATURAL_64
			-- Bit pattern indicating what serial groups are currently running

feature {NONE} -- Access: task

	tasks: ARRAYED_LIST [like new_task_data]
			-- <Precursor>

feature {TEST_EXECUTOR_QUEUE} -- Access: counting

	queued_test_count: NATURAL
			-- Current number of tests in `executor_queue_map'

	running_test_count: NATURAL
			-- Current number of running tests

feature {NONE} -- Access: tests

	queues: ARRAYED_LIST [TEST_EXECUTOR_QUEUE]
			-- Queues which are used in next or current execution

	running_test_map: HASH_TABLE [like running_groups, TEST_I]
			-- Table mapping currently running tests to the corresponding {TEST_EXECUTOR_I} instance
			--
			-- key: running test.
			-- value: group the running test belongs to.

feature {NONE} -- Access: execution groups

	group_map: HASH_TABLE [like running_groups, READABLE_STRING_GENERAL]
			-- Table mapping execution group name to an identifier represented by a single {NATURAL_64} bit
			--
			-- Note: the finite bit count for a identifier represents an limitations on how many groups can
			--       be defined.
			--
			-- key: Group name
			-- value: Group identifier

feature -- Status report

	is_test_running (a_test: TEST_I): BOOLEAN
			-- <Precursor>
		do
			Result := running_test_map.has (a_test)
		ensure then
			result_implies_test_in_map: Result implies running_test_map.has (a_test)
		end

	is_test_queued (a_test: TEST_I): BOOLEAN
			-- <Precursor>
		local
			l_queues: like queues
		do
			l_queues := queues
			from
				l_queues.start
			until
				l_queues.after or Result
			loop
				Result := l_queues.item_for_iteration.is_test_queued (a_test)
				l_queues.forth
			end
		end

	is_debugging: BOOLEAN
			-- <Precursor>

feature {NONE} -- Status report

	one_per_step: BOOLEAN = False
			-- <Precursor>

	has_reported_first_result: BOOLEAN
			-- Has `Current' reported any results yet?

feature -- Status setting

	start
			-- <Precursor>
		local
			l_queues: like queues
		do
				-- Mappings in `group_map' no longer needed
			group_map.wipe_out
			initial_test_count := queued_test_count
			has_reported_first_result := False

			l_queues := queues
			if not l_queues.is_empty then
					-- This means tests have actually been queued before launching `Current'
				append_output (agent (a_formatter: TEXT_FORMATTER)
					do
						a_formatter.process_basic_text ("Executing " + initial_test_count.out + " tests")
						a_formatter.add_new_line
						a_formatter.add_new_line
					end, True)
				from
					l_queues.start
				until
					l_queues.after
				loop
					append_task (l_queues.item_for_iteration)
					l_queues.forth
				end
			end
		end

	queue_test (a_test: TEST_I)
			-- <Precursor>
		local
			l_groups: TAG_SEARCH_TABLE
			l_group_name: READABLE_STRING_GENERAL
			l_group, l_new_group: NATURAL_64
			l_group_map: like group_map
			l_queue: detachable TEST_EXECUTOR_QUEUE
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
				create l_queue.make (Current, l_executor)
				queues.force (l_queue)
			end

				-- Add test to executor set
			l_queue.queue_test (a_test, l_group)
			queued_test_count := queued_test_count + 1
		end

	abort_test (a_test: TEST_I)
			-- <Precursor>
		local
			l_queue: like queue_for_test
		do
			if is_test_running (a_test) then
				remove_running_test (a_test, create {TEST_UNRESOLVED_RESULT}.make (e_test_aborted_tag, e_test_aborted_details, [a_test.name]))
			else
				remove_queued_test (a_test)
			end
		end

	step
			-- <Precursor>
		do
			Precursor
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

	report_result (a_test: TEST_I; a_result: TEST_RESULT_I)
			-- <Precursor>
		do
			remove_running_test (a_test, a_result)
		end

feature {TEST_EXECUTOR_QUEUE} -- Element change

	remove_queued_test (a_test: TEST_I)
			-- Remove test still waiting in queue.
			--
			-- `a_test': Queued test to be removed.
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_test_running: is_test_queued (a_test)
		local
			l_queue: like queue_for_test
		do
			l_queue := queue_for_test (a_test)
			check has_queue: l_queue /= Void end
			check l_queue.is_test_queued (a_test) end
			l_queue.remove_queued_test (a_test)
			queued_test_count := queued_test_count - 1
			test_removed_event.publish ([Current, a_test])
		ensure
			test_removed: not has_test (a_test)
		end

feature {NONE} -- Element change

	remove_running_test (a_test: TEST_I; a_result: TEST_RESULT_I)
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
			l_queue: like queue_for_test
			l_executor: TEST_EXECUTOR_I [TEST_I]
			l_map: like running_test_map
		do
			l_queue := queue_for_test (a_test)
			check l_queue /= Void end
			l_executor := l_queue.executor
			if l_executor.is_running_test (a_test) then
				l_executor.abort_test (a_test)
			end
			l_map := running_test_map
			running_groups := running_groups.bit_xor (l_map.item (a_test))
			l_map.remove (a_test)
			running_test_count := running_test_count - 1
			publish_test_result (a_test, a_result)
		ensure
			test_removed: not has_test (a_test)
			result_added: record.has_result_for_test (a_test) and then
				record.result_for_test (a_test) = a_result
		end

	publish_test_result (a_test: TEST_I; a_result: TEST_RESULT_I)
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

feature {TEST_EXECUTOR_QUEUE} -- Basic operations

	launch_test (a_test: TEST_I; an_executor: TEST_EXECUTOR_I [TEST_I]; a_group: like running_groups)
			-- Launch test in given executor.
			--
			-- `a_test': Test to be launched.
			-- `an_executor': Executor capable of launchging `a_test'.
		require
			a_test_usable: a_test.is_interface_usable
			an_executor_usable: an_executor.is_interface_usable
			an_executor_available: an_executor.is_available
			a_test_compatible: an_executor.is_test_compatible (a_test)
			a_group_valid: running_groups.bit_and (a_group) = 0
		do
			queued_test_count := queued_test_count - 1
			running_test_count := running_test_count + 1
			running_groups := running_groups.bit_or (a_group)
			running_test_map.force (a_group, a_test)
			test_running_event.publish ([Current, a_test])
			an_executor.run_test (a_test)
		end

feature {NONE} -- Basic operations

	remove_task (a_force: BOOLEAN)
			-- <Precursor>
		local
			l_abort: BOOLEAN
			l_executor: TEST_EXECUTOR_I [TEST_I]
			l_queue: like queue_for_test
		do
				-- The only thing we need to do here is clean everything up if it is the last queue being removed
			if tasks.count = 1 then
				if not running_test_map.is_empty then
					if a_force then
						running_tests.do_all (
							agent (a_test: TEST_I)
								do
									remove_running_test (a_test, create {TEST_UNRESOLVED_RESULT}.make (e_test_aborted_tag, e_test_aborted_details, [a_test.name]))
								end)
					else
						running_tests.do_all (
							agent (a_test: TEST_I)
								do
									remove_running_test (a_test, create {TEST_UNRESOLVED_RESULT}.make (e_executor_failure_tag, e_executor_failure_details, [a_test.generating_type, a_test.name]))
								end)
					end
					check running_test_map_empty: running_test_map.is_empty end
				end
					-- Since all tests should have been removed through `remove_running_test'
				check running_groups_reset: running_groups = 0 end
					-- Emptying the queues should have happened when `cancel' was called on each queue
				check no_queued_tests: queued_tests.is_empty end
				check queue_count_reset: queued_test_count = 0 end
				check run_count_reset: running_test_count = 0 end
				clean_record
				initial_test_count := 0
				queues.do_all (agent {TEST_EXECUTOR_QUEUE}.dispose)
				queues.wipe_out
				append_output (agent (a_formatter: TEXT_FORMATTER)
					do
						a_formatter.add_new_line
						a_formatter.process_basic_text ("Execution complete")
						a_formatter.add_new_line
					end, True)
			end
			Precursor (a_force)
		end

	print_test_result (a_formatter: TEXT_FORMATTER; a_test: TEST_I; a_result: TEST_RESULT_I)
			-- Print formatted output for new test result
		require
			a_formatter_attached: a_formatter /= Void
			a_test_attached: a_test /= Void
			a_result_attached: a_result /= Void
		do
			a_test.print_test (a_formatter)
			a_formatter.process_basic_text (": ")
			a_result.print_result (a_formatter)
			a_formatter.add_new_line
			if not a_result.is_pass then
				a_result.print_details_indented (a_formatter, False, 1)
			end
		end

feature {TEST_SUITE_S} -- Events

	on_test_removed (a_test_suite: TEST_SUITE_S; a_test: TEST_I)
			-- <Precursor>
		do
			if is_test_running (a_test) then
				remove_running_test (a_test, create {TEST_UNRESOLVED_RESULT}.make (e_test_removed_tag, e_test_removed_details, [a_test.name]))
			elseif is_test_queued (a_test) then
				remove_queued_test (a_test)
			end
		end

feature {NONE} -- Events

	test_running_event: EVENT_TYPE [TUPLE [session: TEST_EXECUTION_I; test: TEST_I]]
			-- <Precursor>

	test_executed_event: EVENT_TYPE [TUPLE [session: TEST_EXECUTION_I; test: TEST_I; test_result: TEST_RESULT_I]]
			-- <Precursor>

	test_removed_event: EVENT_TYPE [TUPLE [session: TEST_EXECUTION_I; test: TEST_I]]
			-- <Precursor>

feature {NONE} -- Implementation

	queue_for_test (a_test: TEST_I): detachable TEST_EXECUTOR_QUEUE
			-- Corresponding queue for test if already initialized.
		require
			a_test_attached: a_test /= Void
			a_test_usable: a_test.is_interface_usable
		local
			l_queues: like queues
			--l_map: like test_queue_map
			--l_sets: like test_queues
		do
			l_queues := queues
			from
				l_queues.start
			until
				l_queues.after or Result /= Void
			loop
				if l_queues.item_for_iteration.executor.is_test_compatible (a_test) then
					Result := l_queues.item_for_iteration
				else
					l_queues.forth
				end
			end
		ensure
			usable_result: Result /= Void implies Result.is_interface_usable
			valid_result: Result /= Void implies Result.executor.is_test_compatible (a_test)
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				if has_next_step then
					cancel
				else
					queued_tests.do_all (agent remove_queued_test)
				end
			end
		end

feature {NONE} -- Constants

	group_prefix: STRING = "execution/serial"
			-- Prefix for execution group tags

feature {NONE} -- Internationalization

	e_test_removed_tag: STRING = "Removed"
	e_test_removed_details: STRING = "Test $1 was removed from the test suite before it was executed"

	e_test_aborted_tag: STRING = "Aborted"
	e_test_aborted_details: STRING = "The execution of $1 was aborted by the user"

	e_executor_failure_tag: STRING = "Internal Failure"
	e_executor_failure_details: STRING = "[
			The executor for a test of type $1 failed to report a test result for test $2
		]"

invariant
	test_suite_attached: test_suite /= Void
	queues_attached: queues /= Void
	running_test_map_attached: running_test_map /= Void
	group_map_attached: group_map /= Void

	group_map_has_power_of_twos: group_map.linear_representation.for_all (
		agent (a_value: like running_groups): BOOLEAN
			do
				Result := a_value > 0 and (a_value - 1).bit_and (a_value) = 0
			end)

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
