note
	description: "Debugger tooltip handler"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DEBUGER_TOOLTIP_HANDLER

inherit
	ANY

	ES_TOOLTIP_HANDLER
		redefine
			show_tooltip_possible,
			show_tooltip,
			hide_tooltip
		end

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

feature -- Action

	hide_tooltip
			-- Hide the tooltip
		do
			Precursor {ES_TOOLTIP_HANDLER}
			last_expression := Void
		end

feature -- Query

	show_tooltip_possible (a_token: detachable EDITOR_TOKEN): BOOLEAN
			-- Is it possible to show tooltip?
		do
			Result :=
				preferences.debug_tool_data.show_debug_tooltip and then
				attached debugger_manager as l_debug_manager and then
				l_debug_manager.safe_application_is_stopped and then
				a_token /= Void and then
				attached {READABLE_STRING_GENERAL} a_token.data as l_e and then not l_e.is_empty
		end

feature {NONE} -- Implementation

	show_tooltip (a_token: EDITOR_TOKEN)
			-- Show debug tooltip
		local
			l_tooltip_window: like tooltip
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
			if attached {READABLE_STRING_GENERAL} a_token.data as l_expr then
				if last_expression /= l_expr or else not attached tooltip as l_tooltip or else not l_tooltip.is_shown then
					l_tooltip_window := tooltip
					l_object_grid := object_grid
					if l_object_grid = Void then
						l_object_grid := create_object_grid
						l_tooltip_window.set_popup_widget (l_object_grid)
						l_tooltip_window.popup_window.hide_actions.extend (
							agent
							do
								if
									attached object_grid as l_object_grid and then
									attached l_object_grid.activated_item as l_item
								then
									l_item.deactivate
								end
							end
						)
						setup_pointer_actions (l_object_grid)
						object_grid := l_object_grid
					end
					l_object_grid.wipe_out

					create l_e.make_from_string_general (l_expr)
					l_e.replace_substring_all ("%N", " ")
					l_e.replace_substring_all ("%R", " ")
					create l_dbg_expr.make_with_context (l_e)
					create l_dbg_eval.make (l_dbg_expr)
					if not l_dbg_eval.evaluated then
						l_dbg_eval.side_effect_forbidden := not preferences.debug_tool_data.always_evaluate_potential_side_effect_expression
						l_dbg_eval.evaluate
					end
					create l_line.make_with_expression_evaluation (l_dbg_eval, l_object_grid)
					last_expression_line := l_line
					l_row := l_object_grid.extended_new_row
					l_line.attach_to_row (l_row)
					l_line.request_refresh
					on_grid_size_changed (Void)

					if attached show_position_callback as l_c and then attached l_c.item ([l_pointer.x, l_pointer.y]) as l_p then
						create l_rec.make (l_p.x, l_p.y, 0, 0)
					else
						create l_rec.make (l_pointer.x, l_pointer.y, 0, 0)
					end

					l_tooltip_window.show_on_side (l_rec, 0, 0)
					last_expression := l_expr
				end
			end
		end

	pre_activate_cell (ei: EV_GRID_ITEM)
			-- Process special operation before cell `ei' get activated
		do
			if attached {EB_DEBUGGER_MANAGER} debugger_manager as l_mnger and then attached l_mnger.object_viewer_cmd as l_viewer_cmd then
				if attached {ES_OBJECTS_GRID_VALUE_CELL} ei as evi and then evi.is_parented and then evi.row /= Void then
					if evi.is_for_high_potential_effect_value then
						evi.set_button_action (agent ev_application.do_once_on_idle (
							agent
							do
								if attached last_expression_line as l_line then
									l_line.request_reevaluate_expression_allowing_side_effect
									last_expression_line := Void
								end
							end
						))
					else
						if attached {ES_OBJECTS_GRID} ei.parent as p then
							if attached {OBJECT_STONE} p.grid_pebble_from_cell (evi) as ost and then l_viewer_cmd.accepts_stone (ost) then
								evi.set_button_action (agent (a_viewer_cmd: EB_OBJECT_VIEWER_COMMAND; a_stone: OBJECT_STONE)
									require
										a_viewer_cmd_set: a_viewer_cmd /= Void
										a_stone_set: a_stone /= Void
									do
										a_viewer_cmd.set_stone (a_stone)
										hide_tooltip
									end (l_viewer_cmd, ost))
							end
						end
					end
				end
			end
		end

	create_object_grid: ES_OBJECTS_GRID
			-- Create object grid
		local
			l_expand_action: PROCEDURE [EV_GRID_ROW]
		do
			create Result.make_with_name ("", "")
				-- Do it on idle to ensure that the expansion actions on rows
				-- has been called to give correct required height.
			l_expand_action := agent (r: EV_GRID_ROW)
				do ev_application.do_once_on_idle (agent on_grid_size_changed (r)) end
			Result.row_expand_actions.extend (l_expand_action)
			Result.row_collapse_actions.extend (l_expand_action)
			Result.disable_vertical_overscroll
			Result.hide_header
			Result.set_pre_activation_action (agent pre_activate_cell)

			open_viewer_shortcut 		:= preferences.debug_tool_data.new_open_viewer_shortcut
			goto_home_shortcut 			:= preferences.debug_tool_data.new_goto_home_shortcut
			goto_end_shortcut 			:= preferences.debug_tool_data.new_goto_end_shortcut

			Result.register_shortcut (open_viewer_shortcut, agent
				do
					if
						attached {EB_DEBUGGER_MANAGER} debugger_manager as l_manager and then attached l_manager.object_viewer_cmd as l_cmd and then
						attached object_grid as g and then g.has_selected_row
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
				end
				if l_grid.is_horizontal_scroll_bar_show_requested and then l_grid.is_vertical_scroll_bar_show_requested then
					l_width := l_width + l_grid.vertical_scroll_bar.width
				end
				if l_grid.is_header_displayed then
					l_height := l_height + l_grid.header.height
				end
				l_grid.set_minimum_size (l_width, l_height)
				if attached tooltip as l_tooltip then
					l_tooltip.popup_window.set_size (1, 1)
				end
			end
		end

	object_grid: detachable ES_OBJECTS_GRID
			-- Object grid

	max_column_width: INTEGER = 200
			-- Max width of a column in the debugger tooltip grid.

	last_expression: detachable READABLE_STRING_GENERAL;
			-- Last expression analyzed for the debugger

	last_expression_line: detachable ES_OBJECTS_GRID_EXPRESSION_LINE
			-- Last expression line

feature {NONE} -- Shortcuts

	open_viewer_shortcut,
	goto_home_shortcut,
	goto_end_shortcut: ES_KEY_SHORTCUT;

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
