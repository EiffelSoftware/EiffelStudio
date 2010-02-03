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
		do
			build_statistics (a_widget)
			build_grid (a_widget)
		end

	build_statistics (a_widget: like create_widget)
			-- Initialize statistics widget.
		require
			a_widget_attached: a_widget /= Void
		local
			l_vbox, l_cbox: EV_VERTICAL_BOX
			l_rbox, l_bbox, l_pbox: EV_HORIZONTAL_BOX
			l_frame: EV_FRAME
			l_label: EV_LABEL
			l_cell: EV_CELL
			i, j: INTEGER
			l_bars: like create_bars
		do
			create l_vbox
			l_vbox.set_border_width (3)

			create l_pbox
			l_pbox.set_border_width (4)

			create l_rbox
			l_rbox.set_border_width (1)
			l_rbox.set_background_color (colors.stock_colors.grey)

			create statistic_labels.make_filled (create {EV_LABEL}, statistic_count, 3)
			from
				i := 1
			until
				i > statistic_count
			loop
				from
					j := 1
				until
					j > 3
				loop
					if (i /= 1 or j /= 1) then
						create l_label
						l_label.align_text_right
						statistic_labels.put (l_label, i, j)
					end
					j := j + 1
				end
				i := i + 1
			end

				-- Labels
			create l_cbox
			l_cbox.set_border_width (2)
			l_cbox.set_background_color (colors.stock_colors.white)
			create l_cell
			l_cell.set_minimum_height (bar_height)
			l_cell.set_background_color (colors.stock_colors.white)
			l_cbox.extend (l_cell)
			create l_label
			l_label.set_background_color (colors.stock_colors.white)
			l_cbox.extend (l_label)
			from
				i := 1
			until
				i > statistic_count
			loop
				create l_label.make_with_text (locale.translation (category_labels[i]))
				l_label.set_background_color (colors.stock_colors.white)
				l_label.align_text_left
				l_cbox.extend (l_label)
				i := i + 1
			end
			l_rbox.extend (l_cbox)

			from
				i := 1
			until
				i > 3
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
				else
					create l_label
				end
				l_label.set_background_color (colors.stock_colors.white)
				l_label.align_text_right
				l_cbox.extend (l_label)

				if i = 3 then
					create l_cell
					l_cell.set_minimum_height (bar_height)
					l_cell.set_background_color (colors.stock_colors.white)
					l_cbox.extend (l_cell)
				else
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
						l_bars.item (j).set_minimum_height (bar_height)
						l_bars.item (j).set_minimum_width (10)
						l_bars.item (j).set_background_color (colors.stock_colors.white)
						l_bbox.extend (l_bars.item (j))
						l_bbox.disable_item_expand (l_bars.item (j))
						j := j + 1
					end
					l_cbox.extend (l_bbox)
				end
				from
					j := 1
				until
					j > statistic_count
				loop
					create l_bbox
					l_bbox.set_background_color (colors.stock_colors.white)
					l_bbox.set_border_width (1)
					l_bbox.set_padding (2)
					if i < 3 then
						inspect
							j
						when fail_id then
							l_bbox.set_background_color (fail_color)
						when pass_id then
							l_bbox.set_background_color (pass_color)
						when unresolved_id then
							l_bbox.set_background_color (unresolved_color)
						when untested_id then
							l_bbox.set_background_color (untested_color)
						end
					end
					l_label := statistic_labels.item (j, i)
					l_label.set_background_color (colors.stock_colors.white)
					l_label.align_text_right
					l_bbox.extend (l_label)
					l_cbox.extend (l_bbox)
					j := j + 1
				end
				l_rbox.extend (l_cbox)
				i := i + 1
			end

			l_pbox.extend (l_rbox)

			create l_frame.make_with_text ("Statistics")
			l_frame.set_minimum_width (300)
			l_frame.extend (l_pbox)
			a_widget.disable_sensitive

			l_vbox.extend (l_frame)
			l_vbox.disable_item_expand (l_frame)

			l_vbox.extend (create {EV_CELL})

			a_widget.extend (l_vbox)
			a_widget.disable_item_expand (l_vbox)
		end

	build_grid (a_widget: like create_widget)
			-- Initialize `grid'.
		require
			a_widget_attached: a_widget /= Void
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

			register_action (grid.row_expand_actions, agent (a_row: EV_GRID_ROW) do grid.request_columns_auto_resizing end)

			create l_vbox
			l_vbox.set_border_width (1)
			l_vbox.set_background_color (colors.stock_colors.gray)
			l_vbox.extend (grid)
			a_widget.extend (l_vbox)
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor
			register_action (previous_bars.item (1).expose_actions, agent redraw_statistic_bars)
			register_action (previous_bars.item (1).resize_actions, agent redraw_statistic_bars)
		end

feature {NONE} -- Access

	grid: ES_TESTING_TOOL_GRID
			-- Grid used to compare different test suite states

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

	statistic_labels: ARRAY2 [EV_LABEL]
			-- 2D array containing statistic labels
			--
			-- rows: previous, new and changes
			-- columns: statistic categories

	previous_bars, current_bars: like create_bars
			-- Set of bars for visualizing statistics

feature {NONE} -- Status report

	has_printed_test: BOOLEAN
			-- Has `print_formatted_test' printed any thing to `token_writer'?

