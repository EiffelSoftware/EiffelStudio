indexing
	description: "[
					Manager of test result grid in {ES_EWEASEL_TESTING_RESULT_TOOL_PANEL}
					
					One manager for one test run result grid
																					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_TEST_RUN_RESULT_GRID_MANAGER

inherit
	ANY

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_grid: ES_GRID) is
			-- Creation method
		require
			not_void: a_grid /= Void
		local
			l_tool: like testing_result_tool
			l_win: EB_DEVELOPMENT_WINDOW
		do
			grid := a_grid
			grid.enable_multiple_row_selection
			grid.disable_row_height_fixed
			grid.enable_tree
			l_tool := testing_result_tool
			if l_tool /= Void then
				l_win := l_tool.develop_window

				grid.set_configurable_target_menu_mode
				grid.set_configurable_target_menu_handler (agent (l_win.menus.context_menu_factory).standard_compiler_item_menu)
			end
		ensure
			set: grid = a_grid
		end

feature -- Command

	build_columns is
			-- Init columns of `grid'.
		local
			l_grid: !ES_GRID
			l_columns: like all_columns_titles
			l_helper: ES_EWEASEL_TEST_GRID_HELPER
		do
			from
				l_columns := all_columns_titles
				l_grid := grid
				l_grid.set_column_count_to (l_columns.count)
				l_columns.start
			until
				l_columns.after
			loop
				l_grid.column (l_columns.index).set_title (l_columns.item)

				l_columns.forth
			end

			-- Enable grid item edit
			create l_helper.make (l_grid)
			l_grid.pointer_button_press_actions.extend (agent l_helper.on_pointer_press)
			l_grid.enable_auto_size_best_fit_column (1)
		ensure
			added: grid.column_count = 4
		end

	append_result_item (a_item: !ES_EWEASEL_TEST_RESULT_ITEM; a_row: EV_GRID_ROW) is
			-- Append grid items whose information query from `a_item' to `a_row'
		require
			not_void: a_row /= Void
		local
			l_all_columns: like all_columns_titles
			l_grid_item: EV_GRID_ITEM
			l_edit_item: EV_GRID_EDITABLE_ITEM
			l_tag_string: STRING_GENERAL
		do
			from
				l_all_columns := all_columns_titles
				l_all_columns.start
			until
				l_all_columns.after
			loop
				l_grid_item := Void
				inspect
					l_all_columns.index
				when 1 then
					if a_item.title /= Void then
						create {EV_GRID_LABEL_ITEM} l_grid_item.make_with_text (a_item.title)
					end
					if a_item.orignal_eweasel_ouput /= Void and l_grid_item /= Void then
						l_grid_item.set_tooltip (a_item.orignal_eweasel_ouput)
					end
				when 2 then
					if {l_time: DT_DATE_TIME} a_item.test_run_time then
						create {EV_GRID_LABEL_ITEM} l_grid_item.make_with_text (l_time.out)
					else
						create {EV_GRID_LABEL_ITEM} l_grid_item.make_with_text (time_string)
					end
				when 3 then
					l_grid_item := add_column_source (a_item, a_row)
				when 4 then
					l_tag_string := a_item.tag
					if l_tag_string = Void then
						l_tag_string := tag_string
					end

					create l_edit_item.make_with_text (l_tag_string)
					l_edit_item.deactivate_actions.extend (agent on_tag_item_deactive)

					l_grid_item := l_edit_item
				else
					check not_possible: False end
				end

				if {lt_grid_item: !EV_GRID_ITEM } l_grid_item then
					a_row.set_item (l_all_columns.index, lt_grid_item)

					set_forground_color_of_item (a_item, lt_grid_item)
				end

				l_all_columns.forth
			end

			if (create {ES_EWEASEL_RESULT_TYPE}).is_need_correct (a_item.result_type) then
				add_sub_row_items (a_item, a_row)
			end

			unit_test_manager.testing_tool.test_case_grid_manager.update_grid_item_with_test_run_data (a_item)

			unit_test_manager.see_testing_failure_trace_command.enable_sensitive
		end

	reset is
			-- Clear all results
		local
			l_row_count: INTEGER
		do
			l_row_count := grid.row_count
			if l_row_count > 0 then
				grid.remove_rows (1, l_row_count)
			end
		end

	save_test_run_data_to_session is
			-- Save test case data to session data
		local
			l_shared: EB_SHARED_WINDOW_MANAGER
			l_list: like all_test_runs_from_grid
			l_test_cases: !ARRAYED_LIST [ES_EWEASEL_TEST_CASE_ITEM]
		do
			l_list := all_test_runs_from_grid
			l_test_cases := unit_test_manager.testing_tool.test_case_grid_manager.all_test_cases_from_grid

			session_data.append_test_run_data (l_list, l_test_cases)

			create l_shared
			if {l_dev_window: EB_DEVELOPMENT_WINDOW} l_shared.window_manager.last_focused_development_window then
				l_dev_window.session_data.set_value (session_data, session_data_id)
			end
		end

	restore_test_run_data is
			-- Restore session data from session service
		local
			l_shared: EB_SHARED_WINDOW_MANAGER
		do
			create l_shared
			if {l_dev_window: EB_DEVELOPMENT_WINDOW} l_shared.window_manager.last_focused_development_window then
				if {l_data: like session_data} l_dev_window.session_data.value (session_data_id) then
					internal_session_data := l_data
				end
			end
		end

	show_all_failure_traces (a_reverse: BOOLEAN) is
			-- Show failure details of current grid selected rows.
		local
			l_count, l_index: INTEGER
			l_grid: like grid
			l_row: EV_GRID_ROW
		do
			from
				l_grid := grid
				l_count := l_grid.row_count
				l_index := 1
			until
				l_index > l_count
			loop
				l_row := l_grid.row (l_index)

				if l_row.is_expandable then
					if a_reverse then
						l_row.collapse
					else
						l_row.expand
					end
				end

				l_index := l_index + 1
			end
		end

