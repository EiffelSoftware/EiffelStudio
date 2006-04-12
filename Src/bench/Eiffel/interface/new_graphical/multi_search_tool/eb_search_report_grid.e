indexing
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

	EB_SHARED_PREFERENCES
		undefine
			default_create,
			copy
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
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

create
	make

feature {NONE} -- Initialization

	make (a_search_tool: EB_MULTI_SEARCH_TOOL) is
			-- Initialization
		require
			a_search_tool_attached: a_search_tool /= Void
		do
			create report_summary_string.make_empty
			search_tool := a_search_tool
			default_create
			build_interface
		ensure
			report_summary_string_not_void: report_summary_string /= Void
			search_tool_set: search_tool = a_search_tool
		end

feature -- Access

	grid_head_class: STRING is				"Class"
	grid_head_line_number: STRING is 		"Line"
	grid_head_found: STRING is				"Found"
	grid_head_context: STRING is			"Context"
	grid_head_file_location: STRING is		"File location"
			-- Grid header texts

	search_tool: EB_MULTI_SEARCH_TOOL

feature {EB_MULTI_SEARCH_TOOL} -- Access

	header_width: ARRAYED_LIST [INTEGER] is
			-- List of header width.
		once
			create Result.make (4)
			Result.extend (label_font.string_width (grid_head_class) + column_border_space + column_border_space)
			Result.extend (label_font.string_width (grid_head_found) + column_border_space + column_border_space)
			Result.extend (label_font.string_width (grid_head_context) + column_border_space + column_border_space)
			Result.extend (label_font.string_width (grid_head_file_location) + column_border_space + column_border_space)
		end

		column_border_space: INTEGER is 8
				-- Padding space for column content	

		multi_search_performer: MSR is
			--
		do
			Result := search_tool.multi_search_performer
		end

