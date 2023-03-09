note
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
		redefine
			internal_recycle
		end

	EVS_GENERAL_TOOLTIP_UTILITY

feature{NONE} -- Initialization

	make (a_dev_window: like development_window)
			-- Initialize.
		require
			a_dev_window_attached: a_dev_window /= Void
		do
			development_window := a_dev_window
			post_sort_actions.extend (agent on_post_sort)
			build_interface
			grid.set_expand_selected_rows_agent (agent on_expand_one_level)
			grid.set_expand_selected_rows_recursive_agent (agent on_expand_all_level)
			grid.set_collapse_selected_rows_agent (agent on_collapse_one_level)
			grid.set_collapse_selected_rows_recursive_agent (agent on_collapse_all_level)
			grid.header.item_resize_start_actions.extend (agent on_column_resize_by_user_start)
			grid.header.item_resize_end_actions.extend (agent on_column_resize_by_user_end (?, False))
			grid.resizing_behavior.header_resize_end_actions.extend (agent on_column_resize_by_user_end (?, True))
			grid.enable_default_tree_navigation_behavior (True, True, True, True)
			set_item_text_function (agent text_of_grid_item)
			enable_copy
		end

	build_grid
			-- Build `grid'.
		deferred
		ensure
			grid_attached: grid /= Void
		end

	build_sortable_and_searchable
			-- Build sortable and searchable facilities
		require
			grid_attached: grid /= Void
		deferred
		end

	build_interface
			-- Build interface of current view.
		local
			l_binder: ES_TOOL_STONE_REDIRECT_HELPER
		do
			check development_window /= Void end
				-- Build sortable and searchable `grid'.
			build_grid
			build_sortable_and_searchable

				-- Build rest of the interface
			create l_binder.make (development_window)
			l_binder.bind (text, Current)
			l_binder.bind (grid, Current)
			auto_recycle (l_binder)

			color_or_font_change_actions.extend (agent on_color_or_font_changed)
			synchronize_color_or_font_change_with_editor
			synchronize_scroll_behavior_with_editor

				-- Setup context menu handler.
			grid.set_configurable_target_menu_mode
			grid.set_configurable_target_menu_handler (agent context_menu_handler)
			set_context_menu_factory_function (agent (development_window.menus).context_menu_factory)

			enable_direct_start_search
			quick_search_bar.hide_tool_actions.extend (agent do grid.set_focus end)
		end

