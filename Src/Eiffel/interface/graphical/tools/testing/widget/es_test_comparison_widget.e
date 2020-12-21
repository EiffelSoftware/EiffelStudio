note
	description: "[
		Widget used to compare different test results.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_COMPARISON_WIDGET

inherit
	ES_WINDOW_WIDGET [EV_HORIZONTAL_BOX]
		redefine
			on_before_initialize,
			on_after_initialized
		end

	ES_SHARED_TEST_GRID_UTILITIES

	ES_SHARED_TEST_SERVICE

create
	make

feature {NONE} -- Initialization

	on_before_initialize
			-- <Precursor>
		do
			Precursor
			create rows.make_filled (Void, 1, category_count)
			create category_statistics.make_filled (create_statistics, 1, category_count)
		end

	build_widget_interface (a_widget: like create_widget)
			-- <Precursor>
		local
			l_split: EV_HORIZONTAL_SPLIT_AREA
		do
			create l_split
			build_left (l_split)
			build_grid (l_split)

			a_widget.extend (l_split)
		end

	build_left (a_split: EV_HORIZONTAL_SPLIT_AREA)
			-- Build left part of split area (toolbar and statistics).
		require
			a_split_attached: a_split /= Void
		local
			l_box: EV_VERTICAL_BOX
		do
			create l_box
			l_box.set_border_width (2)
			l_box.set_padding (2)
			build_file_widget (l_box)
			build_statistics (l_box)
			a_split.set_first (l_box)
		end

	build_file_widget (a_widget: EV_BOX)
			-- Initialize file text field
		require
			a_widget_attached: a_widget /= Void
		local
			l_frame: EV_FRAME
			l_toolbar: SD_TOOL_BAR
			l_button: SD_TOOL_BAR_BUTTON
			l_hbox: EV_HORIZONTAL_BOX
		do
			create l_hbox
			l_hbox.set_border_width (4)

			create file_text
			file_text.disable_edit
			l_hbox.extend (file_text)

			create l_toolbar.make
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_open_icon_buffer)
			l_button.set_tooltip (locale.translation ({ES_TESTING_RESULTS_TOOL}.l_compare_states))
			register_action (l_button.select_actions, agent on_compare_button_select)
			l_toolbar.extend (l_button)
			l_toolbar.compute_minimum_size
			l_hbox.extend (l_toolbar)
			l_hbox.disable_item_expand (l_toolbar)

			create l_frame.make_with_text (locale.translation (f_result_file))
			l_frame.extend (l_hbox)
			a_widget.extend (l_frame)
			a_widget.disable_item_expand (l_frame)
		end

	build_statistics (a_widget: EV_BOX)
			-- Initialize statistics widget.
		require
			a_widget_attached: a_widget /= Void
		local
			l_cbox: EV_VERTICAL_BOX
			l_rbox, l_bbox, l_pbox: EV_HORIZONTAL_BOX
			l_frame: EV_FRAME
			l_label: EV_LABEL
			l_cell: EV_CELL
			i, j: INTEGER
			l_bars: like create_bars
		do
			create l_pbox
			l_pbox.set_border_width (4)

			create l_rbox
			l_rbox.set_border_width (1)
			l_rbox.set_background_color (colors.stock_colors.grey)

			create statistic_labels.make_filled ([create {EV_LABEL}, create {EV_LABEL}], 1, statistic_count)
			from
				i := 2
			until
				i > statistic_count
			loop
				statistic_labels.put ([create {EV_LABEL}, create {EV_LABEL}], i)
				i := i + 1
			end

				-- Labels
			create l_cbox
			l_cbox.set_border_width (2)
			l_cbox.set_background_color (colors.stock_colors.white)
			create l_label
			l_label.set_background_color (colors.stock_colors.white)
			l_cbox.extend (l_label)
			l_cbox.disable_item_expand (l_label)
			create l_cell
			l_cell.set_background_color (colors.stock_colors.white)
			l_cbox.extend (l_cell)
			from
				i := 1
			until
				i > statistic_count
			loop
				create l_label.make_with_text (locale.translation (category_labels[i]))
				l_label.set_background_color (colors.stock_colors.white)
				l_label.align_text_left
				l_cbox.extend (l_label)
				l_cbox.disable_item_expand (l_label)
				i := i + 1
			end
			l_cbox.set_minimum_width (90)
			l_rbox.extend (l_cbox)
			l_rbox.disable_item_expand (l_cbox)

			from
				i := 1
			until
				i > 2
			loop
				create l_cbox
				l_cbox.set_border_width (2)
				l_cbox.set_padding_width (2)
				l_cbox.set_background_color (colors.stock_colors.white)
				inspect
					i
				when 1 then
					create l_label.make_with_text (locale.translation (t_previous))
				when 2 then
					create l_label.make_with_text (locale.translation (t_current))
				end
				l_label.set_background_color (colors.stock_colors.white)
				l_label.align_text_right
				l_cbox.extend (l_label)
				l_cbox.disable_item_expand (l_label)

				l_bars := create_bars
				if i = 1 then
					previous_bars := l_bars
				else
					current_bars := l_bars
				end
				create l_bbox
				l_bbox.set_padding_width (2)
				l_bbox.set_background_color (colors.stock_colors.white)
				create l_cell
				l_cell.set_background_color (colors.stock_colors.white)
				l_bbox.extend (l_cell)
				from
					j := 1
				until
					j > 4
				loop
					l_bars.item (j).set_minimum_width (10)
					l_bars.item (j).set_background_color (colors.stock_colors.white)
					l_bbox.extend (l_bars.item (j))
					l_bbox.disable_item_expand (l_bars.item (j))
					j := j + 1
				end
				l_cbox.extend (l_bbox)

				from
					j := 1
				until
					j > statistic_count
				loop
					create l_bbox
					l_bbox.set_background_color (statistic_color (j))
					l_bbox.set_border_width (1)
					l_bbox.set_padding (2)
					if i = 1 then
						l_label := statistic_labels.item (j).prev
					else
						l_label := statistic_labels.item (j).new
					end
					l_label.set_background_color (colors.stock_colors.white)
					l_label.align_text_right
					l_bbox.extend (l_label)
					l_cbox.extend (l_bbox)
					l_cbox.disable_item_expand (l_bbox)
					j := j + 1
				end


				l_cbox.set_minimum_width (80)

				l_rbox.extend (l_cbox)
				i := i + 1
			end

			l_pbox.extend (l_rbox)

			create l_frame.make_with_text (locale.translation (f_statistics))
			l_frame.extend (l_pbox)
			l_frame.disable_sensitive
			statistic_widget := l_frame

			a_widget.extend (l_frame)
		end

	build_grid (a_split: EV_HORIZONTAL_SPLIT_AREA)
			-- Initialize `grid'.
		require
			a_split_attached: a_split /= Void
		local
			l_vbox: EV_VERTICAL_BOX
		do
			create grid
			grid.set_column_count_to (3)

			grid.set_auto_resizing_column (1, True)
			grid.set_auto_resizing_column (2, True)
			grid.enable_last_column_use_all_width
			grid.header.i_th (1).set_text (locale.translation (h_test))
			grid.header.i_th (2).set_text (locale.translation (h_old_result))
			grid.header.i_th (3).set_text (locale.translation (h_new_result))
			grid.enable_tree
			grid.hide_tree_node_connectors
			grid.enable_single_row_selection
			grid.disable_sensitive
			grid.enable_partial_dynamic_content
			grid.set_dynamic_content_function (agent grid_item)

			create l_vbox
			l_vbox.set_border_width (1)
			l_vbox.set_background_color (colors.stock_colors.gray)
			l_vbox.extend (grid)
			a_split.set_second (l_vbox)
		end

	on_after_initialized
			-- <Precursor>
		local
			i, l_id: INTEGER
			l_new: BOOLEAN
			l_bar: EV_DRAWING_AREA
		do
			Precursor
			from
				i := 1
			until
				i > 2*statistic_count
			loop
				l_id := (i+1)//2
				l_new := i\\2 = 0
				if l_new then
					l_bar := current_bars.item (l_id)
				else
					l_bar := previous_bars.item (l_id)
				end
				register_action (l_bar.expose_actions, agent redraw_statistic_bars (?, ?, ?, ?, l_bar, l_id, l_new))
				register_action (l_bar.resize_actions, agent redraw_statistic_bars (?, ?, ?, ?, l_bar, l_id, l_new))
				register_action (l_bar.dpi_changed_actions, agent dpi_redraw_statistic_bars (?, ?, ?, ?, ?, l_bar, l_id, l_new))
				i := i + 1
			end
			register_action (grid.row_expand_actions, agent (a_row: EV_GRID_ROW) do grid.request_columns_auto_resizing end)
		end

feature {NONE} -- Access

	grid: ES_TESTING_TOOL_GRID
			-- Grid used to compare different test suite states

	compare_button: SD_TOOL_BAR_BUTTON
			-- Button to initiate a new comparison

	file_text: EV_TEXT_FIELD
			-- Text field containing current file name

	statistic_widget: EV_WIDGET
			-- Widget to be made sensitive once statistics are shown

feature {NONE} -- Access: rows

	rows: ARRAY [detachable EV_GRID_ROW]
			-- Parent rows for each category in `grid', Void if row is not shown.

	category_labels: ARRAY [STRING]
			-- Labels for each row in `rows'
		once
			Result := << t_fail, t_pass, t_unresolved, t_untested, t_unchanged,
			             t_removed >>
		ensure
			result_valid: Result.count = category_count
		end

	category_statistics: ARRAY [like create_statistics]
			-- Statistics for each category

	statistic_labels: ARRAY [TUPLE [prev, new: EV_LABEL]]
			-- Array containing statistic labels
			--
			-- prev: label for previous number of tests in some category
			-- new: label for current number of tests in some category

	previous_bars, current_bars: like create_bars
			-- Set of bars for visualizing statistics

	max_statistic_count: NATURAL
			-- Max value of any statistic in `category_statistics'

