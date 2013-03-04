note
	description: "Debugger tooltip handler"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DEBUGER_TOOLTIP_HANDLER

inherit
	ANY

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

feature -- Events

	propagate_pointer_move (x: INTEGER; y: INTEGER; x_tilt: DOUBLE; y_tilt: DOUBLE; pressure: DOUBLE; screen_x: INTEGER; screen_y: INTEGER)
			-- Propagte pointer move event.
		local
			l_timer: like show_tooltip_timer
			l_delay: like show_tooltip_interval
		do
			if
				preferences.debug_tool_data.show_debug_tooltip and then
				attached debugger_manager as l_debug_manager and then
				l_debug_manager.safe_application_is_stopped
			then
				if attached expression_at (screen_x, screen_y) as l_e then
					l_delay := show_tooltip_interval
					if l_delay > 0 then
						l_timer := show_tooltip_timer
						if l_timer = Void then
							create l_timer
						end
							-- The pointer context might have been changed.
							-- Reschedule displaying tooltip when the tooltip has not been shown
							-- in previous scheduler.
						l_timer.set_interval (0)
						l_timer.actions.wipe_out
						l_timer.actions.extend_kamikaze (agent show_debug_tooltip (l_e))
						l_timer.set_interval (l_delay)
					else
						show_debug_tooltip (l_e)
					end
				else
					stop_debug_tooltip_timer
					if attached debug_tooltip as l_tooltip and then l_tooltip.is_shown then
						l_tooltip.hide
						last_expression := Void
					end
				end
			else
				stop_debug_tooltip_timer
				if attached debug_tooltip as l_tooltip and then l_tooltip.is_shown then
					l_tooltip.hide
					last_expression := Void
				end
			end
		end

	propagate_move (x, y, width, height, a_old_x, a_old_y: INTEGER)
			-- Propagate move
			-- Arguments are positions from the parent window
		do
			if attached debug_tooltip as l_tooltip and then l_tooltip.is_shown then
				l_tooltip.popup_window.set_position (l_tooltip.popup_window.screen_x + x - a_old_x, l_tooltip.popup_window.screen_y + y - a_old_y)
			end
		end

feature -- Action

	hide_tooltip
			-- Hide the tooltip
		do
			if attached debug_tooltip as l_tooltip and then l_tooltip.is_shown then
				l_tooltip.hide
				last_expression := Void
			end
		end

feature -- Status Change

	set_expression_callback (a_c: like expression_callback)
			-- Set `expression_callback' with `a_c'.
		do
			expression_callback := a_c
		ensure
			expression_callback_set: expression_callback = a_c
		end

