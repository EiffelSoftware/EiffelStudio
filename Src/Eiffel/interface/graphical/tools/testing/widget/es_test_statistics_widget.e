note
	description: "[
		Widget displaying various AutoTest statistics.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_STATISTICS_WIDGET

inherit
	ES_WIDGET [EV_VERTICAL_BOX]
		rename
			make as make_widget
		redefine
			on_after_initialized
		end

	TEST_STATISTICS_OBSERVER
		redefine
			on_statistics_updated
		end

	ES_SHARED_TEST_SERVICE

create
	make

feature {NONE} -- Initialization

	make (a_tool: like tool)
			-- Initialize `Current'
			--
			-- `a_tool': Tool in which `Current' is shown.
		require
			a_tool_attached: a_tool /= Void
		do
			tool := a_tool
			make_widget
		end

	build_widget_interface (a_widget: like create_widget)
			-- <Precursor>
		do
			a_widget.set_padding (2)
			a_widget.set_border_width (1)
			build_label_bar (a_widget)
			build_status_bar (a_widget)
		end

	build_label_bar (a_widget: like create_widget)
			-- Initialize labels.
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_cell: EV_CELL
		do
			create l_hbox
			a_widget.extend (l_hbox)

			create l_cell
			l_hbox.extend (l_cell)

			create run_button.make
			run_button.set_pixel_buffer (stock_pixmaps.run_animation_5_icon_buffer)
			run_button.select_actions.extend (agent tool.set_test_tree_filter (run_filter))
			extend_button (l_hbox, run_button)

			create l_cell
			l_hbox.extend (l_cell)
			create l_cell
			l_hbox.extend (l_cell)

			create unresolved_button.make
			unresolved_button.set_pixel_buffer (stock_pixmaps.general_warning_icon_buffer)
			unresolved_button.select_actions.extend (agent tool.set_test_tree_filter (unresolved_filter))
			extend_button (l_hbox, unresolved_button)

			create l_cell
			l_hbox.extend (l_cell)
			create l_cell
			l_hbox.extend (l_cell)

			create fail_button.make
			fail_button.set_pixel_buffer (stock_pixmaps.general_error_icon_buffer)
			fail_button.select_actions.extend (agent tool.set_test_tree_filter (fail_filter))
			extend_button (l_hbox, fail_button)

			create l_cell
			l_hbox.extend (l_cell)
		end

	build_status_bar (a_widget: like create_widget)
			-- Initialize `status_bar' and add it to `widget'.
		local
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
		do
			create l_hbox
			a_widget.extend (l_hbox)

			extend_buffer (l_hbox, 10)

			create l_vbox
			l_vbox.set_border_width (1)
			l_vbox.set_padding (5)
			l_vbox.set_background_color (colors.stock_colors.grey)

			create status_bar
			status_bar.set_minimum_size (4, 10)
			status_bar.set_background_color (untested_color)
			l_vbox.extend (status_bar)
			l_hbox.extend (l_vbox)

			extend_buffer (l_hbox, 10)
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor

			register_action (status_bar.expose_actions, agent redraw_status_bar)
			register_action (status_bar.resize_actions, agent redraw_status_bar)
			register_action (status_bar.dpi_changed_actions, agent dpi_redraw_status_bar)

			perform_with_test_suite (
				agent (a_test_suite: TEST_SUITE_S)
					do
						a_test_suite.statistics.connection.connect_events (Current)
						on_statistics_updated (a_test_suite.statistics)
					end)
		end

