indexing
	description: "[
					Dialog which show/manage all recorded hisotry test run data.
																					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ALL_TEST_RUN_RESULTS_DIALOG

inherit
	ES_DIALOG
		redefine
			on_before_show
		end

create
	make

feature {NONE} -- Implementation refedines

	default_confirm_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.ok_button
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := Interface_names.t_test_runs_history
		end

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		local
			l_pixmaps: EB_SHARED_PIXMAPS
		do
			create l_pixmaps
			Result := l_pixmaps.icon_pixmaps.testing_all_test_runs_icon_buffer
		end

	default_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.ok_button
		end

	build_dialog_interface (a_container: EV_VERTICAL_BOX) is
			-- <Precursor>
		local
			l_box, l_box_2, l_box_3: EV_BOX
			l_label: EV_LABEL
			l_grid: like grid
			l_border: ES_BORDERED_WIDGET [ES_GRID]
		do
			a_container.set_padding ({ES_UI_CONSTANTS}.dialog_button_vertical_padding)
			a_container.set_border_width ({ES_UI_CONSTANTS}.frame_border)

			create {EV_HORIZONTAL_BOX} l_box
			create l_label
			l_label.set_text (interface_names.l_select_a_test_run)
			l_box.extend (l_label)
			l_box.disable_item_expand (l_label)
			a_container.extend (l_box)
			a_container.disable_item_expand (l_box)

			create {EV_HORIZONTAL_BOX} l_box
			l_box.set_padding ({ES_UI_CONSTANTS}.dialog_button_horizontal_padding)

			create {EV_VERTICAL_BOX} l_box_2
			l_box_2.set_padding ({ES_UI_CONSTANTS}.dialog_button_vertical_padding)

			create l_grid
			grid := l_grid
			l_grid.enable_single_row_selection
			l_grid.pointer_double_press_item_actions.extend (agent on_grid_pointer_double_press)
			create l_border.make (l_grid)
			l_box_2.extend (l_border)
			create {EV_HORIZONTAL_BOX} l_box_3
			l_box_3.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			create l_label
			l_label.set_text (interface_names.l_Maximun_count_of_remembered_test_runs)
			l_box_3.extend (l_label)
			l_box_3.disable_item_expand (l_label)

			create maximum_test_run_count
			fill_maximum_test_run_count_with_session_data
			maximum_test_run_count.focus_out_actions.extend (agent on_maximum_test_run_data_count_focus_out)
			l_box_3.extend (maximum_test_run_count)
			l_box_2.extend (l_box_3)
			l_box_2.disable_item_expand (l_box_3)

			l_box.extend (l_box_2)

			create {EV_VERTICAL_BOX} l_box_2
			l_box_2.set_padding ({ES_UI_CONSTANTS}.dialog_button_vertical_padding)
			create show_test_run_cases
			show_test_run_cases.set_text (interface_names.b_Show_test_run_cases)
			show_test_run_cases.select_actions.extend (agent on_show_test_run_cases)
			l_box_2.extend (show_test_run_cases)
			l_box_2.disable_item_expand (show_test_run_cases)

			create remove
			remove.set_text (interface_names.b_remove)
			remove.select_actions.extend (agent on_remove)
			l_box_2.extend (remove)
			l_box_2.disable_item_expand (remove)

			create remove_all
			remove_all.set_text (interface_names.b_remove_all)
			remove_all.select_actions.extend (agent on_remove_all)
			l_box_2.extend (remove_all)
			l_box_2.disable_item_expand (remove_all)

			l_box.extend (l_box_2)
			l_box.disable_item_expand (l_box_2)

			a_container.extend (l_box)

			init_service

			set_button_action (default_button, agent on_default_ok_button)
		end

	buttons: DS_SET [INTEGER]
			-- <Precursor>
		do
			Result := dialog_buttons.ok_cancel_buttons
		end

	default_cancel_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.cancel_button
		end

