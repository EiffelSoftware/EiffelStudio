indexing
	description: 
		"EiffelVision multi-column-list, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_IMP

inherit
	EV_MULTI_COLUMN_LIST_I
		redefine
			interface,
			initialize,
			item,
			call_pebble_function,
			wipe_out,
			append,
			pixmaps_size_changed
		end

	EV_PRIMITIVE_IMP
		redefine
			enable_transport,
			disable_transport,
			pre_pick_steps,
			call_pebble_function,
			post_drop_steps,
			start_transport_filter,
			initialize,
			interface,
			destroy,
			able_to_transport,
			ready_for_pnd_menu,
			set_to_drag_and_drop,
			button_press_switch,
			create_pointer_motion_actions
		end

	EV_ITEM_LIST_IMP [EV_MULTI_COLUMN_LIST_ROW]
		redefine
			i_th,
			count,
			insert_i_th,
			remove_i_th,
			interface,
			wipe_out,
			append,
			initialize
		end

	EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES_IMP
	
	EV_PND_DEFERRED_ITEM_PARENT

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is         
			-- Create a list widget with `par' as
			-- parent and `col_nb' columns.
			-- By default, a list allow only one selection.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_scrolled_window_new (NULL, NULL))
			{EV_GTK_EXTERNALS}.gtk_scrolled_window_set_policy (
				c_object,
				{EV_GTK_EXTERNALS}.GTK_POLICY_AUTOMATIC_ENUM,
				{EV_GTK_EXTERNALS}.GTK_POLICY_AUTOMATIC_ENUM
			)
			
			update_children_agent := agent update_children
			
			create ev_children.make (0)

				-- create a list with one column
			create_list (1)
			clear_selection
		end

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Create a pointer_motion action sequence.
		do
			create Result
		end

	call_selection_action_sequences is
			-- 
		do
			-- Not needed for 1.2 implementation
		end

	button_press_switch (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]

			a_row_number: INTEGER
			clicked_row: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y]
			a_row_number := row_index_from_y_coord (a_y)
			if a_row_number > 0 and then a_row_number <= count then
				clicked_row := ev_children @ a_row_number
			end
			if a_type = {EV_GTK_EXTERNALS}.gDK_BUTTON_PRESS_ENUM then
				if not is_transport_enabled and then pointer_button_press_actions_internal /= Void then
					pointer_button_press_actions_internal.call (t)
				end
				if
					clicked_row /= Void and then 
					clicked_row.pointer_button_press_actions_internal /= Void
				then
					clicked_row.pointer_button_press_actions_internal.call (t)
				end
			elseif a_type = {EV_GTK_EXTERNALS}.gDK_2BUTTON_PRESS_ENUM then --and not is_transport_enabled then
				if pointer_double_press_actions_internal /= Void then
					pointer_double_press_actions_internal.call (t)
				end
				if
					clicked_row /= Void and then 
					clicked_row.pointer_double_press_actions_internal /= Void
				then
					clicked_row.pointer_double_press_actions_internal.call (t)
				end
			end
        	end

	create_list (a_columns: INTEGER) is
			-- Create the clist with `a_columns' columns.
		require
			a_columns_positive: a_columns > 0
		local
			i: INTEGER
			old_list_widget: POINTER
			temp_title: STRING
			temp_width: INTEGER
			temp_alignment, default_alignment: EV_TEXT_ALIGNMENT
			temp_alignment_code: INTEGER
			p: POINTER
			is_multiple_selected: BOOLEAN
			on_key_event_intermediary_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE [EV_KEY, STRING, BOOLEAN]]
		do
			old_list_widget := list_widget
			if old_list_widget /= NULL then
				is_multiple_selected := multiple_selection_enabled
			end
			create default_alignment
			
			list_widget := {EV_GTK_EXTERNALS}.gtk_clist_new (a_columns)
			{EV_GTK_EXTERNALS}.gtk_clist_set_shadow_type (list_widget, {EV_GTK_EXTERNALS}.gTK_SHADOW_NONE_ENUM)
			disable_multiple_selection
		
			real_signal_connect (
				list_widget,
				"select_row",
				agent (App_implementation.gtk_marshal).mcl_event_intermediary (c_object, 1, ?),
				agent (App_implementation.gtk_marshal).gtk_value_int_to_tuple
			)
			real_signal_connect (
				list_widget,
				"unselect_row",
				agent (App_implementation.gtk_marshal).mcl_event_intermediary (c_object, 2, ?),
				agent (App_implementation.gtk_marshal).gtk_value_int_to_tuple
			)
			real_signal_connect (
				list_widget,
				"click_column",
				agent (App_implementation.gtk_marshal).mcl_event_intermediary (c_object, 3, ?),
				agent (App_implementation.gtk_marshal).gtk_value_int_to_tuple
			)
			real_signal_connect (
				list_widget,
				"resize_column",
				agent (App_implementation.gtk_marshal).mcl_event_intermediary (c_object, 4, ?),
				agent (App_implementation.gtk_marshal).column_resize_callback_translate
			)
			
			on_key_event_intermediary_agent := agent (App_implementation.gtk_marshal).on_key_event_intermediary (c_object, ?, ?, ?)
			real_signal_connect (list_widget, "key_press_event", on_key_event_intermediary_agent, key_event_translate_agent)
			real_signal_connect (list_widget, "key_release_event", on_key_event_intermediary_agent, key_event_translate_agent)

			if user_set_row_height > 0 then
				set_row_height (user_set_row_height)		
			else
				set_row_height (App_implementation.default_font_height + 5)
			end

			{EV_GTK_EXTERNALS}.gtk_widget_show (list_widget)

			show_title_row

			from
				i := 1
			until
				i > a_columns
			loop
				if column_titles /= Void and then
					column_titles.valid_index (i) and then
						column_titles.i_th (i) /= Void then
					temp_title := column_titles.i_th (i)
				else
					temp_title := ""
				end
				if column_widths /= Void and then 
								column_widths.valid_index (i) then
					temp_width := column_widths.i_th (i)
				else
					temp_width := Default_column_width
				end
				if column_alignments /= Void and then 
							column_alignments.valid_index (i) then
					-- Create alignment from alignment code.
					temp_alignment_code := column_alignments.i_th (i)
					create temp_alignment
					if temp_alignment_code = temp_alignment.left_alignment then
						temp_alignment.set_left_alignment
					elseif temp_alignment_code = temp_alignment.center_alignment then
						temp_alignment.set_center_alignment
					else
						temp_alignment.set_right_alignment
					end
				else
					temp_alignment := default_alignment
				end

				column_title_changed (temp_title, i)
				column_width_changed (temp_width, i)
				
				if i > 1 then
					-- 1st column is always left aligned.
					column_alignment_changed (temp_alignment, i)
				end

				i := i + 1
			end

			from
				ev_children.start
			until
				ev_children.after
			loop
				p := calloc ({EV_GTK_EXTERNALS}.gtk_clist_struct_columns (list_widget), sizeof_pointer)
				i := {EV_GTK_EXTERNALS}.gtk_clist_append (list_widget, p)
				p.memory_free;
				ev_children.item.dirty_child
				update_child (ev_children.item, ev_children.index)
				ev_children.forth
			end
			if old_list_widget /= NULL then
				{EV_GTK_EXTERNALS}.gtk_container_remove (c_object, old_list_widget)
			end
			{EV_GTK_EXTERNALS}.gtk_container_add (c_object, list_widget)
			--feature {EV_GTK_EXTERNALS}.gtk_scrolled_window_add_with_viewport (c_object, list_widget)
			if is_multiple_selected then
				enable_multiple_selection
			end
		end

	initialize is
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_MULTI_COLUMN_LIST_I}
			initialize_pixmaps
			connect_button_press_switch
			disable_multiple_selection
		end

	motion_handler (a_x, a_y: INTEGER; a_a, a_b, a_c: DOUBLE; a_d, a_e: INTEGER) is
		local
			t: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]
			a_row_number: INTEGER
			a_row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			t := [a_x, a_y, a_a, a_b, a_c, a_d, a_e]
			if pointer_motion_actions_internal /= Void then
				pointer_motion_actions_internal.call (t)
			end
			if a_y > 0 and a_x <= width then
				a_row_number := row_index_from_y_coord (a_y)
				if a_row_number > 0 and then a_row_number <= count then
					a_row_imp := ev_children @ a_row_number
					if a_row_imp.pointer_motion_actions_internal /= Void then
						a_row_imp.pointer_motion_actions_internal.call (t)
					end
				end
			end
		end
		
	pixmaps_size_changed is
			-- 
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
			if pixmaps_height > {EV_GTK_EXTERNALS}.gtk_clist_struct_row_height (list_widget) then
				set_row_height (pixmaps_height)
			end
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	select_callback (a_position: INTEGER) is
		local
			an_item: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			if not ignore_select_callback then	
				an_item := (ev_children @ (a_position + 1))
				if an_item /= previously_selected_node then
					if an_item.select_actions_internal /= Void then
						an_item.select_actions_internal.call (Void)
					end
					if select_actions_internal /= Void then
						select_actions_internal.call ([an_item.interface])
					end
					switch_to_browse_mode_if_necessary
				end
				previously_selected_node := an_item
			end
		end
		
	previously_selected_node: EV_MULTI_COLUMN_LIST_ROW_IMP

	deselect_callback (a_position: INTEGER) is
		local
			an_item: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			an_item := (ev_children @ (a_position + 1))
			if an_item.deselect_actions_internal /= Void then
				an_item.deselect_actions_internal.call (Void)
			end
			if deselect_actions_internal /= Void then
				deselect_actions_internal.call ([an_item.interface])
			end
		end

	column_click_callback (a_column: INTEGER) is
		do
			if column_title_click_actions_internal /= Void then
				column_title_click_actions_internal.call ([a_column + 1])
			end
		end

	column_resize_callback (a_column: INTEGER) is
		local
			temp_col, temp_wid: INTEGER_REF
		do
			temp_col := a_column
			-- Set column width array to new width.
			if (temp_col.item) <= column_count and column_widths /= Void then
				--| FIXME IEK Implement this  width = GTK_CLIST(clist)->column[col].width;
				temp_wid := 80
				update_column_width (temp_wid.item, temp_col.item)
				if column_resized_actions_internal /= Void then
					column_resized_actions_internal.call ([temp_col.item])
				end
			end
		end

feature -- Access

	column_count: INTEGER is
			-- Number of columns in the list.
		do
			if list_widget /= NULL then
				Result := {EV_GTK_EXTERNALS}.gtk_clist_struct_columns (list_widget)
			end
		end

	rows, count: INTEGER is
			-- Number of rows in the list.
		do
			Result := ev_children.count
		end

	i_th (i: INTEGER): EV_MULTI_COLUMN_LIST_ROW is
		do
			Result := (ev_children @ i).interface
		end

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Item which is currently selected, for a multiple
			-- selection.
		local
			an_index: INTEGER
		do
			if
				list_widget /= NULL and
				{EV_GTK_EXTERNALS}.g_list_length (
					{EV_GTK_EXTERNALS}.gtk_clist_struct_selection (list_widget)
				) = 0
			then
					-- there is no selected item
				Result := Void
			elseif list_widget /= NULL then
					-- there is one selected item
				an_index := pointer_to_integer (
					{EV_GTK_EXTERNALS}.g_list_nth_data (
						{EV_GTK_EXTERNALS}.gtk_clist_struct_selection (list_widget),
						0
					)
				)
				Result := (ev_children @ (an_index + 1)).interface
			end
		end

	selected_items: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list.
		local
			i: INTEGER
			an_index: INTEGER
			upper: INTEGER
			row: EV_MULTI_COLUMN_LIST_ROW
		do
			if list_widget /= NULL then
				upper := {EV_GTK_EXTERNALS}.g_list_length (
					{EV_GTK_EXTERNALS}.gtk_clist_struct_selection (list_widget)
				)
			end
			create Result.make (0)
			from
				i := 0
			until
				i = upper
			loop
				an_index := pointer_to_integer (
					{EV_GTK_EXTERNALS}.g_list_nth_data (
						{EV_GTK_EXTERNALS}.gtk_clist_struct_selection (list_widget),
						i
					)
				)
				row := (ev_children @ (an_index + 1)).interface
				Result.force (row)
				i := i + 1
			end
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			if list_widget /= NULL then
				Result := {EV_GTK_EXTERNALS}.g_list_length (
					{EV_GTK_EXTERNALS}.gtk_clist_struct_selection (list_widget)
				).to_boolean
			end
		end

	multiple_selection_enabled: BOOLEAN
			-- True if the user can choose several items
			-- False otherwise.

	title_shown: BOOLEAN is
			-- True if the title row is shown.
			-- False if the title row is not shown.
		do
			if list_widget /= NULL then
				Result := {EV_GTK_EXTERNALS}.gtk_clist_struct_flags (list_widget).bit_and (
					gtk_clist_show_titles_enum
				).to_boolean
			end
		end

feature -- Status setting

	destroy is
			-- Destroy screen widget implementation and EV_LIST_ITEM objects.
		do
			clear_items
			Precursor {EV_PRIMITIVE_IMP}
		end

	show_title_row is
			-- Show the row of the titles.
		do
			{EV_GTK_EXTERNALS}.gtk_clist_column_titles_show (list_widget)
		end

	hide_title_row is
			-- Hide the row of the titles.
		do
			{EV_GTK_EXTERNALS}.gtk_clist_column_titles_hide (list_widget)
		end

	enable_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
			-- For constants, see EV_GTK_CONSTANTS.
		do
			multiple_selection_enabled := True
			ignore_select_callback := True
			if selection_mode_is_single then
				{EV_GTK_EXTERNALS}.gtk_clist_set_selection_mode (
					list_widget,
					{EV_GTK_EXTERNALS}.gTK_SELECTION_MULTIPLE_ENUM
				)
			else
				{EV_GTK_EXTERNALS}.gtk_clist_set_selection_mode (
					list_widget,
					{EV_GTK_EXTERNALS}.gTK_SELECTION_EXTENDED_ENUM
				)
			end
			ignore_select_callback := False
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
			-- For constants, see EV_GTK_CONSTANTS.
		local
			sel_items: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW]
			sel_item: EV_MULTI_COLUMN_LIST_ROW
		do
			multiple_selection_enabled := False
			ignore_select_callback := True
			selection_mode_is_single := True
			sel_items := selected_items
			if not sel_items.is_empty then
				sel_item := sel_items.first
			end	
			{EV_GTK_EXTERNALS}.gtk_clist_set_selection_mode (
				list_widget,
				{EV_GTK_EXTERNALS}.gTK_SELECTION_SINGLE_ENUM
			)
			if sel_item /= Void then
				sel_item.enable_select
				sel_item.select_actions.call (Void)
			end	
			ignore_select_callback := False
		
		end

	select_item (an_index: INTEGER) is
			-- Select an item at the one-based `index' of the list.
		do
			switch_to_browse_mode_if_necessary;
			(ev_children @ an_index).enable_select
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
			switch_to_single_mode_if_necessary;
			(ev_children @ an_index).disable_select
		end

	clear_selection is
			-- Clear the selection of the list.
		do
			if list_widget /= NULL then
				switch_to_single_mode_if_necessary
				ignore_select_callback := True
				{EV_GTK_EXTERNALS}.gtk_clist_unselect_all (list_widget)
				ignore_select_callback := False
			end
		end

	resize_column_to_content (a_column: INTEGER) is
			-- Resize column `a_column' to width of its widest text.
		do
			if list_widget /= NULL then
				column_width_changed (
					{EV_GTK_EXTERNALS}.gtk_clist_optimal_column_width (list_widget, a_column - 1).max (column_width (a_column)),
					a_column
				)
			end
		end

feature -- Element change

	append (s: SEQUENCE [EV_MULTI_COLUMN_LIST_ROW]) is
			-- Copy `s' to end of `Current'.  Do not move cursor.
		do
			{EV_GTK_EXTERNALS}.gtk_clist_freeze (list_widget)
			Precursor (s)
			{EV_GTK_EXTERNALS}.gtk_clist_thaw (list_widget)			
		end

	column_title_changed (a_txt: STRING; a_column: INTEGER) is
			-- Make `a_txt' the title of the column number.
		local
			a_cs: EV_GTK_C_STRING
		do
			if list_widget /= NULL then
				a_cs := a_txt
				{EV_GTK_EXTERNALS}.gtk_clist_set_column_title (
					list_widget,
					a_column - 1,
					a_cs.item
				)
			end
		end

	column_width_changed (value: INTEGER; column: INTEGER) is
			-- Make `value' the new width of the column number
			-- `column'.
		do
			if list_widget /= NULL then
				{EV_GTK_EXTERNALS}.gtk_clist_set_column_width (list_widget, column - 1, value)
			end
		end

	column_alignment_changed (an_alignment: EV_TEXT_ALIGNMENT; a_column: INTEGER) is
			-- Set alignment of `a_column' to corresponding `alignment_code'.
		local
			an_alignment_code: INTEGER
		do
			if an_alignment.is_left_aligned then
				an_alignment_code := {EV_GTK_EXTERNALS}.gTK_JUSTIFY_LEFT_ENUM
			elseif an_alignment.is_center_aligned then
				an_alignment_code := {EV_GTK_EXTERNALS}.gTK_JUSTIFY_CENTER_ENUM
			else
				an_alignment_code := {EV_GTK_EXTERNALS}.gTK_JUSTIFY_RIGHT_ENUM
			end

			{EV_GTK_EXTERNALS}.gtk_clist_set_column_justification (
				list_widget,
				a_column - 1,
				an_alignment_code
			)
		end

	set_row_height (value: INTEGER) is
			-- Make `value' the new height of all the rows.
		do
			if list_widget /= NULL then
				{EV_GTK_EXTERNALS}.gtk_clist_set_row_height (list_widget, value)
			end
			user_set_row_height := value
		end
		
	user_set_row_height: INTEGER
		-- Row height set by user, 0 is not set.

	clear_items is
			-- Clear all the items of the list.
			-- (Remove them from the list and destroy them).
		do
			if rows > 0 then
				ev_children.wipe_out	
				{EV_GTK_EXTERNALS}.gtk_clist_clear (list_widget)
			end
		end
		
	wipe_out is
			-- Remove all items.
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
				-- Remove all items (GTK part)
			clear_selection
			{EV_GTK_EXTERNALS}.gtk_clist_clear (list_widget)
			from
				ev_children.start
			until
				ev_children.after
			loop
				item_imp := ev_children.item
				item_imp.set_parent_imp (Void)
				ev_children.forth
			end

				-- Renew storage containers.
			ev_children.wipe_out
			child_array.wipe_out
			index := 0

			update_pnd_status
		end

feature -- Implementation

	set_to_drag_and_drop: BOOLEAN is
			-- Set transport mode to drag and drop.
		do
			if pnd_row_imp /= Void then
				Result := pnd_row_imp.mode_is_drag_and_drop
			else
				Result := mode_is_drag_and_drop
			end
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
			-- Is list or row able to transport PND data using `a_button'.
		do
			if pnd_row_imp /= Void then
				Result := (pnd_row_imp.mode_is_drag_and_drop and a_button = 1) or
				(pnd_row_imp.mode_is_pick_and_drop and a_button = 3)
			else
				Result := (mode_is_drag_and_drop and a_button = 1) or
				(mode_is_pick_and_drop and a_button = 3)
			end
		end

	ready_for_pnd_menu (a_button: INTEGER): BOOLEAN is
			-- Is list or row able to display PND menu using `a_button'
		do
			if pnd_row_imp /= Void then
				Result := pnd_row_imp.mode_is_target_menu and then a_button = 3
			else
				Result := mode_is_target_menu and then a_button = 3
			end
		end

	enable_transport is
		do
			connect_pnd_callback
		end

	connect_pnd_callback is
		do
			check
				button_release_not_connected: button_release_connection_id = 0
			end
			if button_press_connection_id > 0 then
				{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (c_object, button_press_connection_id)
			end
			real_signal_connect (c_object,
				"button-press-event", 
				agent (App_implementation.gtk_marshal).mcl_start_transport_filter_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?, ?),
				App_implementation.default_translate)
			button_press_connection_id := last_signal_connection_id
			is_transport_enabled := True
		end

	disable_transport is
		do
			Precursor
			update_pnd_status
		end

	update_pnd_status is
			-- Update PND status of list and its children.
		local
			a_enable_flag: BOOLEAN
		do
			from
				ev_children.start
			until
				ev_children.after or else a_enable_flag
			loop
				a_enable_flag := ev_children.item.is_transport_enabled
				ev_children.forth
			end
			update_pnd_connection (a_enable_flag)
		end
		
	update_pnd_connection (a_enable: BOOLEAN) is
			-- Update the PND connection of `Current' if needed.
		do
			if not is_transport_enabled then
				if a_enable or pebble /= Void then
					connect_pnd_callback
				end
			elseif not a_enable and pebble = Void then
				disable_transport_signals
				is_transport_enabled := False
			end		
		end

	start_transport_filter (
			a_type: INTEGER
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Initialize a pick and drop transport.
		local
			a_row_index: INTEGER
		do
			a_row_index := row_index_from_y_coord (a_y)

			if a_row_index > 0 then
				pnd_row_imp := ev_children.i_th (a_row_index)
				if not pnd_row_imp.able_to_transport (a_button) then
					pnd_row_imp := Void
				end
			end

			Precursor (
				a_type,
				a_x, a_y, a_button,
				a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y
			)		
		end

	pnd_row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			-- Implementation object of the current row if in PND transport.

	temp_pebble: ANY

	temp_pebble_function: FUNCTION [ANY, TUPLE [], ANY]
			-- Returns data to be transported by PND mechanism.

	temp_accept_cursor, temp_deny_cursor: EV_CURSOR

	call_pebble_function (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Set `pebble' using `pebble_function' if present.
		do
			temp_pebble := pebble
			temp_pebble_function := pebble_function
			if pnd_row_imp /= Void then
				pebble := pnd_row_imp.pebble
				pebble_function := pnd_row_imp.pebble_function
			end

			if pebble_function /= Void then
				pebble_function.call ([a_x, a_y]);
				pebble := pebble_function.last_result
			end		
		end
	
	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Steps to perform before transport initiated.
		do

			temp_accept_cursor := accept_cursor
			temp_deny_cursor := deny_cursor
			app_implementation.on_pick (pebble)

			if pnd_row_imp /= Void then
				if pnd_row_imp.pick_actions_internal /= Void then
					pnd_row_imp.pick_actions_internal.call ([a_x, a_y])
				end
				accept_cursor := pnd_row_imp.accept_cursor
				deny_cursor := pnd_row_imp.deny_cursor
			else
				if pick_actions_internal /= Void then
					pick_actions_internal.call ([a_x, a_y])
				end
			end

			pointer_x := a_screen_x
			pointer_y := a_screen_y

			if pnd_row_imp = Void then
				if (pick_x = 0 and then pick_y = 0) then
					x_origin := a_screen_x
					y_origin := a_screen_y
				else
					if pick_x > width then
						pick_x := width
					end
					if pick_y > height then
						pick_y := height
					end
					x_origin := pick_x + (a_screen_x - a_x)
					y_origin := pick_y + (a_screen_y - a_y)
				end
			else
				if (pnd_row_imp.pick_x = 0 and then pnd_row_imp.pick_y = 0) then
					x_origin := a_screen_x
					y_origin := a_screen_y
				else
					if pick_x > width then
						pick_x := width
					end
					if pick_y > row_height then
						pick_y := row_height
					end
					x_origin := pnd_row_imp.pick_x + (a_screen_x - a_x)
					y_origin := 
						pnd_row_imp.pick_y +
						(a_screen_y - a_y) + 
						((ev_children.index_of (pnd_row_imp, 1) - 1) * row_height)
				end
			end
		end

	post_drop_steps (a_button: INTEGER) is
			-- Steps to perform once an attempted drop has happened.
		do
			if a_button > 0 and then pnd_row_imp /= Void and not is_destroyed then
				if pnd_row_imp.mode_is_pick_and_drop then
					signal_emit_stop (c_object, "button-press-event")
				end
			elseif a_button > 0 and then mode_is_pick_and_drop and not is_destroyed then
					signal_emit_stop (c_object, "button-press-event")
			end
			x_origin := 0
			y_origin := 0
			last_pointed_target := Void	

			if pebble_function /= Void then
				if pnd_row_imp /= Void then
					pnd_row_imp.set_pebble_void
				else
					temp_pebble := Void
				end
			end

			accept_cursor := temp_accept_cursor
			deny_cursor := temp_deny_cursor
			pebble := temp_pebble
			pebble_function := temp_pebble_function

			temp_pebble := Void
			temp_pebble_function := Void
			temp_accept_cursor := Void
			temp_deny_cursor := Void

			pnd_row_imp := Void
		end


feature {EV_MULTI_COLUMN_LIST_ROW_IMP} -- Implementation

	row_index_from_y_coord (a_y: INTEGER): INTEGER is
			-- Returns the row index at relative coordinate `a_y'.
		local
			ver_adj: POINTER
			temp_a_y, ver_offset: INTEGER
		do
			ver_adj := {EV_GTK_EXTERNALS}.gtk_scrolled_window_get_vadjustment (c_object)
			ver_offset := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_value (ver_adj).rounded
			temp_a_y := a_y + ver_offset
			Result := temp_a_y // (row_height) + 1
			if Result > ev_children.count then
				Result := 0
			end
		end
		
	row_from_y_coord (a_y: INTEGER): EV_PND_DEFERRED_ITEM is
			-- Returns the row at relative coordinate `a_y'
		local
			a_row_index: INTEGER
		do
			a_row_index := row_index_from_y_coord (a_y)
			if a_row_index > 0 then
				Result := ev_children @ a_row_index
			end
		end

feature {NONE} -- Implementation

	gtk_clist_struct_columns (a_clist: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkCList): EIF_POINTER"
		alias
			"columns"
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP}

	set_text_on_position (a_column, a_row: INTEGER; a_text: STRING) is
			-- Set cell text at (a_column, a_row) to `a_text'.
		local
			pixmap_imp: EV_PIXMAP_IMP
			a_cs: EV_GTK_C_STRING
		do
			a_cs := a_text
			if  a_column = 1 and then ev_children.i_th (a_row).internal_pixmap /= Void then
				pixmap_imp ?= ev_children.i_th (a_row).internal_pixmap.implementation
				
				{EV_GTK_EXTERNALS}.gtk_clist_set_pixtext (
					list_widget,
					a_row - 1,
					a_column - 1,
					a_cs.item,
					3,
					pixmap_imp.drawable,
					pixmap_imp.mask
				)
			else
				{EV_GTK_EXTERNALS}.gtk_clist_set_text (
					list_widget,
					a_row - 1,
					a_column - 1,
					a_cs.item
				)
			end
		end

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Set row `a_row' pixmap to `a_pixmap'.
		do
			--| Do nothing, implementation not needed for GTK as it is done when the
		end

feature {NONE} -- Implementation

	update_children is
			-- Update all children with `update_needed' True.
			--| We are on an idle action now. At least one item has marked
			--| itself `update_needed'.
		local
			cur: CURSOR
			new_column_count: INTEGER
		do
			cur := ev_children.cursor
			from
				ev_children.start
			until
				ev_children.after
			loop
				if ev_children.item.interface.count > column_count then
					new_column_count := ev_children.item.interface.count
				end
				ev_children.forth
			end

			if new_column_count > column_count then
				expand_column_count_to (new_column_count)
			end

			from
				ev_children.start
			until
				ev_children.after
			loop
				if ev_children.item.update_needed then
					update_child (ev_children.item, ev_children.index)
				end
				ev_children.forth
			end
			ev_children.go_to (cur)
		end

	update_child (child: EV_MULTI_COLUMN_LIST_ROW_IMP; a_row: INTEGER) is
			-- Update `child'.
		require
			child_exists: child /= Void
			child_dirty: child.update_needed
			room_for_child: child.interface.count <= column_count
		local
			cur: CURSOR
			txt: STRING
			list: EV_MULTI_COLUMN_LIST_ROW
			column_counter: INTEGER
		do
			list := child.interface
			cur := list.cursor
			from
				column_counter := 1
				list.start
			until
				column_counter > column_count
			loop
					-- Set the text in the cell
				if list.after then
					txt := ""
				else
					txt := list.item
					if txt = Void then
						txt := ""
					end
				end
				set_text_on_position (column_counter, a_row, txt)
					-- Pixmap gets updated when the text does.

					-- Prepare next iteration
				if not list.after then
					list.forth
				end
				column_counter := column_counter + 1
			end
			list.go_to (cur)
			child.update_performed
		ensure
			child_updated: not child.update_needed
		end

	selection_mode_is_single: BOOLEAN
			-- Is selection mode set to SINGLE?
	
	switch_to_single_mode_if_necessary is
			-- Change selection mode if the last selected
			-- item is deselected.
		local
			sel_items: like selected_items
		do
			if list_widget /= NULL and then not selection_mode_is_single then
				ignore_select_callback := True
				if multiple_selection_enabled then
					sel_items := selected_items
					if 
						sel_items = Void 
							or else
						selected_items.count <= 1
					then
						{EV_GTK_EXTERNALS}.gtk_clist_set_selection_mode (
							list_widget,
							{EV_GTK_EXTERNALS}.gtk_selection_multiple_enum
						)
						selection_mode_is_single := True
					end
				else
					{EV_GTK_EXTERNALS}.gtk_clist_set_selection_mode (
						list_widget,
						{EV_GTK_EXTERNALS}.gtk_selection_single_enum
					)
					selection_mode_is_single := True
				end
				ignore_select_callback := False
			end
		end
		
	switch_to_browse_mode_if_necessary is
			-- Change selection mode to browse mode
			-- if necessary.
		do
			if list_widget /= NULL and then selection_mode_is_single then
				ignore_select_callback := True
				if multiple_selection_enabled then
					{EV_GTK_EXTERNALS}.gtk_clist_set_selection_mode (
						list_widget, 
						{EV_GTK_EXTERNALS}.gtk_selection_extended_enum
					)					
				else
					{EV_GTK_EXTERNALS}.gtk_clist_set_selection_mode (
						list_widget,
						{EV_GTK_EXTERNALS}.gtk_selection_browse_enum
					)
				end
				ignore_select_callback := False
				selection_mode_is_single := False
			end
		end
		
	ignore_select_callback: BOOLEAN
		-- Ignore the select callback should selection mode change

	ensure_item_visible (a_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Ensure `a_item' is visible on the screen.
		do
			--| FIXME To be implemented
		end

	expand_column_count_to (a_columns: INTEGER) is
		do
			create_list (a_columns)
		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			p: POINTER
			dummy: INTEGER
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)

			-- update the list of rows of the column list:			
			ev_children.go_i_th (i)
			ev_children.put_left (item_imp)

			if v.count > column_count then
				create_list (v.count)
			else
				-- add row to the existing gtk column list:
				p := calloc ({EV_GTK_EXTERNALS}.gtk_clist_struct_columns (list_widget), sizeof_pointer)
				dummy := {EV_GTK_EXTERNALS}.gtk_clist_append (list_widget, p)
				p.memory_free;
				item_imp.dirty_child
				update_child (item_imp, ev_children.count)
			end
			
			if item_imp.is_transport_enabled then
				update_pnd_connection (True)
			end
	
			child_array.go_i_th (i)
			child_array.put_left (v)		
			
			if i < count then
				-- reorder_child (v, v_imp, i)
				{EV_GTK_EXTERNALS}.gtk_clist_row_move (
					list_widget,
					item_imp.index - 1,
					i - 1
				)
			end
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item from list at `a_position'.
			-- Set the items parent to void.
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			clear_selection
			item_imp := (ev_children @ (a_position))
			item_imp.set_parent_imp (Void)
			{EV_GTK_EXTERNALS}.gtk_clist_remove (list_widget, a_position - 1)
			-- remove the row from the `ev_children'
			ev_children.go_i_th (a_position)
			ev_children.remove
			child_array.go_i_th (a_position)
			child_array.remove
			update_pnd_status
		end

	row_height: INTEGER is
		do
			if list_widget /= NULL then
				Result := {EV_GTK_EXTERNALS}.gtk_clist_struct_row_height (list_widget) + 1
			end			
		end

