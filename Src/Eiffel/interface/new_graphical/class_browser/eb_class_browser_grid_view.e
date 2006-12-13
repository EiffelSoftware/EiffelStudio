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
	EB_CLASS_BROWSER_GRID_VIEW [G]

inherit
	QL_OBSERVER

	EB_CONSTANTS

	EB_SHARED_PREFERENCES

	EVS_SEARCHABLE_COMPONENT [G]
		rename
			make as old_make
		redefine
			grid
		end

	SHARED_EDITOR_FONT

	SHARED_EDITOR_DATA

	EB_RECYCLABLE

	EB_CLASS_BROWSER_UTILITY

	EB_SHARED_PIXMAPS

	EB_SHARED_WRITER

	EB_EDITOR_TOKEN_GRID_SUPPORT
		undefine
			grid
		end

feature{NONE} -- Initialization

	make (a_dev_window: like development_window; a_drop_actions: like drop_actions) is
			-- Initialize.
		require
			a_dev_window_attached: a_dev_window /= Void
		do
			development_window := a_dev_window
			drop_actions := a_drop_actions
			post_sort_actions.extend (agent on_post_sort)
			build_interface
			grid.set_expand_selected_rows_agent (agent on_expand_one_level)
			grid.set_expand_selected_rows_recursive_agent (agent on_expand_all_level)
			grid.set_collapse_selected_rows_agent (agent on_collapse_one_level)
			grid.set_collapse_selected_rows_recursive_agent (agent on_collapse_all_level)
			grid.enable_default_tree_navigation_behavior (True, True, True, True)
			set_item_text_function (agent text_of_grid_item)
			enable_copy
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
			color_or_font_change_actions.extend (agent on_color_or_font_changed)
			synchronize_color_or_font_change_with_editor
			synchronize_scroll_behavior_with_editor
		end

feature -- Setting

	set_starting_element (a_class: like starting_element) is
			-- Set `start_class' with `a_class'.
		do
			starting_element := a_class
		ensure
			start_class_set: starting_element = a_class
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
		do
			if a_msg = Void or else a_msg.is_empty then
				trace := Void
			else
				create trace.make_from_string (a_msg)
			end
		end

	set_focus is
			-- Set focus to current grid.
		do
			if is_in_error_state then
				if text.is_displayed and then text.is_sensitive then
					text.set_focus
				end
			else
				if grid.is_displayed and then grid.is_sensitive then
					grid.set_focus
				end
			end
		end

	set_has_grid_been_binded (a_binded: BOOLEAN) is
			-- Set `has_grid_been_binded' with `a_binded'.
		do
			has_grid_been_binded := a_binded
		ensure
			has_grid_been_binded_set: has_grid_been_binded = a_binded
		end