feature {NONE} -- Status report

	has_printed_test: BOOLEAN
			-- Has `print_formatted_test' printed any thing to `token_writer'?

	has_requested_bar_redraw: BOOLEAN
			-- Has there already been a call to `redraw_statistic_bars' since last idle?

feature {NONE} -- Query

	statistic_id (a_state: detachable TEST_STATE): like category_count
			-- Statistic ID according to given state
		do
			if a_state /= Void then
				if a_state.is_tested then
					if a_state.is_pass then
						Result := pass_id
					elseif a_state.is_fail then
						Result := fail_id
					else
						Result := unresolved_id
					end
				else
					Result := untested_id
				end
			else
				Result := removed_id
			end
		ensure
			result_valid: 0 < Result and Result <= category_count
		end

	grid_item (a_column, a_row: INTEGER): EV_GRID_ITEM
			-- Return dynamically computed grid item for given row and column.
		local
			l_row: EV_GRID_ROW
			l_span: EV_GRID_SPAN_LABEL_ITEM
			l_state: detachable TEST_STATE
			l_id: like statistic_id
			l_item: EB_GRID_EDITOR_TOKEN_ITEM
		do
			l_row := grid.row (a_row)
			if attached {TUPLE [name: READABLE_STRING_GENERAL; prev, new: detachable TEST_STATE]} l_row.data as l_stuple then
				if a_column = 1 then
					Result := create_test_item (l_stuple.name)
				else
					if a_column = 2 then
						l_state := l_stuple.prev
					else
						l_state := l_stuple.new
					end
					l_id := statistic_id (l_state)
					create l_item
					inspect
						l_id
					when pass_id then
						l_item.set_pixmap (stock_pixmaps.general_tick_icon)
					when fail_id then
						l_item.set_pixmap (stock_pixmaps.general_error_icon)
					when unresolved_id then
						l_item.set_pixmap (stock_pixmaps.general_warning_icon)
					when untested_id then
						token_writer.add_comment ("not tested")
					when removed_id then
						token_writer.add_comment ("unknown test")
					end
					if l_state /= Void and then l_state.is_tested and then not l_state.is_pass then
						token_writer.process_basic_text (l_state.tag)
					end
					l_item.set_text_with_tokens (token_writer.last_line.content)
					reset_token_writer
					Result := l_item
				end
			elseif attached {like category_count} l_row.data as l_cid then
				if a_column = 1 then
					create l_span.make_master (1)
					l_span.set_text (locale_formatter.formatted_translation (category_labels[l_cid] + " ($1)", [category_statistics[l_cid].new]))
				else
					create l_span.make_span (1)
				end
				Result := l_span
			end
			if Result = Void then
				create Result
			end
		end

feature -- Basic operations

	compare_states (a_file_name: PATH)
			-- Compare current test suite state with state stored in `a_file_name'.
			--
			-- `a_file_name': File name in which old state is stored
		require
			a_file_name_attached: a_file_name /= Void
		local
			l_serializer: TEST_STATE_SERIALIZER
			l_old, l_new: ARRAYED_LIST [TEST_STATE]
			l_lstate, l_rstate: detachable TEST_STATE
			i: INTEGER
		do
			reset_grid
			window.lock_update

			create l_serializer
			l_serializer.deserialize_from_file (a_file_name)
			l_old := l_serializer.last_result
			if l_old = Void then
				if l_serializer.last_error_code = l_serializer.file_not_readable then
					prompts.show_error_prompt (locale_formatter.formatted_translation (e_file_not_readable, [a_file_name]), window, Void)
				elseif l_serializer.last_error_code = l_serializer.file_not_valid then
					prompts.show_error_prompt (locale_formatter.formatted_translation (e_file_not_valid, [a_file_name]), window, Void)
				end
			else
				l_serializer.serialize_test_suite
				l_new := l_serializer.last_result
				if l_new = Void then
					prompts.show_error_prompt (locale.translation (e_test_suite_unavailable), window, Void)
				else
					from
						l_old.start
						l_new.start
					until
						l_old.after and l_new.after
					loop
						if l_old.after then
							l_lstate := Void
						else
							l_lstate := l_old.item_for_iteration
						end
						if l_new.after then
							l_rstate := Void
						else
							l_rstate := l_new.item_for_iteration
						end
						if l_lstate = Void then
							l_new.forth
						elseif l_rstate = Void then
							l_old.forth
						else
							if l_lstate.test_name.same_string (l_rstate.test_name) then
								l_new.forth
								l_old.forth
							else
								if l_lstate.test_name < l_rstate.test_name then
									l_rstate := Void
									l_old.forth
								else
									l_lstate := Void
									l_new.forth
								end
							end
						end
						append_state (l_lstate, l_rstate)
					end

					from
						i := 1
					until
						i > statistic_count
					loop
						statistic_labels.item (i).prev.set_text (category_statistics[i].prev.out)
						if category_statistics[i].prev > 0 then
							statistic_labels.item (i).prev.parent.enable_sensitive
						else
							statistic_labels.item (i).prev.parent.disable_sensitive
						end
						statistic_labels.item (i).new.set_text (category_statistics[i].new.out)
						if category_statistics[i].new > 0 then
							statistic_labels.item (i).new.parent.enable_sensitive
						else
							statistic_labels.item (i).new.parent.disable_sensitive
						end
						i := i + 1
					end

					statistic_widget.enable_sensitive
					grid.enable_sensitive
					file_text.set_text (a_file_name.name)
				end
			end

			request_statistic_bars_redraw
			window.unlock_update
			grid.request_columns_auto_resizing
		end

feature {NONE} -- Events

	redraw_statistic_bars (a_x, a_y, a_width, a_height: INTEGER; a_bar: EV_DRAWING_AREA; an_id: like statistic_count; a_new: BOOLEAN)
			-- Request status bar redraw.
		require
			a_bar_attached: a_bar /= Void
			an_id_valid: 0 < an_id and an_id <= statistic_count
		local
			l_height, l_width, l_prop: INTEGER
			l_stat: NATURAL
		do
			if a_new then
				l_stat := category_statistics[an_id].new
			else
				l_stat := category_statistics[an_id].prev
			end
			l_height := a_bar.height
			l_width := a_bar.width
			a_bar.clear
			if max_statistic_count > 0 then
				l_prop := ((l_stat/max_statistic_count)*l_height).floor
				a_bar.set_foreground_color (statistic_color (an_id))
				a_bar.fill_rectangle (0, l_height - l_prop, l_width, l_height)
			end
		end

	dpi_redraw_statistic_bars (a_dpi: NATURAL_32; a_x, a_y, a_width, a_height: INTEGER; a_bar: EV_DRAWING_AREA; an_id: like statistic_count; a_new: BOOLEAN)
			-- Request status bar redraw.
		require
			a_bar_attached: a_bar /= Void
			an_id_valid: 0 < an_id and an_id <= statistic_count
		do
			redraw_statistic_bars (a_x, a_y, a_width, a_height, a_bar, an_id, a_new)
		end

	request_statistic_bars_redraw
			-- Request that `previous_bars' and `current_bars' are redrawn on next idle
		do
			if not has_requested_bar_redraw then
				ev_application.add_idle_action_kamikaze (agent redraw_bars)
				has_requested_bar_redraw := True
			end
		end

	on_compare_button_select
			-- Calledn when `compare_button' is selected.
		local
			l_tools: ES_SHELL_TOOLS
		do
			l_tools := develop_window.shell_tools
			if attached {ES_TESTING_RESULTS_TOOL} l_tools.tool ({ES_TESTING_RESULTS_TOOL}) as l_tool then
				l_tool.compare_states
			end
		end

feature {NONE} -- Implementation

	append_state (an_old_state, a_new_state: detachable TEST_STATE)
			-- Append given states to `grid'.
		require
			rows_valid: rows.count = category_count
			one_state_attached: an_old_state /= Void or a_new_state /= Void
			both_attached_implies_equal: (an_old_state /= Void and a_new_state /= Void) implies
			                             an_old_state.test_name.same_string (a_new_state.test_name)
		local
			l_lid, l_rid: like statistic_id
			l_row_id, l_pos, i: INTEGER
			l_row: detachable EV_GRID_ROW
			l_data: ANY
		do
			l_lid := statistic_id (an_old_state)
			l_rid := statistic_id (a_new_state)
			category_statistics.item (l_lid).prev := category_statistics.item (l_lid).prev + 1
			if l_lid <= statistic_count then
				max_statistic_count := max_statistic_count.max (category_statistics.item (l_lid).prev)
			end
			category_statistics.item (l_rid).new := category_statistics.item (l_rid).new + 1
			if l_rid <= statistic_count then
				max_statistic_count := max_statistic_count.max (category_statistics.item (l_rid).new)
			end
			if l_lid = l_rid then
				l_row_id := unchanged_id
				category_statistics.item (l_row_id).new := category_statistics.item (l_row_id).new + 1
			else
				l_row_id := l_rid
			end
			l_row := rows.item (l_row_id)
			if l_row = Void then
				from
					l_pos := 1
					i := rows.lower
				until
					i >= l_row_id
				loop
					l_row := rows.item (i)
					if l_row /= Void then
						l_pos := l_row.index + l_row.subrow_count_recursive + 1
					end
					i := i + 1
				end
				grid.insert_new_row (l_pos)
				l_row := grid.row (l_pos)
				rows.put (l_row, l_row_id)
				l_row.set_data (l_row_id)
			end
			l_row.insert_subrow (l_row.subrow_count + 1)
			if an_old_state /= Void then
				l_data := [an_old_state.test_name, an_old_state, a_new_state]
			else
				l_data := [a_new_state.test_name, an_old_state, a_new_state]
			end
			l_row.subrow (l_row.subrow_count).set_data (l_data)
		end

	reset_grid
			-- Reset grid to only contain top level rows.
		local
			i: INTEGER
		do
			grid.remove_and_clear_all_rows
			rows.clear_all
			max_statistic_count := 0
			from
				i := 1
			until
				i > category_count
			loop
				category_statistics.put (create_statistics, i)
				i := i + 1
			end
		end

	print_formatted_test (a_test_suite: TEST_SUITE_S; a_name: READABLE_STRING_GENERAL)
			-- Print formatted version of test to token writer
		do
			if a_test_suite.has_test (a_name) then
				has_printed_test := True
				a_test_suite.test (a_name).print_test (token_writer)
			end
		end

	redraw_bars
			-- Perform redraw of `previous_bars' and `current_bars'.
		local
			i: INTEGER
			l_max: NATURAL
			l_color: EV_COLOR
		do
			from
				i := 1
			until
				i > statistic_count
			loop
				l_max := l_max.max (category_statistics[i].prev)
				l_max := l_max.max (category_statistics[i].new)
				i := i + 1
			end

			from
				i := 1
			until
				i > statistic_count
			loop
				l_color := statistic_color (i)
				draw_proportion (previous_bars.item (i), category_statistics[i].prev, l_max, l_color)
				draw_proportion (current_bars.item (i), category_statistics[i].new, l_max, l_color)
				i := i + 1
			end
			has_requested_bar_redraw := False
		end

	draw_proportion (a_bar: EV_DRAWING_AREA; a_prop, a_max: NATURAL; a_color: EV_COLOR)
			-- Draw porportions for some vertical bar.
		local
			l_height, l_width, l_prop: INTEGER
		do
			l_height := a_bar.height
			l_width := a_bar.width
			a_bar.clear
			if a_max > 0 then
				l_prop := ((a_prop/a_max)*l_height).floor
				a_bar.set_foreground_color (a_color)
				a_bar.fill_rectangle (0, l_height - l_prop, l_width, l_height)
			end
		end

