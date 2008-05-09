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

	EIFFEL_LAYOUT
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
			l_service: SERVICE_CONSUMER [EVENT_LIST_S]
			l_uuid: ES_TESTING_EVENT_LIST_CONTEXTS
			l_event_item: EVENT_LIST_TEST_CASE_ITEM
			l_data_item: ES_EWEASEL_TEST_CASE_ITEM
		do
			manager.add_class_to_cluster (a_new_class_file_name, a_cluster, a_cluster_sub_path)

			create l_class_stone.make (manager.last_added_class)
			create l_window
			l_dev_window := l_window.window_manager.last_focused_development_window
			l_dev_window.commands.new_tab_cmd.execute_with_stone (l_class_stone)

			create l_service
			if l_service.is_service_available then
				create l_data_item
				l_data_item.set_class_i (manager.last_added_class)
				create l_event_item.make ({ENVIRONMENT_CATEGORIES}.testing, 0, l_data_item)
				create l_uuid
				l_service.service.put_event_item (l_uuid.execution_manager, l_event_item)
			end
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
			if check_precompile then
				if catalog_manager.update_catalog_file (a_failed_first) then
					result_analyzer.reset
					result_analyzer.start_buffer_string_moving
					process.launch

					check not_void: testing_tool /= Void end

					if not process.launched then
						create l_error.make_standard (testing_tool.interface_names.l_eweasel_executable_not_found (environment_manager.eweasel_command))
						l_error.show_on_active_window
					else
						display_testing_result_tool
						testing_tool.content.set_focus
					end
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

	update_ui_on_exit is
			-- Update ui states on eweasel exits
		local
			l_testing_result_tool: like testing_result_tool
			l_testing_tool: like testing_tool
		do
			-- Switch buttons states on eweasel exit/terminate
			start_test_run_command.enable_sensitive
			start_test_run_failed_first_command.enable_sensitive
			stop_test_run_command.disable_sensitive

			l_testing_result_tool := testing_result_tool
			if l_testing_result_tool /= Void then
				display_testing_result_tool
				l_testing_result_tool.content.set_focus
			end

			l_testing_tool := testing_tool
			if l_testing_tool /= Void then
				l_testing_tool.set_progress_proportion_completed
			end
		end

	display_testing_result_tool is
			-- We display `testing_result_tool' if not initialized or `testing_result_tool' not visible
		require
			ready: testing_tool /= Void
		local
			l_shim: ES_TESTING_RESULT_TOOL
			l_show_tool_command: ES_SHOW_TOOL_COMMAND
			l_win: EB_DEVELOPMENT_WINDOW
		do
			if testing_result_tool = Void or else not testing_result_tool.content.is_visible then
				l_win := testing_tool.develop_window
				check not_void: l_win /= Void end
				l_shim ?= l_win.shell_tools.tool ({ES_TESTING_RESULT_TOOL})
				if l_shim /= Void then
					l_show_tool_command := l_win.commands.show_shell_tool_commands.item (l_shim)
					l_show_tool_command.execute
				end
			end
		ensure
			created: testing_result_tool /= Void
		end
		
	check_precompile: BOOLEAN is
			-- Check if base and base-mt precompile library correct
			-- If we don't check it, testing tool will hang
		local
			l_retry: BOOLEAN
			l_consumer: SERVICE_CONSUMER [EVENT_LIST_S]
			l_event_list_item: EVENT_LIST_TESTING_RESULT_ITEM
			l_result: ES_EWEASEL_TEST_RESULT_ITEM
			l_contexts: ES_TESTING_EVENT_LIST_CONTEXTS

			l_exception_manager: ISE_EXCEPTION_MANAGER
		do
			if not l_retry then
				check_precompile_correct ("base")
				check_precompile_correct ("base-mt")
				Result := True
			else
				-- precompile library not compatible, we report it to testing result panel
				display_testing_result_tool
				create l_consumer
				if l_consumer.is_service_available then
					create l_exception_manager

					create l_result
					if is_missing_error then
						l_result.set_title (l_exception_manager.last_exception.message)
					else
						-- We want to give end user more useful meaning error, not just `Compiler Error'
						l_result.set_title ("Precompile library version incompatible")
					end

					l_result.set_result_type ({ES_EWEASEL_RESULT_TYPE}.error)
					create l_event_list_item.make ({ENVIRONMENT_CATEGORIES}.testing, 0, l_result)

					create l_contexts
					l_consumer.service.put_event_item (l_contexts.execution_manager, l_event_list_item)
				end
			end
		rescue
			l_retry := True
			retry
		end

	check_precompile_correct (a_library_target_name: STRING) is
			-- Check if precompile library correct
			-- If error, exception will be raised
		require
			not_void: a_library_target_name /= Void and then not a_library_target_name.is_empty
		local
			l_remote_project_dir: REMOTE_PROJECT_DIRECTORY
			l_project_dir: PROJECT_DIRECTORY
			l_exception: DEVELOPER_EXCEPTION
			l_project_file: PROJECT_EIFFEL_FILE
		do
			is_missing_error := False
			create l_project_dir.make (eiffel_layout.precomp_platform_path (False), a_library_target_name)
			create l_remote_project_dir.make (l_project_dir)
			l_remote_project_dir.check_version_number (1)
			l_project_file := l_remote_project_dir.precomp_eif_file

			if not l_project_file.exists or else l_project_file.has_error then
				-- Precompile library missing
				is_missing_error := True
				create l_exception
				l_exception.set_message ("Precompile library " + a_library_target_name + " missing")
				l_exception.raise
			end
		end

	is_missing_error: BOOLEAN
			-- If precompile library missing error?

feature {NONE} -- Porcess event handler

	on_exit is
			-- Handle eweasel process exit action
		local
			l_testing_tool: like testing_tool
			l_testing_result_tool: like testing_result_tool
		do
			result_analyzer.on_eweasel_exit

			update_ui_on_exit

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
		local
			l_testing_result_tool: like testing_result_tool
		do
			update_ui_on_exit
			l_testing_result_tool := testing_result_tool
			if l_testing_result_tool /= Void then
				l_testing_result_tool.test_run_result_grid_manager.save_test_run_data_to_session
			end
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