feature {NONE} -- Initialization

	init_grid is
			-- Initialize `grid'
		do
			build_columns
			init_grid_row
			enable_sorting_on_columns (all_columns)
		end

	init_service is
			-- Initialize event list service
		local
			l_consumer: SERVICE_CONSUMER [EVENT_LIST_S]
		do
			create l_consumer
			if l_consumer.is_service_available then
				l_consumer.service.item_added_event.subscribe (agent on_event_added)
			end
		end

	build_columns is
			-- Init columns of `grid'.
		local
			l_grid: like grid
			l_all_columns: like all_columns_titles
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
		end

	fill_maximum_test_run_count_with_session_data is
			-- Fill `maximum_test_run_count''s text with data from session data
		local
			l_count: NATURAL
		do
			l_count := testing_result_panel.test_run_result_grid_manager.session_data.maximum_remembered_data_count
			maximum_test_run_count.set_text (l_count.out)
		end

	init_grid_row is
			-- Initialize `grid'.
		local
			l_shared: ES_EWEASEL_SINGLETON_FACTORY
			l_data: !ES_EWEASEL_TEST_RUN_SESSION_DATA
			l_result_tool: ES_TESTING_RESULT_TOOL_PANEL
			l_consumer: SERVICE_CONSUMER [EVENT_LIST_S]
			l_event_item: EVENT_LIST_TEST_RUN_ITEM
			l_all_runs: !ARRAYED_LIST [ES_EWEASEL_TEST_RUN_DATA_ITEM]
			l_context_uuid: ES_TESTING_EVENT_LIST_CONTEXTS
		do
			create l_shared
			l_result_tool := l_shared.manager.testing_result_tool
			if l_result_tool /= Void then
				l_data := l_result_tool.test_run_result_grid_manager.session_data
				create l_consumer
				create l_context_uuid
				if l_consumer.is_service_available then
					from
						l_all_runs := l_data.all_test_runs
						l_all_runs.start
					until
						l_all_runs.after
					loop
						create l_event_item.make ({ENVIRONMENT_CATEGORIES}.testing, 0, l_all_runs.item)
						l_consumer.service.put_event_item (l_context_uuid.all_test_runs_dialog, l_event_item)

						l_all_runs.forth
					end
				end

			end
		end

