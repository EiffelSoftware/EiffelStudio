indexing
	description: "[
						Chief manager of eweasel affairs
																								]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_EXECUTION_MANAGER

inherit
	EB_CLUSTER_MANAGER_OBSERVER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation method
		do
		end

feature -- Command

	create_unit_test_case is
			-- Launch wizard which create new eweasel test case
		local
			l_new: ES_NEW_EWEASEL_TEST_MANAGER
			l_dir: DIRECTORY_NAME
			l_manager: ES_NEW_UNIT_TEST_WIZARD_MANAGER
			l_window_manager: EB_SHARED_WINDOW_MANAGER
			l_helper: EVS_HELPERS
			l_wizard_information: ES_NEW_UNIT_TEST_WIZARD_INFORMATION
			l_window: EV_WINDOW
			l_path_helper: ES_CLUSTER_NAME_AND_PATH_HELPER
			l_cluster_path: STRING
		do
			create l_helper
			l_window := l_helper.parent_window_of_focused_widget
			if l_window = Void then
				create l_window_manager
				l_window := l_window_manager.window_manager.last_focused_development_window.window
			end
			create l_manager.make_and_launch (l_window, testing_tool)

			l_wizard_information := l_manager.wizard_info

			if l_wizard_information.is_valid then
				create l_dir.make_from_string (l_wizard_information.test_case_name.as_lower)

				create l_new.make
				l_new.set_wizard_information (l_wizard_information)
				l_new.set_target_test_case_folder (l_dir)
				environment_manager.set_test_case_root_eiffel_class_name (l_wizard_information.new_class_name)
				environment_manager.set_test_case_directory (l_wizard_information.cluster_directory)
				environment_manager.set_test_case_name (l_wizard_information.test_case_name)
				l_new.add_whole_set_of_files

				-- Force compiler to compile the new class, then open it in new tab.
				-- Add test case folder name to end of cluster path, we do it here since this directory maybe renamed automatically
				create l_path_helper
				l_cluster_path := l_wizard_information.cluster_path + l_path_helper.cluster_separator + l_new.folder_name
				compile_and_open_new_unit_test_class (l_wizard_information.new_class_file_name, l_wizard_information.cluster, l_cluster_path)

			else
				-- Inforation is not valid, we do noting. Just quit.
			end
		end

	compile_and_open_new_unit_test_class (a_new_class_file_name: STRING; a_cluster: CLUSTER_I; a_cluster_sub_path: STRING) is
			-- Force compile `a_new_class_file_name' which is just created.
			-- `a_new_class_file_name' file located in `a_cluster', sub path is `a_cluster_sub_path'
		require
			not_void: a_cluster /= Void
			not_void: a_cluster /= Void
			not_void: a_cluster_sub_path /= Void
		local
			l_window: EB_SHARED_WINDOW_MANAGER
			l_class_stone: CLASSI_STONE
			l_dev_window: EB_DEVELOPMENT_WINDOW
		do
			manager.add_class_to_cluster (a_new_class_file_name, a_cluster, a_cluster_sub_path)

			create l_class_stone.make (manager.last_added_class)
			create l_window
			l_dev_window := l_window.window_manager.last_focused_development_window
			l_dev_window.commands.new_tab_cmd.execute_with_stone (l_class_stone)
		end

	stop_eweasel is
			-- Terminate eweasel testing
			-- We can ensure eweasel is terminated
		do
			if is_eweasel_running then
				process.terminate_tree
				check terminated: process.last_termination_successful end
			end
		end

	launch_eweasel (a_failed_first: BOOLEAN) is
			-- Start eweasel testing if possible
			-- To query result, use `is_eweasel_running'
		require
			not_running: not is_eweasel_running
		local
			l_error: ES_ERROR_PROMPT
		do
			if catalog_manager.update_catalog_file (a_failed_first) then
				result_analyzer.reset
				result_analyzer.start_buffer_string_moving
				process.launch

				check not_void: testing_tool /= Void end

				if not process.launched then
					create l_error.make_standard (testing_tool.interface_names.l_eweasel_executable_not_found (environment_manager.eweasel_command))
					l_error.show_on_active_window
				end
			end
		end

