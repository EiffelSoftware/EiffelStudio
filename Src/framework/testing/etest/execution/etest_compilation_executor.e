note
	description: "[
		{TEST_EXECUTOR_I} which wraps an {ETEST_EXECUTOR} also ensuring that the project is compiled.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_COMPILATION_EXECUTOR

inherit
	TEST_EXECUTOR_I [ETEST]

	ROTA_SERIAL_TASK_I
		redefine
			step,
			remove_task
		end

	DISPOSABLE_SAFE

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like etest_suite; a_test_execution: like test_execution)
			-- Initialize `Current'.
			--
			-- `a_test_suite': {ETEST_SUITE} instance.
			-- `a_test_execution': Session which will launch `Current'.
		require
			a_test_execution_attached: a_test_execution /= Void
			a_test_suite_attached: a_test_suite /= Void
		do
			test_execution := a_test_execution
			etest_suite := a_test_suite
			create {ETEST_MELT_TASK} sub_task.make (etest_suite)
			create executor_task.make (test_execution, etest_suite)
		ensure
			test_execution_set: test_execution = a_test_execution
			test_suite_set: etest_suite = a_test_suite
		end

feature -- Access

	test_execution: TEST_EXECUTION_I
			-- <Precursor>

	sleep_time: NATURAL
			-- <Precursor>
		local
			l_sub_task: like sub_task
		do
			l_sub_task := sub_task
			check l_sub_task /= Void end
			Result := sub_task.sleep_time
		end

feature {ETEST_EXECUTOR} -- Access

	etest_suite: ETEST_SUITE
			-- Test suite containing {ETEST} instances

feature {NONE} -- Access

	sub_task: ROTA_TIMED_TASK_I
			-- <Precursor>

	executor_task: ETEST_EXECUTOR
			-- Task executing {ETEST} instances

feature -- Status report

	frozen is_available: BOOLEAN
			-- <Precursor>
		do
			Result := executor_task.is_available
		end

	frozen is_running_test (a_test: TEST_I): BOOLEAN
			-- <Precursor>
		do
			Result := executor_task.is_running_test (a_test)
		end

feature -- Status setting

	step
			-- <Precursor>
		local
			l_comp_task: ETEST_MELT_TASK
		do
			if
				etest_suite.project_access.project.is_compiling and then
				not attached {ETEST_MELT_TASK} sub_task
			then
				sub_task.cancel
				create l_comp_task.make (etest_suite)
				sub_task := l_comp_task
				l_comp_task.start (False)
				if l_comp_task.has_next_step then
					Precursor
				else
					remove_task (l_comp_task, False)
				end
			else
				Precursor
			end
		end

feature {NONE} -- Status setting

	remove_task (a_task: attached like sub_task; a_cancel: BOOLEAN)
			-- <Precursor>
		local
			l_idle_task: ETEST_IDLE_TASK
		do
			check
				attached {ETEST_EXECUTOR} a_task or
				attached {ETEST_MELT_TASK} a_task
			end
			if not a_cancel and attached {ETEST_MELT_TASK} a_task as l_melt_task then
				if l_melt_task.is_successful then
					sub_task := executor_task
					executor_task.start
				else
						-- Lets idle until user fixes compile error and recompiles.
					create l_idle_task
					sub_task := l_idle_task
					l_idle_task.start
				end
					-- Melt task not further needed.
				l_melt_task.dispose
			end
		end

feature {TEST_EXECUTION_I} -- Status setting

	frozen abort_test (a_test: TEST_I)
			-- <Precursor>
		do
			executor_task.abort_test (a_test)
		end

	frozen run_compatible_test (a_test: ETEST)
			-- <Precursor>
		do
			executor_task.run_compatible_test (a_test)
			if not sub_task.has_next_step then
				if sub_task = executor_task then
					executor_task.start
				elseif attached {ETEST_MELT_TASK} sub_task as l_task then
					etest_suite.increase_etest_session_count
					l_task.start (True)
				else
					check
						invalid_task: False
					end
				end
			end
		end

feature {ETEST_EXECUTOR} -- Basic operations

	frozen report_result (a_test: ETEST; a_result: EQA_RESULT)
			-- Report result to test suite
			--
			-- `a_test': Test which was executed.
			-- `a_result': Corresponding test result.
		local
			l_type: TYPE [EQA_RESULT]
		do
				-- Referencing different result types to make sure they are compiled
			l_type := {EQA_EMPTY_RESULT}
			l_type := {EQA_ETEST_RESULT}
			l_type := {EQA_ETEST_PARTIAL_RESULT}

			test_execution.report_result (a_test, a_result)
		end

feature {NONE} -- Implementation

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				if attached {ETEST_MELT_TASK} sub_task as l_task then
					l_task.dispose
				end
				executor_task.dispose
			end
			etest_suite.decrease_etest_session_count
		end

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
