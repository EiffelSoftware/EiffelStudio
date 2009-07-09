note
	description: "Summary description for {ES_TAG_TREE_GRID}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TAG_TREE_GRID [G -> TAG_ITEM]

inherit
	TAG_TREE_GRID [G]
		rename
			make as make_grid
		redefine
			widget,
			grid,
			initialize,
			initialize_layout,
			on_select_row,
			on_deselect_row,
			layout
		end

	ES_WINDOW_WIDGET [EV_VERTICAL_BOX]
		rename
			make as make_window_widget
		redefine
			widget
		end

	ES_SHARED_FONTS_AND_COLORS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_development_window: like develop_window; a_filter: like filter; a_layout: like layout)
			-- Initialize `Current'.
			--
			-- `a_development_window': Development window in which `Current' will be shown.
			-- `a_filter': Filter determining `root_nodes'.
			-- `a_layout': Layout specifying items in grid.
		do
			make_grid (a_filter, a_layout)
			make_window_widget (a_development_window)
		end

	initialize
			-- <Precursor>
		do
			grid := create_grid
		end

	build_widget_interface (a_widget: like widget)
			-- <Precursor>
		local
			l_grid: like grid
			l_colors: like colors
			l_pnd: EB_EDITOR_TOKEN_GRID_SUPPORT
		do
			l_grid := grid
			l_colors := colors

				-- Operational
			l_grid.enable_tree
			l_grid.enable_single_row_selection
			l_grid.enable_partial_dynamic_content

				-- Events
			register_action (l_grid.row_expand_actions, agent on_row_expand)
			register_action (l_grid.row_collapse_actions, agent on_row_collapse)
			register_action (l_grid.row_select_actions, agent on_select_row)
			register_action (l_grid.row_deselect_actions, agent on_deselect_row)
			register_action (l_grid.focus_in_actions, agent on_change_focus)
			register_action (l_grid.focus_out_actions, agent on_change_focus)
			l_grid.set_dynamic_content_function (agent computed_grid_item)

				-- Appearance
			l_grid.hide_tree_node_connectors
			l_grid.set_focused_selection_color (l_colors.grid_focus_selection_color)
			l_grid.set_focused_selection_text_color (l_colors.grid_focus_selection_text_color)
			l_grid.set_non_focused_selection_color (l_colors.grid_unfocus_selection_color)
			l_grid.set_non_focused_selection_text_color (l_colors.grid_unfocus_selection_text_color)

				-- PND support
			create l_pnd.make_with_grid (l_grid)
			l_pnd.synchronize_scroll_behavior_with_editor
			l_pnd.enable_grid_item_pnd_support
			l_pnd.enable_ctrl_right_click_to_open_new_window
			l_pnd.set_context_menu_factory_function (agent (develop_window.menus).context_menu_factory)

			auto_recycle (l_pnd)

			a_widget.set_border_width (1)
			a_widget.set_background_color (l_colors.stock_colors.gray)
			a_widget.extend (l_grid)
		end

	initialize_layout
			-- <Precursor>
		local
			l_auto_size_column: INTEGER
		do
			Precursor
			l_auto_size_column := layout.auto_size_column

			if l_auto_size_column > 0 then
				grid.enable_auto_size_best_fit_column (l_auto_size_column)
			end
		end

feature -- Access

	widget: EV_VERTICAL_BOX
			-- <Precursor>

feature {NONE} -- Access

	grid: ES_GRID
			-- <Precursor>

	layout: ES_TAG_TREE_GRID_LAYOUT [G]
			-- <Precursor>

feature {NONE} -- Events: grid

	on_select_row (a_row: EV_GRID_ROW)
			-- Called when row is selected.
		do
			Precursor (a_row)
			highlight_row (a_row)
		end

	on_deselect_row (a_row: EV_GRID_ROW)
			-- Called when row is deselected.
		do
			Precursor (a_row)
			unhighlight_row (a_row)
		end

	highlight_row (a_row: EV_GRID_ROW)
			-- Make `a_row' look like it is fully selected.
		do
			if grid.has_focus then
				a_row.set_background_color (colors.grid_focus_selection_color)
			else
				a_row.set_background_color (colors.grid_unfocus_selection_color)
			end
		end

	unhighlight_row (a_row: EV_GRID_ROW)
			-- Make `a_row' look like it is not selected.
		do
			a_row.set_background_color (grid.background_color)
		end

	on_change_focus
			-- Make sure all selected rows have correct background color.
		do
			grid.selected_rows.do_all (
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