feature -- Navigation

	go_to_parent (a_row: EV_GRID_ROW) is
			-- Select parent row of `a_row'.
		require
			a_row_attached: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
		local
			l_grid_item: EVS_GRID_SEARCHABLE_ITEM
		do
			if a_row.is_expandable and then a_row.is_expanded then
				a_row.collapse
			else
				if a_row.parent_row /= Void then
					l_grid_item ?= a_row.item (1)
					a_row.disable_select
					l_grid_item ?= first_non_void_grid_item (a_row.parent_row)
					if l_grid_item /= Void then
						ensure_visible (l_grid_item, True)
					end
				end
			end
		end

	first_non_void_grid_item (a_row: EV_GRID_ROW): EV_GRID_ITEM is
			-- First non void item in `a_row'.
			-- Return Void if there is no item in `a_row'.
		require
			a_row_attached: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
		local
			l_column_count: INTEGER
			i: INTEGER
		do
			from
				i := 1
				l_column_count := a_row.parent.column_count
			until
				i > l_column_count or Result /= Void
			loop
				Result := a_row.item (i)
				i := i + 1
			end
		end

	go_to_first_child (a_row: EV_GRID_ROW) is
			-- Select first child (if any) of `a_row'.
		require
			a_row_attached: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
		local
			l_grid_item: EVS_GRID_SEARCHABLE_ITEM
		do
			if a_row.is_expandable then
				if not a_row.is_expanded then
					expand_row (a_row)
				else
					if a_row.subrow_count > 0 then
						a_row.disable_select
						l_grid_item ?= first_non_void_grid_item (a_row.subrow (1))
						if l_grid_item /= Void then
							ensure_visible (l_grid_item, True)
						end
					end
				end
			end
		end

	expand_row (a_row: EV_GRID_ROW) is
			-- Expand `a_row'.
		require
			a_row_attached: a_row /= Void
		do
			if a_row.is_expandable then
				a_row.expand
			end
		end

	collapse_row_recursively (a_row: EV_GRID_ROW) is
			-- Collapse `a_row' recursively.
		require
			a_row_attached: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
		local
			l_subrow_cnt: INTEGER
			l_subrow_index: INTEGER
		do
			if a_row.is_expandable then
				a_row.collapse
			end
			l_subrow_cnt := a_row.subrow_count
			if l_subrow_cnt > 0 then
				from
					l_subrow_index := 1
				until
					l_subrow_index > l_subrow_cnt
				loop
					collapse_row_recursively (a_row.subrow (l_subrow_index))
					l_subrow_index := l_subrow_index + 1
				end
			end
		end

	expand_row_recursively (a_row: EV_GRID_ROW) is
			-- Expand `a_row' recursively.
		require
			a_row_attached: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
		local
			l_subrow_cnt: INTEGER
			l_subrow_index: INTEGER
		do
			if a_row.is_expandable then
				a_row.expand
			end
			l_subrow_cnt := a_row.subrow_count
			if l_subrow_cnt > 0 then
				from
					l_subrow_index := 1
				until
					l_subrow_index > l_subrow_cnt
				loop
					expand_row_recursively (a_row.subrow (l_subrow_index))
					l_subrow_index := l_subrow_index + 1
				end
			end
		end

	collapse_row (a_row: EV_GRID_ROW) is
			-- Collapse subrows of `a_row'.
			-- But don't collapse `a_row', and make sure direct subrows of `a_row' is visible.
		require
			a_row_attached: a_row /= Void
		local
			l_subrow_cnt: INTEGER
			l_subrow_index: INTEGER
		do
			l_subrow_cnt := a_row.subrow_count
			if l_subrow_cnt > 0 then
				from
					l_subrow_index := 1
				until
					l_subrow_index > l_subrow_cnt
				loop
					if a_row.subrow (l_subrow_index).is_expandable then
						a_row.subrow (l_subrow_index).collapse
						processed_rows.extend (a_row.subrow (l_subrow_index))
					end
					l_subrow_index := l_subrow_index + 1
				end
			end
			if a_row.is_expandable and then not processed_rows.has (a_row) then
				a_row.expand
			end
		end

	collapse_row_normal (a_row: EV_GRID_ROW) is
			-- Collapse `a_row' normally.
		require
			a_row_attached: a_row /= Void
		do
			if a_row /= Void and then a_row.is_expandable and then a_row.is_expanded then
				a_row.collapse
			end
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
			-- Every view can provide a customized control bar. Normally a tool bar is placed in this area
			-- through which behavior (such as tooltip display) of current view can be changed.
		deferred
		end

	starting_element: ANY
			-- Starting element as root of the tree displayed in current browser.
			-- This is used when a tree view is to be built. And starting element serves as the root of that tree.
			-- If `starting_element' is Void, don't build tree.

	show_tooltip_checkbox: EV_TOOL_BAR_TOGGLE_BUTTON is
			-- Checkbox to indicate whether or not tooltip is displayed
		do
			if show_tooltip_checkbox_internal = Void then
				create show_tooltip_checkbox_internal
				show_tooltip_checkbox_internal.set_pixmap (pixmaps.icon_pixmaps.general_show_tool_tips_icon)
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

	grid: ES_GRID
			-- Grid used to display information

	string_representation_of_sorted_columns: STRING is
			-- String representation of a list of sorted columns from `a_columns'
		local
			c: INTEGER
			l_sorting_snapshot: like sorting_order_snapshort
			l_tuple: TUPLE [a_column_index: INTEGER; a_sorting_order: INTEGER]
		do
			create Result.make (20)
			l_sorting_snapshot := sorting_order_snapshort
			from
				l_sorting_snapshot.start
				c := l_sorting_snapshot.count
			until
				l_sorting_snapshot.after
			loop
				l_tuple := l_sorting_snapshot.item
				if l_tuple /= Void then
					Result.append (l_tuple.a_column_index.out)
					Result.append_character (':')
					Result.append (l_tuple.a_sorting_order.out)
					if l_sorting_snapshot.index < c then
						Result.append_character (',')
					end
				end
				l_sorting_snapshot.forth
			end
		ensure
			result_attached: Result /= Void
		end

	sorted_columns_from_string (a_str: STRING): LINKED_LIST [TUPLE [a_column_index: INTEGER; a_sorting_order: INTEGER]] is
			-- A list of sorting columns from its string representation
		require
			a_str_attached: a_str /= Void
		local
			l_list: LIST [STRING]
			l_list2: LIST [STRING]
		do
			create Result.make
			from
				l_list := a_str.split (',')
				l_list.start
			until
				l_list.after
			loop
				l_list2 := l_list.item.split (':')
				if l_list2.count = 2 and then l_list2.first.is_integer and then l_list2.last.is_integer then
					Result.extend ([l_list2.first.to_integer, l_list2.last.to_integer])
				end
				l_list.forth
			end
		ensure
			result_attached: Result /= Void
		end

	text_of_grid_item (a_item: EV_GRID_ITEM): STRING is
			-- String representation of `a_item'
		local
			l_token_item: EB_GRID_EDITOR_TOKEN_ITEM
		do
			l_token_item ?= a_item
			if l_token_item /= Void then
				Result := l_token_item.text
			end
		end

	retrieve_data_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performed to get new data which will force current view to be refreshed.
		do
			if retrieve_data_actions_internal = Void then
				create retrieve_data_actions_internal
			end
			Result := retrieve_data_actions_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_up_to_date: BOOLEAN
			-- Is current up-to_date?

	is_tree_node_highlight_enabled: BOOLEAN
			-- Is tree node highlight enabled?
			-- If True, when you select one row in tree view, the whole tree node hierarchy
			-- starting from the row will be highlighted.

	is_in_error_state: BOOLEAN is
			-- Is current grid in error state?
		do
			Result := data = Void
		end

	should_tooltip_be_displayed: BOOLEAN
			-- Should tooltip be displayed?
		deferred
		end

	has_grid_been_binded: BOOLEAN
			-- Has `grid' been binded before?

