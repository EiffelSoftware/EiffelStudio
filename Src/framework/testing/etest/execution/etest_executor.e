note
	description: "[
		Executor capable of executing instances of ETEST.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_EXECUTOR

inherit
	TEST_EXECUTOR_I [ETEST]

	ROTA_PARALLEL_TASK_I [ETEST_EVALUATOR_CONTROLLER]
		redefine
			step,
			remove_task,
			new_task_data
		end

	ETEST_EVALUATOR_BYTE_CODE_FACTORY
		export
			{NONE} all
		end

	AST_TYPE_A_GENERATOR
		export
			{NONE}
		end

	DISPOSABLE_SAFE

	SHARED_DEBUGGER_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite; a_test_execution: like test_execution)
			-- Initialize `Current'.
			--
			-- `a_test_execution': Session which will launch `Current'.
		require
			a_test_execution_attached: a_test_execution /= Void
			a_test_suite_attached: a_test_suite /= Void
		do
			test_execution := a_test_execution
			test_suite := a_test_suite
			create idle_controllers.make_default
			task_cursor := (create {DS_ARRAYED_LIST [like new_task_data]}.make_default).new_cursor
			create byte_code_factory
		ensure
			test_execution_set: test_execution = a_test_execution
			test_suite_set: test_suite = a_test_suite
		end

feature -- Access

	test_execution: TEST_EXECUTION_I
			-- <Precursor>

	test_suite: ETEST_SUITE
			-- Test suite containing {ETEST} instances

	sleep_time: NATURAL_32 = 0
			-- <Precusor>
			--
			-- TODO: check if we received any results during last `step', otherwise increase `sleep_time'

feature {NONE} -- Access

	task_cursor: DS_LIST_CURSOR [like new_task_data]
			-- <Precursor>

	idle_controllers: DS_ARRAYED_LIST [like new_controller]
			-- Controllers not running any test

	controller_count: INTEGER
			-- Number of cotrollers that can be launched in current session
		do
			if test_execution.is_debugging then
				Result := 1
			else
				Result := 4
			end
		ensure
			result_valid: Result > 0
		end

	byte_code_factory: ETEST_EVALUATOR_BYTE_CODE_FACTORY
			-- Factory for creating byte code instructions

feature -- Status report

	is_available: BOOLEAN
			-- <Precursor>
		do
			Result := tasks.count < controller_count
		end

	is_running_test (a_test: TEST_I): BOOLEAN
			-- <Precursor>
		do
			Result := tasks.there_exists (
				agent (a_data: like new_task_data; a_t: TEST_I): BOOLEAN
					do
						Result := a_data.test = a_t and a_data.task.is_running
					end (?, a_test))
		end

feature {NONE} -- Status report

	one_per_step: BOOLEAN = False
			-- <Precursor>

feature -- Status setting

	step
			-- <Precursor>
		local
			l_tasks: like tasks
			l_task_data: like new_task_data
			l_controller: like new_controller
		do
			if test_suite.project_access.project.is_compiling then
				from
					l_tasks := tasks
					l_tasks.start
				until
					l_tasks.after
				loop
					l_task_data := l_tasks.item_for_iteration
					l_controller := l_task_data.task
					if l_controller.is_running then
						l_controller.stop
					end
					l_tasks.forth
				end
			else
				Precursor
			end
		end

