indexing
	description: "[
					Manager of test case grid in {ES_TESTING_TOOL_PANEL}
					
					One manager for one test case grid
																								]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_CASE_GRID_MANAGER

inherit
	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_grid: !ES_GRID) is
			-- Creation method
		do
			grid := a_grid
			grid.drop_actions.extend (agent on_drop)
			grid.drop_actions.set_veto_pebble_function (agent on_veto_drop)
			grid.enable_single_row_selection
			grid.enable_multiple_row_selection
			grid.key_press_actions.extend (agent on_key_press)
		ensure
			set: grid = a_grid
		end

feature -- Command

	build_columns is
			-- Init columns of `grid'.
		local
			l_grid: like grid
			l_all_columns: like all_columns_titles
			l_helper: ES_TEST_GRID_HELPER
		do
			from
				l_grid := grid
				l_all_columns := all_columns_titles
				l_grid.set_column_count_to (l_all_columns.count)
				l_all_columns.start
			until
				l_all_columns.after
			loop
				l_grid.column (l_all_columns.index).set_title (l_all_columns.item)
				l_all_columns.forth
			end

			-- Enable grid item edit
			create l_helper.make (l_grid)
			l_grid.pointer_button_press_actions.extend (agent l_helper.on_pointer_press)

			-- FIXIT: We have column `Runner' and `Auto Generated' for the moment, since CDD is not integrated,
			-- it not make sense to show only one kind of texts.
			grid.hide_column (2)
			grid.hide_column (3)
		ensure
			added: grid.column_count = all_columns_titles.count
		end

	select_next_failed_row is
			-- Select next test case row in `grid'
		do
			select_next_or_previous_failed_row (True)
		end

	select_previous_failed_row is
			-- Select previous test case row in `grid'
		do
			select_next_or_previous_failed_row (False)
		end

	add_test_case (a_event_list_grid_item: !EVENT_LIST_TEST_CASE_ITEM; a_row: EV_GRID_ROW) is
			-- `a_row' is where to insert new grid items, maybe void
		require
			valid: is_test_case_item (a_event_list_grid_item.data)
		do
			if {l_test_case: ES_EWEASEL_TEST_CASE_ITEM} a_event_list_grid_item.data then
				check not_void:a_row /= Void end
				insert_one_row_items (a_row, l_test_case)
			else
				check not_possible: False end
			end
		end

	save_test_case_to_session is
			-- Save test case data to session data
		local
			l_shared: EB_SHARED_WINDOW_MANAGER
			l_list: like all_test_cases_from_grid
			l_seesion_data: ES_EWEASEL_TEST_CASE_SESSION_DATA
		do
			l_list := all_test_cases_from_grid
			create l_seesion_data.make (l_list.count)
			l_seesion_data.append_test_cases (l_list)

			create l_shared
			if {l_dev_window: EB_DEVELOPMENT_WINDOW} l_shared.window_manager.last_focused_development_window then
				l_dev_window.session_data.set_value (l_seesion_data, session_data_id)
			end
		end

	restore_test_case_from_session is
			-- Load test case data from session data
		local
			l_consumer: SERVICE_CONSUMER [EVENT_LIST_S]
			l_event_item: EVENT_LIST_TEST_CASE_ITEM
			l_session_data_value: like all_test_cases_from_grid
		do
			if {l_test_case_data: ES_EWEASEL_TEST_CASE_SESSION_DATA} session_data then
				l_session_data_value := l_test_case_data.all_running_test_cases
				create l_consumer
				if l_consumer.is_service_available then
					from
						l_session_data_value.start
					until
						l_session_data_value.after
					loop
						check valid: l_session_data_value.item.is_valid_for_running end
						create l_event_item.make ({ENVIRONMENT_CATEGORIES}.testing, 0, l_session_data_value.item)

						l_consumer.service.put_event_item (context_uuid, l_event_item)

						l_session_data_value.forth
					end
				end
			end
		end

	update_buttons_sensitivity is
			-- Update buttons' sensitivity
		do
			if all_test_cases_from_grid.count > 0 then
				manager.start_test_run_command.enable_sensitive
				manager.start_test_run_failed_first_command.enable_sensitive
				manager.next_failed_test_command.enable_sensitive
				manager.previous_failed_test_command.enable_sensitive
				manager.update_last_changed_time_command.enable_sensitive
				manager.del_test_case_command.enable_sensitive
			else
				manager.start_test_run_command.disable_sensitive
				manager.start_test_run_failed_first_command.disable_sensitive
				manager.next_failed_test_command.disable_sensitive
				manager.previous_failed_test_command.disable_sensitive
				manager.update_last_changed_time_command.disable_sensitive
				manager.del_test_case_command.disable_sensitive
			end

			if has_failed_test_case then
				manager.show_failed_tests_only_command.enable_sensitive
			else
				manager.show_failed_tests_only_command.disable_sensitive
			end
		end

	only_show_failed_test_cases (a_reverse: BOOLEAN) is
			-- Only show failed test cases in grid?
			-- If `a_reverse', show all test cases
		local
			l_list: like all_test_cases_from_grid
			l_count, l_index: INTEGER
		do
			from
				l_list := all_test_cases_from_grid
				l_list.start
			until
				l_list.after
			loop
				if not a_reverse then
					if not (create {ES_EWEASEL_RESULT_TYPE}).is_need_correct (l_list.item.last_run_result) then
						if {l_row: EV_GRID_ROW} grid.row (l_list.index) then
							l_row.hide
						end
					end
				else
					from
						l_count := grid.row_count
						l_index := 1
					until
						l_index > l_count
					loop
						grid.row (l_index).show

						l_index := l_index + 1
					end
				end

				l_list.forth
			end
		end

	remove_selected_rows is
			-- Remove current selected rows in `grid'
		local
			l_list: ARRAYED_LIST [EV_GRID_ROW]
		do
			l_list := grid.selected_rows
			from
				l_list.start
			until
				l_list.after
			loop
				grid.remove_row (l_list.item.index)
				l_list.forth
			end
		end

	remove_all_rows is
			-- Remove all rows in `grid;
		do
			if grid.row_count > 1 then
				grid.remove_rows (1, grid.row_count)
			end
		end

	refresh_time_columns is
			-- Refresh time related columns' texts
		do
			update_grid_column_time
			update_grid_column_changed_after_last_run
		end

	update_grid_item_with_test_run_data (a_result: !ES_EWEASEL_TEST_RESULT_ITEM) is
			-- Update `a_result' related row's texts and row's data.
		local
			l_test_run_class: CONF_CLASS
			l_grid_row: EV_GRID_ROW
			l_test_case_item: ES_EWEASEL_TEST_CASE_ITEM
		do
			if {lt_class_name: STRING} a_result.root_class_name then
				l_test_run_class := conf_class_of (lt_class_name)
				if {lt_conf_class: CONF_CLASS} l_test_run_class then
					l_grid_row := test_case_row_related_with (lt_conf_class)
					if {lt_row: EV_GRID_ROW} l_grid_row then
						l_test_case_item := test_case_item_from (lt_row)
					else
						check not_possible: False end
					end
				else
					check not_possible: False end
				end

				-- Update test case item data
				l_test_case_item.set_last_run_result (a_result.result_type)
				l_test_case_item.set_last_run_time (a_result.test_run_time)

				if a_result.result_type = {ES_EWEASEL_RESULT_TYPE}.error then
					error_count := error_count + 1
					update_failure_and_error_label
				elseif a_result.result_type = {ES_EWEASEL_RESULT_TYPE}.failed then
					failure_count := failure_count + 1
					update_failure_and_error_label
				end

				if {l_label_item: EV_GRID_LABEL_ITEM} l_grid_row.item (5) then
					update_row_forground_color_base_on_result (l_label_item, a_result.result_type)
				end
			end

			update_buttons_sensitivity
		end

	test_case_row_related_with (a_class: !CONF_CLASS): EV_GRID_ROW is
			-- `grid''s row related with `a_class_i'
			-- Result void if not found
		local
			l_grid_items: like all_test_cases_from_grid
			l_test_case_class: CONF_CLASS
		do
			from
				l_grid_items := all_test_cases_from_grid
				l_grid_items.start
			until
				l_grid_items.after or Result /= Void
			loop
				check valid: l_grid_items.item.is_valid_for_running end
				l_test_case_class := l_grid_items.item.class_i.config_class

				if l_test_case_class /= Void and then l_test_case_class.is_equal (a_class) then
					Result := grid.row (l_grid_items.index)
				end

				l_grid_items.forth
			end
		end

	reset is
			-- Clear last test run data
		do
			failure_count := 0
			error_count := 0
			update_failure_and_error_label
		end

	unselect_all_rows is
			-- Unselect all rows in `grid'
		local
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			from
				l_rows := grid.selected_rows
				l_rows.start
			until
				l_rows.after
			loop
				l_rows.item.disable_select
				l_rows.forth
			end
		end

