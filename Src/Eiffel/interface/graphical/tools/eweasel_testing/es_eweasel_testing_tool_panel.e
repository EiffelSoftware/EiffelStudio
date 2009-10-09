note
	description: "[
						Testing tool main control panel.
						
						This tool can create, execute and analyze eweasel tests
						The detailed test run result avaliable in {ES_EWEASEL_TESTING_RESULT_TOOL}						
						
						This tool is used for eweasel testing for the moment.
						In future, maybe CDD and Autotest will be integrated.
																				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_TESTING_TOOL_PANEL

inherit
	ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE
		rename
			grid_events as test_case_grid
		export
			{ES_EWEASEL_EXECUTION_MANAGER}  interface_names
		redefine
			on_after_initialized,
			build_tool_interface,
			is_appliable_event,
			create_right_tool_bar_items
		end

create
	make

feature {NONE} -- Initialization

	build_tool_interface (a_grid: ES_GRID)
			-- <Precursor>
		local
			l_box: EV_BOX
			l_tool_bar: SD_TOOL_BAR
			l_bottom_container: EV_VERTICAL_BOX
			l_grid_border: EV_CELL
		do
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_grid)
			l_bottom_container := widget

				-- Bottom border for grid
			create l_grid_border
			l_grid_border.set_minimum_height (1)
			l_grid_border.set_background_color (colors.stock_colors.color_3d_shadow)
			l_bottom_container.extend (l_grid_border)
			l_bottom_container.disable_item_expand (l_grid_border)

			create {EV_HORIZONTAL_BOX} l_box
			l_box.set_border_width ({ES_UI_CONSTANTS}.notebook_border)
			l_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			l_bottom_container.extend (l_box)
			l_bottom_container.disable_item_expand (l_box)

				-- Progress bar
			create progress_bar
			l_box.extend (progress_bar)

				-- Cancel button
			create l_tool_bar.make
			l_tool_bar.extend (unit_test_manager.stop_test_run_command.new_sd_toolbar_item (True))
			l_tool_bar.compute_minimum_size
			l_box.extend (l_tool_bar)
			l_box.disable_item_expand (l_tool_bar)

			test_case_grid_manager.build_columns

				-- Enable sorting
			enable_sorting_on_columns (test_case_grid_manager.all_columns.to_array)
			enable_copy_to_clipboard
		ensure then
			set: test_case_grid = a_grid
		end

	on_after_initialized
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
				l_factory.manager.new_manual_test_command.enable_sensitive
			else
				l_shared.eiffel_project.manager.load_agents.extend (agent test_case_grid_manager.restore_test_case_from_session)
				l_shared.eiffel_project.manager.load_agents.extend (agent ((l_factory.manager).new_manual_test_command).enable_sensitive)
			end
		end

	init_event_list_service
			-- Initilaize event list service
		local
			l_service: EVENT_LIST_S
		do
			if event_list.is_service_available then
				l_service := event_list.service
				l_service.item_added_event.subscribe (agent on_event_list_item_added)
			end
		end

	on_event_list_item_added (a_service: EVENT_LIST_S; a_event_list_item: EVENT_LIST_ITEM_I)
			-- Handle evetn list added actions
		local
			l_contexts: ES_EWEASEL_TESTING_EVENT_LIST_CONTEXTS
		do
			if a_event_list_item.category = {ENVIRONMENT_CATEGORIES}.testing then
				if attached {ES_EWEASEL_TEST_RESULT_ITEM} a_event_list_item.data as l_data then
					create l_contexts

					if a_service.items (l_contexts.eweasel_result_analyzer).has (a_event_list_item) then
						set_progress_proportion (l_data.test_case_result_index, l_data.total_test_cases_count)
					end
				end
			end
		end

	populate_event_grid_row_items (a_event_item: EVENT_LIST_ITEM_I; a_row: EV_GRID_ROW)
			-- <Precursor>
		do
			if attached {EVENT_LIST_TEST_CASE_ITEM} a_event_item as l_test_case_item then
				test_case_grid_manager.add_test_case (l_test_case_item, a_row)
			else
				check not_possible: False end
			end

			-- FIXIT: Save session data here is too heavy?
			test_case_grid_manager.save_test_case_to_session
			test_case_grid_manager.update_buttons_sensitivity
		end

	do_default_action (a_row: EV_GRID_ROW)
			-- <Precursor>
		local
			l_class_stone: CLASSI_STONE
		do
			if attached {EVENT_LIST_ITEM} a_row.data as l_event_list_item then
				if attached {ES_EWEASEL_TEST_CASE_ITEM} l_event_list_item.data as l_test_case then
					check is_running_state: l_test_case.is_valid_for_running end
					create l_class_stone.make (l_test_case.class_i)
					(create {EB_CONTROL_PICK_HANDLER}).launch_stone (l_class_stone)
				end
			end
		end

