note
	description: "[
		Executor capable of running parallel instances of {ETEST}.
		
		Note: although ETEST_EXECUTOR represents a valid {TEST_EXEUCTOR_I}, it is not directly used by
		      {ETEST} instances to by executed. Instead {TEST_EXECUTION} is used which uses `Current'
		      through a bridge pattern, but also makes sure the project is properly compiled before
		      starting or proceeding `Current'.
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
			remove_task,
			new_task_data,
			cancel
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

	make (an_execution: like test_execution; an_etest_suite: like etest_suite)
			-- Initialize `Current'.
			--
			-- `an_execution': Execution which launches `Current'.
			-- `an_etest_suite': ETEST_SUITE instance.
		require
			an_execution_attached: an_execution /= Void
			an_etest_suite_attached: an_etest_suite /= Void
		do
			test_execution := an_execution
			etest_suite := an_etest_suite
			create idle_controllers.make_default
			create empty_tasks.make (0)
			create occupied_controllers.make (0)
			tasks := empty_tasks
			create byte_code_factory
		ensure
			test_execution_set: test_execution = an_execution
			etest_suite_set: etest_suite = an_etest_suite
		end

feature -- Access

	etest_suite: ETEST_SUITE
			-- Etest suite

	test_execution: TEST_EXECUTION_I
			-- <Precursor>

	sleep_time: NATURAL_32 = 0
			-- <Precusor>
			--
			-- TODO: check if we received any results during last `step', otherwise increase `sleep_time'

feature {NONE} -- Access

	tasks: LIST [like new_task_data]
			-- <Precursor>

	empty_tasks: ARRAYED_LIST [like new_task_data]
			-- Task list which is always empty (does not contain any tasks)

	occupied_controllers: ARRAYED_LIST [like new_task_data]
			-- Controllers currently running a test

	idle_controllers: DS_ARRAYED_LIST [like new_controller]
			-- Controllers not running any test

	controller_count: INTEGER
			-- Number of controllers that can be launched in current session
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

	testing_directory: DIRECTORY_NAME
			-- Directory in which tests should be executed
		local
			l_dir: STRING
		do
			l_dir := etest_suite.project_access.project.project_directory.testing_results_path
			create Result.make_from_string (l_dir)
			Result.extend (testing_directory_name)
		end

feature -- Status report

	is_available: BOOLEAN
			-- <Precursor>
		do
			Result := occupied_controllers.count < controller_count
		end

	is_running_test (a_test: TEST_I): BOOLEAN
			-- <Precursor>
		do
			Result := occupied_controllers.there_exists (
				agent (a_data: like new_task_data; a_t: TEST_I): BOOLEAN
					do
						Result := a_data.test = a_t and a_data.task.is_running
					end (?, a_test))
		end

feature {NONE} -- Status report

	one_per_step: BOOLEAN = False
			-- <Precursor>

feature -- Status setting

	start
			-- Start execution
		do
			occupied_controllers.do_all (agent launch_test)
			tasks := occupied_controllers
			create_directory_safe (testing_directory)
		end