feature -- Query

	is_test_case_item (a_data: ANY): BOOLEAN is
			-- If `a_data' is test case item?
		do
			Result := {l_test: ES_EWEASEL_TEST_CASE_ITEM} a_data
		end

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

	selected_test_cases (a_failed_first: BOOLEAN): !ARRAYED_LIST [EVENT_LIST_TEST_CASE_ITEM] is
			-- Selected test cased in `grid'
			-- `a_failed_first' means failed test case put to the front of list
		local
			l_selected_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_not_failed_tests: !ARRAYED_LIST [EVENT_LIST_TEST_CASE_ITEM]
			l_failed_tests: !ARRAYED_LIST [EVENT_LIST_TEST_CASE_ITEM]
			l_result_type: ES_EWEASEL_RESULT_TYPE
		do
			from
				l_selected_rows := grid.selected_rows
				if l_selected_rows.count = 0 and grid.row_count > 0 then
					-- We select all rows if end users slected none.
					grid.select_all_rows
					l_selected_rows := grid.selected_rows
				end
				create l_not_failed_tests.make (l_selected_rows.count)
				create l_failed_tests.make (l_selected_rows.count)
				create l_result_type
				l_selected_rows.start
			until
				l_selected_rows.after
			loop
				if {l_test_case: EVENT_LIST_TEST_CASE_ITEM} l_selected_rows.item.data then
					if {l_test_case_item: ES_EWEASEL_TEST_CASE_ITEM} l_test_case.data then
						if a_failed_first and l_result_type.is_need_correct (l_test_case_item.last_run_result) then
							l_failed_tests.extend (l_test_case)
						else
							l_not_failed_tests.extend (l_test_case)
						end
					else
						check not_possilbe: False end
					end
				else
					check must_has_data: False end
				end

				l_selected_rows.forth
			end

			create Result.make (l_selected_rows.count)

			check nothing: not a_failed_first implies l_failed_tests.is_empty end
			Result.append (l_failed_tests)

			Result.append (l_not_failed_tests)
		end

	all_test_cases_from_grid: !ARRAYED_LIST [ES_EWEASEL_TEST_CASE_ITEM]
			-- Fectch all test case items information from `grid'
		local
			l_grid: like grid
			l_index, l_count: INTEGER
			l_row: EV_GRID_ROW
		do
			from
				l_grid := grid
				l_index := 1
				l_count := l_grid.row_count
				create Result.make (l_count)
			until
				l_index > l_count
			loop
				l_row := l_grid.row (l_index)
				if {lt_row: EV_GRID_ROW} l_row then
					if {l_test_case: ES_EWEASEL_TEST_CASE_ITEM} test_case_item_from (lt_row) then
						Result.extend (l_test_case)
					end
				end
				l_index := l_index + 1
			end
		end

	session_data: ES_EWEASEL_TEST_CASE_SESSION_DATA is
			-- Session data
			-- Result maybe void
		local
			l_shared: EB_SHARED_WINDOW_MANAGER
		do
			create l_shared
			if {l_dev_window: EB_DEVELOPMENT_WINDOW} l_shared.window_manager.last_focused_development_window then
				Result ?= l_dev_window.session_data.value (session_data_id)
			end
		end

	has_failed_test_case: BOOLEAN is
			-- Doese `grid' have any failed test case?
		local
			l_test_cases: like all_test_cases_from_grid
		do
			from
				l_test_cases := all_test_cases_from_grid
				l_test_cases.start
			until
				l_test_cases.after or Result
			loop
				if (create {ES_EWEASEL_RESULT_TYPE}).is_need_correct (l_test_cases.item.last_run_result) then
					Result := True
				end
				l_test_cases.forth
			end
		end

	failure_count: INTEGER
			-- How many {EWEASEL_TEST_RESULT_ITEM} result type is {EWEASEL_RESULT_TYPE}.failed

	error_count: INTEGER
			-- How many {EWEASEL_TEST_RESULT_ITEM} result type is {EWEASEL_RESULT_TYPE}.error

feature {NONE} -- Agents

	on_veto_drop (a_stone: CLASSC_STONE): BOOLEAN is
			-- Veto function of `on_drop'.
		require
			not_void: a_stone /= Void
		do
			if {l_class_i: CLASS_I} a_stone.class_i then
				Result := test_case_finder.is_test_case_class (l_class_i)

				if Result then
					Result := not has_test_case (l_class_i)
				end
			end
		end

	on_drop (a_stone: CLASSI_STONE) is
			-- Handle `grid' drop actions.
		require
			not_void: a_stone /= Void
			is_test_case: test_case_finder.is_test_case_class (a_stone.class_i)
		local
			l_consumer: SERVICE_CONSUMER [EVENT_LIST_S]
			l_event_item: EVENT_LIST_TEST_CASE_ITEM
			l_data_item: ES_EWEASEL_TEST_CASE_ITEM
		do
			if {l_class: CLASS_I} a_stone.class_i then
				if not has_test_case (l_class) then -- We don't allow duplicated test case
					create l_consumer
					if l_consumer.is_service_available then
						create l_data_item
						l_data_item.set_class_i (l_class)
						create l_event_item.make ({ENVIRONMENT_CATEGORIES}.testing, 0, l_data_item)
						l_consumer.service.put_event_item (context_uuid, l_event_item)
					end
				end
			end
		end

	on_key_press (a_key: EV_KEY) is
			-- Hanlde key press actions on `grid'
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.key_delete then
				remove_selected_rows
				update_buttons_sensitivity
			else

			end
		end

