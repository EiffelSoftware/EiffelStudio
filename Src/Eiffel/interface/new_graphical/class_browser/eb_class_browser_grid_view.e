indexing
	description: "[
					Grid view used in class browser
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CLASS_BROWSER_GRID_VIEW

inherit
	QL_OBSERVER

	EB_CONSTANTS

	EB_SHARED_PREFERENCES

	EVS_SEARCHABLE_COMPONENT
		rename
			make as old_make
		undefine
			ensure_visible
		redefine
			grid
		end

	SHARED_EDITOR_FONT
		redefine
			line_height
		end

	SHARED_EDITOR_DATA

	EB_RECYCLABLE

	EB_CLASS_BROWSER_UTILITY

	EB_SHARED_PIXMAPS

feature{NONE} -- Initialization

	make (a_dev_window: like development_window; a_drop_actions: like drop_actions) is
			-- Initialize.
		require
			a_dev_window_attached: a_dev_window /= Void
		do
			development_window := a_dev_window
			drop_actions := a_drop_actions
			build_interface
		ensure
			drop_actions_set: drop_actions = a_drop_actions
		end

	build_grid is
			-- Build `grid'.
		deferred
		ensure
			grid_attached: grid /= Void
		end

	build_sortable_and_searchable is
			-- Build sortable and searchable facilities
		require
			grid_attached: grid /= Void
		deferred
		end

	build_interface is
			-- Build interface of current view.
		do
			check development_window /= Void end
				-- Build sortable and searchable `grid'.
			build_grid
			build_sortable_and_searchable

				-- Build rest of the interface
			if drop_actions /= Void then
				text.drop_actions.fill (drop_actions)
			end
			grid.pointer_double_press_actions.extend (agent on_pointer_double_click)

			on_color_or_font_changed_agent := agent on_color_or_font_changed
			editor_preferences.keyword_font_preference.change_actions.extend (on_color_or_font_changed_agent)
			editor_preferences.keyword_text_color_preference.change_actions.extend (on_color_or_font_changed_agent)
			editor_preferences.normal_text_color_preference.change_actions.extend (on_color_or_font_changed_agent)
			editor_preferences.editor_font_preference.change_actions.extend (on_color_or_font_changed_agent)
			preferences.class_browser_data.odd_row_background_color_preference.change_actions.extend (on_color_or_font_changed_agent)
			preferences.class_browser_data.even_row_background_color_preference.change_actions.extend (on_color_or_font_changed_agent)

			on_scroll_behavior_changed
			on_scroll_behavior_changed_agent := agent on_scroll_behavior_changed
			editor_preferences.mouse_wheel_scroll_full_page_preference.change_actions.extend (on_scroll_behavior_changed_agent)
			editor_preferences.mouse_wheel_scroll_size_preference.change_actions.extend (on_scroll_behavior_changed_agent)
			editor_preferences.scrolling_common_line_count_preference.change_actions.extend (on_scroll_behavior_changed_agent)
		end

feature -- Setting

	set_start_class (a_class: like start_class) is
			-- Set `start_class' with `a_class'.
		do
			start_class := a_class
		ensure
			start_class_set: start_class = a_class
		end

	lock_update_grid is
			-- Lock update on `grid'.
		do
			grid.lock_update
		end

	unlock_update_grid is
			-- Unlock update on `grid'.
		do
			grid.unlock_update
		end

	enable_tree_node_highlight is
			-- Enable tree node highlight.
			-- Go to `is_tree_node_highlight_enabled' for more information.
		do
			is_tree_node_highlight_enabled := True
		ensure
			tree_node_highlight_enabled: is_tree_node_highlight_enabled
		end

	disable_tree_node_highlight is
			-- Disable tree node highlight.
			-- Go to `is_tree_node_highlight_enabled' for more information.
		do
			is_tree_node_highlight_enabled := False
		ensure
			tree_node_highlight_disabled: not is_tree_node_highlight_enabled
		end


	set_trace (a_msg: STRING) is
			-- Set `trace' with `a_msg'.
		require
			a_msg_attached: a_msg /= Void
		do
			create trace.make_from_string (a_msg)
		end