feature -- Setting

	set_starting_element (a_class: ANY)
			-- Set `start_class' with `a_class'.
		do
			starting_element := {like starting_element} / a_class
		end

	enable_tree_node_highlight
			-- Enable tree node highlight.
			-- Go to `is_tree_node_highlight_enabled' for more information.
		do
			is_tree_node_highlight_enabled := True
		ensure
			tree_node_highlight_enabled: is_tree_node_highlight_enabled
		end

	disable_tree_node_highlight
			-- Disable tree node highlight.
			-- Go to `is_tree_node_highlight_enabled' for more information.
		do
			is_tree_node_highlight_enabled := False
		ensure
			tree_node_highlight_disabled: not is_tree_node_highlight_enabled
		end

	set_trace (a_msg: STRING)
			-- Set `trace' with `a_msg'.
		do
			if a_msg = Void or else a_msg.is_empty then
				trace := Void
			else
				create trace.make_from_string (a_msg)
			end
		end

	set_focus
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

	set_has_grid_been_resized_manually (b: BOOLEAN)
			-- Set `has_grid_been_resized_manually' with `b'.
		do
			has_grid_been_resized_manually := b
		ensure
			has_grid_been_resized_manually_set: has_grid_been_resized_manually = b
		end

	set_sorting_order_getter (a_getter: like sorting_order_getter)
			-- Set `sorting_order_getter' with `a_getter'.
		do
			sorting_order_getter := a_getter
		ensure
			sorting_order_getter_set: sorting_order_getter = a_getter
		end

	set_sorting_order_setter (a_setter: like sorting_order_setter)
			-- Set `sorting_order_setter' with `a_setter'.
		do
			sorting_order_setter := a_setter
		ensure
			sorting_order_setter_set: sorting_order_setter = a_setter
		end

	try_auto_resize_grid (a_columns: ARRAY [TUPLE [min_width: INTEGER; max_width: INTEGER; column_index: INTEGER]]; a_force: BOOLEAN)
			-- Auto resize `grid' using size given by `a_columns' if `a_force' is True or else if `grid' has not been resized manually by user.
			-- If `min_width' or `max_width' for some column is negative, then that column will be resized according to its required width.
			-- For more information about `min_width' and `max_width', see `auto_resize_columns'.
		require
			a_columns_attached: a_columns /= Void
			a_columns_valid: not a_columns.has (Void)
		local
			i: INTEGER
			l_item: TUPLE [min_width: INTEGER; max_width: INTEGER; column_index: INTEGER]
			l_size_tbl: HASH_TABLE [TUPLE [min_width: INTEGER; max_width: INTEGER], INTEGER]
		do
			if a_force or else not has_grid_been_resized_manually then
				create l_size_tbl.make (a_columns.upper - a_columns.lower + 1)
				from
					i := a_columns.lower
				until
					i > a_columns.upper
				loop
					l_item := a_columns.item (i)
					if l_item.min_width < 0 or else l_item.max_width < 0 then
						l_size_tbl.put (Void, l_item.column_index)
					else
						l_size_tbl.put ([l_item.min_width, l_item.max_width], l_item.column_index)
					end
					i := i + 1
				end
				grid.header.item_resize_end_actions.block
				auto_resize_columns (grid, l_size_tbl)
				grid.header.item_resize_end_actions.resume
			end
		end

	enable_use_fixed_fonts
			-- Enable to use fixed fonts.
			-- Fixed fonts don't change with preferences.
		do
			is_fixed_fonts_used := True
		ensure
			is_fixed_fonts_used_set: is_fixed_fonts_used
		end

	disable_use_fixed_fonts
			-- Enable to use fixed fonts.
			-- Fixed fonts don't change with preferences.		
		do
			is_fixed_fonts_used := False
		ensure
			is_fixed_fonts_used_set: not is_fixed_fonts_used
		end

feature -- Navigation

	go_to_parent (a_row: EV_GRID_ROW)
			-- Select parent row of `a_row'.
		require
			a_row_attached: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
		do
			if a_row.is_expandable and then a_row.is_expanded then
				a_row.collapse
			else
				if a_row.parent_row /= Void then
					a_row.disable_select
					if attached {EVS_GRID_SEARCHABLE_ITEM} first_non_void_grid_item (a_row.parent_row) as l_grid_item then
						ensure_visible (l_grid_item, True)
					end
				end
			end
		end

	first_non_void_grid_item (a_row: EV_GRID_ROW): EV_GRID_ITEM
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

	go_to_first_child (a_row: EV_GRID_ROW)
			-- Select first child (if any) of `a_row'.
		require
			a_row_attached: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
		do
			if a_row.is_expandable then
				if not a_row.is_expanded then
					expand_row (a_row)
				else
					if a_row.subrow_count > 0 then
						a_row.disable_select
						if attached {EVS_GRID_SEARCHABLE_ITEM} first_non_void_grid_item (a_row.subrow (1)) as l_grid_item then
							ensure_visible (l_grid_item, True)
						end
					end
				end
			end
		end

	expand_row (a_row: EV_GRID_ROW)
			-- Expand `a_row'.
		require
			a_row_attached: a_row /= Void
		do
			if a_row.is_expandable then
				a_row.expand
			end
		end

	collapse_row_recursively (a_row: EV_GRID_ROW)
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

	expand_row_recursively (a_row: EV_GRID_ROW)
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

	collapse_row (a_row: EV_GRID_ROW)
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

	collapse_row_normal (a_row: EV_GRID_ROW)
			-- Collapse `a_row' normally.
		require
			a_row_attached: a_row /= Void
		do
			if a_row /= Void and then a_row.is_expandable and then a_row.is_expanded then
				a_row.collapse
			end
		end