feature {TEST_EXECUTION_I, ETEST_COMPILATION_EXECUTOR} -- Status setting

	abort_test (a_test: TEST_I)
			-- <Precursor>
		local
			l_occupieds: like occupied_controllers
		do
			from
				l_occupieds := occupied_controllers
				l_occupieds.start
			until
				l_occupieds.off
			loop
				if l_occupieds.item_for_iteration.test = a_test then
						-- Controller will be removed automatically during next `step'
					l_occupieds.item_for_iteration.task.stop
					l_occupieds.go_i_th (0)
				else
					l_occupieds.forth
				end
			end
		end

feature {ETEST_COMPILATION_EXECUTOR, TEST_EXECUTION_I} -- Status setting

	run_compatible_test (a_test: ETEST)
			-- <Precursor>
		local
			l_idle: like idle_controllers
			l_controller: like new_controller
			l_data: like new_task_data
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
			l_data := new_task_data (l_controller)
			l_data.test := a_test
			occupied_controllers.force (l_data)
			if has_next_step then
				launch_test (l_data)
			end
		end

feature {NONE} -- Status setting

	launch_test (a_task_data: like new_task_data)
			-- Generate byte code for test and launch it through `a_controller'.
			--
			-- `a_task_data': Task data of controller to be launched.
		require
			a_task_data_attached: a_task_data /= Void
			a_task_data_has_test: a_task_data.test /= Void
		local
			l_test: detachable ETEST
			l_byte_code: STRING
			l_generics: TYPE_LIST_AS
			l_type: GENERIC_CLASS_TYPE_AS
			l_tag_tree: TAG_TREE [TEST_I]
			l_isolated: BOOLEAN
			l_controller: like new_controller
		do
			l_test := a_task_data.test
			check l_test /= Void end
			a_task_data.isolated := False
			if
				attached l_test.eiffel_class.compiled_representation as l_test_class and then
				attached l_test_class.feature_named (l_test.routine_name) as l_test_routine
			then
				create l_generics.make (1)
				l_generics.force (create {CLASS_TYPE_AS}.initialize (create {ID_AS}.initialize(l_test_class.name)))
				create l_type.initialize (create {ID_AS}.initialize ({ETEST_CONSTANTS}.eqa_test_evaluator), l_generics)

					-- Check if all required evaluator classes/types/features are compiled
				if
					attached etest_suite.project_access.class_from_name ({ETEST_CONSTANTS}.eqa_evaluator_root, Void) as l_evaluator_class and then
					attached {EIFFEL_CLASS_C} l_evaluator_class.compiled_representation as l_evaluator and then
					not l_evaluator.types.is_empty and then
					attached l_evaluator.feature_named ({ETEST_CONSTANTS}.eqa_evaluator_routine) as l_evaluator_routine and then
					l_evaluator_routine.valid_body_id and then
					attached l_test.eiffel_class.is_compiled and then
					attached evaluate_type_if_possible (l_type, l_evaluator) as l_evaluator_type
				then
						-- Create byte code
					l_byte_code := byte_code_factory.execute_test_code (l_test, l_evaluator, l_evaluator_routine)

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
							l_tag_tree.has_item (l_test) and then
							not l_tag_tree.item_suffixes (isolate_prefix, l_test).is_empty
						then
								-- Restart controller if test should be executed isolated
							l_controller.stop
							a_task_data.isolated := True
						end
					end
					if not l_controller.is_running then
						l_controller.start (l_evaluator, l_evaluator_routine)
					end
					l_controller.execute_test ([l_byte_code, l_test.name.as_string_8])
				else
					test_execution.report_result (l_test, create {EQA_EMPTY_RESULT}.make ("test not properly compiled", Void))
				end
			else
				test_execution.report_result (l_test, create {EQA_EMPTY_RESULT}.make ("test not compiled", Void))
			end
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
			l_dir_name: DIRECTORY_NAME
		do
			l_task_data := tasks.item_for_iteration
			l_controller := l_task_data.task
			l_test := l_task_data.test
			check test_attached: l_test /= Void end

				-- Try to retrieve result from controller
			if not l_controller.is_running then
				create {EQA_EMPTY_RESULT} l_result.make ("evaluator could not be launched", Void)
			else
				l_dir_name := testing_directory
				l_dir_name.extend (l_test.name)
				delete_directory_safe (l_dir_name)
				if l_controller.has_result then
					l_result := l_controller.test_result
				else
					create {EQA_EMPTY_RESULT} l_result.make ("evaluator died", Void)
				end
			end

				-- Remove controller from `occupied_controllers'
			Precursor (a_force)

				-- Remove breakpoint if set
			if attached l_task_data.breakpoint as l_breakpoint then
				debugger_manager.breakpoints_manager.delete_breakpoint (l_breakpoint)
				l_task_data.breakpoint := Void
			end

				-- Add to controller to `idle_controllers' and stop it if test was marked isolated
			if not a_force then
				if l_task_data.isolated then
					l_controller.stop
				end
				idle_controllers.force_last (l_controller)
			end

				-- Report result
			if test_execution.is_test_running (l_test) then
				test_execution.report_result (l_test, l_result)
			end

			if a_force then
				l_controller.dispose
			end
		end

	cancel
			-- <Precursor>
		do
				-- Since `cancel' is only called from {ETEST_EXECUTION} when compiling started, wo do not
				-- completely abort testing. Instead we only stop the controllers, ensure `has_next_step' is
				-- False and relaunch them when `start' is called after compilation is done.
			occupied_controllers.do_all (
				agent (a_task_data: like new_task_data)
					do
						a_task_data.task.stop
					end)
			tasks := empty_tasks
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

	create_directory_safe (a_name: STRING)
			-- Try to recursively create directory of given name.
			--
			-- `a_name': Name of directory to be created.
		require
			a_name_attached: a_name /= Void
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				(create {DIRECTORY}.make (a_name)).recursive_create_dir
			end
		rescue
			l_retried := True
			retry
		end

	delete_directory_safe (a_name: STRING)
			-- Remove directory.
			--
			-- `a_name': Name of directory to be deleted.
		require
			a_name_attached: a_name /= Void
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				(create {DIRECTORY}.make (a_name)).recursive_delete
			end
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Factory

	new_controller: ETEST_EVALUATOR_CONTROLLER
			-- Create new controller
		do
			if test_execution.is_debugging then
				create {ETEST_EVALUATOR_DEBUGGER_CONTROLLER} Result.make (etest_suite, testing_directory)
			else
				create {ETEST_EVALUATOR_PROCESS_CONTROLLER} Result.make (etest_suite, testing_directory)
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
	testing_directory_name: STRING = "execution"

invariant
	empty_tasks_empty: empty_tasks.is_empty

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
