note
	description: "Search report grid."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SEARCH_REPORT_GRID

inherit
	ES_GRID
		redefine
			on_key_pressed
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create,
			copy
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	MSR_FORMATTER
		undefine
			default_create, copy, is_equal
		end

	SHARED_WORKBENCH
		undefine
			default_create, copy, is_equal
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	EB_CONTEXT_MENU_HANDLER
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_search_tool: like search_tool)
			-- Initialization
		require
			a_search_tool_attached: a_search_tool /= Void
		do
			create {STRING_32}report_summary_string.make_empty
			search_tool := a_search_tool
			default_create
			enable_default_tree_navigation_behavior (True, True, True, True)
			build_interface
			set_configurable_target_menu_mode
			set_configurable_target_menu_handler (agent context_menu_handler)
			set_context_menu_factory (a_search_tool.window.menus.context_menu_factory)
		ensure
			report_summary_string_not_void: report_summary_string /= Void
			search_tool_set: search_tool = a_search_tool
		end

	context_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY)
			-- Context menu handler
		do
			context_menu_factory.standard_compiler_item_menu (a_menu, a_target_list, a_source, a_pebble)
		end

feature -- Access

	grid_head_class: STRING_GENERAL
		do
			Result := interface_names.l_class
		end

	grid_head_line_number: STRING_GENERAL
		do
			Result := interface_names.l_line
		end

	grid_head_found: STRING_GENERAL
		do
			Result := interface_names.l_found
		end

	grid_head_context: STRING_GENERAL
		do
			Result := interface_names.l_context
		end

	grid_head_file_location: STRING_GENERAL
		do
			Result := interface_names.l_file_location
		end

	search_tool: ES_SEARCH_TOOL
			-- The search tool

feature {ES_MULTI_SEARCH_TOOL_PANEL} -- Access

	header_width: ARRAYED_LIST [INTEGER]
			-- List of header width.
		once
			create Result.make (4)
			Result.extend (label_font.string_width (grid_head_class) + column_border_space + column_border_space + 40)
			Result.extend (label_font.string_width (grid_head_found) + column_border_space + column_border_space + 10)
			Result.extend (label_font.string_width (grid_head_context) + column_border_space + column_border_space + 10)
			Result.extend (label_font.string_width (grid_head_file_location) + column_border_space + column_border_space + 10)
		end

	column_border_space: INTEGER = 8
			-- Padding space for column content	

	multi_search_performer: MSR
			-- Search performer from the search tool.
		do
			Result := search_tool.panel.multi_search_performer
		ensure
			Result_not_void: Result /= Void
		end

