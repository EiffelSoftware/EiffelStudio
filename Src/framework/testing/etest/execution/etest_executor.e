note
	description: "[
		Executor capable of running parallel instances of {ETEST}.
		
		Note: although ETEST_EXECUTOR represents a valid {TEST_EXECUTOR_I}, it is not directly used by
		      {ETEST} instances to by executed. Instead {TEST_EXECUTION} is used which uses `Current'
		      through a bridge pattern, but also makes sure the project is properly compiled before
		      starting or proceeding `Current'.
	]"
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

	INTERNAL_COMPILER_STRING_EXPORTER

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
			-- `a_max_controller_count': Maximum number of controllers that can be launched in parallel.
		require
			an_execution_attached: an_execution /= Void
			an_etest_suite_attached: an_etest_suite /= Void
		local
			l_service: SERVICE_CONSUMER [SESSION_MANAGER_S]
		do
			test_execution := an_execution
			etest_suite := an_etest_suite
			create idle_controllers.make (10)
			create empty_tasks.make (0)
			create occupied_controllers.make (10)
			tasks := empty_tasks
			create l_service
			if
				attached l_service.service as l_session_service and then
				attached l_session_service.retrieve (False) as l_session and then
				attached {NATURAL} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.concurrent_executors,
					{TEST_SESSION_CONSTANTS}.concurrent_executors_default) as l_count
			then
				max_controller_count := l_count
			else
				max_controller_count := {TEST_SESSION_CONSTANTS}.concurrent_executors_default
			end

			create start_time.make_now
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

	idle_controllers: ARRAYED_LIST [like new_controller]
			-- Controllers not running any test

	controller_count: NATURAL
			-- Number of controllers that can be launched in current session
		do
			if test_execution.is_debugging then
				Result := 1
			else
				Result := max_controller_count
			end
		ensure
			result_valid: Result > 0
		end

	max_controller_count: NATURAL
			-- Maximum number of controllers the can be launched in parallel

	testing_directory: PATH
			-- Directory in which tests should be executed
		do
			Result := etest_suite.project_access.project.project_directory.testing_results_path.extended (testing_directory_name)
		end

	start_time: DATE_TIME
			-- Time at which `Current' was created

