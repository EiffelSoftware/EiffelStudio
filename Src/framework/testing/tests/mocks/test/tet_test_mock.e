note
	description: "[
		Mock of an {TEST_I} which uses an {TET_EXECUTOR_MOCK} for execution. The executor simply calls
		`step' until `has_next_step' is False, then reports `last_result' as the obtained test result.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TET_TEST_MOCK

inherit
	TEST_I

	TET_MOCK

	ROTA_TASK_I

feature {NONE} -- Initialization

	make (a_test_set: TET_TEST_SET)
			-- Initialize new test.
		local
			l_name: STRING
		do
			test_set := a_test_set
			counter.put (counter.item + 1)
			l_name := "test" + counter.item.out
			create name.make_from_string (l_name)
			create serial_groups.make (10)
		end

feature -- Access

	test_set: TET_TEST_SET
			-- Test set using `Current' to mock some test engine functionality

	name: IMMUTABLE_STRING_8
			-- <Precursor>

	serial_groups: TAG_SEARCH_TABLE
			-- Set containing serial groups

	last_result: detachable EQA_RESULT

feature {NONE} -- Access

	counter: CELL [NATURAL]
			-- Counter used for unique names
		once
			create Result.put (0)
		end

feature -- Status report

	is_aborted: BOOLEAN
		deferred
		ensure
			result_implies_not_executing: Result implies not has_next_step
			result_implies_no_result: Result implies not has_result
		end

	has_result: BOOLEAN
		do
			Result := last_result /= Void
		ensure
			result_implies_not_executing: Result implies not has_next_step
			result_implies_not_aborted: Result implies not is_aborted
		end

feature {TET_EXECUTOR_MOCK} -- Status setting

	start
			-- Start the execution of `Current'
		deferred
		end

feature -- Factory

	new_executor (an_execution: TEST_EXECUTION_I): TET_EXECUTOR_MOCK [like Current]
			-- <Precursor>
		do
			create Result.make (an_execution, test_set)
			test_set.executors.force (Result)
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