feature {NONE} -- Factory

	create_widget: EV_HORIZONTAL_BOX
			-- <Precursor>
		do
			create Result
		end

	create_test_item (a_name: READABLE_STRING_GENERAL): EB_GRID_EDITOR_TOKEN_ITEM
			-- Create new grid item displaying test for given name
		require
			a_name_attached: a_name /= Void
		do
			create Result
			has_printed_test := False
			perform_with_test_suite (agent print_formatted_test (?, a_name))
			if not has_printed_test then
				token_writer.process_basic_text (a_name)
			end
			Result.set_text_with_tokens (token_writer.last_line.content)
			reset_token_writer
		end

	create_statistics: TUPLE [prev, new: NATURAL]
			-- Default statistic tuple
			--
			-- prev: Total number of results previously in category
			-- new: Total number of result currently in category
		do
			Result := [{NATURAL_32} 0, {NATURAL_32} 0]
		end

	create_bars: ARRAY [EV_DRAWING_AREA]
			-- Tuple containing set of bars for visualizing statistics
		do
			Result := << create {EV_DRAWING_AREA}, create {EV_DRAWING_AREA}, create {EV_DRAWING_AREA}, create {EV_DRAWING_AREA} >>
		ensure
			result_valid: Result.count = statistic_count
		end