feature {NONE} -- Implementation queries

	grid: !ES_GRID
			-- Grid managed by Current.

	has_test_case (a_class_i: !CLASS_I): BOOLEAN is
			-- Does the grid already has row represent `a_class_i'
		local
			l_all_items: like all_test_cases_from_grid
		do
			from
				l_all_items := all_test_cases_from_grid
				l_all_items.start
			until
				l_all_items.after or Result
			loop
				Result := l_all_items.item.class_i.is_equal (a_class_i)

				l_all_items.forth
			end
		end

	test_case_finder: !ES_TEST_CASE_FINDER is
			-- Test case helper class
		once
			create Result
		end

	conf_class_of (a_class_name: !STRING): CONF_CLASS is
			-- Result void if not found
		local
			l_util: ES_TEST_CASE_FINDER
		do
			create l_util
			Result := l_util.conf_class_of (a_class_name)
		end

	test_case_item_from (a_row: !EV_GRID_ROW): ES_EWEASEL_TEST_CASE_ITEM is
			-- Result void if not found
		do
			if {l_event_data: EVENT_LIST_TEST_CASE_ITEM} a_row.data then
				if {l_test_case: ES_EWEASEL_TEST_CASE_ITEM} l_event_data.data then
					Result := l_test_case
				else
					check not_possible: False end
				end
			else
				check not_possible: False end
			end
		end

	manager: ES_EWEASEL_EXECUTION_MANAGER is
			-- Chief eWeasel execution manager
		local
			l_panel: ES_TESTING_TOOL_PANEL
		do
			l_panel := testing_tool_panel
			check not_void: l_panel /= Void end
			Result := l_panel.unit_test_manager
		ensure
			not_void: Result /= Void
		end

	testing_tool_panel: !ES_TESTING_TOOL_PANEL is
			-- Testing tool panel
		local
			l_shared: ES_EWEASEL_SINGLETON_FACTORY
		do
			create l_shared
			if {l_test: ES_TESTING_TOOL_PANEL} l_shared.manager.testing_tool then
				Result := l_test
			else
				check not_possible: False end
			end
		end

	session_data_id: STRING is "com.eiffel.testing.test_cases_id"
			-- Session data used for session service

	context_uuid: !UUID is
			-- Context uuid
		local
			l_enum: ES_TESTING_EVENT_LIST_CONTEXTS
		do
			create l_enum
			Result := l_enum.es_test_case_grid_manager
		end

feature {NONE} -- Implementation commands

	update_failure_and_error_label is
			-- Update {ES_TESTING_TOOL_PANEL}'s failure and error labels' texts
		do
			testing_tool_panel.set_failure_label_with (failure_count)
			testing_tool_panel.set_error_label_with (error_count)
		end

	update_row_forground_color_base_on_result (a_label_item: !EV_GRID_LABEL_ITEM; a_result: INTEGER) is
			-- Update `a_label_item''s row forground color base on `a_result'
		require
			valid: (create {ES_EWEASEL_RESULT_TYPE}).is_valid (a_result)
		local
			l_result_type: ES_EWEASEL_RESULT_TYPE
			l_shared: ES_SHARED_FONTS_AND_COLORS
		do
			create l_result_type
			a_label_item.set_text (l_result_type.result_to_string (a_result))

			if {lt_row: EV_GRID_ROW} a_label_item.row then
				create l_shared
				if a_result = {ES_EWEASEL_RESULT_TYPE}.failed then
					if {lt_color: EV_COLOR} l_shared.colors.high_priority_foreground_color then
						set_all_items_forground_color_to (lt_row, lt_color)
					end
				elseif a_result = {ES_EWEASEL_RESULT_TYPE}.passed or a_result = {ES_EWEASEL_RESULT_TYPE}.failed then
					if {lt_color_2: EV_COLOR} l_shared.colors.low_priority_foreground_color then
						set_all_items_forground_color_to (lt_row, lt_color_2)
					end
				elseif a_result = {ES_EWEASEL_RESULT_TYPE}.default_type then
					if {lt_color_3: EV_COLOR} l_shared.colors.normal_priority_foreground_color then
						set_all_items_forground_color_to (lt_row, lt_color_3)
					end
				end
			end
		end

	set_all_items_forground_color_to (a_row: !EV_GRID_ROW; a_color: !EV_COLOR) is
			-- Set all items in `a_row''s colors to `a_color'
		local
			l_item: EV_GRID_ITEM
			l_max, l_index: INTEGER
		do
			from
				l_max := a_row.count
				l_index := 1
			until
				l_index > l_max
			loop
				l_item := a_row.item (l_index)
				if l_item /= Void then
					l_item.set_foreground_color (a_color)
				end

				l_index := l_index + 1
			end
		end

	update_grid_column_time is
			-- Update column `Changed_time'
		local
			l_test_cases: like all_test_cases_from_grid
			l_item: ES_EWEASEL_TEST_CASE_ITEM
			l_grid: like grid
			l_date_time: DT_DATE_TIME
			l_date_time_ise, l_date_time_ise_utc: DATE_TIME
			l_date_time_duration: DATE_TIME_DURATION
		do
			-- We have to convert file time from utc to local ourselves since it only provide utc time
			create l_date_time_ise.make_now
			create l_date_time_ise_utc.make_now_utc
			l_date_time_duration := l_date_time_ise.relative_duration (l_date_time_ise_utc)

			from
				l_grid := grid
				l_test_cases := all_test_cases_from_grid
				l_test_cases.start
			until
				l_test_cases.after
			loop
				l_item := l_test_cases.item

					create l_date_time.make_from_epoch (l_item.class_i.file_date)
					l_date_time.add_hours (l_date_time_duration.hour)
					if {l_label_item: EV_GRID_LABEL_ITEM} l_grid.item (4, l_test_cases.index) then
						l_label_item.set_text (l_date_time.out)
					end

					l_item.set_changed_time (l_date_time)

				l_test_cases.forth
			end
		end

	update_grid_column_changed_after_last_run is
			-- Update column `Changed after last test run'
		local
			l_test_cases: like all_test_cases_from_grid
			l_item: ES_EWEASEL_TEST_CASE_ITEM
			l_grid: like grid
		do
			from
				l_grid := grid
				l_test_cases := all_test_cases_from_grid
				l_test_cases.start
			until
				l_test_cases.after
			loop
				l_item := l_test_cases.item

				if {l_label_item: EV_GRID_LABEL_ITEM} l_grid.item (7, l_test_cases.index) then

					if {l_last_run_time: DT_DATE_TIME} l_item.last_run_time and {l_changed_time: DT_DATE_TIME} l_item.changed_time then
						if l_last_run_time < l_changed_time then
							-- Changed
							l_label_item.set_text (interface_names.l_true)

						else
							-- Not changed
							l_label_item.set_text (interface_names.l_false)
						end
					end
				end

				l_test_cases.forth
			end
		end

	insert_one_row_items (a_row: EV_GRID_ROW; a_test_case: !ES_EWEASEL_TEST_CASE_ITEM) is
			-- Insert items to `a_row', items information query from `a_test_case'
		require
			not_void: a_row /= Void
			valid: test_case_finder.is_test_case_class (a_test_case.class_i)
		local
			l_all_columns: like all_columns_titles
			l_grid_item: EV_GRID_ITEM
			l_tag_string: STRING_GENERAL
			l_edit_item: EV_GRID_EDITABLE_ITEM
			l_grid_helper: ES_TEST_GRID_HELPER
			l_changed_time: STRING_GENERAL
			l_last_result_label_item: !EV_GRID_LABEL_ITEM
			l_changed_date_time, l_last_run_date_time: DT_DATE_TIME
			l_changed_string: STRING_GENERAL
		do
			from
				l_all_columns := all_columns_titles
				l_all_columns.start
			until
				l_all_columns.after
			loop
				inspect
					l_all_columns.index
				when 1 then
					create l_grid_helper.make (grid)
					l_grid_item := l_grid_helper.new_editor_token_item (create {STRING}.make_from_string (a_test_case.class_i.name.as_upper))
				when 2 then
					create {EV_GRID_LABEL_ITEM} l_grid_item.make_with_text ("eWeasel") -- Hidden column
				when 3 then
					create {EV_GRID_LABEL_ITEM} l_grid_item.make_with_text ("false") -- Hidden column
				when 4 then
					if {l_data_2: ES_EWEASEL_TEST_CASE_ITEM} test_case_item_from (a_row) then
						if l_data_2.changed_time /= Void then
							l_changed_time := l_data_2.changed_time.out
						end
					end

					if l_changed_time = Void then
						l_changed_time := interface_names.t_not_updated
					end
					create {EV_GRID_LABEL_ITEM} l_grid_item.make_with_text (l_changed_time)
				when 5 then
					create l_last_result_label_item
					-- We handle this item later in this feature
					l_grid_item := l_last_result_label_item
				when 6 then
					if {l_data: ES_EWEASEL_TEST_CASE_ITEM} test_case_item_from (a_row) then
						l_tag_string := l_data.tag
					end

					if l_tag_string = Void then
						l_tag_string := ""
					end

					create l_edit_item.make_with_text (l_tag_string)
					l_edit_item.deactivate_actions.extend (agent on_tag_item_deactive)

					l_grid_item := l_edit_item
				when 7 then
					if {l_data_3: ES_EWEASEL_TEST_CASE_ITEM} test_case_item_from (a_row) then
						l_changed_date_time := l_data_3.changed_time
						l_last_run_date_time := l_data_3.last_run_time
						if l_changed_date_time /= Void and l_last_run_date_time /= Void then
							l_changed_string := (l_changed_date_time > l_last_run_date_time).out
						else
							l_changed_string := interface_names.t_not_updated
						end
					end

					create {EV_GRID_LABEL_ITEM} l_grid_item.make_with_text (l_changed_string)
				else
					check not_possible: False end
				end

				a_row.set_item (l_all_columns.index, l_grid_item)
				if {lt_item: EV_GRID_LABEL_ITEM} l_last_result_label_item then
					update_row_forground_color_base_on_result (lt_item, a_test_case.last_run_result)
				end
				l_all_columns.forth
			end
		end

	all_columns_titles: ARRAYED_LIST [STRING_GENERAL] is
			-- All columns titles in `grid'
		once
			create Result.make (7)
			Result.extend (interface_names.l_name)
			Result.extend ("Runner") -- Hidden for the moment
			Result.extend ("Auto generated") -- Hiddent for the moment
			Result.extend (interface_names.t_changed_time)
			Result.extend (interface_names.t_result)
			Result.extend (interface_names.l_tags)
			Result.extend (interface_names.t_changed_after_last_run) --  Changed after last test run?
		ensure
			not_void: Result /= Void
			column_count_right: Result.count = 7
		end

	select_next_or_previous_failed_row (a_select_next: BOOLEAN) is
			-- Select next/previous failed row in `grid'
		local
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_selected_row: EV_GRID_ROW
			l_index_of_selected: INTEGER
		do
			l_rows := all_failed_rows
			if not l_rows.is_empty then
				-- First we find which row is slected
				from
					l_rows.start
				until
					l_rows.after or l_selected_row /= Void
				loop
					if l_rows.item.is_selected then
						l_selected_row := l_rows.item
					end
					l_rows.forth
				end

				if l_selected_row = Void then
					l_rows.first.enable_select
				else
					l_index_of_selected := l_rows.index_of (l_selected_row, 1)
					unselect_all_rows
					if a_select_next then
						if l_index_of_selected < l_rows.count then
							l_rows.i_th (l_index_of_selected + 1).enable_select
						else
							l_rows.first.enable_select
						end
					else
						if l_index_of_selected > 1 then
							l_rows.i_th (l_index_of_selected - 1).enable_select
						else
							l_rows.last.enable_select
						end
					end
				end
			end
		end

	all_failed_rows: !ARRAYED_LIST [EV_GRID_ROW] is
			-- All rows which last test run failed
		local
			l_grid: like grid
			l_index, l_max: INTEGER
			l_result_type: ES_EWEASEL_RESULT_TYPE
		do
			from
				l_grid := grid
				create Result.make (l_grid.row_count)
				create l_result_type
				l_max := l_grid.row_count
				l_index := 1
			until
				l_index > l_max
			loop
				if {lt_data: EVENT_LIST_ITEM} l_grid.row (l_index).data then
					if {lt_test_case: ES_EWEASEL_TEST_CASE_ITEM} lt_data.data then
						if l_result_type.is_need_correct (lt_test_case.last_run_result) then
							Result.extend (l_grid.row (l_index))
						end
					end
				else
					check not_possible: False end
				end

				l_index := l_index + 1
			end
		end

	on_tag_item_deactive is
			-- Handle a editable item deactive action	
		do
			if {l_item: EV_GRID_EDITABLE_ITEM} grid.activated_item then
				if {l_row: EV_GRID_ROW} l_item.row then
					if {l_data: ES_EWEASEL_TEST_CASE_ITEM} test_case_item_from (l_row) then
						if {l_grid_item: EV_GRID_EDITABLE_ITEM} grid.activated_item then
							l_data.set_tag (l_grid_item.text)
							update_current_session_data
						else
							check not_possible: False end
						end
					end
				end
			end
		end

	update_current_session_data is
			-- Update Current session data with current data in the grid
		do
			-- Different from {ES_TEST_RUN_RESULT_GRID_MANAGER}.update_current_session_data
			-- Test case only save ONE list of test case (instead of saving ALL test run data in ES_TEST_RUN_RESULT_GRID_MANAGER)
			-- So we only need overwrite here
			save_test_case_to_session
		end
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