feature -- Query

	environment_manager: ES_EWEASEL_ENVIRONMENT_MANAGER is
			-- All enviroment variables used by eweasel
		do
			if internal_environment_manager = Void then
				create internal_environment_manager.make
			end
			Result := internal_environment_manager
		ensure
			not_void: Result /= Void
		end

	catalog_manager: ES_EWEASEL_CATALOG_FILE_MANAGER is
			-- eweasel catalog file manager
		do
			if internal_catalog_manager = Void then
				create internal_catalog_manager.make
			end
			Result := internal_catalog_manager
		ensure
			not_void: Result /= Void
		end

	is_eweasel_running: BOOLEAN is
			-- If eweasel process is running?
		do
			Result := process.is_running
		end

	testing_tool: ES_TESTING_TOOL_PANEL is
			-- Testing tool
			-- Result maybe void if tool panel not initialized
		local
			l_shared: EB_SHARED_WINDOW_MANAGER
			l_dev: EB_DEVELOPMENT_WINDOW
			l_tool: ES_TOOL [EB_TOOL]
			l_tmp_result: ES_TESTING_TOOL_PANEL
		do
			create l_shared
			l_dev := l_shared.window_manager.last_focused_development_window
			if l_dev /= Void then
				l_tool := l_dev.shell_tools.tool ({ES_TESTING_TOOL})
				if l_tool.is_tool_instantiated then
					l_tmp_result ?= l_tool.panel
					if l_tmp_result /= Void then
						if l_tmp_result.is_initialized then
							Result := l_tmp_result
						end
					end
				end
			end
		end

	testing_result_tool: ES_TESTING_RESULT_TOOL_PANEL is
			-- Testing result tool
			-- Result maybe void if result tool panel not intialized
		local
			l_shared: EB_SHARED_WINDOW_MANAGER
			l_dev: EB_DEVELOPMENT_WINDOW
			l_tool: ES_TOOL [EB_TOOL]
			l_tmp_result: ES_TESTING_RESULT_TOOL_PANEL
		do
			create l_shared
			l_dev := l_shared.window_manager.last_focused_development_window
			if l_dev /= Void then
				l_tool := l_dev.shell_tools.tool ({ES_TESTING_RESULT_TOOL})
				if l_tool.is_tool_instantiated then
					l_tmp_result ?= l_tool.panel
					if l_tmp_result /= Void then
						if l_tmp_result.is_initialized then
							Result := l_tmp_result
						end
					end
				end
			end
		end

feature -- UI commands

	new_manual_test_command: !ES_NEW_UNIT_TEST_CASE_COMMAND is
			-- New manual/eweasel test case command
		once
			create Result.make (Current)
		end

	del_test_case_command: !ES_DELETE_TEST_CASE_COMMAND is
			-- Delete test case from grid command
		once
			create Result.make (Current)
		end

	start_test_run_command: !ES_START_TEST_RUN_COMMAND is
			-- Start test run command
		once
			create Result.make (Current)
		end

	start_test_run_failed_first_command: !ES_START_TEST_RUN_FAILED_FIRST_COMMAND is
			-- Start test run failed first command
		once
			create Result.make (Current)
		end

	stop_test_run_command: !ES_STOP_TEST_RUN_COMMAND is
			-- Stop test run command
		once
			create Result.make (Current)
		end

	next_failed_test_command: !ES_NEXT_FAILED_TEST_COMMAND is
			-- Next failed test command
		once
			create Result.make (Current)
		end

	previous_failed_test_command: !ES_PREVIOUS_FAILED_TEST_COMMAND is
			-- Previous failed test command
		once
			create Result.make (Current)
		end

	show_failed_tests_only_command: !ES_SHOW_FAILED_TESTS_ONLY_COMMAND is
			-- Show failed tests only command
		once
			create Result.make (Current)
		end

	update_last_changed_time_command: !ES_UPDATE_TEST_CASE_TIME_COMMAND is
			-- Update test case last changed time command
		once
			create Result.make (Current)
		end

	all_test_run_results_command: !ES_ALL_TEST_RUN_RESULTS_COMMAND is
			-- All test run results command
		once
			create Result.make (Current)
		end

	see_testing_failure_trace_command: !ES_SHOW_FAILURE_TRACE_COMMAND is
			-- See testing failure trace command
		once
			create Result.make (Current)
		end

	compare_with_expected_result_command: !ES_COMPARE_RESULT_COMMAND is
			-- Compare with expected result command
		once
			create Result.make (Current)
		end