feature -- View update

	update (a_observable: QL_OBSERVABLE; a_data: ANY) is
			-- Notification from `a_observable' indicating that `a_data' changed.
		require else
			a_observable_can_be_void: a_observable = Void
		do
			data ?= a_data
			is_up_to_date := False
			on_notify
			update_view
		end

	reset_display is
			-- Clear all graphical output
		do
			text.remove_text
			if grid.row_count > 0 then
				grid.remove_rows (1, grid.row_count)
			end
		end

feature -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- Tool manager

	widget: EV_WIDGET is
			-- Widget of current view
		do
			if widget_internal = Void then
				create main_container
				text.disable_edit
				text.set_background_color (editor_preferences.normal_background_color)
				text.set_foreground_color (editor_preferences.normal_text_color)
				text.set_font (font)
				main_container.extend (text)
				main_container.extend (component_widget)
				component_widget.hide
				widget_internal := main_container
			end
			Result := widget_internal
		end

	control_bar: EV_WIDGET is
			-- Widget of a control bar through which, certain control can be performed upon current view
		deferred
		end

	start_class: QL_CLASS
			-- Class as root of tree
			-- This is used when a tree view is to be built. And start class serves as the root of that tree.
			-- If `start_class' is Void, don't build tree.

	collapse_button: EV_TOOL_BAR_BUTTON is
			-- Button to collapse one level of tree
		do
			if collapse_button_internal = Void then
				create collapse_button_internal
				collapse_button_internal.set_pixmap (icon_collapse_all)
				collapse_button_internal.set_tooltip (tooltip_with_accelerator (interface_names.l_collapse_layer, accelerator_from_preference ("collapse_tree_node")))
				collapse_button_internal.select_actions.extend (collapse_button_pressed_action)
			end
			Result := collapse_button_internal
		ensure
			result_attached: Result /= Void
		end

	expand_button: EV_TOOL_BAR_BUTTON is
			-- Button to expand one level of tree
		do
			if expand_button_internal = Void then
				create expand_button_internal
				expand_button_internal.set_pixmap (icon_expand_all)
				expand_button_internal.set_tooltip (tooltip_with_accelerator (interface_names.l_expand_layer,accelerator_from_preference ("expand_tree_node")))
				expand_button_internal.select_actions.extend (expand_button_pressed_action)
			end
			Result := expand_button_internal
		ensure
			result_attached: Result /= Void
		end

	show_tooltip_checkbox: EV_TOOL_BAR_TOGGLE_BUTTON is
			-- Checkbox to indicate whether or not tooltip is displayed
		do
			if show_tooltip_checkbox_internal = Void then
				create show_tooltip_checkbox_internal
				show_tooltip_checkbox_internal.set_pixmap (pixmaps.icon_pixmaps.debug_exception_dialog_icon)
				show_tooltip_checkbox_internal.set_tooltip (interface_names.h_show_tooltip)
				if preferences.class_browser_data.is_tooltip_shown then
					show_tooltip_checkbox_internal.enable_select
				else
					show_tooltip_checkbox_internal.disable_select
				end
			end
			Result := show_tooltip_checkbox_internal
		ensure
			result_attached: Result /= Void
		end

	grid_item_at_position (a_x, a_y: INTEGER): EV_GRID_ITEM is
			-- Item at position (`a_x', `a_y') which is related to the top-left coordinate of `grid'
			-- Void if no item is found.
		local
			l_header_height: INTEGER
		do
			if grid.is_header_displayed then
				l_header_height := grid.header.height
			end
			Result := grid.item_at_virtual_position (grid.virtual_x_position + a_x, grid.virtual_y_position + a_y - l_header_height)
		end

	editor_token_at_position (a_x, a_y: INTEGER): EDITOR_TOKEN is
			-- Editor token at position (`a_x', `a_y') which is related to the top-left coordinate of `grid'
			-- Void if no item is found.
		local
			l_editor_token_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_index: INTEGER
		do
			l_editor_token_item ?= grid_item_at_position (a_x, a_y)
			if l_editor_token_item /= Void then
				l_index := l_editor_token_item.token_index_at_current_position
				if l_index > 0 then
					Result := l_editor_token_item.token_at_position (l_index)
				end
			end
		end

	grid: ES_GRID
			-- Grid used to display information

feature -- Status report

	is_up_to_date: BOOLEAN
			-- Is current up-to_date?

	is_tree_node_highlight_enabled: BOOLEAN
			-- Is tree node highlight enabled?
			-- If True, when you select one row in tree view, the whole tree node hierarchy
			-- starting from the row will be highlighted.

feature{NONE} -- Implementation

	text: EV_TEXT is
			-- Text area to display warning/error message
		do
			if internal_text = Void then
				create internal_text
			end
			Result := internal_text
		ensure
			result_attached: Result /= Void
		end

	main_container: EV_VERTICAL_BOX
			-- Main container to hole current view

	widget_internal: like widget
			-- Implementation of `widget'