feature {NONE} -- Agents

	on_before_show is
			-- <Precursor>
		do
			Precursor {ES_DIALOG}
			init_grid
		end

	on_grid_pointer_double_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_item: EV_GRID_ITEM) is
			-- Handle grid pointer double press actions
		do
			on_show_test_run_cases
		end

	on_show_test_run_cases is
			-- Handle show test run cases
		local
			l_all_test_cases: !ARRAYED_LIST [ES_EWEASEL_TEST_CASE_ITEM]
			l_all_test_results: !ARRAYED_LIST [ES_EWEASEL_TEST_RESULT_ITEM]
			l_selected_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_current_row: EV_GRID_ROW
			l_factory: ES_EWEASEL_SINGLETON_FACTORY
		do
			l_selected_rows := grid.selected_rows
			if l_selected_rows.count > 0 then
				check l_selected_rows.count < 2 end

				create l_factory
				if l_factory.manager.testing_tool /= Void then
					l_factory.manager.testing_tool.reset
				end

				l_current_row := l_selected_rows.first
				if {l_test_result_item: EVENT_LIST_TEST_RUN_ITEM} l_current_row.data  then
					if {l_current_data: ES_EWEASEL_TEST_RUN_DATA_ITEM} l_test_result_item.data then
						l_all_test_results := l_current_data.test_run_data
						l_all_test_cases := l_current_data.related_test_cases
						put_all_test_results_to_event_list (l_all_test_results)
						put_all_test_cases_to_event_list (l_all_test_cases)

						testing_result_panel.test_run_result_grid_manager.session_data.set_current_session_data_index (l_current_row.index)

						on_dialog_button_pressed (default_button)
					else
						check not_possible: False end
					end
				else
					check not_possible: False end
				end
			end
		end

	on_remove is
			-- Handle the action that remove current selected row
		local
			l_row: ARRAYED_LIST [EV_GRID_ROW]
		do
			from
				l_row := grid.selected_rows
				l_row.start
			until
				l_row.after
			loop
				if {lt_row: EV_GRID_ROW} l_row.item then
					lt_row.hide
				end

				l_row.forth
			end
		end

	on_default_ok_button is
			-- Handle default button action
		local
			l_index, l_count: INTEGER
			l_grid: like grid
			l_rows: ARRAYED_LIST [!EV_GRID_ROW]
			l_string: STRING_32
		do
			from
				l_grid := grid
				l_count := l_grid.row_count
				create l_rows.make (l_count)
				l_index := 1
			until
				l_index > l_count
			loop
				if {lt_row: EV_GRID_ROW} l_grid.row (l_index) then
					-- We should first collect a list of rows, then remove the rows in another loop
					-- since row index will be changed in `remove_data'

					if not lt_row.is_show_requested then
						l_rows.extend (lt_row)
					end
				end

				l_index := l_index + 1
			end

			from
				l_rows.start
			until
				l_rows.after
			loop
				remove_data (l_rows.item)

				l_rows.forth
			end

			-- Save maximum saved test run data count session data
			l_string := maximum_test_run_count.text
			check l_string.is_natural_32 end
			testing_result_panel.test_run_result_grid_manager.session_data.set_maximum_remembered_data_count (l_string.to_natural_32)
		end

	on_remove_all is
			-- Handle the action that remove all data
		local
			l_index, l_count: INTEGER
			l_grid: like grid
		do
			from
				l_grid := grid
				l_count := l_grid.row_count
				l_index := 1
			until
				l_index > l_count
			loop
				if {lt_row: EV_GRID_ROW} l_grid.row (l_index) then
					lt_row.hide
				end

				l_index := l_index + 1
			end

		end

	on_event_added (a_service: EVENT_LIST_S; a_item: EVENT_LIST_ITEM_I) is
			-- Event list service hook
		local
			l_index: INTEGER
			l_grid: like grid
		do
			if {l_item: EVENT_LIST_TEST_RUN_ITEM} a_item then
				l_grid := grid
				l_index := l_grid.row_count
				l_index := l_index + 1
				l_grid.set_row_count_to (l_index)
				populate_event_grid_row_items (l_item, l_grid.row (l_index))
			end
		end

	on_maximum_test_run_data_count_focus_out is
			-- Handle `maximum_test_run_count' focus out actions
			-- We reset the value if end user provided invalid value
		local
			l_string: STRING_32
		do
			l_string := maximum_test_run_count.text
			if not l_string.is_natural_32 then
				fill_maximum_test_run_count_with_session_data
			end
		end

