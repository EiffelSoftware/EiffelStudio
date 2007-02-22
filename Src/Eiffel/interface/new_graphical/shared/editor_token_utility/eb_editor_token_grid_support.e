indexing
	description: "[
					Supports for editor token grid.
					Functonalites:
						1. Scroll behaviour synchronization with preferences.
						2. Editor token font and color synchronization with preferences.
						3. Grid odd/even row background color synchronization with preferences.
						4. Pick and drop
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR_TOKEN_GRID_SUPPORT

inherit
	SHARED_EDITOR_DATA

	EB_SHARED_PREFERENCES

	EVS_GRID_UTILITY

	EV_SHARED_APPLICATION

	EVS_GRID_PND_SUPPORT
		redefine
			enable_grid_item_pnd_support
		end

create
	make_with_grid

feature -- Access

	color_or_font_change_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performed when color or font in editor changes
		do
			if color_or_font_change_actions_internal = Void then
				create color_or_font_change_actions_internal
			end
			Result := color_or_font_change_actions_internal
		ensure
			result_attached: Result /= Void
		end

	stone_and_index_at_position (a_x, a_y: INTEGER): like stone_and_index_from_editor_token_item is
			-- Stone of editor token and its index at position (`a_x', `a_y') which is related to the top-left coordinate of `grid'
			-- Void if no item is found or that item contains no stone.			
		local
			l_editor_token_item: EB_GRID_EDITOR_TOKEN_ITEM
		do
			l_editor_token_item ?= grid_item_at_position (grid, a_x, a_y)
			if l_editor_token_item /= Void then
				Result := stone_and_index_from_editor_token_item (l_editor_token_item)
			end
		ensure
			good_result: Result /= Void implies (Result.stone /= Void and then Result.index > 0)
		end

	stone_and_index_from_editor_token_item (a_item: EB_GRID_EDITOR_TOKEN_ITEM): TUPLE [stone: STONE; index: INTEGER] is
			-- Stone and its editor token index from `a_item'
		local
			l_index: INTEGER
			l_stone: STONE
		do
			l_index := a_item.token_index_at_current_position
			if l_index > 0 then
				l_stone ?= a_item.editor_token_pebble (l_index)
				if l_stone /= Void then
					Result := [l_stone, l_index]
				end
			end
		ensure
			good_result: Result /= Void implies (Result.stone /= Void and then Result.index > 0)
		end

feature -- Pick and drop support for grid items

	on_pick_start_from_grid_pickable_item (a_item: EV_GRID_ITEM; a_grid_support: EB_EDITOR_TOKEN_GRID_SUPPORT) is
			-- Action performed when pick on `a_item'.
			-- `a_grid_support' is responsible for managing pick and drop for `a_item'.
		require
			a_grid_support_attached: a_grid_support /= Void
		local
			l_item: ES_GRID_PICKABLE_ITEM
			l_grid: EV_GRID
			l_stone: STONE
		do
			if a_item /= Void and then a_item.is_parented and then not ev_application.ctrl_pressed then
				l_item ?= a_item
				if l_item /= Void and then l_item.grid_item.is_parented then
					l_stone ?= l_item.on_pick
					if l_stone /= Void then
						l_grid := l_item.grid_item.parent
						set_last_picked_item (l_item.grid_item)
						set_last_pebble (l_stone)
						a_grid_support.set_last_pebble (l_stone)
						l_grid.remove_selection
						l_grid.set_accept_cursor (l_stone.stone_cursor)
						l_grid.set_deny_cursor (l_stone.x_stone_cursor)
						l_item.grid_item.redraw
					end
				end
			end
		end

	on_pick_ended_from_grid_pickable_item (a_item: EV_GRID_ITEM) is
			-- Action performed when pick ends
		local
			l_item: ES_GRID_PICKABLE_ITEM
			l_grid_item: EV_GRID_ITEM
		do
			l_item ?= a_item
			if l_item /= Void then
				l_item.on_pick_ends
				l_grid_item := l_item.grid_item
				if l_grid_item.is_parented and then l_grid_item.is_selectable then
					l_grid_item.enable_select
				end
				if l_grid_item.is_parented then
					l_grid_item.redraw
				end
			end
		end

feature -- Setting

	synchronize_scroll_behavior_with_editor is
			-- Sychronize scroll behavior with editor.
		local
			l_change_agent: like on_scroll_behavior_change_agent
		do
			l_change_agent := on_scroll_behavior_change_agent
			on_scroll_behavior_change
			editor_preferences.mouse_wheel_scroll_full_page_preference.change_actions.extend (l_change_agent)
			editor_preferences.mouse_wheel_scroll_size_preference.change_actions.extend (l_change_agent)
			editor_preferences.scrolling_common_line_count_preference.change_actions.extend (l_change_agent)
		end

	desynchronize_scroll_behavior_with_editor is
			-- Desychronize scroll behavior with editor.
			-- Note: Make sure that this feature gets called after use, otherwise memory leak may occur.
		local
			l_change_agent: like on_scroll_behavior_change_agent
		do
			l_change_agent := on_scroll_behavior_change_agent
			editor_preferences.mouse_wheel_scroll_full_page_preference.change_actions.prune_all (l_change_agent)
			editor_preferences.mouse_wheel_scroll_size_preference.change_actions.prune_all (l_change_agent)
			editor_preferences.scrolling_common_line_count_preference.change_actions.prune_all (l_change_agent)
		end

	synchronize_color_or_font_change_with_editor is
			-- Synchronize color or font with editor.
		local
			l_change_agent: like on_color_or_font_change_agent
			l_list: ARRAYED_LIST [ACTION_SEQUENCE [TUPLE]]
		do
			l_change_agent := on_color_or_font_change_agent
			create l_list.make (6)
			l_list.extend (editor_preferences.keyword_font_preference.change_actions)
			l_list.extend (editor_preferences.keyword_text_color_preference.change_actions)
			l_list.extend (editor_preferences.normal_text_color_preference.change_actions)
			l_list.extend (editor_preferences.editor_font_preference.change_actions)
			l_list.extend (preferences.class_browser_data.odd_row_background_color_preference.change_actions)
			l_list.extend (preferences.class_browser_data.even_row_background_color_preference.change_actions)
			from
				l_list.start
			until
				l_list.after
			loop
				if not l_list.item.has (l_change_agent) then
					l_list.item.extend (l_change_agent)
				end
				l_list.forth
			end
		end

	desynchronize_color_or_font_change_with_editor is
			-- Desychronize color or font change with editor.
			-- Note: Make sure that this feature gets called after use, otherwise memory leak may occur.
		local
			l_change_agent: like on_color_or_font_change_agent
		do
			l_change_agent := on_color_or_font_change_agent
			editor_preferences.keyword_font_preference.change_actions.prune_all (l_change_agent)
			editor_preferences.keyword_text_color_preference.change_actions.prune_all (l_change_agent)
			editor_preferences.normal_text_color_preference.change_actions.prune_all (l_change_agent)
			editor_preferences.editor_font_preference.change_actions.prune_all (l_change_agent)
			preferences.class_browser_data.odd_row_background_color_preference.change_actions.prune_all (l_change_agent)
			preferences.class_browser_data.even_row_background_color_preference.change_actions.prune_all (l_change_agent)
		end

	enable_ctrl_right_click_to_open_new_window is
			-- Enable that Ctrl+Right click will open a new development window to display stone conatined in current pointer hovered editor token.
		do
			if not grid.pointer_button_press_actions.has (on_pointer_right_click_agent) then
				grid.pointer_button_press_actions.extend (on_pointer_right_click_agent)
			end
		end

	disable_ctrl_right_click_to_open_new_window is
			-- Disable that Ctrl+Right click will open a new development window to display stone conatined in current pointer hovered editor token.
		do
			grid.pointer_button_press_actions.prune_all (on_pointer_right_click_agent)
		end

	enable_grid_item_pnd_support is
			-- Enable pick and drop on individual editor token.
			-- This will overwrite the currently set `item_pebble_function'.
			-- Actions in `pick_start_actions' will be invoked when pick starts and
			-- actions in `pick_end_actions' will be invoked when pick ends.
		do
			Precursor
			pick_start_actions.extend (agent on_pick_start_from_grid_pickable_item (?, Current))
			pick_end_actions.extend (agent on_pick_ended_from_grid_pickable_item)
		end

feature{NONE} -- Actions

	on_color_or_font_change is
			-- Action to be performed when color or font in editor changes
		do
			if not color_or_font_change_actions.is_empty then
				color_or_font_change_actions.call (Void)
			end
		end

	on_scroll_behavior_change is
			-- Action to be performed when scroll behavior changes
		do
			grid.scrolling_behavior.set_mouse_wheel_scroll_full_page (editor_preferences.mouse_wheel_scroll_full_page)
			grid.scrolling_behavior.set_mouse_wheel_scroll_size (editor_preferences.mouse_wheel_scroll_size)
			grid.scrolling_behavior.set_scrolling_common_line_count (editor_preferences.scrolling_common_line_count)
		end

	on_pointer_right_click (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Action to be performed when pointer right click on `grid'
			-- Behavior is launch the stone contained in pointer hovered editor token in a new development window.
		local
			l_data: like stone_and_index_at_position
			l_stone: STONE
		do
			if a_button = {EV_POINTER_CONSTANTS}.right and then ev_application.ctrl_pressed then
				l_data := stone_and_index_at_position (a_x, a_y)
				if l_data /= Void then
					l_stone := l_data.stone
					if l_stone.is_valid then
						if l_stone /= Void and then l_stone.is_valid then
							(create {EB_CONTROL_PICK_HANDLER}).launch_stone (l_stone)
						end
					end
				end
			end
		end

feature{NONE} -- Implementation

	color_or_font_change_actions_internal: like color_or_font_change_actions
			-- Implementation of `color_or_font_change_actions'	

	on_color_or_font_change_agent_internal: like on_color_or_font_change_agent
			-- Implementation of `on_color_or_font_change_agent'

	on_scroll_behavior_change_agent_internal: like on_scroll_behavior_change_agent
			-- Implementation of `on_scroll_behavior_change_agent'

	on_pointer_right_click_agent_internal: like on_pointer_right_click_agent
			-- Implementation of `on_pointer_right_click_agent'

	on_color_or_font_change_agent: PROCEDURE [ANY, TUPLE] is
			-- Agent of `on_color_or_font_change'
		do
			if on_color_or_font_change_agent_internal = Void then
				on_color_or_font_change_agent_internal := agent on_color_or_font_change
			end
			Result := on_color_or_font_change_agent_internal
		ensure
			Result_attached: Result /= Void
		end

	on_scroll_behavior_change_agent: PROCEDURE [ANY, TUPLE] is
			-- Agent of `on_scroll_behavior_change'
		do
			if on_scroll_behavior_change_agent_internal = Void then
				on_scroll_behavior_change_agent_internal := agent on_scroll_behavior_change
			end
			Result := on_scroll_behavior_change_agent_internal
		ensure
			result_attached: Result /= Void
		end

	on_pointer_right_click_agent: PROCEDURE [ANY, TUPLE [INTEGER_32, INTEGER_32, INTEGER_32, REAL_64, REAL_64, REAL_64, INTEGER_32, INTEGER_32]] is
			-- Agent of `on_pointer_right_click'
		do
			if on_pointer_right_click_agent_internal = Void then
				on_pointer_right_click_agent_internal := agent on_pointer_right_click
			end
			Result := on_pointer_right_click_agent_internal
		ensure
			result_attached: Result /= Void
		end

invariant
	grid_attached: grid /= Void

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