feature{NONE} -- Actions

	on_color_or_font_changed_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_color_or_font_changed'

	on_scroll_behavior_changed_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_scroll_behavior_changed'

	on_color_or_font_changed is
			-- Action to be performed when color or font used to display editor tokens changes
		do
			if grid.is_displayed then
				fill_rows
				bind_grid
			else
				text.set_background_color (editor_preferences.normal_background_color)
				text.set_foreground_color (editor_preferences.normal_text_color)
				text.set_font (font)
				text.refresh_now
			end
		end

	on_scroll_behavior_changed is
			-- Action to be performed when scroll behevior preferences changes
		do
			grid.scrolling_behavior.set_mouse_wheel_scroll_full_page (editor_preferences.mouse_wheel_scroll_full_page)
			grid.scrolling_behavior.set_mouse_wheel_scroll_size (editor_preferences.mouse_wheel_scroll_size)
			grid.scrolling_behavior.set_scrolling_common_line_count (editor_preferences.scrolling_common_line_count)
		end

	on_pick_ended (a_item: EV_ABSTRACT_PICK_AND_DROPABLE) is
			-- Action performed when pick ends
		local
			l_item: EB_GRID_EDITOR_TOKEN_ITEM
		do
			l_item ?= last_picked_item
			if l_item /= Void then
				l_item.set_last_picked_token (0)
				if l_item.is_parented and then l_item.is_selectable then
					l_item.enable_select
				end
				if l_item.is_parented then
					l_item.redraw
				end
			end
			last_picked_item := Void
		ensure
			last_picked_item_not_attached: last_picked_item = Void
		end

	on_pick (a_item: EV_GRID_ITEM): ANY is
			-- Action performed when pick on `a_item'.
		local
			l_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_stone: STONE
			l_index: INTEGER
		do
			last_picked_item := Void
			l_item ?= a_item
			if l_item /= Void then
				l_index := l_item.token_index_at_current_position
				if l_index > 0 then
					Result := l_item.editor_token_pebble (l_index)
					l_stone ?= Result
					if l_stone /= Void then
						grid.remove_selection
						grid.set_accept_cursor (l_stone.stone_cursor)
						grid.set_deny_cursor (l_stone.x_stone_cursor)
						l_item.set_last_picked_token (l_index)
						l_item.redraw
						last_picked_item := l_item
					end
				end
			end
		end

	on_notify is
			-- Action to be performed when `update' is called.
		deferred
		end

	on_pointer_double_click (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Action to be performed when pointer double clicked
		local
			l_editor_token: EDITOR_TOKEN
		do
--			if a_button = 1 then
--				l_editor_token := editor_token_at_position (a_x, a_y)
--				if l_editor_token /= Void and then not l_editor_token.image.is_empty then
--					ev_application.clipboard.set_text (l_editor_token.image)
--				end
--			end
		end

	on_predefined_key_pressed (a_key: EV_KEY): BOOLEAN is
			-- Action to be performed when predefined function keys are pressed
			-- If `a_key' is processed, return True, otherwise False.
		require
			a_key_attached: a_key /= Void
		do
			Result := True
			if is_accelerator_matched (a_key, accelerator_from_preference ("collapse_tree_node")) then
				on_collapse_one_level
			elseif is_accelerator_matched (a_key, accelerator_from_preference ("expand_tree_node")) then
				on_expand_one_level
			elseif is_accelerator_matched (a_key, accelerator_from_preference ("collapse_all_levels")) then
				on_collapse_all_level
			elseif is_accelerator_matched (a_key, accelerator_from_preference ("expand_all_levels")) then
				on_expand_all_level
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				on_enter_pressed
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_c and then ev_application.ctrl_pressed then
				on_ctrl_c_pressed
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_a and then ev_application.ctrl_pressed then
				on_ctrl_a_pressed
			else
				Result := False
			end
		end

	on_enter_pressed is
			-- Action to be performed when enter key is pressed
		deferred
		end

	on_ctrl_c_pressed is
			-- Action to be performed when Ctrl+C is pressed
		local
			l_text: STRING
		do
			l_text := selected_text
			if not l_text.is_empty then
				ev_application.clipboard.set_text (l_text)
			end
		end

	on_ctrl_a_pressed is
			-- Action to be performed when Ctrl+A is pressed
		do
			grid.select_all_rows
		end

	on_expand_all_level is
			-- Action to be performed to recursively expand all selected rows.
		deferred
		end

	on_collapse_all_level is
			-- Action to be performed to recursively collapse all selected rows.
		deferred
		end

	on_expand_one_level is
			-- Action to be performed to expand all selected rows.
		deferred
		end

	on_collapse_one_level is
			-- Action to be performed to collapse all selected rows.
		deferred
		end

feature -- Recycle

	recycle is
			-- Recyclable
		do
			development_window := Void
			if quick_search_bar /= Void then
				quick_search_bar.recycle
			end
			quick_search_bar := Void
			recycle_agents
		end

	recycle_agents is
			-- Recycle agents in preferences.
		do
			if on_color_or_font_changed_agent /= Void then
				editor_preferences.keyword_font_preference.change_actions.prune_all (on_color_or_font_changed_agent)
				editor_preferences.keyword_text_color_preference.change_actions.prune_all (on_color_or_font_changed_agent)
				editor_preferences.normal_text_color_preference.change_actions.prune_all (on_color_or_font_changed_agent)
				editor_preferences.editor_font_preference.change_actions.prune_all (on_color_or_font_changed_agent)
				preferences.class_browser_data.odd_row_background_color_preference.change_actions.prune_all (on_color_or_font_changed_agent)
				preferences.class_browser_data.even_row_background_color_preference.change_actions.prune_all (on_color_or_font_changed_agent)
			end
			if on_scroll_behavior_changed_agent /= Void then
				editor_preferences.mouse_wheel_scroll_full_page_preference.change_actions.prune_all (on_scroll_behavior_changed_agent)
				editor_preferences.mouse_wheel_scroll_size_preference.change_actions.prune_all (on_scroll_behavior_changed_agent)
				editor_preferences.scrolling_common_line_count_preference.change_actions.prune_all (on_scroll_behavior_changed_agent)
			end
		end

	collapse_button_pressed_action: PROCEDURE [ANY, TUPLE] is
			-- Action to be performed when `collapse_button' is pressed
		deferred
		ensure
			result_attached: Result /= Void
		end

	expand_button_pressed_action: PROCEDURE [ANY, TUPLE] is
			-- Action to be performed when `expand_button' is pressed
		deferred
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Sorting

	item_tester (a_item, b_item: EV_GRID_ITEM): BOOLEAN is
			-- Tester to test if index of `a_item' is less than `b_item'
		require
			a_item_attached: a_item /= Void
			a_item_is_parented: a_item.parent /= Void
			b_item_attached: b_item /= Void
			b_item_is_parented: b_item.parent /= Void
		do
			if a_item.row.index /= b_item.row.index then
				Result := a_item.row.index < b_item.row.index
			else
				Result := a_item.column.index < b_item.column.index
			end
		end

	sorted_items (a_item_list: LIST [EV_GRID_ITEM]): DS_LIST [EV_GRID_ITEM] is
			-- Sorted items of `a_item_list'
		require
			a_item_list_attached: a_item_list /= Void
		local
			l_tester: AGENT_BASED_EQUALITY_TESTER [EV_GRID_ITEM]
			l_sorter: DS_QUICK_SORTER [EV_GRID_ITEM]
		do
			create {DS_ARRAYED_LIST [EV_GRID_ITEM]}Result.make (a_item_list.count)
			from
				a_item_list.start
			until
				a_item_list.after
			loop
				Result.force_last (a_item_list.item)
				a_item_list.forth
			end
			create l_tester.make (agent item_tester)
			create l_sorter.make (l_tester)
			l_sorter.sort (Result)
		end

feature{NONE} -- Implementation

	quick_search_bar: EB_GRID_QUICK_SEARCH_TOOL

	last_picked_item: EV_GRID_ITEM
			-- Last picked item	

	line_height: INTEGER is
			-- Line height
		do
			Result := Precursor
			Result := Result + Result // 5
		end

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Actions performed when drop occurs on current view	

	internal_text: like text
			-- Implementation of `text'

	data: QL_DOMAIN
			-- Data to be displayed in current view

	even_line_color: EV_COLOR is
			-- Background color for even lines
		do
			Result := preferences.class_browser_data.even_row_background_color
		ensure
			result_attached: Result /= Void
		end

	odd_line_color: EV_COLOR is
			-- Background color for odd lines
		do
			Result := preferences.class_browser_data.odd_row_background_color
		ensure
			result_attached: Result /= Void
		end

	update_view is
			-- Update current view according to change in `model'.
		deferred
		ensure
			view_up_to_date: is_up_to_date
		end

	fill_rows is
			-- Fill rows with `data'.
		deferred
		end

	bind_grid is
			-- Bind data in `rows' into `grid'.
		deferred
		end

	row_depth (a_row: EV_GRID_ROW): INTEGER is
			-- Tree depth of `a_row'.
			-- Top level row has depth 0.
		require
			a_row_attached: a_row /= Void
		local
			l_parent_row: EV_GRID_ROW
		do
			from
				l_parent_row := a_row.parent_row
			until
				l_parent_row = Void
			loop
				Result := Result + 1
				l_parent_row := l_parent_row.parent_row
			end
		ensure
			result_non_negative: Result >= 0
		end

	selected_text: STRING is
			-- String representation of selected rows/items
			-- If no row/item is selected, return an empty string.
		deferred
		ensure
			result_attached: Result /= Void
		end

	tabs (n: INTEGER): STRING is
			-- String representation of `n' tabs
		require
			n_non_negative: n >= 0
		local
			i: INTEGER
		do
			create Result.make (n)
			if n > 0 then
				from
					i := 1
				until
					i > n
				loop
					Result.append_character ('%T')
					i := i + 1
				end
			end
		ensure
			result_attached: Result /= Void
		end

	do_all_in_rows (a_row_list: LIST [EV_GRID_ROW]; a_agent: PROCEDURE [ANY, TUPLE [EV_GRID_ROW]]) is
			-- Call `a_agent' for all rows in `a_row_list'.
		require
			a_row_list_attached: a_row_list /= Void
			a_agent_attached: a_agent /= Void
		do
			if not a_row_list.is_empty then
				from
					a_row_list.start
				until
					a_row_list.after
				loop
					a_agent.call ([a_row_list.item])
					a_row_list.forth
				end
			end
		end

	do_all_in_items (a_item_list: LIST [EV_GRID_ITEM]; a_agent: PROCEDURE [ANY, TUPLE [EV_GRID_ITEM]]) is
			-- Call `a_agent' for all items in `a_item_list'.
		require
			a_item_list_attached: a_item_list /= Void
			a_agent_attached: a_agent /= Void
		do
			if not a_item_list.is_empty then
				from
					a_item_list.start
				until
					a_item_list.after
				loop
					a_agent.call ([a_item_list.item])
					a_item_list.forth
				end
			end
		end

	tooltip_with_accelerator (a_text: STRING; a_accelerator: EV_ACCELERATOR): STRING is
			-- Tooltip text `a_text' with information of accelerator key `a_accelerator'
		require
			a_text_attached: a_text /= Void
			a_accelerator_attached: a_accelerator /= Void
		do
			create Result.make (a_text.count + 10)
			Result.append (a_text)
			Result.append (" (")
			Result.append (a_accelerator.out)
			Result.append_character (')')
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature{NONE} -- Implementation

	expand_button_internal: like expand_button
			-- Implementation of `expand_button'

	collapse_button_internal: like collapse_button
			-- Implementation of `collapse_button'

	show_tooltip_checkbox_internal: like show_tooltip_checkbox
			-- Implementation of `show_tooltip_checkbox'

	trace: STRING
			-- Trace message						

invariant
	development_window_attached: development_window /= Void

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
