indexing
	description: 
		"EiffelVision multi-column-list, implementation interface."
	status: "See notice at end of class"
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
			update_child,
			wipe_out
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
			pointer_over_widget,
			interface,
			destroy,
			visual_widget,
			able_to_transport,
			ready_for_pnd_menu,
			set_to_drag_and_drop,
			button_press_switch,
			create_pointer_motion_actions,
			disconnect_all_signals
		end

	EV_ITEM_LIST_IMP [EV_MULTI_COLUMN_LIST_ROW]
		redefine
			i_th,
			count,
			remove_i_th,
			reorder_child,
			add_to_container,
			destroy,
			list_widget,
			interface,
			visual_widget,
			disconnect_all_signals,
			wipe_out
		end

	EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is         
			-- Create a list widget with `par' as
			-- parent and `col_nb' columns.
			-- By default, a list allow only one selection.
		do
			base_make (an_interface)
			set_c_object (C.gtk_scrolled_window_new (NULL, NULL))
			C.gtk_scrolled_window_set_policy (
				c_object,
				C.GTK_POLICY_AUTOMATIC_ENUM,
				C.GTK_POLICY_AUTOMATIC_ENUM
			)
			visual_widget := C.gtk_event_box_new
			C.gtk_widget_show (visual_widget)
			C.gtk_scrolled_window_add_with_viewport (c_object, visual_widget)
			create ev_children.make (0)
			set_row_height (15)
				-- create a list with one column
			create_list (1)
		end

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Create a pointer_motion action sequence.
		do
			create Result
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
			a_row_number := (a_y // (row_height + 1)) + 1
			if a_row_number <= count then
				clicked_row := ev_children @ a_row_number
			end
			if a_type = C.GDK_BUTTON_PRESS_ENUM then
				if not is_transport_enabled and then pointer_button_press_actions_internal /= Void then
					pointer_button_press_actions_internal.call (t)
				end
				if
					clicked_row /= Void and then 
					clicked_row.pointer_button_press_actions_internal /= Void
				then
					clicked_row.pointer_button_press_actions_internal.call (t)
				end
			elseif a_type = C.GDK_2BUTTON_PRESS_ENUM then --and not is_transport_enabled then
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
		do
			
			old_list_widget := list_widget
			if old_list_widget /= NULL then
				is_multiple_selected := multiple_selection_enabled
			end
			create default_alignment
			
			list_widget := C.gtk_clist_new (a_columns)
			disable_multiple_selection
		
			real_signal_connect (
				list_widget,
				"select_row",
				agent select_callback,
				agent gtk_value_int_to_tuple
			)
			real_signal_connect (
				list_widget,
				"unselect_row",
				agent deselect_callback,
				agent gtk_value_int_to_tuple
			)
			real_signal_connect (
				list_widget,
				"click_column",
				agent column_click_callback,
				agent gtk_value_int_to_tuple
			)
			real_signal_connect (
				list_widget,
				"resize_column",
				agent column_resize_callback,
				agent column_resize_callback_translate
			)				
			
			if row_height > 0 then
				set_row_height (row_height)		
			end

			C.gtk_widget_show (list_widget)

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
				p := calloc (C.gtk_clist_struct_columns (list_widget), sizeof_pointer)
				i := C.gtk_clist_append (list_widget, p)
				c_free (p);
				ev_children.item.dirty_child
				update_child (ev_children.item, ev_children.index)
				ev_children.forth
			end
			
			if old_list_widget /= NULL then
				C.gtk_container_remove (visual_widget, old_list_widget)
			end
			C.gtk_container_add (visual_widget, list_widget)
			if is_multiple_selected then
				enable_multiple_selection
			end
		end

	select_callback (int: TUPLE [INTEGER]) is
		local
			temp_int: INTEGER_REF
			a_position: INTEGER
			an_item: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			temp_int ?= int.item (1)
			a_position := temp_int.item + 1

			an_item := (ev_children @ a_position)
			if an_item.select_actions_internal /= Void then
				an_item.select_actions_internal.call ([])
			end
			if select_actions_internal /= Void then
				select_actions_internal.call ([an_item.interface])
			end
			switch_to_browse_mode_if_necessary
		end

	deselect_callback (int: TUPLE [INTEGER]) is
		local
			temp_int: INTEGER_REF
			a_position: INTEGER
			an_item: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			temp_int ?= int.item (1)
			a_position := temp_int.item + 1
			an_item := (ev_children @ a_position)
			if an_item.deselect_actions_internal /= Void then
				an_item.deselect_actions_internal.call ([])
			end
			if deselect_actions_internal /= Void then
				deselect_actions_internal.call ([an_item.interface])
			end
		end

	column_click_callback (int: INTEGER) is
		do
			if column_title_click_actions_internal /= Void then
				column_title_click_actions_internal.call ([int + 1])
			end
		end

	column_resize_callback_translate (n: INTEGER; args: POINTER): TUPLE is
		local
			gtkarg2: POINTER
		do
			gtkarg2 := gtk_args_array_i_th (args, 1)
			Result := [gtk_marshal.gtk_value_int (args) + 1, gtk_marshal.gtk_value_int (gtkarg2)]
			-- Column is zero based in gtk.
		end

	column_resize_callback (int: TUPLE [INTEGER]) is
		local
			temp_col, temp_wid: INTEGER_REF
		do
			temp_col ?= int.item (1)
			-- Set column width array to new width.
			if (temp_col.item) <= column_count and column_widths /= Void then
				temp_wid ?= int.item (2)
				update_column_width (temp_wid.item, temp_col.item)
			end
		end

	initialize is
		do
			{EV_PRIMITIVE_IMP} Precursor
			{EV_MULTI_COLUMN_LIST_I} Precursor
			real_signal_connect (visual_widget, "motion_notify_event", agent motion_handler, Default_translate)
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
			if a_y > y_coord_offset then
				a_row_number := ((a_y - y_coord_offset) // row_height) + 1
				if a_row_number <= count then
					a_row_imp := ev_children @ a_row_number
					if a_row_imp.pointer_motion_actions_internal /= Void then
						a_row_imp.pointer_motion_actions_internal.call (t)
					end
				end
			end
		end

feature -- Access

	column_count: INTEGER is
			-- Number of columns in the list.
		do
			if list_widget /= NULL then
				Result := C.gtk_clist_struct_columns (list_widget)
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
				C.g_list_length (
					C.gtk_clist_struct_selection (list_widget)
				) = 0
			then
					-- there is no selected item
				Result := Void
			elseif list_widget /= NULL then
					-- there is one selected item
				an_index := pointer_to_integer (
					C.g_list_nth_data (
						C.gtk_clist_struct_selection (list_widget),
						0
					)
				)
				Result ?= (ev_children @ (an_index + 1)).interface
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
				upper := C.g_list_length (
					C.gtk_clist_struct_selection (list_widget)
				)
			end
			create Result.make (0)
			from
				i := 0
			until
				i = upper
			loop
				an_index := pointer_to_integer (
					C.g_list_nth_data (
						C.gtk_clist_struct_selection (list_widget),
						i
					)
				)
				row ?= (ev_children @ (an_index + 1)).interface
				Result.force (row)
				i := i + 1
			end
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			if list_widget /= NULL then
				Result := C.g_list_length (
					C.gtk_clist_struct_selection (list_widget)
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
				Result := C.gtk_clist_struct_flags (list_widget).bit_and (
					C.Gtk_clist_show_titles_enum
				).to_boolean
			end
		end

feature -- Status setting

	destroy is
			-- Destroy screen widget implementation and EV_LIST_ITEM objects.
		do
			clear_items
			{EV_PRIMITIVE_IMP} Precursor 
		end

	show_title_row is
			-- Show the row of the titles.
		do
			C.gtk_clist_column_titles_show (list_widget)
		end

	hide_title_row is
			-- Hide the row of the titles.
		do
			C.gtk_clist_column_titles_hide (list_widget)
		end

	enable_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
			-- For constants, see EV_GTK_CONSTANTS.
		do
			multiple_selection_enabled := True
			if selection_mode_is_single then
				C.gtk_clist_set_selection_mode (
					list_widget,
					C.GTK_SELECTION_MULTIPLE_ENUM
				)
			else
				C.gtk_clist_set_selection_mode (
					list_widget,
					C.GTK_SELECTION_EXTENDED_ENUM
				)
			end
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
			-- For constants, see EV_GTK_CONSTANTS.
		do
			multiple_selection_enabled := False
			selection_mode_is_single := True
			C.gtk_clist_unselect_all (list_widget)
			C.gtk_clist_set_selection_mode (
				list_widget,
				C.GTK_SELECTION_SINGLE_ENUM
			)
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
				C.gtk_clist_unselect_all (list_widget)
			end
		end

	resize_column_to_content (a_column: INTEGER) is
			-- Resize column `a_column' to width of its widest text.
		do
			if list_widget /= NULL then
				column_width_changed (
					C.gtk_clist_optimal_column_width (list_widget, a_column - 1),
					a_column
				)
			end
		end

feature -- Element change

	column_title_changed (a_txt: STRING; a_column: INTEGER) is
			-- Make `a_txt' the title of the column number.
		do
			if list_widget /= NULL then
				C.gtk_clist_set_column_title (
					list_widget,
					a_column - 1,
					eiffel_to_c (a_txt)
				)
			end
		end

	column_width_changed (value: INTEGER; column: INTEGER) is
			-- Make `value' the new width of the column number
			-- `column'.
		do
			if list_widget /= NULL then
				C.gtk_clist_set_column_width (list_widget, column - 1, value)
			end
		end

	column_alignment_changed (an_alignment: EV_TEXT_ALIGNMENT; a_column: INTEGER) is
			-- Set alignment of `a_column' to corresponding `alignment_code'.
		local
			an_alignment_code: INTEGER
		do
			if an_alignment.is_left_aligned then
				an_alignment_code := C.GTK_JUSTIFY_LEFT_ENUM
			elseif an_alignment.is_center_aligned then
				an_alignment_code := C.GTK_JUSTIFY_CENTER_ENUM
			else
				an_alignment_code := C.GTK_JUSTIFY_RIGHT_ENUM
			end

			C.gtk_clist_set_column_justification (
				list_widget,
				a_column - 1,
				an_alignment_code
			)
		end

	set_row_height (value: INTEGER) is
			-- Make `value' the new height of all the rows.
		do
			if list_widget /= NULL then
				C.gtk_clist_set_row_height (list_widget, value)
			end
			row_height := value
		end

	clear_items is
			-- Clear all the items of the list.
			-- (Remove them from the list and destroy them).
		do
			if rows > 0 then
				ev_children.wipe_out	
				C.gtk_clist_clear (list_widget)
			end
		end
		
	wipe_out is
			-- Remove all items.
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
				-- Remove all items (GTK part)
			C.gtk_clist_clear (list_widget)
			from
				ev_children.start
			until
				ev_children.after
			loop
				item_imp := ev_children.item
				item_imp.set_parent_imp (Void)
				ev_children.forth
			end

				-- Remove all items (Eiffel part)
			ev_children.wipe_out
			index := 0

			update_pnd_status
		end


feature {EV_APPLICATION_IMP} -- Implementation

	pointer_over_widget (a_gdkwin: POINTER; a_x, a_y: INTEGER): BOOLEAN is
			-- Is mouse pointer hovering above list.
		local
			gdkwin_parent, gdkwin_parent_parent: POINTER
			clist_parent: POINTER
		do
			if is_displayed then
				gdkwin_parent := C.gdk_window_get_parent (a_gdkwin)
				if gdkwin_parent /= NULL then
					gdkwin_parent_parent := C.gdk_window_get_parent (gdkwin_parent)
				end
				clist_parent := C.gdk_window_get_parent (
					C.gtk_clist_struct_clist_window (list_widget)
				)
				Result := gdkwin_parent = clist_parent or
					gdkwin_parent_parent = clist_parent

				if clist_parent = gdkwin_parent then
					if row_from_y_coord (a_y) /= 0 then
						Result := False
					end
				end
			end
		end

feature -- Implementation

	update_child (child: EV_MULTI_COLUMN_LIST_ROW_IMP; a_row: INTEGER) is
		do
			C.gtk_clist_freeze (list_widget)
			Precursor {EV_MULTI_COLUMN_LIST_I} (child, a_row)
			C.gtk_clist_thaw (list_widget)
		end

	set_to_drag_and_drop: BOOLEAN is
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
				signal_disconnect (button_press_connection_id)
			end
			signal_connect ("button-press-event", agent start_transport_filter, default_translate)
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

			if not is_transport_enabled then
				if a_enable_flag or pebble /= Void then
					connect_pnd_callback
				end
			elseif not a_enable_flag and pebble = Void then
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
			a_row_index := row_from_y_coord (a_y)

			if a_row_index > 0 then
				pnd_row_imp := ev_children.i_th (a_row_index)
				if not pnd_row_imp.able_to_transport (a_button) then
					pnd_row_imp := Void
				end
			end
			
			if pnd_row_imp /= Void or else pebble /= Void then
				Precursor (
				a_type,
				a_x, a_y, a_button,
				a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y)
			end			
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
		local
			env: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
		do
			create env
			app_imp ?= env.application.implementation
			check
				app_imp_not_void: app_imp /= Void
			end

			temp_accept_cursor := accept_cursor
			temp_deny_cursor := deny_cursor
			app_imp.on_pick (pebble)

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

			if accept_cursor = Void then
				--| FIXME IEK
				create accept_cursor--.make_with_code (curs_code.standard)
			end
			if deny_cursor = Void then
				create deny_cursor--.make_with_code (curs_code.no)
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

	post_drop_steps is
			-- Steps to perform once an attempted drop has happened.
		local
			env: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
		do
			if pnd_row_imp /= Void then
				if pnd_row_imp.mode_is_pick_and_drop then
					signal_emit_stop (visual_widget, "button-press-event")
				end
			elseif mode_is_pick_and_drop then
					signal_emit_stop (visual_widget, "button-press-event")
			end
			create env
			app_imp ?= env.application.implementation
			check
				app_imp_not_void: app_imp /= Void
			end

			app_imp.on_drop (pebble)
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

	row_from_y_coord (a_y: INTEGER): INTEGER is
			-- Returns the row at relative coordinate `a_y'.
		do
			Result := a_y // (row_height + 1) + 1
			if Result > ev_children.count then
				Result := 0
			end
		end

feature {NONE} -- Implementation

	y_coord_offset: INTEGER is
			-- Used for altering y coord to detect motion on rows.
		do
			if title_shown then
				Result := 27
				--| FIXME IEK Need to fetch the value from gtk.
			else
				Result := 4
			end
		end

	gtk_clist_struct_columns (a_clist: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkCList): EIF_POINTER"
		alias
			"columns"
		end

	gtk_value_int_to_tuple (n_args: INTEGER; args: POINTER): TUPLE [INTEGER] is
			-- Tuple containing integer value from first of `args'.
		do
			Result := [gtk_marshal.gtk_value_int (args)]
		end

	set_text_on_position (a_column, a_row: INTEGER; a_text: STRING) is
			-- Set cell text at (a_column, a_row) to `a_text'.
		local
			row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			pixmap_imp: EV_PIXMAP_IMP
		do
			row_imp := ev_children.i_th (a_row)
			if row_imp.pixmap /= Void and a_column = 1 then
				pixmap_imp ?= row_imp.pixmap.implementation
				C.gtk_clist_set_pixtext (
					list_widget,
					a_row - 1,
					a_column - 1,
					eiffel_to_c (a_text),
					3,
					C.gtk_pixmap_struct_pixmap (pixmap_imp.gtk_pixmap),
					C.gtk_pixmap_struct_mask (pixmap_imp.gtk_pixmap)
				)
			else 
				C.gtk_clist_set_text (
					list_widget,
					a_row - 1,
					a_column - 1,
					eiffel_to_c (a_text)
				)
			end
		end

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Set row `a_row' pixmap to `a_pixmap'.
		do
			--| Do nothing, implementation not needed for GTK.
		end

feature {NONE} -- Implementation

	selection_mode_is_single: BOOLEAN
			-- Is selection mode set to SINGLE?
	
	switch_to_single_mode_if_necessary is
			-- Change selection mode if the last selected
			-- item is deselected.
		local
			sel_items: like selected_items
		do
			if list_widget /= NULL and then not selection_mode_is_single then
				if multiple_selection_enabled then
					sel_items := selected_items
					if 
						sel_items = Void 
							or else
						selected_items.count <= 1
					then
						C.gtk_clist_set_selection_mode (
							list_widget,
							C.Gtk_selection_multiple_enum
						)
						selection_mode_is_single := True
					end
				else
					C.gtk_clist_set_selection_mode (
						list_widget,
						C.Gtk_selection_single_enum
					)
					selection_mode_is_single := True
				end
			end
		end
		
	switch_to_browse_mode_if_necessary is
			-- Change selection mode to browse mode
			-- if necessary.
		do
			if list_widget /= NULL and then selection_mode_is_single then
				if multiple_selection_enabled then
					C.gtk_clist_set_selection_mode (
						list_widget, 
						C.Gtk_selection_extended_enum
					)					
				else
					C.gtk_clist_set_selection_mode (
						list_widget,
						C.Gtk_selection_browse_enum
					)
				end
				selection_mode_is_single := False
			end
		end


	ensure_item_visible (a_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Ensure `a_item' is visible on the screen.
		do
			--| FIXME To be implemented
		end

	expand_column_count_to (a_columns: INTEGER) is
		do
			create_list (a_columns)
		end

	add_to_container (v: EV_MULTI_COLUMN_LIST_ROW) is
			-- Add `v' to the list.
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			p: POINTER
			dummy: INTEGER
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)

			-- update the list of rows of the column list:
			ev_children.force (item_imp)

			if v.count > column_count then
				create_list (v.count)
			else
				-- add row to the existing gtk column list:
				p := calloc (C.gtk_clist_struct_columns (list_widget), sizeof_pointer)
				dummy := C.gtk_clist_append (list_widget, p)
				c_free (p);
				item_imp.dirty_child
				update_child (item_imp, ev_children.count)
			end
			update_pnd_status		
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
			C.gtk_clist_remove (list_widget, a_position - 1)
			-- remove the row from the `ev_children'
			ev_children.go_i_th (a_position)
			ev_children.remove
			update_pnd_status
		end

	reorder_child (v: like item; a_position: INTEGER) is
			-- Move `v' to `a_position' in Current.
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			temp_list: like ev_children
			a_counter: INTEGER
		do
			item_imp ?= v.implementation
			C.gtk_clist_row_move (
				list_widget,
				item_imp.index - 1,
				a_position - 1
			)
			-- Insert `v' in to ev_children list.	

			create temp_list.make (0)
			from
				a_counter := 1
			until
				a_counter = a_position
			loop
				temp_list.extend (ev_children.i_th (a_counter))
				a_counter := a_counter + 1
			end
			
			-- Insert `v' at a_position
			temp_list.extend (item_imp)

			from
				a_counter := a_position
			until
				a_counter = count
				-- The child to be reordered is always at i_th (count)
				-- Ie: We are reordering and truncating.
			loop
				temp_list.extend (ev_children.i_th (a_counter))
				a_counter := a_counter + 1
			end

			ev_children := temp_list	
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			check
				do_not_call: False
			end
		end

	row_height: INTEGER
		-- Value used to store row height if list isn't yet created.

	visual_widget: POINTER

	disconnect_all_signals is
		do
			--| FIXME
		end

feature {EV_ANY_I} -- Implementation

	list_widget: POINTER

	interface: EV_MULTI_COLUMN_LIST

end -- class EV_MULTI_COLUMN_LIST_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

