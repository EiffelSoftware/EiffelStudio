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
			on_before_initialize
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
			create rows.make_filled (Void, 1, row_count)
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
			l_vbox: EV_VERTICAL_BOX
			l_frame: EV_FRAME
		do
			create l_vbox
			l_vbox.set_border_width (3)

			create l_frame.make_with_text ("Statistics")
			l_frame.set_minimum_width (300)
			l_vbox.extend (l_frame)

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
			grid.enable_last_column_use_all_width
			grid.header.i_th (1).set_text (locale.translation (h_test))
			grid.header.i_th (2).set_text (locale.translation (h_old_result))
			grid.header.i_th (3).set_text (locale.translation (h_new_result))
			grid.enable_tree
			grid.hide_tree_node_connectors
			grid.enable_single_row_selection

			create l_vbox
			l_vbox.set_border_width (1)
			l_vbox.set_background_color (colors.stock_colors.gray)
			l_vbox.extend (grid)
			a_widget.extend (l_vbox)
		end

feature {NONE} -- Access

	grid: ES_TESTING_TOOL_GRID
			-- Grid used to compare different test suite states

	rows: ARRAY [detachable EV_GRID_ROW]

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
		do
			reset_grid
			grid.lock_update

			create l_serializer
			l_serializer.deserialize_from_file (a_file_name)
			l_old := l_serializer.last_result
			l_serializer.serialize_test_suite
			l_new := l_serializer.last_result
			if l_old = Void then

			elseif l_new = Void then

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
			end
			grid.unlock_update
			grid.request_columns_auto_resizing
		end

feature {NONE} -- Implementation

	append_state (an_old_state, a_new_state: detachable TEST_STATE)
			-- Append given states to `grid'.
		require
			rows_valid: rows.count = row_count
			one_state_attached: an_old_state /= Void or a_new_state /= Void
			both_attached_implies_equal: (an_old_state /= Void and a_new_state /= Void) implies
			                             an_old_state.test_name.same_string (a_new_state.test_name)
		local
			l_litem, l_ritem: like create_state_item
			l_row_id, l_pos, i: INTEGER
			l_row, l_subrow: detachable EV_GRID_ROW
			l_item: EV_GRID_SPAN_LABEL_ITEM
			l_font: EV_FONT
		do
			l_litem := create_state_item (an_old_state)
			l_ritem := create_state_item (a_new_state)
			if l_litem.row = l_ritem.row then
				l_row_id := unchanged_row
			else
				l_row_id := l_ritem.row
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
				create l_item.make_master (1)
				create l_font
				l_font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
				l_item.set_font (l_font)
				inspect
					l_row_id
				when fail_row then
					l_item.set_text (locale.translation (t_fail_row))
				when pass_row then
					l_item.set_text (locale.translation (t_pass_row))
				when unresolved_row then
					l_item.set_text (locale.translation (t_unresolved_row))
				when untested_row then
					l_item.set_text (locale.translation (t_untested_row))
				when unchanged_row then
					l_item.set_text (locale.translation (t_unchanged_row))
				when removed_row then
					l_item.set_text (locale.translation (t_removed_row))
				end
				l_row.set_item (1, l_item)
				create l_item.make_span (1)
				l_row.set_item (2, l_item)
				create l_item.make_span (1)
				l_row.set_item (3, l_item)
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
		do
			grid.remove_and_clear_all_rows
			rows.clear_all
		end

	print_formatted_test (a_test_suite: TEST_SUITE_S; a_name: READABLE_STRING_8)
			-- Print formatted version of test to token writer
		do
			if a_test_suite.has_test (a_name) then
				has_printed_test := True
				a_test_suite.test (a_name).print_test (token_writer)
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
						l_row := pass_row
						l_item.set_pixmap (stock_pixmaps.general_tick_icon)
					else
						token_writer.process_basic_text (a_state.tag.as_string_32)
						if a_state.is_fail then
							l_row := fail_row
							l_item.set_pixmap (stock_pixmaps.general_error_icon)
						else
							l_row := unresolved_row
							l_item.set_pixmap (stock_pixmaps.general_warning_icon)
						end
					end
				else
					l_row := untested_row
					token_writer.process_basic_text ("not tested")
				end
			else
				l_row := removed_row
				token_writer.process_basic_text ("unknown test")
			end
			l_item.set_text_with_tokens (token_writer.last_line.content)
			reset_token_writer
			Result := [l_item, l_row]
		end

feature {NONE} -- Constants

	fail_row: INTEGER = 1
	pass_row: INTEGER = 2
	unresolved_row: INTEGER = 3
	untested_row: INTEGER = 4
	unchanged_row: INTEGER = 5
	removed_row: INTEGER = 6
			-- Row index for different categories

	row_count: INTEGER = 6
			-- Number of parent rows

feature {NONE} -- Internationalization

	h_test: STRING = "Test"
	h_old_result: STRING = "Old Result"
	h_new_result: STRING = "Current Result"

	t_fail_row: STRING = "Fail"
	t_pass_row: STRING = "Pass"
	t_unresolved_row: STRING = "Unresolved"
	t_untested_row: STRING = "Not Tested"
	t_unchanged_row: STRING = "Unchanged"
	t_removed_row: STRING = "Removed"

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