feature {EB_MULTI_SEARCH_TOOL} -- Redraw

	redraw_grid is
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
				search_tool.new_search_tool_bar.hide

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
														new_label_item ("Line " + l_text_item.line_number.out + ":"))
							set_item (2,
														l_row_count,
														new_label_item (replace_rnt_to_space (l_text_item.text)))
							item (2, l_row_count).set_foreground_color (preferences.editor_data.operator_text_color)
							create l_grid_drawable_item
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
																new_label_item ("Capture " +
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

	build_interface is
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

			column (1).header_item.pointer_button_press_actions.force_extend (agent on_grid_header_click (1))
			column (2).header_item.pointer_button_press_actions.force_extend (agent on_grid_header_click (2))

			row_select_actions.extend (agent on_grid_row_selected)
			set_item_pebble_function (agent grid_pebble_function)
			set_accept_cursor (Cursors.cur_class)
			set_deny_cursor (Cursors.cur_x_class)
			set_minimum_width (100)
		end

	new_label_item (a_string: STRING): EV_GRID_LABEL_ITEM is
			-- Create uniformed label item
		require
			string_attached: a_string /= Void
		local
			l_color: EV_COLOR
		do
			create Result.make_with_text (a_string)
			l_color := background_color
			Result.set_foreground_color (row_text_color (l_color))
		ensure
			new_item_not_void: Result /= Void
		end

	label_font: EV_FONT is
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

	expose_drawable_action (drawable: EV_DRAWABLE; a_item: MSR_ITEM; query_grid_row: EV_GRID_ROW) is
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

	row_text_color (a_bg_color: EV_COLOR): EV_COLOR is
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

	report_summary_string: STRING

	adjust_grid_column_width is
			-- Adjust grid column width to best fit visible area.
		local
			i: INTEGER
			l_grid_width: INTEGER
			col : EV_GRID_COLUMN
			full_width: INTEGER
			temp_width: INTEGER
			l_width: INTEGER
			l_required_width: ARRAYED_LIST [INTEGER]
		do
			if row_count /= 0 then
				create l_required_width.make (column_count)
				from
					i := 1
				until
					i > column_count
				loop
					col := column (i)
					l_required_width.extend (col.required_width_of_item_span (1, col.parent.row_count))
					full_width := full_width + (header_width @ i).max (l_required_width @ i)
					i := i + 1
				end
				l_grid_width := width
				from
					i := 1
				until
					i > column_count
				loop
					col := column (i)
					temp_width := (header_width @ i).max (l_required_width @ i)
					l_width := ((temp_width / full_width) * l_grid_width).floor
					if l_width > temp_width then
						l_width := temp_width
					end
					l_width := l_width-- + column_border_space
					col.set_width (l_width)
					i := i + 1
				end
			end
		end

feature {NONE} -- Stone

	stone_from_class_i (a_class_i: CLASS_I): STONE is
			-- Make a stone from a_class_i.
			-- If a_class_i compiled returns CLASSC_STONE , or a CLASSI_STONE.
		require
			a_class_i_not_void: a_class_i /= Void
		do
			Result := search_tool.stone_from_class_i (a_class_i)
		end

feature {NONE} -- Sort data

	on_grid_header_click (a_column_index: INTEGER) is
			-- User click on the column header of index `a_column_index'.
		require
			a_column_index_valid: column_index_valid (a_column_index)
			not_destroyed: not is_destroyed
		local
			l_item: MSR_TEXT_ITEM
		do
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

	sorted_column: INTEGER
			-- Column on which sorting is done.	

	column_index_valid (a_column_index: INTEGER): BOOLEAN  is
			-- Validate a column index.
		do
			Result := a_column_index > 0 and a_column_index <= column_count
		end

	sorting_order: BOOLEAN
			-- If True, sort from the smaller to the larger.

feature {EB_MULTI_SEARCH_TOOL} -- Implementation

	put_report_summary is
			-- Put report summary
		require
			performer_launched: multi_search_performer.is_search_launched
		do
			report_summary_string := "   " +
										multi_search_performer.text_found_count.out +
										" found(s) in " +
										multi_search_performer.class_count.out +
										" class(es)"
			search_tool.summary_label.set_text (report_summary_string)
		end

	grid_pebble_function (a_item: EV_GRID_ITEM) : STONE is
			-- Grid pebble function
		local
			l_row: EV_GRID_ROW
			l_item: MSR_ITEM
			l_class_name: STRING
			l_list: LIST [CLASS_I]
		do
			if a_item /= Void then
				l_row := a_item.row
				l_item ?= l_row.data
				if l_item /= Void then
					create l_class_name.make_from_string (l_item.class_name)
					l_class_name.to_upper
					l_list := universe.classes_with_name (l_class_name)
					if l_list /= Void and then not l_list.is_empty then
						Result := stone_from_class_i (l_list.first)
					end
				end
			end
		end

	compute_adjust_vertical (a_font: EV_FONT; a_label_item: EV_GRID_ITEM) is
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
						text_height := a_font.string_size ("a").integer_item (2)
					end
					client_height := label_item.height - label_item.top_border - label_item.bottom_border
					vertical_text_offset_into_available_space := client_height - text_height - 1
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

	extend_pointer_actions (a_row: EV_GRID_ROW) is
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
				a_row.item (i).pointer_button_press_actions.extend (agent on_grid_row_clicked (?, ?, ?, ?, ?, ?, ?, ?, a_row))
				i := i + 1
			end
		end

	on_grid_row_clicked (a, b, c : INTEGER; d, e, f: DOUBLE; g, h: INTEGER; a_row: EV_GRID_ROW) is
			-- A row is clicked by mouse pointer.
		do
			if not selected_rows.is_empty then
				if selected_rows.first = a_row then
					on_grid_row_selected (a_row)
				end
			end
		end

	on_grid_row_selected (a_row: EV_GRID_ROW) is
			-- Invoke when a row of the report grid selected
		require
			a_row_not_void: a_row /= Void
		local
			l_item: MSR_ITEM
		do
			search_tool.set_check_class_succeed (true)
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
					search_tool.check_class_file_and_do (agent on_grid_row_selected_perform)
				end
			end
		end

	on_grid_row_selected_perform is
			-- Do actual `on_grid_row_selected'
		local
			l_text_item: MSR_TEXT_ITEM
			l_editor: EB_EDITOR
			l_saving_string: STRING
		do
			search_tool.set_new_search_set (false)
			l_text_item ?= multi_search_performer.item
			if l_text_item /= Void then
				if search_tool.old_editor /= Void then
					l_editor := search_tool.old_editor
				else
					l_editor := search_tool.editor
				end
--				if old_editor /= editor implies (not is_item_source_changed (l_text_item)) then
				if (not search_tool.is_item_source_changed (l_text_item)) then
					if l_text_item.end_index_in_unix_text + 1 > l_text_item.start_index_in_unix_text then
						if l_editor.text_is_fully_loaded then
							l_editor.select_region (l_text_item.start_index_in_unix_text, l_text_item.end_index_in_unix_text + 1)
						end
					elseif l_text_item.end_index_in_unix_text + 1 = l_text_item.start_index_in_unix_text then
						l_editor.text_displayed.cursor.go_to_position (l_text_item.end_index_in_unix_text + 1)
						l_editor.deselect_all
					end
					if l_editor.has_selection then
						l_editor.show_selection (False)
					end
					l_editor.refresh_now
					search_tool.summary_label.set_text (report_summary_string)
					search_tool.new_search_tool_bar.hide
				else
					if search_tool.is_customized or search_tool.is_whole_project_searched then
						l_saving_string := " saving file and"
					else
						l_saving_string := ""
					end
					search_tool.summary_label.set_text (report_summary_string + "   Item expires. Try" + l_saving_string + " searching again.")
					search_tool.new_search_tool_bar.show
				end
			else
				search_tool.summary_label.set_text (report_summary_string)
				search_tool.new_search_tool_bar.hide
			end
		end

	select_current_row is
			-- Select current row in the grid
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
			end
		end

	grid_row_by_data (a_data: ANY) : EV_GRID_ROW is
			-- Find a row in a_grid that include a_data
		local
			i: INTEGER
			l_row: EV_GRID_ROW
			loop_end: BOOLEAN
		do
			loop_end := false
			from
				i := 1
			until
				i > row_count or loop_end
			loop
				l_row := row (i)
				if l_row.data /= Void and then l_row.data = a_data then
					Result := l_row
					loop_end := true
				end
				i := i + 1
			end
		end

invariant
	report_summary_string_not_void: report_summary_string /= Void
	search_tool_set: search_tool /= Void
indexing
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
