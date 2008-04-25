indexing
	description: "[
						Testing tool main control panel.
						
						This tool can create, execute and analyze eweasel tests
						The detailed test run result avaliable in {ES_TESTING_RESULT_TOOL}						
						
						This tool is used for eweasel testing for the moment.
						In future, maybe CDD and Autotest will be integrated.
																				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_PANEL

inherit
	ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE
		export
			{ES_EWEASEL_EXECUTION_MANAGER}  interface_names
		redefine
			on_after_initialized,
			build_tool_interface,
			is_appliable_event
		end

create
	make

feature {NONE} -- Initialization

	build_tool_interface (a_grid: ES_GRID) is
			-- <Precursor>
		local
			l_box: EV_BOX
			l_string: STRING_GENERAL
			l_contants: EV_LAYOUT_CONSTANTS
			l_level_2_2_vertical_box: EV_VERTICAL_BOX
			l_top_container: EV_VERTICAL_BOX
			l_tool_bar: SD_TOOL_BAR
		do
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_grid)
			test_case_grid := a_grid

			create l_contants

			-- Level 2 2nd box
			l_top_container := widget
			create l_level_2_2_vertical_box
			create {EV_HORIZONTAL_BOX} l_box
			l_box.set_border_width (l_contants.default_border_size)
			l_level_2_2_vertical_box.extend (l_box)
			l_level_2_2_vertical_box.disable_item_expand (l_box)

			l_string := runs_string.twin
			l_string.append (": 0/0")
			create runs_label.make_with_text (l_string)
			l_box.extend (runs_label)

			create errors_label
			set_error_label_with (0)
			l_box.extend (errors_label)

			create failures_label
			set_failure_label_with (0)
			l_box.extend (failures_label)

			create {EV_HORIZONTAL_BOX} l_box
			l_box.set_border_width (l_contants.default_border_size)
			l_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			l_level_2_2_vertical_box.extend (l_box)
			l_level_2_2_vertical_box.disable_item_expand (l_box)

			create progress_bar
			l_box.extend (progress_bar)
			create l_tool_bar.make
			l_tool_bar.extend (unit_test_manager.stop_test_run_command.new_sd_toolbar_item (False))
			l_tool_bar.compute_minimum_size
			l_box.extend (l_tool_bar)
			l_box.disable_item_expand (l_tool_bar)

			check not_void: test_case_grid /= Void  end
			test_case_grid_manager.build_columns
			-- Enable sorting
			enable_sorting_on_columns (test_case_grid_manager.all_columns)
			enable_copy_to_clipboard

			l_level_2_2_vertical_box.set_padding_width (l_contants.default_padding_size)
			l_level_2_2_vertical_box.set_border_width (l_contants.default_border_size)
			l_top_container.extend (l_level_2_2_vertical_box)
			l_top_container.disable_item_expand (l_level_2_2_vertical_box)
		ensure then
			set: test_case_grid = a_grid
		end

	on_after_initialized is
			-- <Precursor>
			-- Build own interface after base interface created
		local
			l_shared: SHARED_EIFFEL_PROJECT
			l_factory: ES_EWEASEL_SINGLETON_FACTORY
		do
			-- Init event list service
			init_event_list_service

			create l_shared
			create l_factory
			if l_shared.eiffel_project.manager.is_project_loaded then
				test_case_grid_manager.restore_test_case_from_session
				add_testing_hook
				l_factory.manager.new_manual_test_command.enable_sensitive
			else
				l_shared.eiffel_project.manager.load_agents.extend (agent test_case_grid_manager.restore_test_case_from_session)
				l_shared.eiffel_project.manager.load_agents.extend (agent add_testing_hook)
				l_shared.eiffel_project.manager.load_agents.extend (agent ((l_factory.manager).new_manual_test_command).enable_sensitive)
			end
		end

	add_testing_hook is
			-- Add hook to system configuration rebuild action
		local
			l_finder: ES_TEST_CASE_FINDER
		do
			-- FIXIT: Maybe we need a additional plug-able tools builder, such as EB_DEVELOPMENT_WINDOW_PLUGIN_BUILDER ?
			-- 		To build the tools we maybe disabled in the future?
			create l_finder
			l_finder.add_hook
		end

	init_event_list_service is
			-- Initilaize event list service
		local
			l_service: EVENT_LIST_S
		do
			if event_list.is_service_available then
				l_service := event_list.service
				l_service.item_added_event.subscribe (agent on_event_list_item_added)
			end
		end

	on_event_list_item_added (a_service: EVENT_LIST_S; a_event_list_item: EVENT_LIST_ITEM_I) is
			-- Handle evetn list added actions
		local
			l_contexts: ES_TESTING_EVENT_LIST_CONTEXTS
		do
			if a_event_list_item.category = {ENVIRONMENT_CATEGORIES}.testing then
				if {l_data: ES_EWEASEL_TEST_RESULT_ITEM} a_event_list_item.data then
					create l_contexts

					if a_service.items (l_contexts.eweasel_result_analyzer).has (a_event_list_item) then
						set_progress_proportion (l_data.test_case_result_index, l_data.total_test_cases_count)
					end
				end
			end
		end

	populate_event_grid_row_items (a_event_item: EVENT_LIST_ITEM_I; a_row: EV_GRID_ROW) is
			-- <Precursor>
		do
			if {l_test_case_item: EVENT_LIST_TEST_CASE_ITEM} a_event_item then
				test_case_grid_manager.add_test_case (l_test_case_item, a_row)
			else
				check not_possible: False end
			end

			-- FIXIT: Save session data here is too heavy?
			test_case_grid_manager.save_test_case_to_session
			test_case_grid_manager.update_buttons_sensitivity
		end

	do_default_action (a_row: EV_GRID_ROW) is
			-- <Precursor>
		local
			l_class_stone: CLASSI_STONE
		do
			if {l_event_list_item: EVENT_LIST_ITEM} a_row.data then
				if {l_test_case: ES_EWEASEL_TEST_CASE_ITEM} l_event_list_item.data then
					check is_running_state: l_test_case.is_valid_for_running end
					create l_class_stone.make (l_test_case.class_i)
					(create {EB_CONTROL_PICK_HANDLER}).launch_stone (l_class_stone)
				end
			end
		end

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- <Precursor>
		local
			l_constants: EB_CONSTANTS
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_icons: ES_PIXMAPS_10X10
		do
			create l_constants
			l_icons := l_constants.pixmaps.mini_pixmaps
			create Result.make (8)

			Result.force_last (unit_test_manager.new_manual_test_command.new_sd_toolbar_item (False))
			Result.force_last (unit_test_manager.del_test_case_command.new_sd_toolbar_item (False))

			create l_separator.make
			Result.force_last (l_separator)

			Result.force_last (unit_test_manager.next_failed_test_command.new_sd_toolbar_item (False))
			Result.force_last (unit_test_manager.previous_failed_test_command.new_sd_toolbar_item (False))

			Result.force_last (unit_test_manager.show_failed_tests_only_command.new_sd_toolbar_item (False))
			Result.force_last (unit_test_manager.update_last_changed_time_command.new_sd_toolbar_item (False))

			create l_separator.make
			Result.force_last (l_separator)

			Result.force_last (unit_test_manager.start_test_run_command.new_sd_toolbar_item (False))
			Result.force_last (unit_test_manager.start_test_run_failed_first_command.new_sd_toolbar_item (False))
		end