feature -- View update

	update (a_observable: QL_OBSERVABLE; a_data: ANY)
			-- Notification from `a_observable' indicating that `a_data' changed.
		require else
			a_observable_can_be_void: a_observable = Void
		local
		do
			data := {like data} / a_data
			if data = Void then
				value := {like value} / a_data
			end
			is_up_to_date := False
			update_view
		end

	reset_display
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

	widget: EV_WIDGET
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

	control_bar: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Widget of a control bar through which, certain control can be performed upon current view
			-- Every view can provide a customized control bar. Normally a tool bar is placed in this area
			-- through which behavior (such as tooltip display) of current view can be changed.
		deferred
		end

	starting_element: detachable ANY
			-- Starting element as root of the tree displayed in current browser.
			-- This is used when a tree view is to be built. And starting element serves as the root of that tree.
			-- If `starting_element' is Void, don't build tree.

	grid: ES_EDITOR_TOKEN_GRID
			-- Grid used to display information

	text_of_grid_item (a_item: EV_GRID_ITEM): STRING_32
			-- String representation of `a_item'
		do
			if attached {EB_GRID_EDITOR_TOKEN_ITEM} a_item as l_token_item then
				Result := l_token_item.text
			end
		end

	retrieve_data_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed to get new data which will force current view to be refreshed.
		do
			if retrieve_data_actions_internal = Void then
				create retrieve_data_actions_internal
			end
			Result := retrieve_data_actions_internal
		ensure
			result_attached: Result /= Void
		end

	show_tooltip_button: EB_PREFERENCED_SD_TOOL_BAR_TOGGLE_BUTTON
			-- Checkbox to indicate whether or not tooltip is displayed
		do
			if show_tooltip_button_internal = Void then
				create show_tooltip_button_internal.make (preferences.class_browser_data.show_tooltip_preference)
				show_tooltip_button_internal.set_pixmap (pixmaps.icon_pixmaps.general_show_tool_tips_icon)
				show_tooltip_button_internal.set_pixel_buffer (pixmaps.icon_pixmaps.general_show_tool_tips_icon_buffer)
				show_tooltip_button_internal.set_tooltip (interface_names.h_show_tooltip)
				show_tooltip_button_internal.select_actions.extend (agent on_show_tooltip_changed)
			end
			Result := show_tooltip_button_internal
		ensure
			result_attached: Result /= Void
		end

	sorting_order_getter: FUNCTION [STRING]
			-- Agent to retrieve last recorded sorting order

	sorting_order_setter: PROCEDURE [STRING]
			-- Agent to retrieve last recorded sorting order

	selected_row_background_color (a_grid_row: EV_GRID_ROW): EV_COLOR
			-- Background color for selected row `a_grid_row'
		require
			a_grid_row_attached: a_grid_row /= Void
			a_grid_valid: a_grid_row.is_selected and then a_grid_row.is_selected
		local
			l_grid: EV_GRID
		do
			l_grid := a_grid_row.parent
			if l_grid.has_focus then
				Result := l_grid.focused_selection_color
			else
				Result := l_grid.non_focused_selection_color
			end
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

	is_in_error_state: BOOLEAN
			-- Is current grid in error state?
		do
			Result := data = Void
		end

	should_tooltip_be_displayed: BOOLEAN
			-- Should tooltip be displayed?
		deferred
		end

	has_grid_been_resized_manually: BOOLEAN
			-- Has `grid' been binded before?

	is_fixed_fonts_used: BOOLEAN
			-- Should content of Current view use fixed fonts?
			-- Fixed fonts don't change with preferences.
			-- Default: False