feature -- Query

	all_columns: !ARRAYED_LIST [EV_GRID_COLUMN] is
			-- All columns in `grid'
		local
			l_index, l_count: INTEGER
			l_grid: like grid
		do
			from
				l_grid := grid
				l_index := 1
				l_count := l_grid.column_count
				create Result.make (l_count)
			until
				l_index > l_count
			loop
				Result.extend (l_grid.column (l_index))
				l_index := l_index + 1
			end
		end

	session_data: !ES_EWEASEL_TEST_RUN_SESSION_DATA is
			-- Session data
		do
			if not {l_test: !ES_EWEASEL_TEST_RUN_SESSION_DATA} internal_session_data then
				create internal_session_data.make
			end
			Result := internal_session_data
		end

feature {NONE} -- Implementation commands

	update_current_session_data is
			-- Update Current session data with current data in the grid
		local
			l_list: like all_test_runs_from_grid
			l_current_session_data: ARRAYED_LIST [ES_EWEASEL_TEST_RESULT_ITEM]
		do
			l_list := all_test_runs_from_grid
			if {l_session_data: ES_EWEASEL_TEST_RUN_DATA_ITEM} session_data.current_session_data then
				l_current_session_data := l_session_data.test_run_data
				if l_current_session_data /= Void then
					check same_size: l_list.count = l_current_session_data.count end
					from
						l_list.start
						l_current_session_data.start
					until
						l_list.after
					loop
						-- Update session data
						l_current_session_data.replace (l_list.item)

						l_list.forth
						l_current_session_data.forth
					end
				end
			end
		end

	add_column_source (a_item: !ES_EWEASEL_TEST_RESULT_ITEM; a_row: EV_GRID_ROW): !EV_GRID_ITEM is
			-- Add item to column `source'
		require
			not_void: a_row /= Void
		local
			l_token_item: !EB_GRID_EDITOR_TOKEN_ITEM
			l_helper: ES_EWEASEL_TEST_GRID_HELPER
		do
			if a_item.execution_error_in /= Void then
				create {EV_GRID_LABEL_ITEM} Result.make_with_text (a_item.execution_error_in)
			elseif a_item.root_class_name /= Void then
				create l_helper.make (grid)
				if {lt_class_name: STRING} a_item.root_class_name.as_string_8 then
					l_token_item := l_helper.new_editor_token_item (lt_class_name)
					Result := l_token_item
				end
			end
		end

	show_failure_trace_of (a_row: !EV_GRID_ROW) is
			-- Show failure details of `a_row'
			-- This feature will add subrow into `a_row'
		local
			l_item: like result_item_of
		do
			if grid.grid_selected_top_rows (grid).has (a_row) then
				l_item := result_item_of (a_row)
				check not_void: l_item /= Void end

			 	if {lt_item: ES_EWEASEL_TEST_RESULT_ITEM} l_item then
			 		add_sub_row_items (lt_item, a_row)
			 	end

			end
		end

	add_sub_row_items (a_item: !ES_EWEASEL_TEST_RESULT_ITEM; a_parent_row: !EV_GRID_ROW) is
			-- Add detail information rows to `a_row'
		local
			l_item: EV_GRID_LABEL_ITEM
			l_sub_row: EV_GRID_ROW
			l_lines: like lines_of -- FIXIT: How to show multi-line details?
			l_row_height: INTEGER
		do
			if a_parent_row.subrow_count = 0 then -- We only add subrows one time
				if a_item.orignal_eweasel_ouput /= Void then
					l_lines := lines_of (a_item.orignal_eweasel_ouput)
					l_sub_row := grid.extended_new_subrow (a_parent_row)
					create l_item.make_with_text (a_item.orignal_eweasel_ouput)
					l_sub_row.set_item (1, l_item)
					l_row_height := {ES_UI_CONSTANTS}.grid_row_height
					if l_lines /= Void then
						l_sub_row.set_height (l_row_height * l_lines.count)
					end

					if unit_test_manager.see_testing_failure_trace_command.is_selected then
						a_parent_row.expand
					end
				end
			end
		end

	set_forground_color_of_item (a_eweasel_result: !ES_EWEASEL_TEST_RESULT_ITEM; a_grid_item: !EV_GRID_ITEM) is
			-- Set forground color of `a_grid_item' base on `a_eweasel_result'.
		local
			l_colors: ES_SHARED_FONTS_AND_COLORS
		do
			create l_colors
			inspect
				a_eweasel_result.result_type
			when {ES_EWEASEL_RESULT_TYPE}.failed, {ES_EWEASEL_RESULT_TYPE}.error then
				a_grid_item.set_foreground_color (l_colors.colors.high_priority_foreground_color)
			when {ES_EWEASEL_RESULT_TYPE}.passed then
				a_grid_item.set_foreground_color (l_colors.colors.low_priority_foreground_color)
			else
				-- Default we do nothing	
			end

		end

	on_tag_item_deactive is
			-- Handle a editable item deactive action
		local
			l_row: EV_GRID_ROW
		do
			if {l_item: EV_GRID_EDITABLE_ITEM} grid.activated_item then
				l_row := l_item.row

				if {l_event_list_item: EVENT_LIST_TESTING_RESULT_ITEM} l_row.data then
					 if {l_data: ES_EWEASEL_TEST_RESULT_ITEM} l_event_list_item.data then
						if {l_grid_item: EV_GRID_EDITABLE_ITEM} grid.activated_item then
							l_data.set_tag (l_grid_item.text)

							update_current_session_data
						end
					 end
				end
			end
		end