feature {NONE} -- UI implementation

	all_columns: !ARRAYED_LIST [EV_GRID_COLUMN] is
			-- All columns in `grid'
		local
			l_grid: ES_GRID
			l_index, l_count: INTEGER
		do
			l_grid := grid
			from
				create Result.make (l_grid.column_count)
				l_index := 1
				l_count := l_grid.column_count
			until
				l_index > l_count
			loop
				Result.extend (l_grid.column (l_index))

				l_index := l_index + 1
			end
		end

	all_columns_titles: !ARRAYED_LIST [STRING_GENERAL] is
			-- All columns' titles
		do
			create Result.make (3)
			Result.extend (interface_names.t_test_count) -- "Test Count"
			Result.extend (interface_names.t_Date) -- "Date"
			Result.extend (interface_names.t_time) -- "Time"
		end

	maximum_test_run_count: EV_TEXT_FIELD
			-- Text field for maximum recorded test runs

	show_test_run_cases: EV_BUTTON
			-- Show test run cases button

	remove: EV_BUTTON
			-- Remove selected test case button

	remove_all: EV_BUTTON
			-- Remove all test cases button

	grid: ES_GRID
			-- Grid where show test runs history

	populate_event_grid_row_items (a_event_item: EVENT_LIST_ITEM_I; a_row: EV_GRID_ROW) is
			-- Populate a event item, fill `a_row' with grid items
		require
			not_void: a_row /= Void
			not_void: a_event_item /= Void
		local
			l_item: EV_GRID_ITEM
			l_columns: like all_columns_titles
		do
			if {l_data: ES_EWEASEL_TEST_RUN_DATA_ITEM} a_event_item.data then
				from
					l_columns := all_columns_titles
					l_columns.start
				until
					l_columns.after
				loop
					inspect
						l_columns.index
					when 1 then
						create {EV_GRID_LABEL_ITEM} l_item.make_with_text (l_data.test_run_data.count.out)
					when 2 then
						create {EV_GRID_LABEL_ITEM} l_item.make_with_text (l_data.date_time.date.out)
					when 3 then
						create {EV_GRID_LABEL_ITEM} l_item.make_with_text (l_data.date_time.time.out)
					else
						check not_possible: False end
					end
					a_row.set_item (l_columns.index, l_item)

					l_columns.forth
				end
				a_row.set_data (a_event_item)
			else
				check not_possible: False end
			end
		end

	put_all_test_cases_to_event_list (a_list: !ARRAYED_LIST [ES_EWEASEL_TEST_CASE_ITEM]) is
			-- Put `a_list''s items to event list service
		local
			l_shared: ES_EWEASEL_SINGLETON_FACTORY
			l_consumer: SERVICE_CONSUMER [EVENT_LIST_S]
			l_event_item: EVENT_LIST_TEST_CASE_ITEM
			l_tool: ES_TESTING_TOOL_PANEL
			l_context_uuid: ES_TESTING_EVENT_LIST_CONTEXTS
		do
			create l_shared
			l_tool := l_shared.manager.testing_tool
			if l_tool /= Void then
				l_tool.test_case_grid_manager.remove_all_rows

				create l_consumer
				create l_context_uuid
				if l_consumer.is_service_available then

					from
						a_list.start
					until
						a_list.after
					loop
						create l_event_item.make ({ENVIRONMENT_CATEGORIES}.testing, 0, a_list.item)
						l_consumer.service.put_event_item (l_context_uuid.all_test_runs_dialog, l_event_item)
						a_list.forth
					end
				end
			end
		end

	put_all_test_results_to_event_list (a_list: !ARRAYED_LIST [ES_EWEASEL_TEST_RESULT_ITEM]) is
			-- Pu `a_list''s items to event list service
		local
			l_shared: ES_EWEASEL_SINGLETON_FACTORY
			l_consumer: SERVICE_CONSUMER [EVENT_LIST_S]
			l_event_item: EVENT_LIST_TESTING_RESULT_ITEM
			l_context_uuid: ES_TESTING_EVENT_LIST_CONTEXTS
		do
			create l_shared
			l_shared.manager.testing_result_tool.test_run_result_grid_manager.reset

			create l_consumer
			create l_context_uuid
			if l_consumer.is_service_available then

				from
					a_list.start
				until
					a_list.after
				loop
					create l_event_item.make ({ENVIRONMENT_CATEGORIES}.testing, 0, a_list.item)
					l_consumer.service.put_event_item (l_context_uuid.all_test_runs_dialog, l_event_item)
					a_list.forth
				end
			end
		end

	remove_data (a_row: !EV_GRID_ROW) is
			-- Remove test result data related with `a_row'
		local
			l_shared: ES_EWEASEL_SINGLETON_FACTORY
			l_session_data: !ES_EWEASEL_TEST_RUN_SESSION_DATA
		do
			if {l_data: EVENT_LIST_TEST_RUN_ITEM} a_row.data then
				if {l_inner_data: ES_EWEASEL_TEST_RUN_DATA_ITEM} l_data.data then
					create l_shared
					grid.remove_row (a_row.index)
					l_session_data := l_shared.manager.testing_result_tool.test_run_result_grid_manager.session_data
					check l_session_data.has_test_data (l_inner_data) end
					l_session_data.remove_test_run_data (l_inner_data)
				end
			end
		end

	testing_result_panel: ES_TESTING_RESULT_TOOL_PANEL is
			-- Testing result tool panel
		local
			l_shared: ES_EWEASEL_SINGLETON_FACTORY
		do
			create l_shared
			Result := l_shared.manager.testing_result_tool
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Copy from {ES_EVENT_LIST_TOOL_PANEL_BASE} FIXIT: merge?

	frozen sorting_row_comparer (a_row, a_other_row: EV_GRID_ROW; a_order: INTEGER_32; a_column: INTEGER): BOOLEAN is
			-- Agent function used to determine row order.
			--
			-- `a_row': The primary row to check.
			-- `a_row': The secondary row to check.
			-- `a_order': An order determined by order constants from {EVS_GRID_TWO_WAY_SORTING_ORDER}.
			-- `a_column': The column index requested to be sorted.
			-- `Result': True to indicate `a_row' is less than `a_other_row', False otherwise.
		require
			row_a_valid: a_row /= Void
			row_b_valid: a_other_row /= Void
			a_order_is_valid: a_order = {EVS_GRID_TWO_WAY_SORTING_ORDER}.ascending_order or a_order = {EVS_GRID_TWO_WAY_SORTING_ORDER}.descending_order
			a_column_is_valid_index: a_column > 0 and a_column <= grid.column_count
		local
			l_res: like compare_rows
		do
			l_res := compare_rows (a_row, a_other_row, a_column)
			if a_order = {EVS_GRID_TWO_WAY_SORTING_ORDER}.ascending_order then
				Result := not l_res
			else
				Result := l_res
			end
		end

	frozen enable_sorting_on_columns (a_columns: ARRAY [EV_GRID_COLUMN])
			-- Enables sorting on a selected set of columns
			--
			-- `a_columns': The columns to enable sorting on.
		require
			a_columns_attached: a_columns /= Void
		local
			l_wrapper: like grid_wrapper
			l_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [EV_GRID_ROW]
			l_column: EV_GRID_COLUMN
			l_upper, i: INTEGER
		do
			l_wrapper := grid_wrapper
			l_wrapper.enable_auto_sort_order_change
			if l_wrapper.sort_action = Void then
				l_wrapper.set_sort_action (agent sort_handler)
			end

			from
				i := a_columns.lower
				l_upper := a_columns.upper
			until i > l_upper loop
				l_column := a_columns [i]
				check l_column_attached: l_column /= Void end
				if l_column /= Void then
					create l_sort_info.make (agent sorting_row_comparer (?, ?, ?, l_column.index), {EVS_GRID_TWO_WAY_SORTING_ORDER}.ascending_order)
					l_sort_info.enable_auto_indicator
					l_wrapper.set_sort_info (l_column.index, l_sort_info)
				end
				i := i + 1
			end
		end

	compare_rows (a_row, a_other_row: EV_GRID_ROW; a_column: INTEGER): BOOLEAN is
			-- Compares two rows from the local grid and returns an index based on their comparative result.
			--
			-- Note: Basic implementation handles both string and integer string checking. Items with special
			--       rendering should have redefined implementation in `row_item_text' to retrieve a sortable
			--       text string.
			--
			-- `a_row': The primary row to check.
			-- `a_other_row': The secondary row to check.
			-- `a_column': The column index requested to be sorted.
			-- `Result': True to indicate `a_row' is less than `a_other_row', False otherwise.
		require
			row_a_valid: a_row /= Void
			row_b_valid: a_other_row /= Void
			a_column_is_valid_index: a_column > 0 and a_column <= grid.column_count
		local
			l_item: EV_GRID_ITEM
				-- Should to STRING_GENERAL, but it requires a change in elks
			l_text: STRING_32
			l_other_text: STRING_32
		do
			l_item := a_row.item (a_column)
			if l_item /= Void then
				l_text := row_item_text (l_item)
			end
			l_item := a_other_row.item (a_column)
			if l_item /= Void then
				l_other_text := row_item_text (l_item)
			end
			if l_text /= Void and l_other_text /= Void then
				if l_text.is_integer_64 and l_other_text.is_integer_64 then
					Result := l_text.to_integer_64 < l_other_text.to_integer_64
				else
					Result := l_text < l_other_text
				end
			elseif l_text = Void then
				Result := True
			end
		ensure
			asymmetric: Result implies not compare_rows (a_other_row, a_row, a_column)
		end

	frozen grid_wrapper: EVS_GRID_WRAPPER [EV_GRID_ROW]
			-- A grid helper class
		do
			Result := internal_grid_wrapper
			if Result = Void then
				create Result.make (grid)
				internal_grid_wrapper := Result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = Result
		end

	internal_grid_wrapper: like grid_wrapper
			-- Cached version of `grid_wrapper'
			-- Note: Do not use directly!

	frozen sort_handler (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [EV_GRID_ROW]) is
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty: not a_column_list.is_empty
			a_comparator_attached: a_comparator /= Void
		local
			l_grid: like grid
			l_sorter: DS_QUICK_SORTER [EV_GRID_ROW]
			l_rows: DS_ARRAYED_LIST [EV_GRID_ROW]
			l_row: EV_GRID_ROW
			l_count, i: INTEGER
			l_event_items: DS_ARRAYED_LIST [TUPLE [event_item: EVENT_LIST_ITEM_I; expand: BOOLEAN]]
			l_event_item: EVENT_LIST_ITEM_I
			l_sub_row_count: INTEGER
		do
			create l_sorter.make (a_comparator)

			l_grid := grid
			l_count := l_grid.row_count

				-- Retrieve top level grid items
			create l_rows.make ((l_count / 2).truncated_to_integer)

			from i := 1 until i > l_count loop
				l_row := l_grid.row (i)
				l_rows.force_last (l_row)
				i := i + l_row.subrow_count_recursive + 1
			end

				-- Perform sort
			l_sorter.sort (l_rows)

				-- Extract all event item data for repopulation
			create l_event_items.make (l_rows.count)
			from l_rows.start until l_rows.after loop
				l_row := l_rows.item_for_iteration
				l_event_item ?= l_row.data
				check l_event_item_attached: l_event_item /= Void end
				l_event_items.force_last ([l_event_item, l_row.is_expanded])
				l_rows.forth
			end

				-- Repopulate grid
			l_grid.lock_update
			l_grid.remove_and_clear_all_rows

			from i := 1; l_event_items.start until l_event_items.after loop
				l_grid.set_row_count_to (i)
				l_row := l_grid.row (i)
				l_event_item := l_event_items.item_for_iteration.event_item

				l_row.set_data (l_event_item)
				populate_event_grid_row_items (l_event_item, l_row)
				l_grid.grid_row_fill_empty_cells (l_row)
				if l_event_items.item_for_iteration.expand then
					l_row.expand
				end

				if l_row.parent /= Void then
					l_sub_row_count := l_row.subrow_count_recursive
				end

				i := i + 1 + l_sub_row_count
				l_event_items.forth
			end

			l_grid.unlock_update
		end

	row_item_text (a_item: EV_GRID_ITEM): STRING_32
			-- Extracts a string representation of a grid row's cell item.
			--
			-- `a_item': Grid item to retrieve string representation for.
			-- `Result': A string representation of the item or Void if not string representation could be created.
		require
			a_item_attached: a_item /= Void
			not_a_item_is_destroyed: not a_item.is_destroyed
			a_item_is_parented: a_item.is_parented
		local
			l_label_item: EV_GRID_LABEL_ITEM
			l_string: STRING_GENERAL
		do
			l_label_item ?= a_item
			if l_label_item /= Void then
				Result := l_label_item.text
			end
			if Result = Void or else Result.is_empty then
					-- There might be string information in the item data, use that.
				l_string ?= a_item.data
				if l_string /= Void then
					Result := l_string.to_string_32
				end
			end
			if Result = Void then
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
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