feature {ES_MULTI_SEARCH_TOOL_PANEL} -- Redraw

	redraw_grid
			-- Redraw grid according to search result and refresh summary label.
		local
			l_index: INTEGER
			i, j, k: INTEGER
			l_row_count: INTEGER
			submatch_parent: INTEGER
			arrayed_list: ARRAYED_LIST[MSR_ITEM]
			l_item: MSR_ITEM
			l_class_item: MSR_CLASS_ITEM
			l_text_item: MSR_TEXT_ITEM
			l_grid_drawable_item: EV_GRID_DRAWABLE_ITEM
			l_grid_label_item: EV_GRID_LABEL_ITEM
			l_class_i: CLASS_I
			font: EV_FONT
			l_new_row: EV_GRID_ROW
		do
			if multi_search_performer.is_search_launched then
				if not multi_search_performer.is_empty then
					l_class_item ?= multi_search_performer.item_matched.first
					if l_class_item /= Void then
						column (1).set_title (grid_head_class)
					else
						column (1).set_title (grid_head_line_number)
					end
				end
				remove_and_clear_all_rows
				put_report_summary
				search_tool.panel.report_tool.new_search_tool_bar.hide

				l_index := multi_search_performer.index
				font := label_font
				from
					arrayed_list := multi_search_performer.item_matched
					arrayed_list.start
					l_row_count := l_row_count + 1
					i := 0
					j := 0
					k := 0
				until
					arrayed_list.after
				loop
					l_item := arrayed_list.item

					l_class_item ?= arrayed_list.item
					if l_class_item /= Void then
						j := j + 1
						insert_new_row (l_row_count)
						l_new_row := row (l_row_count)
						l_new_row.set_data (l_class_item)
						if i /= 0 then
							set_item (2, i, new_label_item (k.out))
							item (2, i).set_foreground_color (preferences.editor_data.number_text_color_preference.value)
							extend_pointer_actions (row (i))
						end
						i := l_row_count
						create l_grid_label_item.make_with_text (l_item.class_name)
						l_grid_label_item.set_tooltip (l_item.class_name)
						l_class_i ?= l_class_item.data
						if l_class_i /= Void then
							l_grid_label_item.set_pixmap (pixmap_from_class_i (l_class_i))
						end
						set_item (1, l_row_count, l_grid_label_item)
						set_item (3,
													l_row_count,
													new_label_item (once "-"))
						set_item (4,
													l_row_count,
													new_label_item (l_item.path))
						k := 0
					else
						l_text_item ?= l_item
						if l_text_item /= Void then
							k := k + 1
							if i /= 0 then
								insert_new_row_parented (l_row_count, row (i))
								l_new_row := row (l_row_count)
								l_new_row.set_data (l_text_item)
							end
							if l_row_count > row_count then
								insert_new_row (l_row_count)
								l_new_row := row (l_row_count)
								l_new_row.set_data (l_text_item)
							end
							set_item (1,
									l_row_count,
									new_label_item (interface_names.l_line.as_string_32 + " " + l_text_item.line_number.out + " :"))
							set_item (2,
									l_row_count,
									new_label_item (replace_rnt_to_space (l_text_item.text)))
							item (2, l_row_count).set_foreground_color (preferences.editor_data.operator_text_color)
							create l_grid_drawable_item
							l_grid_drawable_item.set_tooltip (l_text_item.context_text)
							set_item (3, l_row_count, l_grid_drawable_item)
							l_grid_drawable_item.expose_actions.extend (agent expose_drawable_action (?, l_item, row (l_row_count)))
							l_grid_drawable_item.set_required_width (font.string_width (l_text_item.context_text))
							set_item (4, l_row_count, new_label_item (l_item.path))
							extend_pointer_actions (l_new_row)
							if not l_text_item.captured_submatches.is_empty then
								submatch_parent := l_row_count
								row (l_row_count).ensure_expandable
								from
									l_text_item.captured_submatches.start
								until
									l_text_item.captured_submatches.after
								loop
									l_row_count := l_row_count + 1
									insert_new_row_parented (l_row_count, row (submatch_parent))
									set_item (1,
																l_row_count,
																new_label_item (interface_names.l_capture.as_string_32 + " " +
																				l_text_item.captured_submatches.index.out +
																				": " +
																				l_text_item.captured_submatches.item))
									l_text_item.captured_submatches.forth
								end
							end
						end
					end
					l_row_count := l_row_count + 1
					arrayed_list.forth
				end
				if i /= 0 then
					set_item (2, i, new_label_item (k.out))
					item (2, i).set_foreground_color (preferences.editor_data.number_text_color)
				end
				multi_search_performer.go_i_th (l_index)
			end
			adjust_grid_column_width
		end