feature -- Basic operations

	compare_states (a_file_name: READABLE_STRING_8)
			-- Compare current test suite state with state stored in `a_file_name'.
			--
			-- `a_file_name': File name in which old state is stored
		require
			a_file_name_attached: a_file_name /= Void
		local
			l_serializer: TEST_STATE_SERIALIZER
			l_old, l_new: ARRAYED_LIST [TEST_STATE]
			l_lstate, l_rstate: detachable TEST_STATE
			l_item: EV_GRID_SPAN_LABEL_ITEM
			i: INTEGER
			l_label: STRING_32
		do
			reset_grid
			window.lock_update

			create l_serializer
			l_serializer.deserialize_from_file (a_file_name)
			l_old := l_serializer.last_result
			l_serializer.serialize_test_suite
			l_new := l_serializer.last_result
			if l_old = Void then
				-- TODO: error handling
			elseif l_new = Void then
				-- TODO: error handling
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
					i := rows.lower
				until
					i > rows.upper
				loop
					if attached rows.item (i) as l_row then
						create l_item.make_master (1)
						l_item.set_text (locale.formatted_string (category_labels.item (i) + " ($1)", [category_statistics.item (i).new]))
						l_row.set_item (1, l_item)
						create l_item.make_span (1)
						l_row.set_item (2, l_item)
						create l_item.make_span (1)
						l_row.set_item (3, l_item)
					end
					i := i + 1
				end


				from
					i := 1
				until
					i > statistic_count
				loop
					statistic_labels.item (i, 1).set_text (category_statistics[i].prev.out)
					statistic_labels.item (i, 2).set_text (category_statistics[i].new.out)
					create l_label.make (10)
					if 0 < category_statistics[i].add then
						l_label.append_character ('+')
						l_label.append_natural_32 (category_statistics[i].add)
					end
					if 0 < category_statistics[i].sub then
						if 0 < category_statistics[i].add then
							l_label.append_string ("   ")
						end
						l_label.append_character ('-')
						l_label.append_natural_32 (category_statistics[i].sub)
					end
					statistic_labels.item (i, 3).set_text (l_label)
					i := i + 1
				end

				widget.enable_sensitive
			end

			window.unlock_update
			grid.request_columns_auto_resizing
		end

