note
	description: "[
		Objects representing a subset of queued and running tests of some {TEST_EXECUTION} which can be
		executed with the same executor.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXECUTOR_QUEUE

inherit
	ROTA_TASK_I

	DISPOSABLE_SAFE

create {TEST_EXECUTION}
	make

feature {NONE} -- Initialization

	make (an_execution: like execution; an_executor: like executor)
			-- Initialize `Current'.
			--
			-- `an_execution': Execution handling all test queues.
			-- `an_executor': Executor capable of executing tests queued in `Current'.
		require
			an_executor_attached: an_executor /= Void
			an_execution_attached: an_execution /= Void
			an_executor_usable: an_executor.is_interface_usable
		do
			execution := an_execution
			executor := an_executor
			create queued_test_map.make (10)
		end

feature -- Access

	execution: TEST_EXECUTION
			-- Execution handling all test queues

	executor: TEST_EXECUTOR_I [TEST_I]
			-- Executor capable of executing tests queued in `Current'

feature {NONE} -- Access

	queued_test_map: HASH_TABLE [SEARCH_TABLE [TEST_I], like running_groups]
			-- Table mapping execution groups to corresponding test queues. The groups are identified by
			-- a single bit in a 64bit integer. The queue itself is implemented as a set so there is no
			-- guarantee that the tests will be executed in a certain order.
			--
			-- keys: Bit pattern identifying group.
			-- values: Sets containing test that are queued in the corresponding group.

	running_groups: NATURAL_64
			-- Bit pattern identifying serial groups currently running
		do
			Result := execution.running_groups
		end

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>
		do
			Result := executor.has_next_step or not queued_test_map.is_empty
		end

feature -- Query

	is_test_queued (a_test: TEST_I): BOOLEAN
			-- Is test queued?
			--
			-- `a_test': A test.
			-- `Result': True if `a_test' is waiting in a queue, false otherwise.
		local
			l_queues: like queued_test_map
		do
			from
				l_queues := queued_test_map
				l_queues.start
			until
				Result or l_queues.after
			loop
				Result := l_queues.item_for_iteration.has (a_test)
				l_queues.forth
			end
		end

feature -- Element change

	append_queued_tests (a_list: ARRAYED_LIST [TEST_I])
			-- Append and queued tests in `Current' to given list.
			--
			-- `a_list': List to which queued tests should be appended.
		require
			a_list_attached: a_list /= Void
		local
			l_map: like queued_test_map
			l_queue: SEARCH_TABLE [TEST_I]
		do
			l_map := queued_test_map
			from
				l_map.start
			until
				l_map.after
			loop
				l_queue := l_map.item_for_iteration
				from
					l_queue.start
				until
					l_queue.after
				loop
					a_list.force (l_queue.item_for_iteration)
					l_queue.forth
				end
				l_map.forth
			end
		end

feature -- Basic operations

	step
			-- <Precursor>
		local
			l_executor: like executor
			l_group: like running_groups
			l_queues: like queued_test_map
			l_queue: SEARCH_TABLE [TEST_I]
			l_test: TEST_I
		do
			l_executor := executor
			if l_executor.has_next_step then
				l_executor.step
			end

				-- Try to launch new tests
			l_queues := queued_test_map
			from
				l_queues.start
			until
				l_queues.after or not l_executor.is_available
			loop
				l_group := l_queues.key_for_iteration
				if running_groups.bit_and (l_group) = 0 then
					l_queue := l_queues.item_for_iteration
					l_queue.start
					check queue_not_empty: not l_queue.off end
					l_test := l_queue.item_for_iteration

						-- Remove test from queue
					l_queue.remove (l_test)

						-- Remove empty queue from queues
					if l_queue.is_empty then
						l_queues.remove (l_group)
					end

						-- Launch test
					execution.launch_test (l_test, executor, l_group)
				else
					l_queues.forth
				end
			end
		end

	cancel
			-- <Precursor>
		local
			l_tests: ARRAYED_LIST [TEST_I]
		do
			if executor.has_next_step then
				executor.cancel
			end
			create l_tests.make (execution.queued_test_count.to_integer_32)
			append_queued_tests (l_tests)
			l_tests.do_all (agent execution.remove_queued_test)
			check test_map_empty: queued_test_map.is_empty end
		end

	queue_test (a_test: TEST_I; a_group: like running_groups)
			-- Add test to `group_map' under given group.
			--
			-- `a_test': Test to be added.
			-- `a_group': Group id to which test should be added.
		require
			a_test_attached: a_test /= Void
			a_test_usable: a_test.is_interface_usable
			a_test_not_queued: not is_test_queued (a_test)
			a_test_compatible: executor.is_test_compatible (a_test)
		local
			l_queues: like queued_test_map
			l_tests: SEARCH_TABLE [TEST_I]
		do
			l_queues := queued_test_map
			if l_queues.has (a_group) then
				l_tests := l_queues.item (a_group)
			else
				create l_tests.make (10)
				l_queues.force (l_tests, a_group)
			end
			l_tests.force (a_test)
		ensure
			a_test_queued: is_test_queued (a_test)
		end

feature {TEST_EXECUTION} -- Basic operations

	remove_queued_test (a_test: TEST_I)
			-- Remove test from queue without executing.
			--
			-- `a_test': Test to be removed from queue.
		require
			a_test_attached: a_test /= Void
			a_test_queued: is_test_queued (a_test)
		local
			l_queues: like queued_test_map
			l_tests: detachable SEARCH_TABLE [TEST_I]
			l_group: like running_groups
		do
			from
				l_queues := queued_test_map
				l_queues.start
			invariant
				not l_queues.off
			until
				l_tests /= Void
			loop
				l_group := l_queues.key_for_iteration
				l_tests := l_queues.item_for_iteration
				if not l_tests.has (a_test) then
					l_tests := Void
					l_queues.forth
				end
			end
			l_tests.remove (a_test)
			if l_tests.is_empty then
				l_queues.remove (l_group)
			end
		ensure
			a_test_not_queued: not is_test_queued (a_test)
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				executor.dispose
			end
		end

invariant
	executor_attached: executor /= Void
	queued_test_map_attached: queued_test_map /= Void

	queued_test_map_valid: queued_test_map.linear_representation.for_all (
		agent (a_set: SEARCH_TABLE [TEST_I]): BOOLEAN
			do
				Result := not a_set.is_empty and then a_set.linear_representation.for_all (
					agent (a_test: TEST_I): BOOLEAN
						do
							Result := a_test.is_interface_usable and then
							          executor.is_test_compatible (a_test) and then
							          not executor.is_running_test (a_test)
						end)
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