feature {NONE} -- Interface

	build_interface
			-- Build interface.
		do
			enable_row_height_fixed
			enable_single_row_selection
			disable_always_selected
			enable_tree
			set_item (4, 1, Void)
			column (1).set_title (grid_head_class)
			column (2).set_title (grid_head_found)
			column (3).set_title (grid_head_context)
			column (4).set_title (grid_head_file_location)

			column (1).header_item.pointer_button_press_actions.extend (agent on_grid_header_click (1, ?, ?, ?, ?, ?, ?, ?, ?))
			column (2).header_item.pointer_button_press_actions.extend (agent on_grid_header_click (2, ?, ?, ?, ?, ?, ?, ?, ?))

			set_item_pebble_function (agent grid_pebble_function)
			set_accept_cursor (Cursors.cur_class)
			set_deny_cursor (Cursors.cur_x_class)
			set_minimum_width (100)
		end

	new_label_item (a_string: STRING_GENERAL): EV_GRID_LABEL_ITEM
			-- Create uniformed label item
		require
			string_attached: a_string /= Void
		local
			l_color: EV_COLOR
		do
			create Result.make_with_text (a_string)
			l_color := background_color
			Result.set_foreground_color (row_text_color (l_color))
			Result.set_tooltip (a_string)
		ensure
			new_item_not_void: Result /= Void
		end

	label_font: EV_FONT
			-- Font of report text.
		local
			l_label: EV_LABEL
		once
			create l_label
			Result := l_label.font
		end

	adjust_vertical: INTEGER
			-- Offset between top of a row and top of charactors in it, buffer for effiency enhancement

	text_height: INTEGER
			-- Height of the text in the `search_report_grid', buffer for effiency enhancement

	expose_drawable_action (drawable: EV_DRAWABLE; a_item: MSR_ITEM; query_grid_row: EV_GRID_ROW)
			-- Draw grid item, to make the text colorfull.
			-- return width of current drawable item.
		local
			offset: INTEGER
			row_selected, focused: BOOLEAN
			l_color, focused_sel_color, non_focused_sel_color: EV_COLOR
			font: EV_FONT
			l_item: MSR_TEXT_ITEM
		do
			font := label_font
			focused_sel_color := focused_selection_color
			non_focused_sel_color := non_focused_selection_color
			if adjust_vertical = 0 then
				compute_adjust_vertical (font, query_grid_row.item (1))
			end
			drawable.clear
			drawable.set_font (font)
			row_selected := query_grid_row.is_selected
			focused := has_focus
			if row_selected then
				if focused then
					drawable.set_foreground_color(focused_sel_color)
				else
					drawable.set_foreground_color(non_focused_sel_color)
				end
			else
				drawable.set_foreground_color (background_color)
			end
			l_color := row_text_color (drawable.foreground_color)

			drawable.fill_rectangle (0, 0, drawable.width,drawable.height)
			l_item ?= a_item
			if l_item /= Void then
				drawable.set_foreground_color (l_color)
				drawable.draw_text_top_left (0, adjust_vertical,
											l_item.context_text.substring (1, l_item.start_index_in_context_text - 1))
				if not row_selected then
					drawable.set_foreground_color (preferences.editor_data.operator_text_color)
				end
				offset := font.string_width (l_item.context_text.substring (1, l_item.start_index_in_context_text - 1))

				drawable.draw_text_top_left (offset, adjust_vertical, replace_rnt_to_space (l_item.text))
				drawable.set_foreground_color (l_color)
				offset := font.string_width (l_item.context_text.substring (1, l_item.start_index_in_context_text + l_item.text.count - 1))

				drawable.draw_text_top_left (offset,
											adjust_vertical,
											l_item.context_text.substring (l_item.start_index_in_context_text + l_item.text.count,
																			l_item.context_text.count))
			else
				drawable.draw_text (0, adjust_vertical, "-")
			end
		end

	row_text_color (a_bg_color: EV_COLOR): EV_COLOR
			-- Text color according to its background color `a_bg_color'
		require
			bg_color_attached: a_bg_color  /= Void
		do
			if a_bg_color.lightness > 0.6 then
				create Result.make_with_rgb (0, 0, 0)
			else
				create Result.make_with_rgb (1, 1, 1)
			end
		end

	report_summary_string: STRING_GENERAL

	adjust_grid_column_width
			-- Adjust grid column width to best fit visible area.
		do
			safe_resize_column_to_content (column (1), True, False)
			safe_resize_column_to_content (column (2), True, False)
			safe_resize_column_to_content (column (3), True, False)
			safe_resize_column_to_content (column (4), True, False)
		end

