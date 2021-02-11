note
	description: "Summary description for {EB_GRID_PREFERENCES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make (a_win_prefs: EB_DEVELOPMENT_WINDOW_PREFERENCES)
		do
			dev_window_preferences := a_win_prefs
			initialize
			update
		end

	initialize
		local
			prefs: like dev_window_preferences
			l_update_agent: PROCEDURE
		do
			prefs := dev_window_preferences
			l_update_agent := agent update
			prefs.grid_font_preference.change_actions.extend (l_update_agent)
			prefs.grid_foreground_color_preference.change_actions.extend (l_update_agent)
			prefs.grid_background_color_preference.change_actions.extend (l_update_agent)
			prefs.grid_focused_selection_text_color_preference.change_actions.extend (l_update_agent)
			prefs.grid_focused_selection_color_preference.change_actions.extend (l_update_agent)
			prefs.grid_non_focused_selection_text_color_preference.change_actions.extend (l_update_agent)
			prefs.grid_non_focused_selection_color_preference.change_actions.extend (l_update_agent)
			prefs.grid_separator_color_preference.change_actions.extend (l_update_agent)
			prefs.grid_tree_node_connector_color_preference.change_actions.extend (l_update_agent)
		end

feature -- Actions

	change_actions: ACTION_SEQUENCE
			-- Actions to be performed when value changes, after call to set_value.
		do
			Result := internal_change_actions
			if Result = Void then
				create Result
				internal_change_actions := Result
			end
		ensure
			result_attached: Result /= Void
		end

	internal_change_actions: detachable ACTION_SEQUENCE

feature -- Element change

	update
		local
			prefs: like dev_window_preferences
		do
			prefs := dev_window_preferences
			font := prefs.grid_font_preference.value
			foreground_color := prefs.grid_foreground_color_preference.value
			background_color := prefs.grid_background_color_preference.value
			focused_selection_text_color := prefs.grid_focused_selection_text_color_preference.value
			focused_selection_color := prefs.grid_focused_selection_color_preference.value
			non_focused_selection_text_color := prefs.grid_non_focused_selection_text_color_preference.value
			non_focused_selection_color := prefs.grid_non_focused_selection_color_preference.value
			separator_color := prefs.grid_separator_color_preference.value
			tree_node_connector_color := prefs.grid_tree_node_connector_color_preference.value

			change_actions.call
		end

	apply_to (g: EV_GRID)
		do
			g.set_background_color (background_color)
			g.set_foreground_color (foreground_color)
			g.set_focused_selection_color (focused_selection_color)
			g.set_non_focused_selection_color (non_focused_selection_color)
			g.set_focused_selection_text_color (focused_selection_text_color)
			g.set_non_focused_selection_text_color (non_focused_selection_text_color)
			g.set_separator_color (separator_color)
			g.set_tree_node_connector_color (tree_node_connector_color)

			g.set_row_height (line_height_with_zoom_factor)
		end

feature -- Access

	dev_window_preferences: EB_DEVELOPMENT_WINDOW_PREFERENCES

feature -- Fonts

	font: EV_FONT

	line_height: INTEGER
		do
			Result := font.line_height
		end

	font_with_zoom_factor: EV_FONT
		do
			Result := internal_font_with_zoom_factor
			if Result = Void then
				Result := font.twin
				internal_font_with_zoom_factor := Result
			end
		end

	line_height_with_zoom_factor: INTEGER
		do
			Result := font_with_zoom_factor.line_height
		end

	internal_font_with_zoom_factor: detachable like font_with_zoom_factor

	zoom_factor: INTEGER

	set_zoom_factor (zf: INTEGER)
		local
			h: INTEGER
			ft: EV_FONT
		do
			if zf /= zoom_factor then
				zoom_factor := zf

				h := font.height + zf
				ft := font_with_zoom_factor
				if h > 0 then
					ft.set_height (h)
				end
				change_actions.call
			end
		end

feature -- Colors	

	foreground_color: EV_COLOR

	background_color: EV_COLOR

	focused_selection_text_color: EV_COLOR

	focused_selection_color: EV_COLOR

	non_focused_selection_text_color: EV_COLOR

	non_focused_selection_color: EV_COLOR

	separator_color: EV_COLOR

	tree_node_connector_color: EV_COLOR

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