feature {NONE} -- Events

	redraw_statistic_bars (a_x, a_y, a_width, a_height: INTEGER)
			-- Request status bar redraw
		do
			redraw_bars
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
			l_litem, l_ritem: like create_state_item
			l_row_id, l_pos, i: INTEGER
			l_row, l_subrow: detachable EV_GRID_ROW
		do
			l_litem := create_state_item (an_old_state)
			l_ritem := create_state_item (a_new_state)
			category_statistics.item (l_litem.row).prev := category_statistics.item (l_litem.row).prev + 1
			category_statistics.item (l_ritem.row).new := category_statistics.item (l_ritem.row).new + 1
			if l_litem.row = l_ritem.row then
				l_row_id := unchanged_id
				category_statistics.item (l_row_id).new := category_statistics.item (l_row_id).new + 1
			else
				l_row_id := l_ritem.row
				category_statistics.item (l_litem.row).sub := category_statistics.item (l_litem.row).sub + 1
				category_statistics.item (l_row_id).add := category_statistics.item (l_row_id).add + 1
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
			end
			l_row.insert_subrow (l_row.subrow_count + 1)
			l_subrow := l_row.subrow (l_row.subrow_count)
			if an_old_state /= Void then
				l_subrow.set_item (1, create_test_item (an_old_state.test_name))
			else
				l_subrow.set_item (1, create_test_item (a_new_state.test_name))
			end
			l_subrow.set_item (2, l_litem.grid_item)
			l_subrow.set_item (3, l_ritem.grid_item)
		end

	reset_grid
			-- Reset grid to only contain top level rows.
		local
			i: INTEGER
		do
			grid.remove_and_clear_all_rows
			rows.clear_all
			from
				i := 1
			until
				i > category_count
			loop
				category_statistics.put (create_statistics, i)
				i := i + 1
			end
		end

	print_formatted_test (a_test_suite: TEST_SUITE_S; a_name: READABLE_STRING_8)
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
				inspect
					i
				when fail_id then
					l_color := fail_color
				when pass_id then
					l_color := pass_color
				when unresolved_id then
					l_color := unresolved_color
				when untested_id then
					l_color := untested_color
				end
				draw_proportion (previous_bars.item (i), category_statistics[i].prev, l_max, l_color)
				draw_proportion (current_bars.item (i), category_statistics[i].new, l_max, l_color)
				i := i + 1
			end
		end

	draw_proportion (a_bar: EV_DRAWING_AREA; a_prop, a_max: NATURAL; a_color: EV_COLOR)
		local
			l_height, l_width, l_prop: INTEGER
		do
			l_height := a_bar.height
			l_width := a_bar.width
			a_bar.clear
			if a_max > 0 then
				l_prop := ((a_prop/a_max)*l_height).ceiling
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

	create_test_item (a_name: READABLE_STRING_8): EB_GRID_EDITOR_TOKEN_ITEM
			-- Create new grid item displaying test for given name
		require
			a_name_attached: a_name /= Void
		do
			create Result
			has_printed_test := False
			perform_with_test_suite (agent print_formatted_test (?, a_name))
			if not has_printed_test then
				token_writer.process_basic_text (a_name.as_string_32)
			end
			Result.set_text_with_tokens (token_writer.last_line.content)
			reset_token_writer
		end

	create_state_item (a_state: detachable TEST_STATE): TUPLE [grid_item: EV_GRID_ITEM; row: INTEGER]
			-- Create new grid item for given test state
		local
			l_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_row: INTEGER
		do
			create l_item
			if a_state /= Void then
				if a_state.is_tested then
					if a_state.is_pass then
						l_row := pass_id
						l_item.set_pixmap (stock_pixmaps.general_tick_icon)
					else
						token_writer.process_basic_text (a_state.tag.as_string_32)
						if a_state.is_fail then
							l_row := fail_id
							l_item.set_pixmap (stock_pixmaps.general_error_icon)
						else
							l_row := unresolved_id
							l_item.set_pixmap (stock_pixmaps.general_warning_icon)
						end
					end
				else
					l_row := untested_id
					token_writer.add_comment ("not tested")
				end
			else
				l_row := removed_id
				token_writer.add_comment ("unknown test")
			end
			l_item.set_text_with_tokens (token_writer.last_line.content)
			reset_token_writer
			Result := [l_item, l_row]
		end

	create_statistics: TUPLE [prev, new, sub, add: NATURAL]
			-- Default statistic tuple
			--
			-- prev: Total number of results previously in category
			-- new: Total number of result currently in category
			-- sub: Total number of tests which moved to different category
			-- add: Total number of tests which moved into category
		do
			Result := [{NATURAL_32} 0, {NATURAL_32} 0, {NATURAL_32} 0, {NATURAL_32} 0]
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

	bar_height: INTEGER = 100

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

invariant
	category_statistics_valid: category_statistics.count = statistic_count
	statistic_labels_valid: statistic_labels.width = 3 and statistic_labels.height = statistic_count
	previous_bars_valid: previous_bars.count = statistic_count
	current_bars_valid: current_bars.count = statistic_count

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
