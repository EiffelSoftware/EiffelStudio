note
	description: "[
		Editor token grid used in testing tool widgets.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_GRID

inherit
	ES_EDITOR_TOKEN_GRID
		redefine
			initialize
		end

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		local
			l_pnd: EB_EDITOR_TOKEN_GRID_SUPPORT
		do
			Precursor

			register_action (row_select_actions, agent on_select_row)
			register_action (row_deselect_actions, agent on_deselect_row)
			register_action (focus_in_actions, agent on_change_focus)
			register_action (focus_out_actions, agent on_change_focus)

				-- PND support
			create l_pnd.make_with_grid (Current)
			l_pnd.synchronize_scroll_behavior_with_editor
			l_pnd.enable_grid_item_pnd_support
			--l_pnd.enable_ctrl_right_click_to_open_new_window
			--l_pnd.set_context_menu_factory_function (agent (develop_window.menus).context_menu_factory)

			auto_recycle (l_pnd)
		end

feature {NONE} -- Events

	on_select_row (a_row: EV_GRID_ROW)
			-- Called when row is selected.
		do
			highlight_row (a_row)
		end

	on_deselect_row (a_row: EV_GRID_ROW)
			-- Called when row is deselected.
		do
			unhighlight_row (a_row)
		end

	highlight_row (a_row: EV_GRID_ROW)
			-- Make `a_row' look like it is fully selected.
		do
			if has_focus then
				a_row.set_background_color (focused_selection_color) --colors.grid_focus_selection_color)
			else
				a_row.set_background_color (non_focused_selection_color) --colors.grid_unfocus_selection_color)
			end
		end

	unhighlight_row (a_row: EV_GRID_ROW)
			-- Make `a_row' look like it is not selected.
		do
			a_row.set_background_color (background_color)
		end

	on_change_focus
			-- Make sure all selected rows have correct background color.
		do
			selected_rows.do_all (
				agent (a_row: EV_GRID_ROW)
					require
						a_row /= Void
					do
						highlight_row (a_row)
					end)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