feature {NONE} -- Implementation

	show_debug_tooltip (a_expr: READABLE_STRING_GENERAL)
			-- Show debug tooltip
		require
			a_expr_attached: a_expr /= Void
			a_expr_not_void: not a_expr.is_empty
		local
			l_tooltip_window: like debug_tooltip
			l_object_grid: like object_grid
			l_dbg_expr: DBG_EXPRESSION
			l_dbg_eval: DBG_EXPRESSION_EVALUATION
			l_line: ES_OBJECTS_GRID_EXPRESSION_LINE
			l_e: STRING_32
			l_rec: EV_RECTANGLE
			l_screen: EV_SCREEN
			l_pointer: EV_COORDINATE
			l_row: EV_GRID_ROW
		do
			create l_screen
			l_pointer := l_screen.pointer_position
				-- Ensure expression has not been changed under the mouse pointer.
			if attached expression_at (l_pointer.x, l_pointer.y) as l_expr and then l_expr.same_string (a_expr) then
				if last_expression /= a_expr or else not attached debug_tooltip as l_tooltip or else not l_tooltip.is_shown then
					l_tooltip_window := debug_tooltip
					if l_tooltip_window = Void then
						create l_tooltip_window.make
						l_tooltip_window.set_hide_timeout (3_000)
						debug_tooltip := l_tooltip_window
					end

					l_object_grid := object_grid
					if l_object_grid = Void then
						l_object_grid := create_object_grid
						l_tooltip_window.set_popup_widget (l_object_grid)
						object_grid := l_object_grid
					end
					l_object_grid.wipe_out
					l_object_grid.set_default_columns_layout (<<
								[l_object_grid.col_name_id, True, False, 150, interface_names.l_Expression, interface_names.to_expression],
								[l_object_grid.col_value_id, True, False, 150, interface_names.l_value, interface_names.to_value],
								[l_object_grid.col_type_id, True, False, 100, interface_names.l_type, interface_names.to_type],
								[l_object_grid.col_address_id, True, False, 80, interface_names.l_address, interface_names.to_address],
								[l_object_grid.col_scoop_pid_id, True, False,   30, interface_names.l_scoop_pid, interface_names.to_scoop_pid],
								[l_object_grid.col_context_id, True, False, 200, interface_names.l_Context, interface_names.to_context]
							>>
						)
					l_object_grid.set_columns_layout (1, l_object_grid.default_columns_layout)

					create l_e.make_from_string_general (a_expr)
					l_e.replace_substring_all ("%N", " ")
					l_e.replace_substring_all ("%R", " ")
					create l_dbg_expr.make_with_context (l_e)
					create l_dbg_eval.make (l_dbg_expr)
					if not l_dbg_eval.evaluated then
						l_dbg_eval.side_effect_forbidden := True
						l_dbg_eval.evaluate
					end
					create l_line.make_with_expression_evaluation (l_dbg_eval, l_object_grid)
					l_row := l_object_grid.extended_new_row
					l_line.attach_to_row (l_row)
					l_line.request_refresh
					on_grid_size_changed (Void)

					create l_rec.make (l_pointer.x, l_pointer.y, 0, 0)
					l_tooltip_window.show_on_side (l_rec, 0, 0)
					last_expression := a_expr
				end
			end
		end

	create_object_grid: ES_OBJECTS_GRID
			-- Create object grid
		do
			create Result.make_with_name ("", "")
			Result.row_expand_actions.extend (agent on_grid_size_changed)
			Result.row_collapse_actions.extend (agent on_grid_size_changed)
			Result.disable_vertical_overscroll

			open_viewer_shortcut 		:= preferences.debug_tool_data.new_open_viewer_shortcut
			goto_home_shortcut 			:= preferences.debug_tool_data.new_goto_home_shortcut
			goto_end_shortcut 			:= preferences.debug_tool_data.new_goto_end_shortcut

			Result.register_shortcut (open_viewer_shortcut, agent
				do
					if
						attached {EB_DEBUGGER_MANAGER} debugger_manager as l_manager and then attached l_manager.object_viewer_cmd as l_cmd and then
						attached object_grid as g and then g.selected_rows.count > 0
					then
						if attached {OBJECT_STONE} g.grid_pebble_from_row_and_column (g.selected_rows.first, Void) as ost then
							l_cmd.set_stone (ost)
							hide_tooltip
						end
					end
				end)
			Result.register_shortcut (goto_home_shortcut, agent
				local
					g: like object_grid
				do
					g := object_grid
					g.set_virtual_position (g.virtual_x_position, 0)
				end)
			Result.register_shortcut (goto_end_shortcut,  agent
				local
					g: like object_grid
				do
					g := object_grid
					g.set_virtual_position (g.virtual_x_position, g.maximum_virtual_y_position)
				end)
		ensure
			Result_not_void: Result /= Void
		end

	stop_debug_tooltip_timer
			-- Destroy the debug tooltip timer
		do
			if attached show_tooltip_timer as l_timer then
				l_timer.set_interval (0)
				l_timer.actions.wipe_out
			end
		end

	on_grid_size_changed (a_row: detachable EV_GRID_ROW)
			-- Call when the size of grid is changed
		local
			l_screen: EV_SCREEN
			l_width, l_height: INTEGER
			l_required_width: INTEGER
			i: INTEGER
			l_grid_width: INTEGER
		do
			if attached object_grid as l_grid then
				l_grid.handle_project_specific_columns
				from
					i := 1
				until
					i > l_grid.column_count
				loop
					if l_grid.column (i).is_show_requested then
						l_required_width := l_grid.column (i).required_width_of_item_span (1, l_grid.row_count).min (max_column_width) + {ES_UI_CONSTANTS}.grid_item_spacing * 2
						l_grid.column (i).set_width (l_required_width)
						l_grid_width := l_grid_width + l_required_width
					end
					i := i + 1
				end
				create l_screen
				l_width := l_grid_width
				if l_grid.row_count > 0 and then not l_grid.row (1).is_expanded then
					l_height := l_grid.row_height
				else
					l_height := l_grid.virtual_height.min (l_screen.height - l_grid.screen_y.max (0))
					if l_grid.is_horizontal_scroll_bar_show_requested and then l_grid.is_vertical_scroll_bar_show_requested then
						l_width := l_width + l_grid.vertical_scroll_bar.width
					end
				end
				if l_grid.is_header_displayed then
					l_height := l_height + l_grid.header.height
				end
				l_grid.set_minimum_size (l_width, l_height)
				if attached debug_tooltip as l_tooltip then
					l_tooltip.popup_window.set_size (1, 1)
				end
			end
		end

	expression_at (a_x, a_y: INTEGER): detachable READABLE_STRING_GENERAL
			-- Expression at position
			-- `a_x', `a_y' are screen positions.
		do
			if attached expression_callback as l_c then
				Result := l_c.item ([a_x, a_y])
			end
		ensure
			Result_not_empty: attached Result as l_res implies not l_res.is_empty
		end

	expression_callback: detachable FUNCTION [ANY, TUPLE [INTEGER, INTEGER], detachable READABLE_STRING_GENERAL]
			-- Callback to query expression
			-- Arguments are screen positions

	debug_tooltip: detachable ES_SMART_TOOLTIP_WINDOW
			-- Debug tooktip

	object_grid: detachable ES_OBJECTS_GRID
			-- Object grid

	show_tooltip_timer: detachable EV_TIMEOUT
			-- Timer to show debug tooltip

	show_tooltip_interval: INTEGER
			-- Wait a bit to show the tooltip
		do
			Result := preferences.debug_tool_data.show_debug_tooltip_delay
		end

	max_column_width: INTEGER = 200
			-- Max width of a column in the debugger tooltip grid.

	last_expression: detachable READABLE_STRING_GENERAL;
			-- Last expression analyzed for the debugger

feature {NONE} -- Shortcuts

	open_viewer_shortcut,
	goto_home_shortcut,
	goto_end_shortcut: ES_KEY_SHORTCUT;

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