feature {ES_EWEASEL_CATALOG_FILE_MANAGER} -- Internal query

	result_analyzer: ES_EWEASEL_RESULT_ANALYZER is
			--	analyzer which analyze eweasel ouputs
		do
			if internal_result_analyzer = Void then
				create internal_result_analyzer.make
			end
			Result := internal_result_analyzer
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	process: PROCESS is
			-- Process used by process manager.
		do
			if internal_process = Void then
				internal_process := new_process
				internal_process.enable_launch_in_new_process_group
				internal_process.set_separate_console (False)
				internal_process.set_hidden (True)
				internal_process.set_timer (create {PROCESS_VISION2_TIMER}.make (100))
				internal_process.set_abort_termination_when_failed (False)
				internal_process.set_buffer_size (128)
				internal_process.redirect_input_to_stream

				internal_process.redirect_output_to_agent (agent result_analyzer.on_eweasel_output)
				internal_process.redirect_error_to_same_as_output

				internal_process.set_on_exit_handler (agent on_exit)
				internal_process.set_on_terminate_handler (agent on_terminate)
			end
			Result := internal_process
		ensure
			not_void: Result /= Void
			created: internal_process /= Void
			same: internal_process = Result
		end

	new_process: like internal_process is
			-- Create a new eweasel process
			-- ONLY used by `process'.
		local
			l_factory: PROCESS_FACTORY
			l_list: ARRAYED_LIST [STRING]

		do
			create l_list.make (10)

			catalog_manager.append_catalog_parameter (l_list)
			init_parameter_manager.append_init_parameter (l_list)

			create l_factory
			Result := l_factory.process_launcher (environment_manager.eweasel_command, l_list, environment_manager.path)
		ensure
			not_void: Result /= Void
		end

	init_parameter_manager: ES_EWEASEL_INIT_PARAMETER_MANAGER is
			-- Control manager
		do
			if internal_init_parameter_manager = Void then
				create internal_init_parameter_manager.make
			end
			Result := internal_init_parameter_manager
		ensure
			not_void: Result /= Void
		end

	swtich_buttons_states_on_exit is
			-- Switch buttons states on eweasel exit/terminate
		do
			start_test_run_command.enable_sensitive
			start_test_run_failed_first_command.enable_sensitive
			stop_test_run_command.disable_sensitive
		end

feature {NONE} -- Porcess event handler

	on_exit is
			-- Handle eweasel process exit action
		local
			l_testing_tool: like testing_tool
			l_testing_result_tool: like testing_result_tool
		do
			result_analyzer.on_eweasel_exit

			swtich_buttons_states_on_exit

			l_testing_result_tool := testing_result_tool
			if l_testing_result_tool /= Void then
				l_testing_result_tool.test_run_result_grid_manager.save_test_run_data_to_session
			end

			l_testing_tool := testing_tool
			if l_testing_tool /= Void then
				l_testing_tool.test_case_grid_manager.refresh_time_columns
			end
			result_analyzer.clear_buffer_string_moving
		end

	on_terminate is
			-- Handle eweasel terminate action
		do
			swtich_buttons_states_on_exit
			testing_result_tool.test_run_result_grid_manager.save_test_run_data_to_session
			result_analyzer.clear_buffer_string_moving
		end

feature {NONE} -- Internal instance holders

	internal_environment_manager: like environment_manager
			-- Environment manager
			-- Used by `environment_manager' only

	internal_catalog_manager: like catalog_manager
			-- Catalog manager
			-- Used by `catalog_manager' only

	internal_init_parameter_manager: like init_parameter_manager
			-- `init_parameter_manager' instance holder
			-- Used by `init_parameter_manager' only

	internal_process: PROCESS
			-- Instance holder of `process'
			-- Used by `process' only

	internal_result_analyzer: like result_analyzer;
			-- `result_analyzer' instance holder
			-- Used by `result_anaylzer' only

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