feature{NONE} -- Implementation

	text: EV_TEXT is
			-- Text area to display warning/error message
		do
			if internal_text = Void then
				create internal_text
				internal_text.key_press_actions.extend (agent on_key_pressed_in_text)
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

	on_notify is
			-- Action to be performed when `update' is called.
		deferred
		end

	on_predefined_key_pressed (a_key: EV_KEY): BOOLEAN is
			-- Action to be performed when predefined function keys are pressed
			-- If `a_key' is processed, return True, otherwise False.
		require
			a_key_attached: a_key /= Void
		do
			Result := True
			 if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				on_enter_pressed
			else
				Result := False
			end
		end

	on_enter_pressed is
			-- Action to be performed when enter key is pressed
		deferred
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

	on_post_sort (a_sorting_status_snapshot: LINKED_LIST [TUPLE [a_column_index: INTEGER; a_sorting_order: INTEGER]]) is
			-- Action to be performed after a sorting
		deferred
		end

	on_key_pressed_in_text (a_key: EV_KEY) is
			-- Action to be performed when `a_key' is pressed in `text'
		require
			a_key_attached: a_key /= Void
		do
			if ev_application.ctrl_pressed then
				if a_key.code = {EV_KEY_CONSTANTS}.key_a then
					if not text.text.is_empty then
						text.select_all
					end
				elseif a_key.code = {EV_KEY_CONSTANTS}.key_c then
					if text.has_selection then
						ev_application.clipboard.set_text (text.selected_text)
					end
				end
			end
		end

	on_show_tooltip_changed is
			-- Action to be performed when selection status of `show_tooltip_checkbox' changes
		do
			if preferences.class_browser_data.is_tooltip_shown /= show_tooltip_checkbox.is_selected then
				preferences.class_browser_data.show_tooltip_preference.set_value (show_tooltip_checkbox.is_selected)
			end
		end

	on_show_tooltip_changed_from_outside is
			-- Action to be performed when selection status of `show_tooltip_checkbox' changes from outside
		local
			l_displayed: BOOLEAN
		do
			l_displayed := preferences.class_browser_data.is_tooltip_shown
			if l_displayed /= show_tooltip_checkbox.is_selected then
				if l_displayed then
					show_tooltip_checkbox.enable_select
				else
					show_tooltip_checkbox.disable_select
				end
			end
		end

feature {NONE} -- Recycle

	internal_recycle is
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
			desynchronize_color_or_font_change_with_editor
			desynchronize_scroll_behavior_with_editor
		end

feature {NONE} -- Implementation

	default_row_height: INTEGER is
			-- Default height to set grid rows.
		do
			Result := line_height.max (pixmap_height)
				-- We make sure we give enough space to display the pixmap.
		end

	quick_search_bar: EB_GRID_QUICK_SEARCH_TOOL
			-- Search bar used in browser

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Actions performed when drop occurs on current view	

	internal_text: like text
			-- Implementation of `text'

	data: ANY
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

	tooltip_with_accelerator (a_text: STRING_GENERAL; a_accelerator: EV_ACCELERATOR): STRING_GENERAL is
			-- Tooltip text `a_text' with information of accelerator key `a_accelerator'
		require
			a_text_attached: a_text /= Void
			a_accelerator_attached: a_accelerator /= Void
		local
			l_text: STRING_32
		do
			create l_text.make (a_text.count + 10)
			l_text.append (a_text)
			l_text.append (" (")
			l_text.append (a_accelerator.out)
			l_text.append_character (')')
			Result := l_text
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	on_show_tooltip_changed_from_outside_agent: PROCEDURE [ANY, TUPLE]
			-- Agent kept for recycling