feature -- Query

	unit_test_manager: attached ES_EWEASEL_EXECUTION_MANAGER
			-- Manager of manual unit test.
		local
			l_shared: ES_EWEASEL_SINGLETON_FACTORY
		do
			create l_shared
			Result := l_shared.manager
		end

	test_case_grid_manager: ES_EWEASEL_TEST_CASE_GRID_MANAGER
			-- Manager of `test_case_grid'
		do
			Result := internal_test_case_grid_manager
			if Result = Void then
				if attached {ES_GRID} test_case_grid as l_grid then
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

	reset
			-- Clear last test run data
		do
			set_progress_proportion (0, 0)
			test_case_grid_manager.reset
		end

	set_progress_proportion (a_already_run, a_total: INTEGER)
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
					l_proportion := (a_already_run / a_total).truncated_to_real
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

feature {ES_EWEASEL_EXECUTION_MANAGER} -- Command

	set_progress_proportion_completed
			-- Set progress proportion completed
		local
			l_bar: like progress_bar
		do
			l_bar := progress_bar
			if l_bar /= Void then
				l_bar.set_proportion (1)
			end
		end

feature {ES_EWEASEL_TEST_CASE_GRID_MANAGER} -- Command

	set_error_label_with (a_value: INTEGER)
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

	set_failure_label_with (a_value: INTEGER)
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

	is_appliable_event (a_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Redefine
		local
			l_tester: ES_EWEASEL_TEST_CASE_FINDER
		do
			Result := a_item /= Void and then a_item.category = {ENVIRONMENT_CATEGORIES}.testing
			if attached {ES_EWEASEL_TEST_CASE_ITEM} a_item.data as l_item then
				create l_tester
				Result := l_tester.is_test_case_class (l_item.class_i)
			end
			if Result then
				Result := attached {EVENT_LIST_TEST_CASE_ITEM} a_item as l_test_case_item
			end
		end

	runs_string: STRING_GENERAL
			-- String used by `runs_label'
		do
			Result := interface_names.l_runs
		end

	errors_string: STRING_GENERAL
			-- String used by `errors_label'
		do
			Result := interface_names.b_errors
		end

	failures_string: STRING_GENERAL
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

feature {NONE} -- Factory

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_icons: ES_PIXMAPS_10X10
			l_shim: ES_EWEASEL_TESTING_RESULT_TOOL
			l_show_tool_command: ES_SHOW_TOOL_COMMAND
		do
			l_icons := pixmaps.mini_pixmaps

			create Result.make (8)

			Result.force_last (unit_test_manager.new_manual_test_command.new_sd_toolbar_item (False))
			Result.force_last (unit_test_manager.del_test_case_command.new_sd_toolbar_item (False))

			create l_separator.make
			Result.force_last (l_separator)

			Result.force_last (unit_test_manager.next_failed_test_command.new_sd_toolbar_item (False))
			Result.force_last (unit_test_manager.previous_failed_test_command.new_sd_toolbar_item (False))

			Result.force_last (unit_test_manager.show_failed_tests_only_command.new_sd_toolbar_item (False))
			Result.force_last (unit_test_manager.update_last_changed_time_command.new_sd_toolbar_item (False))
			Result.force_last (unit_test_manager.find_test_case_command.new_sd_toolbar_item (False))

			create l_separator.make
			Result.force_last (l_separator)

			Result.force_last (unit_test_manager.start_test_run_command.new_sd_toolbar_item (False))
			Result.force_last (unit_test_manager.start_test_run_failed_first_command.new_sd_toolbar_item (False))

			Result.force_last (create {SD_TOOL_BAR_SEPARATOR}.make)

			l_shim ?= develop_window.shell_tools.tool ({ES_EWEASEL_TESTING_RESULT_TOOL})
			if l_shim /= Void then
				l_show_tool_command := develop_window.commands.show_shell_tool_commands.item (l_shim)
				Result.force_last (l_show_tool_command.new_sd_toolbar_item (False))
			end
		end

	create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_string: STRING_GENERAL
			l_vbox: EV_VERTICAL_BOX
			l_box: EV_HORIZONTAL_BOX
			l_pixmap: EV_PIXMAP
		do
			l_string := runs_string.twin
			l_string.append (": 0/0")

			create Result.make (5)

				-- Runs
			create l_vbox
			l_vbox.extend (create {EV_CELL})

			create l_box
			l_box.set_border_width ({ES_UI_CONSTANTS}.notebook_border)
			l_box.set_padding ({ES_UI_CONSTANTS}.label_horizontal_padding)

			l_pixmap := stock_pixmaps.run_animation_5_icon.twin
			l_pixmap.set_minimum_size (l_pixmap.width, l_pixmap.height)
			l_box.extend (l_pixmap)

			create runs_label.make_with_text (l_string)
			runs_label.align_text_left
			l_box.extend (runs_label)

			l_vbox.extend (l_box)
			l_vbox.disable_item_expand (l_box)
			l_vbox.extend (create {EV_CELL})
			Result.put_last (create {SD_TOOL_BAR_WIDGET_ITEM}.make (l_vbox))

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Errors
			create l_vbox
			l_vbox.extend (create {EV_CELL})

			create l_box
			l_box.set_border_width ({ES_UI_CONSTANTS}.notebook_border)
			l_box.set_padding ({ES_UI_CONSTANTS}.label_horizontal_padding)

			l_pixmap := stock_pixmaps.general_error_icon.twin
			l_pixmap.set_minimum_size (l_pixmap.width, l_pixmap.height)
			l_box.extend (l_pixmap)

			create errors_label
			errors_label.align_text_left
			set_error_label_with (0)
			l_box.extend (errors_label)

			l_vbox.extend (l_box)
			l_vbox.disable_item_expand (l_box)
			l_vbox.extend (create {EV_CELL})
			Result.put_last (create {SD_TOOL_BAR_WIDGET_ITEM}.make (l_vbox))

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Failures
			create l_vbox
			l_vbox.extend (create {EV_CELL})

			create l_box
			l_box.set_border_width ({ES_UI_CONSTANTS}.notebook_border)
			l_box.set_padding ({ES_UI_CONSTANTS}.label_horizontal_padding)

			l_pixmap := stock_pixmaps.general_warning_icon.twin
			l_pixmap.set_minimum_size (l_pixmap.width, l_pixmap.height)
			l_box.extend (l_pixmap)

			create failures_label
			failures_label.align_text_left
			set_failure_label_with (0)
			l_box.extend (failures_label)

			l_vbox.extend (l_box)
			l_vbox.disable_item_expand (l_box)
			l_vbox.extend (create {EV_CELL})
			Result.put_last (create {SD_TOOL_BAR_WIDGET_ITEM}.make (l_vbox))
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