feature {NONE} -- Externals

	pointer_to_integer (pointer: POINTER): INTEGER is
			-- int pointer_to_integer (void* pointer) {
			--     return (int) pointer;
			-- }
			-- Hack used for Result = ((EIF_INTEGER)(pointer)), blank alias avoids parser rules.
		external
			"C [macro <stdio.h>] (EIF_POINTER): EIF_INTEGER"
		alias
			" "
		end

	frozen gtk_clist_show_titles_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_CLIST_SHOW_TITLES"
		end

	calloc (nmemb, size: INTEGER): POINTER is
			-- void *calloc(size_t nmemb, size_t size);
		external
			"C (size_t, size_t): void* | <stdlib.h>"
		end
		
	sizeof_pointer: INTEGER is
		external
			"C [macro <stdio.h>]"
		alias
			"sizeof(void*)"
		end

feature {EV_ANY_I} -- Implementation

	list_widget: POINTER

	interface: EV_MULTI_COLUMN_LIST
	
	update_children_agent: PROCEDURE [EV_MULTI_COLUMN_LIST_I, TUPLE]
			-- Agent object for update_children

feature {EV_ANY_I} -- External

    frozen gtk_clist_column_width (a_clist: POINTER; a_column: INTEGER): INTEGER is
        external
            "C inline use <gtk/gtk.h>"
        alias
            "GTK_CLIST ($a_clist)->column[$a_column].width"
        end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MULTI_COLUMN_LIST_IMP