feature -- Status report

	is_available: BOOLEAN
			-- <Precursor>
		do
			Result := occupied_controllers.count < controller_count.as_integer_32
		end

	is_running_test (a_test: TEST_I): BOOLEAN
			-- <Precursor>
		do
			Result := occupied_controllers.there_exists (
				agent (a_data: like new_task_data; a_t: TEST_I): BOOLEAN
					do
						if a_data.test = a_t then
							if a_data.task.is_running then
							end
						end
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
					l_occupieds.item_for_iteration.task.reset
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
				l_idle.remove
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
		local
			l_body_id: INTEGER_32
			l_tag_tree: TAG_TREE [TEST_I]
			l_controller: like new_controller
		do
			check attached a_task_data.test as l_test then
				a_task_data.isolated := False
				if
					attached l_test.eiffel_class.compiled_representation as l_test_class and then
					not l_test_class.is_generic and then not l_test_class.types.is_empty and then
					attached l_test_class.feature_named (l_test.routine_name) as l_test_routine
				then
					l_body_id := l_test_routine.real_body_index (l_test_class.types.first) - 1

					if test_execution.is_debugging then
						set_breakpoint (a_task_data, l_test_routine)
					end

					l_controller := a_task_data.task
					if l_controller.is_running then
						l_tag_tree := test_execution.test_suite.tag_tree
						if
							l_tag_tree.has_item (l_test) and then
							not l_tag_tree.item_suffixes (isolate_prefix, l_test).is_empty
						then
								-- Restart controller if test should be executed isolated
							l_controller.reset
							a_task_data.isolated := True
						end
					end
					l_controller.launch_test ([l_test.name.to_string_8, l_test_class.name.to_string_8, l_body_id])
				else
					test_execution.report_result (l_test, create {TEST_UNRESOLVED_RESULT}.make (e_test_not_compiled_tag, e_test_not_compiled_details, e_test_not_compiled_details, [l_test.name, l_test.class_name]))
				end
			end
		end

	remove_task (a_force: BOOLEAN)
			-- <Precursor>
		local
			l_task_data: like new_task_data
			l_controller: like new_controller
			l_test: detachable ETEST
			l_result: TEST_RESULT_I
			l_last_output: STRING
		do
			l_task_data := tasks.item_for_iteration
			l_controller := l_task_data.task
			l_test := l_task_data.test
			check test_attached: l_test /= Void end

				-- Try to retrieve result from controller
			if not l_controller.is_running then
				create {TEST_UNRESOLVED_RESULT} l_result.make (e_evaluator_launch_tag, e_evaluator_launch_details, e_evaluator_launch_details, [l_test.name])
			else
				if l_controller.has_result then
					create {ETEST_RESULT} l_result.make (l_controller.test_result)
				else
					l_last_output := l_controller.last_output
					if l_last_output.is_empty then
						l_last_output := "No Output Available"
					end
					create {TEST_UNRESOLVED_RESULT} l_result.make (e_evaluator_died_tag, e_evaluator_died_details, e_evaluator_died_details + "%N%N$3", [l_test.name, l_controller.last_exit_code, l_last_output])
				end
			end
				-- Removed created directory regardless of the presence or obsence of the controller which
				-- could have died unexpectly.
			remove_testing_directory (l_test, l_result)

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
					l_controller.reset
				end
				idle_controllers.force (l_controller)
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
				-- Since `cancel' is only called from {ETEST_EXECUTION} when compiling started, we do not
				-- completely abort testing. Instead we only stop the controllers, ensure `has_next_step' is
				-- False and relaunch them when `start' is called after compilation is done.
			occupied_controllers.do_all (
				agent (a_task_data: like new_task_data)
					do
						a_task_data.task.reset
						if attached a_task_data.test as l_test then
							remove_testing_directory (l_test, Void)
						end
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

	create_directory_safe (a_path: PATH)
			-- Try to recursively create directory of given name.
			--
			-- `a_path': Name of directory to be created.
		require
			a_name_attached: a_path /= Void
		local
			l_retried: BOOLEAN
			d: DIRECTORY
		do
			if not l_retried then
				create d.make_with_path (a_path)
				d.recursive_create_dir
			end
		rescue
			l_retried := True
			retry
		end

	remove_testing_directory (a_test: ETEST; a_result: detachable TEST_RESULT_I)
			-- Remove directory.
			--
			-- `a_test': Test for which working directory should be removed.
		require
			a_test_attached: a_test /= Void
		local
			l_retried, l_keep, l_default: BOOLEAN
			l_testing_dir, l_target_dir: like testing_directory
			l_service: SERVICE_CONSUMER [SESSION_MANAGER_S]
			l_session: SESSION_I
			l_key: STRING
			l_dir: DIRECTORY
		do
			if not l_retried then
				create l_service
				if a_result /= Void and then attached l_service.service as l_session_service then
					l_session := l_session_service.retrieve (False)
					if a_result.is_fail then
						l_key := {TEST_SESSION_CONSTANTS}.keep_failing
						l_default := {TEST_SESSION_CONSTANTS}.keep_failing_default
					elseif a_result.is_pass then
						l_key := {TEST_SESSION_CONSTANTS}.keep_passing
						l_default := {TEST_SESSION_CONSTANTS}.keep_passing_default
					else
						l_key := {TEST_SESSION_CONSTANTS}.keep_unresolved
						l_default := {TEST_SESSION_CONSTANTS}.keep_unresolved_default
					end
					if attached {BOOLEAN} l_session.value (l_key) as l_value then
						l_keep := l_value
					else
						l_keep := l_default
					end
				else
					l_keep := False
				end

				l_testing_dir := testing_directory.extended (a_test.name)
				if l_keep then
					l_target_dir := testing_directory.extended (start_time.formatted_out (file_name_format_string))
					create l_dir.make_with_path (l_target_dir)
					if not l_dir.exists then
						l_dir.recursive_create_dir
					end
					l_target_dir := l_target_dir.extended (a_test.name)
					if l_dir.exists then
						create l_dir.make_with_path (l_testing_dir)
						l_dir.change_name (l_target_dir.name)
					end
				else
					create l_dir.make_with_path (l_testing_dir)
					if l_dir.exists then
						l_dir.recursive_delete
					end
				end
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
			-- isolated: True if task should be stopped after executing test.
		local
			l_test: detachable ETEST
			l_breakpoint: detachable BREAKPOINT
		do
			Result := [a_task, l_test, False, l_breakpoint]
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
								a_controller.reset
							end
							a_controller.dispose
						end)
				idle_controllers.wipe_out
			end
		end

feature {NONE} -- Constants

	isolate_prefix: STRING = "execution/isolated"
	testing_directory_name: STRING = "execution"

	file_name_format_string: STRING = "yyyy-[0]mm-[0]dd hh-[0]mi-[0]ss"

feature {NONE} -- Internationalization

	e_evaluator_launch_tag: STRING = "No Evaluator"
	e_evaluator_launch_details: STRING = "[
			The evaluator needed to execute test $1 could not be launched. Most likely the last compilation
			of the current project did not succeed.
		]"

	e_evaluator_died_tag: STRING = "Evaluator Died"
	e_evaluator_died_details: STRING = "[
			The evaluator process which was executing test $1 terminated unexpectedly with exit code $2. 
			What to do: Check your ecf, you can not execute tests with an ecf that uses "Root: All classes". 
			Any output from the evaluator is printed below.
		]"

	e_test_not_compiled_tag: STRING = "Not Compiled"
	e_test_not_compiled_details: STRING = "[
			Test $1 could not be executed as the class containing it ($2) is not compiled.
		]"

	e_no_bytecode_tag: STRING = "Not Compiled"
	e_no_bytecode_details: STRING = "[
			Test $1 could not be executed because the required bytecode could not be generated.
		]"

invariant
	empty_tasks_empty: empty_tasks.is_empty

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