feature -- Query

	unit_test_manager: !ES_EWEASEL_EXECUTION_MANAGER is
			-- Manager of manual unit test.
		local
			l_shared: ES_EWEASEL_SINGLETON_FACTORY
		do
			create l_shared
			Result := l_shared.manager
		end

	test_case_grid_manager: ES_TEST_CASE_GRID_MANAGER is
			-- Manager of `test_case_grid'
		do
			Result := internal_test_case_grid_manager
			if Result = Void then
				if {l_grid: ES_GRID} test_case_grid then
					create Result.make (l_grid)
				else
					check not_possible: False end
				end
				internal_test_case_grid_manager := Result
			end
		ensure
			not_void: Result /= Void
			created: internal_test_case_grid_manager /= Void
		end

feature -- Command

	reset is
			-- Clear last test run data
		do
			set_progress_proportion (0, 0)
			test_case_grid_manager.reset
		end

	set_progress_proportion (a_already_run, a_total: INTEGER) is
			-- Set progress bar with `a_proportion'
		require
			valid: a_already_run >= 0 and a_total >= 0 and a_already_run <= a_total
		local
			l_bar: like progress_bar
			l_label: like runs_label
			l_proportion: REAL
			l_runs_label: STRING_GENERAL
		do
			l_bar := progress_bar
			if l_bar /= Void and then not l_bar.is_destroyed then
				if a_total /= 0 then
					l_proportion := a_already_run / a_total
					l_bar.set_proportion (l_proportion)
				else
					l_bar.set_proportion (0)
				end
			end

			l_label := runs_label
			if l_label /= Void and then not l_label.is_destroyed then
				l_runs_label := runs_string.twin
				l_runs_label.append (": " + a_already_run.out + "/" + a_total.out)
				l_label.set_text (l_runs_label)
			end
		end

