note
	description: "[
		Mock on an {TEST_EXECUTOR_I} which simulates the execution of {TET_TEST_MOCK} instances.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TET_EXECUTOR_MOCK [G -> TET_TEST_MOCK]

inherit
	TEST_EXECUTOR_I [G]

	TET_MOCK

	ROTA_PARALLEL_TASK_I [G]
		redefine
			remove_task
		end

create
	make

feature {NONE} -- Access

	make (a_test_execution: like test_execution; a_test_set: TET_TEST_SET)
			-- Initialize `Current'.
		do
			create tasks.make (max_running_tests)
			test_execution := a_test_execution
			test_set := a_test_set
		end

feature -- Access

	test_execution: TEST_EXECUTION_I
			-- <Precursor>

	test_set: TET_TEST_SET
			-- Test set using `Current' as a mock

	max_running_tests: INTEGER = 10
			-- Maximal number of running tests

	sleep_time: NATURAL_32 = 0
			-- <Precursor>

feature -- Access: statistics

	running_test_count: INTEGER
			-- Number of tests `Current' ran in total

	concurrent_running_test_count: INTEGER
			-- Number of tests which ran in parallel

feature {NONE} -- Access

	tasks: ARRAYED_LIST [like new_task_data]
			-- <Precursor>

	one_per_step: BOOLEAN = False
			-- <Precursor>

feature -- Status report

	is_available: BOOLEAN
			-- <Precursor>
		do
			Result := tasks.count < max_running_tests
		end

feature -- Status setting

	run_compatible_test (a_test: G)
			-- <Precursor>
		local
			l_groups: TAG_SEARCH_TABLE
			l_group: IMMUTABLE_STRING_8
			l_count: INTEGER
		do
			from
				l_groups := a_test.serial_groups
				l_groups.start
			until
				l_groups.after
			loop
				l_group := l_groups.item_for_iteration
				test_set.assert ("test in serial group " + l_group + " is already running",
					not running_groups.has (l_group))
				running_groups.force (l_group)
				l_groups.forth
			end
			running_test_count := running_test_count + 1
			a_test.start
			append_task (a_test)
			l_count := tasks.count
			if l_count > concurrent_running_test_count then
				concurrent_running_test_count := l_count
			end
		end

feature -- Query

	is_running_test (a_test: TEST_I): BOOLEAN
			-- <Precursor>
		do
			Result := tasks.there_exists (agent (l_data: like new_task_data; l_test: TEST_I): BOOLEAN
				do
					Result := l_data.task = l_test
				end (?, a_test))
		end

feature -- Basic operations

	abort_test (a_test: TEST_I)
			-- <Precursor>
		do
			if attached {G} a_test as l_test then
				check l_test.has_next_step end
				l_test.cancel

				remove_groups (l_test)
			else
				check False end
			end
		end

feature {NONE} -- Basic operations

	remove_task (a_force: BOOLEAN)
		local
			l_test: G
			l_result: detachable EQA_RESULT
		do
			l_test := tasks.item_for_iteration.task
			Precursor (a_force)
			remove_groups (l_test)
			if l_test.has_result then
				l_result := l_test.last_result
				check l_result /= Void end
				test_execution.report_result (l_test, l_result)
			end
		end

	remove_groups (a_test: G)
		do
			a_test.serial_groups.linear_representation.do_all (
				agent (a_group: IMMUTABLE_STRING_8)
					do
						check group_running: running_groups.has (a_group) end
						running_groups.remove (a_group)
					end)
		end

feature {NONE} -- Access: execution table

	running_groups: TAG_SEARCH_TABLE
		once
			create Result.make (100)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