feature {TEST_EXECUTION_I} -- Status setting

	abort_test (a_test: TEST_I)
			-- <Precursor>
		local
			l_cursor: like task_cursor
		do
			from
				l_cursor := tasks.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				if l_cursor.item.test = a_test then
						-- Controller will be removed automatically during next `step'
					l_cursor.item.task.stop
					l_cursor.go_after
				else
					l_cursor.forth
				end
			end
		end

feature {NONE} -- Status setting

	run_compatible_test (a_test: ETEST)
			-- <Precursor>
		local
			l_idle: like idle_controllers
			l_controller: like new_controller
		do
				-- Check if test class is compiled
			l_idle := idle_controllers
			if l_idle.is_empty then
				l_controller := new_controller
			else
				l_idle.start
				l_controller := l_idle.item_for_iteration
				l_idle.remove_at
			end
			append_task (l_controller)
			if test_suite.project_access.project.is_compiling then
					-- Will be launched when compilation is done
				tasks.last.test := a_test
			else
				launch_test (tasks.last, a_test)
			end
		end

	launch_test (a_task_data: like new_task_data; a_test: ETEST)
			-- Generate byte code for test and launch it through `a_controller'.
			--
			-- `a_task_data': Task data of controller to be launched.
			-- `a_test': Test to be launched.
		require
			a_task_data_attached: a_task_data /= Void
			a_test_attached: a_test /= Void
			a_test_running: test_execution.is_test_running (a_test)
			not_compiling: not test_suite.project_access.project.is_compiling
		local
			l_byte_code: STRING
			l_generics: TYPE_LIST_AS
			l_type: GENERIC_CLASS_TYPE_AS
			l_tag_tree: TAG_TREE [TEST_I]
			l_isolated: BOOLEAN
			l_controller: like new_controller
		do
			a_task_data.test := a_test
			a_task_data.isolated := False
			if
				attached a_test.eiffel_class.compiled_representation as l_test_class and then
				attached l_test_class.feature_named (a_test.routine_name) as l_test_routine
			then
				create l_generics.make (1)
				l_generics.force (create {CLASS_TYPE_AS}.initialize (create {ID_AS}.initialize(l_test_class.name)))
				create l_type.initialize (create {ID_AS}.initialize ({ETEST_CONSTANTS}.eqa_test_evaluator), l_generics)

					-- Check if all required evaluator classes/types/features are compiled
				if
					attached test_suite.project_access.class_from_name ("EQA_EVALUATOR_ROOT", Void) as l_evaluator_class and then
					attached {EIFFEL_CLASS_C} l_evaluator_class.compiled_representation as l_evaluator and then
					not l_evaluator.types.is_empty and then
					attached l_evaluator.feature_named ({ETEST_CONSTANTS}.eqa_evaluator_routine) as l_evaluator_routine and then
					l_evaluator_routine.valid_body_id and then
					attached a_test.eiffel_class.is_compiled and then
					attached evaluate_type_if_possible (l_type, l_evaluator) as l_evaluator_type
				then
						-- Create byte code
					l_byte_code := byte_code_factory.execute_test_code (a_test, l_evaluator, l_evaluator_routine)

						-- Set breakpoint if debugging
					if test_execution.is_debugging then
						set_breakpoint (a_task_data, l_evaluator_routine)
					end

						-- Pass byte code to available controller
					l_controller := a_task_data.task
					if l_controller.is_running then
						l_tag_tree := test_execution.test_suite.tag_tree
						if not l_controller.is_ready then
							l_controller.stop
						elseif
							l_tag_tree.has_item (a_test) and then
							not l_tag_tree.item_suffixes (isolate_prefix, a_test).is_empty
						then
								-- Restart controller if test should be executed isolated
							l_controller.stop
							a_task_data.isolated := True
						end
					end
					if not l_controller.is_running then
						l_controller.start (l_evaluator, l_evaluator_routine)
					end
					l_controller.execute_test ([l_byte_code, a_test.name.as_string_8])
				else
					test_execution.report_result (a_test, create {EQA_EMPTY_RESULT}.make ("test not properly compiled", Void))
				end
			else
				test_execution.report_result (a_test, create {EQA_EMPTY_RESULT}.make ("test not compiled", Void))
			end
		ensure
			test_set: a_task_data.test = a_test
		end

	remove_task (a_force: BOOLEAN)
			-- <Precursor>
		local
			l_task_data: like new_task_data
			l_controller: like new_controller
			l_test: detachable ETEST
			l_result: EQA_RESULT
			l_remove: BOOLEAN
			l_tag_tree: TAG_TREE [TEST_I]
		do
			l_task_data := task_cursor.item
			l_controller := l_task_data.task
			l_test := l_task_data.test
			check l_test /= Void end
			if l_controller.is_running then
					-- The controller was running so we try to report a result
				if l_controller.has_result then
					l_result := l_controller.test_result
				else
					create {EQA_EMPTY_RESULT} l_result.make ("evaluator died", Void)
				end
				Precursor (a_force)
				if attached l_task_data.breakpoint as l_breakpoint then
					debugger_manager.breakpoints_manager.delete_breakpoint (l_breakpoint)
					l_task_data.breakpoint := Void
				end
				if not a_force then
					if l_task_data.isolated then
						l_controller.stop
					end
					idle_controllers.force_last (l_controller)
				end
				if test_execution.is_test_running (l_test) then
					test_execution.report_result (l_test, l_result)
				end
			else
					-- If removal is not forced, try to relaunch test after compilation
				if not a_force and test_execution.is_test_running (l_test) then
					launch_test (l_task_data, l_test)
				else
					Precursor (a_force)
				end
			end
			if a_force then
				l_controller.dispose
			end
		end

feature {NONE} -- Implementation

	set_breakpoint (a_task_data: like new_task_data; a_feature: FEATURE_I)
			-- Set breakpoint in given feature if not set yet, and store breakpoint in task data.
			--
			-- `a_task_data': Task data in which breakpoint should be stored.
			-- `a_feature': Feature for which breakpoint should be set in first slot.
		require
			a_task_data_attached: a_task_data /= Void
			a_feature_attached: a_feature /= Void
		local
			l_manager: BREAKPOINTS_MANAGER
			l_feature: E_FEATURE
			l_slot: INTEGER
		do
			l_manager := debugger_manager.breakpoints_manager
			l_feature := a_feature.e_feature
			l_slot := l_feature.first_breakpoint_slot_index
			if not l_manager.is_breakpoint_enabled (l_feature, l_slot) then
				l_manager.set_user_breakpoint (l_feature, l_slot)
				if l_manager.is_breakpoint_set (l_feature, l_slot, False) then
					a_task_data.breakpoint := l_manager.user_breakpoint (l_feature, l_slot)
				end
			end
		end

feature {NONE} -- Factory

	new_controller: ETEST_EVALUATOR_CONTROLLER
			-- Create new controller
		do
			if test_execution.is_debugging then
				create {ETEST_EVALUATOR_DEBUGGER_CONTROLLER} Result.make (test_suite)
			else
				create {ETEST_EVALUATOR_PROCESS_CONTROLLER} Result.make (test_suite)
			end
		end

	new_task_data (a_task: ETEST_EVALUATOR_CONTROLLER): TUPLE [task: like new_controller; test: detachable ETEST; isolated: BOOLEAN; breakpoint: detachable BREAKPOINT]
			-- <Precursor>
			--
			-- task: `a_task'.
			-- test: Void if controller is currently executing a test, attached if controller is paused
			--       while executing test
			-- isolated: True if task should be stopped after executing test
		do
			Result := [a_task, Void, False, Void]
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				if has_next_step then
					cancel
				end
				idle_controllers.do_all (
					agent (a_controller: like new_controller)
						do
							if a_controller.is_running then
								a_controller.stop
							end
							a_controller.dispose
						end)
				idle_controllers.wipe_out
			end
		end

feature {NONE} -- Constants

	isolate_prefix: STRING = "execution/isolated"

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