feature{NONE} -- Implementation

	text: EV_TEXT
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

	on_color_or_font_changed
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

	on_predefined_key_pressed (a_key: EV_KEY): BOOLEAN
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

	on_enter_pressed
			-- Action to be performed when enter key is pressed
		local
			l_item: EV_GRID_ITEM
		do
			l_item := item_to_put_in_editor
			if l_item /= Void then
				open_item_editor (l_item)
			else
				on_expand_all_level
			end
		end

	on_expand_all_level
			-- Action to be performed to recursively expand all selected rows.
		deferred
		end

	on_collapse_all_level
			-- Action to be performed to recursively collapse all selected rows.
		deferred
		end

	on_expand_one_level
			-- Action to be performed to expand all selected rows.
		deferred
		end

	on_collapse_one_level
			-- Action to be performed to collapse all selected rows.
		deferred
		end

	on_post_sort (a_sorting_status_snapshot: LINKED_LIST [TUPLE [a_column_index: INTEGER; a_sorting_order: INTEGER]])
			-- Action to be performed after a sorting
		local
			l_current_sorting_order: STRING
			l_previous_sorting_order: STRING
		do
			if sorting_order_setter /= Void then
				if sorting_order_getter /= Void then
					l_previous_sorting_order := sorting_order_getter.item (Void)
					l_current_sorting_order := string_representation_of_sorted_columns
					if l_previous_sorting_order = Void or else not l_previous_sorting_order.is_equal (l_current_sorting_order) then
						sorting_order_setter.call ([l_current_sorting_order])
					end
				end
			end
		end

	on_key_pressed_in_text (a_key: EV_KEY)
			-- Action to be performed when `a_key' is pressed in `text'
		require
			a_key_attached: a_key /= Void
		local
			l_code: INTEGER
		do
			l_code := a_key.code
			if ev_application.ctrl_pressed then
				if l_code = {EV_KEY_CONSTANTS}.key_a then
					if not text.text.is_empty then
						text.select_all
					end
				elseif l_code = {EV_KEY_CONSTANTS}.key_c or l_code = {EV_KEY_CONSTANTS}.key_insert then
					if text.has_selection then
						ev_application.clipboard.set_text (text.selected_text)
					end
				end
			end
		end

	on_show_tooltip_changed
			-- Action to be performed when selection status of `show_tooltip_button' changes
		do
			if preferences.class_browser_data.is_tooltip_shown /= show_tooltip_button.is_selected then
				preferences.class_browser_data.show_tooltip_preference.set_value (show_tooltip_button.is_selected)
			end
		end

	on_column_resize_by_user_start (a_header: EV_HEADER_ITEM)
			-- Action to be performed when resize of columns of `grid' starts
		do
			set_is_resize_by_user (True)
		end

	on_column_resize_by_user_end (a_header: EV_HEADER_ITEM; a_force: BOOLEAN)
			-- Action to be performed when columns of `grid' is resized.
		do
			if (a_force or else is_resize_by_user) and then not has_grid_been_resized_manually then
				set_has_grid_been_resized_manually (True)
			end
		end

feature {NONE} -- Recycle

	internal_recycle
			-- Recyclable
		do
			Precursor {EB_EDITOR_TOKEN_GRID_SUPPORT}
			development_window := Void
			if quick_search_bar /= Void then
				quick_search_bar.recycle
			end
			quick_search_bar := Void
			recycle_agents
			grid.recycle
		end

	recycle_agents
			-- Recycle agents in preferences.
		do
			desynchronize_color_or_font_change_with_editor
			desynchronize_scroll_behavior_with_editor
			if show_tooltip_button_internal /= Void then
				show_tooltip_button.recycle
			end
		end

feature {NONE} -- Implementation

	default_row_height: INTEGER
			-- Default height to set grid rows.
		do
			Result := grid_row_height_for_tokens (not is_fixed_fonts_used)
		end

	quick_search_bar: EB_GRID_QUICK_SEARCH_TOOL
			-- Search bar used in browser

	internal_text: like text
			-- Implementation of `text'

	data: ANY
			-- Data to be displayed in current view

	value: DOUBLE_REF
			-- Value of last calculated formatter

	even_line_color: EV_COLOR
			-- Background color for even lines
		do
			Result := preferences.class_browser_data.even_row_background_color
		ensure
			result_attached: Result /= Void
		end

	odd_line_color: EV_COLOR
			-- Background color for odd lines
		do
			Result := preferences.class_browser_data.odd_row_background_color
		ensure
			result_attached: Result /= Void
		end

	update_view
			-- Update current view according to change in `model'.
		do
			if not is_up_to_date then
				tooltip_window.hide_tooltip
				if data /= Void then
					text.hide
					component_widget.show
					provide_result
				else
					component_widget.hide
					text.show
					if value /= Void then
						provide_value_result
					else
						provide_error_message
					end
				end
				is_up_to_date := True
			end
		ensure
			view_up_to_date: is_up_to_date
		end

	provide_value_result
			-- Provide result for `value'.
		require
			value_attached: value /= Void
		local
			l_text: STRING_GENERAL
		do
			l_text := interface_names.first_character_as_upper (interface_names.l_value).twin
			l_text.append (": ")
			l_text.append (value.item.out)
			text.set_text (l_text)
		end

	provide_result
			-- Provide result displayed in Current view.
		deferred
		end

	provide_error_message
			-- Provide error message displayed in Current view.
		local
			l_msg: STRING_32
		do
			l_msg := Warning_messages.w_Formatter_failed.twin
			if trace /= Void then
				l_msg.append ("%N")
				l_msg.append (trace)
			end
			text.set_text (l_msg)
		end

	fill_rows
			-- Fill rows with `data'.
		deferred
		end

	bind_grid
			-- Bind data in `rows' into `grid'.
		deferred
		end

	do_all_in_rows (a_row_list: LIST [EV_GRID_ROW]; a_agent: PROCEDURE [EV_GRID_ROW])
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

	do_all_in_items (a_item_list: LIST [EV_GRID_ITEM]; a_agent: PROCEDURE [EV_GRID_ITEM])
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

	show_tooltip_button_internal: like show_tooltip_button
			-- Implementation of `show_tooltip_button'	

	is_resize_by_user: BOOLEAN
			-- Is column resized manually by user
			-- After user manually resized, we don't auto resize `grid' according to required column width anymore.				

	set_is_resize_by_user (b: BOOLEAN)
			-- Set `is_resize_by_user' with `b'.
		do
			is_resize_by_user := b
		ensure
			is_resize_by_user_set: is_resize_by_user = b
		end

	select_all_in_dynamic_grid (a_grid: EV_GRID; a_item_function: FUNCTION [INTEGER, INTEGER, EV_GRID_ITEM]; a_columns: LIST [INTEGER])
			-- Select all rows/items in dynamic grid `a_grid'.			
			-- `a_item_function' is the function to get grid items on the fly.			
			-- `a_columns' contains indexes of columns whose items are to be retrieved.
			-- `a_columns' is Void means all columns of `a_grid' are to be retrieved.
		require
			a_grid_attached: a_grid /= Void
			a_grid_valid: a_grid.is_content_partially_dynamic
			a_item_function_attached: a_item_function /= Void
		local
			l_row_count: INTEGER
			l_column_count: INTEGER
			l_row, l_column: INTEGER
			l_columns: LIST [INTEGER]
			l_cur_column: INTEGER
		do
			a_grid.remove_selection
			l_row_count := a_grid.row_count
			l_column_count := a_grid.column_count

			if a_columns = Void then
				create {ARRAYED_LIST [INTEGER]}l_columns.make (l_row_count)
				from
					l_column := 1
				until
					l_column > l_column_count
				loop
					l_columns.extend (l_column)
					l_column := l_column + 1
				end
			else
				l_columns := a_columns
			end
			l_column_count := l_columns.count

			from
				l_row := 1
			until
				l_row > l_row_count
			loop
				from
					l_columns.start
				until
					l_columns.after
				loop
					l_cur_column := l_columns.item
					if a_grid.item (l_cur_column, l_row) = Void then
						a_grid.set_item (l_cur_column, l_row, a_item_function.item ([l_cur_column, l_row]))
					end
					l_columns.forth
				end
				a_grid.row (l_row).enable_select
				l_row := l_row + 1
			end
		end