feature {NONE} -- Access

	tool: ES_TESTING_TOOL_PANEL
			-- Tool in which `Current' is shown

	run_button: SD_TOOL_BAR_BUTTON
	unresolved_button: SD_TOOL_BAR_BUTTON
	fail_button: SD_TOOL_BAR_BUTTON
			-- Buttons displaying test counts

	status_bar: EV_DRAWING_AREA
			-- Status bar visualizing current percentage of passing/failing/unresolved tests

	test_count,
	executed_count,
	pass_count,
	fail_count,
	unresolved_count: NATURAL
			-- Number of tests in a certain category

feature {NONE} -- Implementation

	on_statistics_updated (a_stats: TEST_STATISTICS_I)
			-- <Precursor>
		do
			test_count := a_stats.test_count
			pass_count := a_stats.passing_test_count
			fail_count := a_stats.failing_test_count
			unresolved_count := a_stats.unresolved_test_count
			executed_count := a_stats.executed_test_count

			update_buttons
			status_bar.redraw
		end

	update_buttons
			-- Update labels on buttons.
		local
			l_text: STRING_32
		do
			create l_text.make (50)
			l_text.append (locale.translation (l_run_button))
			l_text.append (": ")
			l_text.append_natural_32 (executed_count)
			l_text.append_character ('/')
			l_text.append_natural_32 (test_count)
			run_button.set_text (l_text)
			if test_count = 0 then
				if run_button.is_sensitive then
					run_button.disable_sensitive
				end
			else
				if not run_button.is_sensitive then
					run_button.enable_sensitive
				end
			end
			run_button.tool_bar.compute_minimum_size

			create l_text.make (50)
			l_text.append (locale.translation (l_unresolved_button))
			l_text.append (": ")
			l_text.append_natural_32 (unresolved_count)
			unresolved_button.set_text (l_text)
			if unresolved_count = 0 then
				if unresolved_button.is_sensitive then
					unresolved_button.disable_sensitive
				end
			else
				if not unresolved_button.is_sensitive then
					unresolved_button.enable_sensitive
				end
			end
			unresolved_button.tool_bar.compute_minimum_size

			create l_text.make (50)
			l_text.append (locale.translation (l_fail_button))
			l_text.append (": ")
			l_text.append_natural_32 (fail_count)
			fail_button.set_text (l_text)
			if fail_count = 0 then
				if fail_button.is_sensitive then
					fail_button.disable_sensitive
				end
			else
				if not fail_button.is_sensitive then
					fail_button.enable_sensitive
				end
			end
			fail_button.tool_bar.compute_minimum_size
		end

	redraw_status_bar (a_x, a_y, a_width, a_height: INTEGER)
			-- Called when `status_bar' must be redrawn.
		local
			l_bar: like status_bar
			l_test_count: NATURAL
			l_position, l_total, i, l_width: INTEGER
			l_colors: ARRAY [EV_COLOR]
			l_widths: ARRAY [NATURAL]
		do
			l_bar := status_bar
			l_test_count := test_count
			if l_test_count > 0 then
				l_colors := << pass_color, unresolved_color, fail_color, untested_color >>
				l_widths := << pass_count, unresolved_count, fail_count, l_test_count - executed_count >>
				l_total := l_bar.width
				from
					i := l_widths.lower
				until
					i > l_widths.upper
				loop
						-- Using `ceiling' to make sure bar is filled up all the way
					l_width := ((l_widths.item (i) / l_test_count) * l_total).ceiling
					l_bar.set_foreground_color (l_colors.item (i))
					l_bar.fill_rectangle (l_position, 0, l_position + l_width, l_bar.height)

					l_position := l_position + l_width
					i := i + 1
				end
			else
				l_bar.clear
			end
		end

	dpi_redraw_status_bar (a_dpi: NATURAL_32; a_x, a_y, a_width, a_height: INTEGER)
			-- Called when `status_bar' must be redrawn.
		do
			redraw_status_bar (a_x, a_y, a_width, a_height)
		end

feature {NONE} -- Factory

	create_widget: EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

feature {NONE} -- Helpers

	extend_no_expand (a_box: EV_BOX; a_widget: EV_WIDGET)
			-- Extend given box with widget and disable expansion.
		do
			a_box.extend (a_widget)
			a_box.disable_item_expand (a_widget)
		end

	extend_button (a_box: EV_BOX; a_button: SD_TOOL_BAR_BUTTON)
			-- Extend given box with a tool bar containing a single button.
		local
			l_tool_bar: SD_TOOL_BAR
		do
			create l_tool_bar.make
			l_tool_bar.extend (a_button)
			l_tool_bar.compute_minimum_size
			extend_no_expand (a_box, l_tool_bar)
		end

	extend_buffer (a_box: EV_BOX; a_width: INTEGER)
			-- Extend given box with a cell of a fixed width.
		local
			l_cell: EV_CELL
		do
			create l_cell
			l_cell.set_minimum_width (a_width)
			a_box.extend (l_cell)
			a_box.disable_item_expand (l_cell)
		end

feature {NONE} -- Internationalization

	l_run_button: STRING = "Run"
	l_unresolved_button: STRING = "Unresolved"
	l_fail_button: STRING = "Fail"

	tt_runs_button: STRING = "Filter tests by their last result"
	tt_unresolved_button: STRING = "Show unresolved tests"
	tt_fail_button: STRING = "Show failing tests"

feature {NONE} -- Constants

	run_filter: STRING = "^result"
	unresolved_filter: STRING = "^result/unresolved"
	fail_filter: STRING = "^result/fail"

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