feature{NONE} -- Implementation

	show_tooltip_checkbox_internal: like show_tooltip_checkbox
			-- Implementation of `show_tooltip_checkbox'

	trace: STRING
			-- Trace message

feature -- Tree hierarchy highlight

	highlight_tree_on_grid_focus_change is
			-- Highlight/Dehighlight selected tree hierarchy when focus of `grid' changes.
		require
			grid_is_in_tree_mode: grid.is_tree_enabled
			tree_node_highlight_enabled: is_tree_node_highlight_enabled
		local
			l_agent: PROCEDURE [ANY, TUPLE [EV_GRID_ROW]]
			l_selected_rows: LIST [EV_GRID_ROW]
			l_row: EV_GRID_ROW
		do
			if grid.has_focus then
				l_agent := agent highlight_row
			else
				l_agent := agent dehighlight_row
			end
			l_selected_rows := grid.selected_rows
			if not l_selected_rows.is_empty then
				processed_rows.wipe_out
				from
					l_selected_rows.start
				until
					l_selected_rows.after
				loop
					l_row := l_selected_rows.item
					if not processed_rows.has (l_row) then
						l_agent.call ([l_row])
						processed_rows.extend (l_row)
					end
					l_selected_rows.forth
				end
			end
		end

	highlight_row (a_row: EV_GRID_ROW) is
			-- Highlight `a_row and all its subrows.
		require
			a_row_attached: a_row /= Void
			grid_is_in_tree_mode: grid.is_tree_enabled
		local
			l_row_index: INTEGER
			l_row_count: INTEGER
		do
			if is_tree_node_highlight_enabled then
				if a_row.is_selected then
					if grid.has_focus then
						a_row.set_background_color (preferences.editor_data.selection_background_color)
					else
						a_row.set_background_color (preferences.editor_data.focus_out_selection_background_color)
					end
				else
					a_row.set_background_color (odd_line_color)
				end
				l_row_count := a_row.subrow_count
				if l_row_count > 0 then
					from
						l_row_index := 1
					until
						l_row_index > l_row_count
					loop
						highlight_row (a_row.subrow (l_row_index))
						l_row_index := l_row_index + 1
					end
				end
			end
		end

	dehighlight_row (a_row: EV_GRID_ROW) is
			-- Dehighlight `a_row' and all its subrows.
		require
			a_row_attached: a_row /= Void
			grid_is_in_tree_mode: grid.is_tree_enabled
		local
			l_row_index: INTEGER
			l_row_count: INTEGER
			l_is_parent_selected: BOOLEAN
			l_parent_row: EV_GRID_ROW
		do
			if is_tree_node_highlight_enabled then
				from
					l_parent_row := a_row.parent_row
				until
					l_parent_row = Void or l_is_parent_selected
				loop
					l_is_parent_selected := l_parent_row.is_selected
					l_parent_row := l_parent_row.parent_row
				end
				if a_row.is_selected then
					if grid.has_focus then
						a_row.set_background_color (preferences.editor_data.selection_background_color)
					else
						a_row.set_background_color (preferences.editor_data.focus_out_selection_background_color)
					end
				else
					if l_is_parent_selected then
						a_row.set_background_color (odd_line_color)
					else
						a_row.set_background_color (even_line_color)
					end
				end
				l_row_count := a_row.subrow_count
				if l_row_count > 0 then
					from
						l_row_index := 1
					until
						l_row_index > l_row_count
					loop
						dehighlight_row (a_row.subrow (l_row_index))
						l_row_index := l_row_index + 1
					end
				end
			end
		end

	processed_rows: LIST [EV_GRID_ROW] is
			-- Rows that have been processed during some expansion or collapsion
		do
			if processed_rows_internal = Void then
				create {LINKED_LIST [EV_GRID_ROW]}processed_rows_internal.make
			end
			Result := processed_rows_internal
		ensure
			result_attached: Result /= Void
		end

	processed_rows_internal: like processed_rows
			-- Implementation of `processed_Rows'

	retrieve_data_actions_internal: like retrieve_data_actions
			-- Implementation of `retrieve_data_actions'

invariant
	development_window_attached: not is_recycled implies development_window /= Void

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