feature{NONE} -- Implementation/Exception

	trace: STRING
			-- Trace message

feature -- Tree hierarchy highlight

	highlight_tree_on_grid_focus_change
			-- Highlight/Dehighlight selected tree hierarchy when focus of `grid' changes.
		require
			grid_is_in_tree_mode: grid.is_tree_enabled
			tree_node_highlight_enabled: is_tree_node_highlight_enabled
		local
			l_agent: PROCEDURE [EV_GRID_ROW]
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

	highlight_row (a_row: EV_GRID_ROW)
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
					a_row.set_background_color (selected_row_background_color (a_row))
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

	dehighlight_row (a_row: EV_GRID_ROW)
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
					a_row.set_background_color (selected_row_background_color (a_row))
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

	processed_rows: LIST [EV_GRID_ROW]
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

feature{NONE} -- Implementation/Stone

	item_to_put_in_editor_for_single_item_grid: like item_to_put_in_editor
			-- Grid item which may contain a stone to put into editor
			-- Void if no satisfied item is found.			
		local
			l_selected_items: LIST [EV_GRID_ITEM]
			l_item: EV_GRID_ITEM
		do
			l_selected_items := grid.selected_items
			if l_selected_items.count = 1 then
			    l_item := l_selected_items.first
			    if l_item.is_parented and then ((not l_item.row.is_expandable) or else l_item.row.is_expanded) then
			    	Result := l_item
			    end
			end
		end

	item_to_put_in_editor_for_tree_row: EV_GRID_ITEM
			-- Grid item which may contain a stone to put into editor
			-- Void if no satisfied item is found.
		local
			l_rows: LIST [EV_GRID_ROW]
			l_grid_row: EV_GRID_ROW
		do
			l_rows := grid.selected_rows
			if l_rows.count = 1 then
				if l_rows.first.parent = grid then
					l_grid_row := l_rows.first
					if is_subrow_recursively_expanded (l_grid_row, agent (a_grid_row: EV_GRID_ROW): BOOLEAN do Result := a_grid_row.is_expanded end) then
						Result := l_grid_row.item (1)
					end
				end
			end
		end

	is_subrow_recursively_expanded (a_row: EV_GRID_ROW; a_expanded_agent: FUNCTION [EV_GRID_ROW, BOOLEAN]): BOOLEAN
			-- Is `a_row' and all its recursive subrows expanded?
			-- `a_expanded_agent' is a function to decide if the grid row given as the only argument is expanded.
		require
			a_row_attached: a_row /= Void
			a_expanded_agent_attached: a_expanded_agent /= Void
		local
			l_row_count: INTEGER
			l_row_index: INTEGER
		do
			if a_row.is_expandable then
				Result := a_expanded_agent.item ([a_row])
				l_row_count := a_row.subrow_count
				if Result and then l_row_count > 0 then
					from
						l_row_index := 1
					until
						l_row_index > l_row_count or not Result
					loop
						Result := is_subrow_recursively_expanded (a_row.subrow (l_row_index), a_expanded_agent)
						l_row_index := l_row_index + 1
					end
				end
			else
				Result := True
			end
		end

	item_to_put_in_editor: EV_GRID_ITEM
			-- Grid item which may contain a stone to put into editor
			-- Void if no satisfied item is found.			
		deferred
		end

	open_item_editor (a_item: EV_GRID_ITEM)
			-- If `a_item' is an editor token item and contains a valid stone, open that stone in editor.
		require
			a_item_attached: a_item /= Void
		do
			if
				attached {EB_GRID_EDITOR_TOKEN_ITEM} a_item as l_editor_token_item and then
				attached l_editor_token_item.stone as l_stone and then
				l_stone.is_valid
			then
				development_window.set_stone (l_stone)
			end
		end

invariant
	development_window_attached: not is_recycled implies development_window /= Void

note
        copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