feature {NONE} -- Constants

	fail_id: INTEGER = 1
	pass_id: INTEGER = 2
	unresolved_id: INTEGER = 3
	untested_id: INTEGER = 4
	unchanged_id: INTEGER = 5
	removed_id: INTEGER = 6
			-- IDs for different categories

	category_count: INTEGER = 6
			-- Number of different categories

	statistic_count: INTEGER = 4
			-- n-th first categories for which a statistic is shown

	statistic_color (an_id: like statistic_count): EV_COLOR
			-- Associated color for given statistic id
		require
			an_id_valid: 0 < an_id and an_id <= statistic_count
		do
			inspect
				an_id
			when fail_id then
				Result := fail_color
			when pass_id then
				Result := pass_color
			when unresolved_id then
				Result := unresolved_color
			when untested_id then
				Result := untested_color
			end
		end

feature {NONE} -- Internationalization

	h_test: STRING = "Test"
	h_old_result: STRING = "Previous Result"
	h_new_result: STRING = "Current Result"

	t_fail: STRING = "Fail"
	t_pass: STRING = "Pass"
	t_unresolved: STRING = "Unresolved"
	t_untested: STRING = "Not Tested"
	t_unchanged: STRING = "Unchanged"
	t_removed: STRING = "Removed"

	t_previous: STRING = "Previous"
	t_current: STRING = "Current"

	f_result_file: STRING = "Result File"
	f_statistics: STRING = "Statistics"

	e_test_suite_unavailable: STRING = "Unable to fetch results from test suite"
	e_file_not_readable: STRING = "Unable to read results from file%N$1"
	e_file_not_valid: STRING = "$1%Nis not a valid test result file"

invariant
	category_statistics_valid: category_statistics.count = category_count
	statistic_labels_valid: statistic_labels.count = statistic_count
	previous_bars_valid: previous_bars.count = statistic_count
	current_bars_valid: current_bars.count = statistic_count

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