feature {NONE} -- Stone

	stone_from_class_i (a_class_i: CLASS_I): STONE
			-- Make a stone from a_class_i.
			-- If a_class_i compiled returns CLASSC_STONE , or a CLASSI_STONE.
		require
			a_class_i_not_void: a_class_i /= Void
		do
			Result := search_tool.panel.stone_from_class_i (a_class_i)
		end

feature {NONE} -- Sort data

	on_grid_header_click (a_column_index: INTEGER; a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			-- User click on the column header of index `a_column_index'.
		require
			a_column_index_valid: column_index_valid (a_column_index)
			not_destroyed: not is_destroyed
		local
			l_item: MSR_TEXT_ITEM
		do
				-- only on left mouse button
			if a_button = 1 then
				if row_count > 1 and then header.pointed_divider_index = 0 then
					if sorted_column = a_column_index then
							-- We invert the sorting.
						sorting_order := not sorting_order
					else
						sorted_column := a_column_index
						sorting_order := False
					end
					if row_count > 0 then
						l_item ?= multi_search_performer.item_matched.first
						if l_item = Void then
							if a_column_index = 1 then
								multi_search_performer.sort_on (multi_search_performer.sort_by_class_name, sorting_order)
								redraw_grid
								select_current_row
							elseif a_column_index = 2 then
								multi_search_performer.sort_on (multi_search_performer.sort_by_found, sorting_order)
								redraw_grid
								select_current_row
							end
						end
					end
				end
			end
		end

	sorted_column: INTEGER
			-- Column on which sorting is done.	

	column_index_valid (a_column_index: INTEGER): BOOLEAN
			-- Validate a column index.
		do
			Result := a_column_index > 0 and a_column_index <= column_count
		end

	sorting_order: BOOLEAN
			-- If True, sort from the smaller to the larger.

feature {ES_MULTI_SEARCH_TOOL_PANEL} -- Implementation

	put_report_summary
			-- Put report summary
		require
			performer_launched: multi_search_performer.is_search_launched
		local
			l_text_found, l_class_found: INTEGER
		do
			l_text_found := multi_search_performer.text_found_count
			l_class_found := multi_search_performer.class_count
			report_summary_string := ("   ").as_string_32 + interface_names.l_n_matches (l_text_found) + " " + interface_names.l_in_n_classes (l_class_found)
			search_tool.panel.report_tool.set_summary (report_summary_string)
		end

	grid_pebble_function (a_item: EV_GRID_ITEM) : STONE
			-- Grid pebble function
		local
			l_row: EV_GRID_ROW
			l_item: MSR_ITEM
			l_text_item: MSR_TEXT_ITEM
			l_start, l_end: INTEGER
			l_class: CLASS_I
			l_class_c: CLASS_C
			l_compiled_line_stone: COMPILED_LINE_STONE
			l_uncompiled_line_stone: UNCOMPILED_LINE_STONE
		do
			if a_item /= Void then
				l_row := a_item.row
				l_item ?= l_row.data
				if l_item /= Void then
					l_class ?= l_item.data
					if l_class /= Void then
						l_text_item ?= l_row.data
						if l_text_item /= Void then
							l_start := l_text_item.start_index_in_unix_text
							l_end := l_text_item.end_index_in_unix_text + 1
							l_class_c := l_class.compiled_representation
							if l_class_c /= Void then
								create l_compiled_line_stone.make_with_line (l_class_c, 1, True)
								l_compiled_line_stone.set_selection ([l_start, l_end])
								Result := l_compiled_line_stone
							else
								create l_uncompiled_line_stone.make_with_line (l_class, 1, True)
								l_uncompiled_line_stone.set_selection ([l_start, l_end])
								Result := l_uncompiled_line_stone
							end
						else
							Result := stone_from_class_i (l_class)
						end
					end
				end
			end
		end

	compute_adjust_vertical (a_font: EV_FONT; a_label_item: EV_GRID_ITEM)
			-- Compute `adjust_vertical'
		require
			font_attached: a_font /= Void
			label_item_attached: a_label_item /= Void
		local
			vertical_text_offset_into_available_space: INTEGER
			label_item: EV_GRID_LABEL_ITEM
			client_height: INTEGER
		do
			if adjust_vertical = 0 then
				label_item ?= a_label_item
				if label_item /= Void then
					if text_height = 0 then
						text_height := a_font.string_size (once "a").height
					end
					client_height := label_item.height - label_item.top_border - label_item.bottom_border
					vertical_text_offset_into_available_space := client_height - text_height
					if label_item.is_top_aligned then
						vertical_text_offset_into_available_space := 0
					elseif label_item.is_bottom_aligned then
					else
						vertical_text_offset_into_available_space := vertical_text_offset_into_available_space // 2
					end
					vertical_text_offset_into_available_space := vertical_text_offset_into_available_space.max (0)
					adjust_vertical := vertical_text_offset_into_available_space + label_item.top_border
				end
			end
		end

	extend_pointer_actions (a_row: EV_GRID_ROW)
			-- Extend pointer actions to every row item.
		require
			a_row_attached: a_row /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_row.count
			loop
				a_row.item (i).pointer_double_press_actions.extend (agent on_grid_row_double_clicked (?, ?, ?, ?, ?, ?, ?, ?, a_row))
				i := i + 1
			end
		end

	on_grid_row_double_clicked (a, b, c : INTEGER; d, e, f: DOUBLE; g, h: INTEGER; a_row: EV_GRID_ROW)
			-- A row is clicked by mouse pointer.
		do
			if not selected_rows.is_empty then
				if selected_rows.first = a_row then
					go_to_line_of_editor (a_row)
				end
			end
		end

	on_key_pressed (a_key: EV_KEY)
			-- On key pressed.
		local
			l_selected_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			Precursor {ES_GRID}(a_key)
			inspect a_key.code
			when key_enter then
				if not selected_rows.is_empty then
					go_to_line_of_editor (selected_rows.first)
				end
			when key_home then
				if row_count > 0 then
					remove_selection
					select_row (1)
					l_selected_rows := selected_rows
					if not l_selected_rows.is_empty then
						l_selected_rows.first.ensure_visible
					end
				end
			when key_end then
				if row_count > 0 then
					remove_selection
					select_row (row_count)
					l_selected_rows := selected_rows
					if not l_selected_rows.is_empty then
						l_selected_rows.first.ensure_visible
					end
				end
			else
			end
		end

	go_to_line_of_editor (a_row: EV_GRID_ROW)
			-- Invoke when a row of the report grid selected
		require
			a_row_not_void: a_row /= Void
		local
			l_item: MSR_ITEM
		do
			search_tool.panel.set_check_class_succeed (True)
			if a_row.parent /= Void and then a_row.parent_row /= Void and then a_row.parent_row.is_expandable and then not a_row.parent_row.is_expanded then
				a_row.parent_row.expand
				adjust_grid_column_width
			end
			if is_displayed then
				a_row.ensure_visible
			end
			l_item ?= a_row.data
			if l_item /= Void then
				multi_search_performer.start
				multi_search_performer.search (l_item)
				if multi_search_performer.is_search_launched and then not multi_search_performer.off then
					search_tool.panel.check_class_file_and_do (agent on_grid_row_selected_perform)
				end
			end
		end

	on_grid_row_selected_perform
			-- Do actual `on_grid_row_selected'
		local
			l_text_item: MSR_TEXT_ITEM
			l_editor: EB_EDITOR
			l_saving_string: STRING_GENERAL
			l_start, l_end: INTEGER
			l_tool: ES_MULTI_SEARCH_TOOL_PANEL
		do
			l_tool := search_tool.panel
			l_tool.set_new_search_set (False)
			if multi_search_performer.is_search_launched and then not multi_search_performer.off then
				l_text_item ?= multi_search_performer.item
			end
			if l_text_item /= Void then
				if l_tool.old_editor /= Void and then not l_tool.old_editor.is_recycled then
					l_editor := l_tool.old_editor
				else
					l_editor := l_tool.editor
				end
				if l_editor /= Void then
					if (not l_tool.is_item_source_changed (l_text_item)) then
						l_start := l_text_item.start_index_in_unix_text
						l_end := l_text_item.end_index_in_unix_text + 1
						if l_end > l_start then
							if l_editor.text_is_fully_loaded then
								l_editor.select_region (l_start, l_end)
							end
						elseif l_end = l_start then
							l_editor.text_displayed.cursor.go_to_position (l_end)
							l_editor.deselect_all
						end
						if l_editor.has_selection then
							l_editor.show_selection (False)
						end
						if l_tool.saved_cursor /= 0 and then l_tool.saved_cursor = multi_search_performer.index then
							l_tool.first_result_reached_actions.call ([True])
						else
							l_tool.first_result_reached_actions.call ([False])
						end
						if multi_search_performer.islast then
							l_tool.bottom_reached_actions.call ([True])
						else
							l_tool.bottom_reached_actions.call ([False])
						end
						l_editor.refresh_now
						l_tool.report_tool.set_summary (report_summary_string)
						l_tool.report_tool.set_new_search_button_visible (False)
						if not l_tool.report_cursor_recorded then
							l_tool.save_current_cursor
							l_tool.set_report_cursor_recorded (True)
						end
					else
						l_tool.bottom_reached_actions.call ([False])
						l_tool.first_result_reached_actions.call ([False])
						if l_tool.is_customized or l_tool.is_whole_project_searched then
							l_saving_string := interface_names.l_try_saving_file_and_searching
						else
							l_saving_string := interface_names.l_try_searching
						end
						l_tool.report_tool.set_summary (report_summary_string.as_string_32 + "   " + l_saving_string)
						l_tool.report_tool.set_new_search_button_visible (True)
					end
				end
			else
				l_tool.report_tool.set_summary (report_summary_string)
				l_tool.report_tool.set_new_search_button_visible (False)
			end
		end

	select_current_row
			-- Select current row in the grid, and perform selecting in the editor.
		require
			search_launched: multi_search_performer.is_search_launched
		local
			l_row: EV_GRID_ROW
			l_row_index: INTEGER
			l_selected_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			if not multi_search_performer.off then
				l_row := grid_row_by_data (multi_search_performer.item)
			end
			if l_row /= Void then
				l_row_index := l_row.index
			elseif row_count > 0 then
				l_row_index := 1
			end
			l_selected_rows := selected_rows
			if not l_selected_rows.is_empty then
				(l_selected_rows @ 1).disable_select
			end
			if l_row_index > 0 and l_row_index <= row_count then
				select_row (l_row_index)
				l_selected_rows := selected_rows
				if not l_selected_rows.is_empty then
					go_to_line_of_editor (l_selected_rows @ 1)
				end
			end
		end

	grid_row_by_data (a_data: ANY) : EV_GRID_ROW
			-- Find a row in a_grid that include a_data
		local
			i: INTEGER
			l_row: EV_GRID_ROW
			loop_end: BOOLEAN
		do
			loop_end := False
			from
				i := 1
			until
				i > row_count or loop_end
			loop
				l_row := row (i)
				if l_row.data /= Void and then l_row.data = a_data then
					Result := l_row
					loop_end := True
				end
				i := i + 1
			end
		end

invariant
	report_summary_string_not_void: report_summary_string /= Void
	search_tool_set: search_tool /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