feature {NONE} -- Implementation queries

	all_columns_titles: ARRAYED_LIST [STRING_GENERAL] is
			-- All columns titles in `grid'
		once
			create Result.make (4)

			Result.extend (interface_names.l_error)
			Result.extend (interface_names.t_time)
			Result.extend (interface_names.l_context)
			Result.extend (interface_names.l_tags)
		ensure
			not_void: Result /= Void
			column_count_right: Result.count = 4
		end

	grid: !ES_GRID
			-- Grid managed.

	testing_result_tool: ES_EWEASEL_TESTING_RESULT_TOOL_PANEL is
			-- Testing result tool panel
		do
			Result := unit_test_manager.testing_result_tool
		end

	lines_of (a_string: STRING): LIST [STRING_8] is
			-- Split `a_string' to list of lines separated by '%R'
		do
			if a_string /= Void then
				Result := a_string.split ('%R')
			end
		end

	result_item_of (a_row: !EV_GRID_ROW): ES_EWEASEL_TEST_RESULT_ITEM is
			-- eweasel result item data in `a_row'
		do
			if {l_event_data: EVENT_LIST_TESTING_RESULT_ITEM} a_row.data then
				if {l_test_case: ES_EWEASEL_TEST_RESULT_ITEM} l_event_data.data then
					Result := l_test_case
				else
					check not_possible: False end
				end
			else
				-- Maybe this is subrow
			end
		end

	all_test_runs_from_grid: !ARRAYED_LIST [ES_EWEASEL_TEST_RESULT_ITEM]
			-- Fectch all test case items information from `grid'
		local
			l_grid: like grid
			l_index, l_count: INTEGER
			l_item: ES_EWEASEL_TEST_RESULT_ITEM
		do
			from
				l_grid := grid
				l_index := 1
				l_count := l_grid.row_count
				create Result.make (l_count)
			until
				l_index > l_count
			loop
				if {l_row: EV_GRID_ROW} l_grid.row (l_index) then
					l_item := result_item_of (l_row)
					if l_item /= Void then
						Result.extend (l_item)
					end
				end
				l_index := l_index + 1
			end
		end

	time_string: !STRING_GENERAL is
			-- Default time string used in grid items
		do
			create {STRING} Result.make_from_string ("")
		end

	tag_string: !STRING_GENERAL is
			-- Default tag string used in grid items
		do
			create {STRING} Result.make_from_string ("")
		end

	session_data_id: STRING is "com.eiffel.testing.test_run_data_id"
			-- Session data used for session service

	unit_test_manager: !ES_EWEASEL_EXECUTION_MANAGER
			-- Manager of manual unit test.
		local
			l_shared: ES_EWEASEL_SINGLETON_FACTORY
		do
			create l_shared
			Result := l_shared.manager
		end

	internal_session_data: like session_data;
			-- Instance holder of `session_data'
			-- Note: used by `session_data' ONLY!

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