feature {ES_TEST_CASE_GRID_MANAGER} -- Command

	set_error_label_with (a_value: INTEGER) is
			-- Set `errors_label' text with `a_value'
		require
			non_negative: a_value >= 0
		local
			l_string: STRING_GENERAL
		do
			l_string := errors_string.twin
			l_string.append (": " + a_value.out)
			errors_label.set_text (l_string)
		end

	set_failure_label_with (a_value: INTEGER) is
			-- Set `failures_label' text with `a_value'
		require
			non_negative: a_value >= 0
		local
			l_string: STRING_GENERAL
		do
			l_string := failures_string.twin
			l_string.append (": " + a_value.out)
			failures_label.set_text (l_string)
		end

feature {NONE}	-- Implementation

	is_appliable_event (a_item: EVENT_LIST_ITEM_I): BOOLEAN is
			-- Redefine
		local
			l_tester: ES_TEST_CASE_FINDER
		do
			Result := a_item /= Void and then a_item.category = {ENVIRONMENT_CATEGORIES}.testing
			if {l_item: ES_EWEASEL_TEST_CASE_ITEM} a_item.data then
				create l_tester
				Result := l_tester.is_test_case_class (l_item.class_i)
			end
			if Result then
				Result := {l_test_case_item: EVENT_LIST_TEST_CASE_ITEM} a_item
			end
		end

	runs_string: STRING_GENERAL is
			-- String used by `runs_label'
		do
			Result := interface_names.l_runs
		end

	errors_string: STRING_GENERAL is
			-- String used by `errors_label'
		do
			Result := interface_names.b_errors
		end

	failures_string: STRING_GENERAL is
			-- String used by `failures_label'
		do
			Result := interface_names.l_failures
		end

	internal_test_case_grid_manager: like test_case_grid_manager
			-- Instance holder
			-- Note: used by `test_case_grid_manager' ONLY!

feature {NONE} -- UI widgets

	runs_label: EV_LABEL
			-- Label show how many runs

	errors_label: EV_LABEL
			-- Label show how many errors

	failures_label: EV_LABEL
			-- Label show how many failures

	progress_bar: EV_HORIZONTAL_PROGRESS_BAR
			-- Progress bar show test case run progress

	test_case_grid: ES_GRID;
			-- Grid to show all test cases of Current run.

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
