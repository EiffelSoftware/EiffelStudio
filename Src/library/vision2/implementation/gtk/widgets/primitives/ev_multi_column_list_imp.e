--| FIXME NOT_REVIEWED this file has not been reviewed
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
			item
		end

	EV_PRIMITIVE_IMP
		redefine
			enable_transport,
			disable_transport,
			pre_pick_steps,
			post_drop_steps,
			start_transport_filter,
			initialize,
			pointer_over_widget,
			interface,
			destroy,
			set_foreground_color,
			set_background_color,
			foreground_color,
			background_color
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
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is         
			-- Create a list widget with `par' as
			-- parent and `col_nb' columns.
			-- By default, a list allow only one selection.
		do
			base_make (an_interface)

			-- Creating the gtk scrolled window

			set_c_object (C.gtk_event_box_new)

			scroll_window := (
				C.gtk_scrolled_window_new (
					Default_pointer, 
					Default_pointer
				)
			)
			C.gtk_scrolled_window_set_policy (
				scroll_window,
				C.GTK_POLICY_AUTOMATIC_ENUM,
				C.GTK_POLICY_AUTOMATIC_ENUM
			)
			C.gtk_widget_show (scroll_window)
			C.gtk_container_add (c_object, scroll_window)
			create ev_children.make (0)
			set_row_height (15)

				-- create a list with one column
			create_list (1)
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
		do
			old_list_widget := list_widget
			
			list_widget := C.gtk_clist_new (a_columns)
		
			real_signal_connect (
				list_widget,
				"select_row",
				~select_callback,
				~gtk_value_int_to_tuple
			)
			real_signal_connect (
				list_widget,
				"unselect_row",
				~deselect_callback,
				~gtk_value_int_to_tuple
			)
			real_signal_connect (
				list_widget,
				"click_column",
				~column_click_callback,
				~gtk_value_int_to_tuple
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
				if column_widths /= Void and then column_widths.valid_index (i)
				then
					temp_width := column_widths.i_th (i)
				else
					temp_width := Default_column_width
				end

				column_title_changed (temp_title, i)
				column_width_changed (temp_width, i)
				i := i + 1
			end

			from
				ev_children.start
			until
				ev_children.after
			loop
				i := C.c_gtk_clist_append_row (list_widget)
				ev_children.item.dirty_child
				update_child (ev_children.item, ev_children.index)
				ev_children.forth
			end
			
			if old_list_widget /= Default_pointer then
				C.gtk_container_remove (scroll_window, old_list_widget)
			end
			C.gtk_container_add (scroll_window, list_widget)
		end

	select_callback (int: TUPLE [INTEGER]) is
		local
			temp_int: INTEGER_REF
			a_position: INTEGER
			an_item: EV_MULTI_COLUMN_LIST_ROW
		do
			temp_int ?= int.item (1)
			a_position := temp_int.item + 1

			an_item := (ev_children @ a_position).interface
			an_item.select_actions.call ([])
			interface.select_actions.call ([an_item])
		end

	deselect_callback (int: TUPLE [INTEGER]) is
		local
			temp_int: INTEGER_REF
			a_position: INTEGER
			an_item: EV_MULTI_COLUMN_LIST_ROW
		do
			temp_int ?= int.item (1)
			a_position := temp_int.item + 1

			an_item := (ev_children @ a_position).interface
			an_item.deselect_actions.call ([])
			interface.deselect_actions.call ([an_item])
		end

	column_click_callback (int: INTEGER) is
		do
			-- FIXME IEK Should include column number somewhere.
			interface.column_click_actions.call ([])
		end

	initialize is
		do
			{EV_PRIMITIVE_IMP} Precursor
			{EV_MULTI_COLUMN_LIST_I} Precursor
		end	

feature -- Access

	column_count: INTEGER is
			-- Number of columns in the list.
		do
			if list_widget /= Default_pointer then
				Result := C.c_gtk_clist_columns (list_widget)
			end
		end

	rows, count: INTEGER is
			-- Number of rows in the list.
		do
			Result := ev_children.count
		end

	--item: EV_MULTI_COLUMN_LIST_ROW is
	--	do
	--		Result := (ev_children @ (index)).interface
	--	end

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
			if (list_widget /= Default_pointer and
			C.c_gtk_clist_selection_length (list_widget) = 0 ) then
					-- there is no selected item
				Result := Void
			elseif list_widget /= Default_pointer then
					-- there is one selected item
				an_index := C.c_gtk_clist_ith_selected_item (
					list_widget,
					0
				)		
				Result ?= (ev_children @ (an_index + 1)).interface
			end
		end

	selected_items: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list
		local
			i: INTEGER
			an_index: INTEGER
			upper: INTEGER
			row: EV_MULTI_COLUMN_LIST_ROW
		do
			if list_widget /= Default_pointer then
				upper := 
				C.c_gtk_clist_selection_length (list_widget)
			end
			create Result.make
			from
				i := 0
			until
				i = upper
			loop
				index := C.c_gtk_clist_ith_selected_item (list_widget, i)
				row ?= (ev_children @ (an_index + 1)).interface
				Result.extend (row)
				i := i + 1
			end
		end

	background_color: EV_COLOR is
			-- Color used for the background of the widget.
			-- This feature might change if we give the
			-- possibility to set colors on the rows.
		--| FIXME IEK Redefine to return list widget color.

		do
			Result := {EV_PRIMITIVE_IMP} Precursor
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget,
			-- usually the text.
			-- This feature might change if we give the
			-- possibility to set colors on the rows.
		--| FIXME IEK FG Redefine to return list widget color.
		do
			Result := {EV_PRIMITIVE_IMP} Precursor
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			if list_widget /= Default_pointer then
				Result := C.c_gtk_clist_selected (list_widget).to_boolean
			end
		end

	multiple_selection_enabled: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		do
			if list_widget /= Default_pointer then
				Result := (C.c_gtk_clist_selection_mode (list_widget) 
					= C.GTK_SELECTION_MULTIPLE_ENUM)
			end
		end

	title_shown: BOOLEAN is
			-- True if the title row is shown.
			-- False if the title row is not shown.
		do
			if list_widget /= Default_pointer then
				Result := C.c_gtk_clist_title_shown (list_widget).to_boolean
			end
		end

feature -- Status setting

	destroy is
		-- Destroy screen widget implementation and EV_LIST_ITEM objects
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
			-- For constants, see EV_GTK_CONSTANTS
		do
			C.gtk_clist_set_selection_mode (
				list_widget, C.GTK_SELECTION_MULTIPLE_ENUM
			)	
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
			-- For constants, see EV_GTK_CONSTANTS
		do
			C.gtk_clist_set_selection_mode (
				list_widget,
				C.GTK_SELECTION_SINGLE_ENUM
			)	
		end

	align_text_left (a_column: INTEGER) is
		do
			C.gtk_clist_set_column_justification (
				list_widget,
				a_column - 1,
				C.GTK_JUSTIFY_LEFT_ENUM
			)
		end

	align_text_right (a_column: INTEGER) is
		do
			C.gtk_clist_set_column_justification (
				list_widget,
				a_column - 1,
				C.GTK_JUSTIFY_RIGHT_ENUM
			)
		end

	align_text_center (a_column: INTEGER) is
		do
			C.gtk_clist_set_column_justification (
				list_widget,
				a_column - 1,
				C.GTK_JUSTIFY_CENTER_ENUM
			)
		end

	select_item (an_index: INTEGER) is
			-- Select an item at the one-based `index' of the list.
		do
			(ev_children @ an_index).enable_select
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
			(ev_children @ an_index).disable_select
		end

	clear_selection is
			-- Clear the selection of the list.
		do
			if list_widget /= Default_pointer then
				C.gtk_clist_unselect_all (list_widget)
			end
		end

feature -- Element change

	column_title_changed (a_txt: STRING; a_column: INTEGER) is
			-- Make `a_txt' the title of the column number.
		local
			a: ANY
		do
			if list_widget /= Default_pointer then
				a := a_txt.to_c
				C.gtk_clist_set_column_title (list_widget, a_column - 1, $a)
			end
		end

	column_width_changed (value: INTEGER; column: INTEGER) is
			-- Make `value' the new width of the column number
			-- `column'.
		do
			if list_widget /= Default_pointer then
				C.gtk_clist_set_column_width (list_widget, column - 1, value)
			end
		end

	set_row_height (value: INTEGER) is
			-- Make `value' the new height of all the rows.
		do
			if list_widget /= Default_pointer then
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

	set_background_color (a_color: EV_COLOR) is
			-- Make `a_color' the new `background_color' of every rows.
		local
			children_array: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
			row: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			--| FIXME IEK BG color not applicable for rows at present.
			{EV_PRIMITIVE_IMP} Precursor (a_color)
			
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Make `a_color' the new `foreground_color' of every rows.
		local
			children_array: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
			row: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			--| FIXME FG color not applicable for rows at present.
			{EV_PRIMITIVE_IMP} Precursor (a_color)
		end

feature {EV_APPLICATION_IMP} -- Implementation

	pointer_over_widget (a_gdkwin: POINTER; a_x, a_y: INTEGER): BOOLEAN is
			-- Is mouse pointer hovering above list.
		local
			gdkwin_parent, gdkwin_parent_parent: POINTER
			clist_parent: POINTER
			a_row: INTEGER
		do
			gdkwin_parent := C.gdk_window_get_parent (a_gdkwin)
			if gdkwin_parent /= Default_pointer then
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

feature -- Implementation

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
			signal_connect ("button-press-event", ~start_transport_filter, default_translate)
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
				disable_transport
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
				if not pnd_row_imp.is_transport_enabled then
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
	
	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Steps to perform before transport initiated.
		local
			env: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
			curs_code: EV_CURSOR_CODE
			pnd_mode: BOOLEAN
		do
			create env
			app_imp ?= env.application.implementation
			check
				app_imp_not_void: app_imp /= Void
			end

			temp_pebble := pebble
			temp_pebble_function := pebble_function
			temp_accept_cursor := accept_cursor
			temp_deny_cursor := deny_cursor

			if pnd_row_imp /= Void then

				pebble := pnd_row_imp.pebble
				pebble_function := pnd_row_imp.pebble_function
			end

			if pebble_function /= Void then
				pebble_function.call ([a_x, a_y]);
				pebble := pebble_function.last_result
			end

			app_imp.on_pick (pebble)

			create curs_code

			if pnd_row_imp /= Void then
				pnd_row_imp.interface.pick_actions.call ([a_x, a_y])
				pnd_mode := pnd_row_imp.mode_is_pick_and_drop
				accept_cursor := pnd_row_imp.accept_cursor
				deny_cursor := pnd_row_imp.deny_cursor
			else
				interface.pick_actions.call ([a_x, a_y])
				pnd_mode := mode_is_pick_and_drop
			end

			if pnd_mode then
				is_pnd_in_transport := True
			else
				is_dnd_in_transport := True
			end

			if accept_cursor = Void then
				create accept_cursor.make_with_code (curs_code.standard)
			end
			if deny_cursor = Void then
				create deny_cursor.make_with_code (curs_code.no)
			end

			pointer_x := a_screen_x
			pointer_y := a_screen_y
			if pick_x = 0 and pick_y = 0 then
				pick_x := a_screen_x
				pick_y := a_screen_y
			end
		end

	post_drop_steps is
			-- Steps to perform once an attempted drop has happened.
		local
			env: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
		do
			create env
			app_imp ?= env.application.implementation
			check
				app_imp_not_void: app_imp /= Void
			end

			app_imp.on_drop (pebble)
			pick_x := 0 --| FIXME IEK This wipes out user setting of pick position
			pick_y := 0
			last_pointed_target := Void	

			if pebble_function /= Void then
				if pnd_row_imp /= Void then
					--| FIXME IEK Make row pebble void.
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
		local
			v_adjust: POINTER
		do
			v_adjust :=  C.gtk_scrolled_window_get_vadjustment (scroll_window)
			Result := C.gtk_adjustment_struct_value (v_adjust).rounded
			Result := a_y + Result
			Result := Result // (row_height + 1) + 1
			if Result > ev_children.count then
				Result := 0
			end
		end

feature {NONE} -- Implementation

	gtk_value_int_to_tuple (n_args: INTEGER; args: POINTER): TUPLE [INTEGER] is
			-- Tuple containing integer value from first of `args'.
		do
			Result := [gtk_value_int (args)]
		end

	set_text_on_position (a_column, a_row: INTEGER; a_text: STRING) is
			-- Set cell text at (a_column, a_row) to `a_text'.
		local
			a: ANY
			row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			pixmap_imp: EV_PIXMAP_IMP
			pixmap_pointer: POINTER
		do
			a := a_text.to_c

			row_imp := ev_children.i_th (a_row)
			if row_imp.pixmap /= Void and a_column = 1 then
				pixmap_imp ?= row_imp.pixmap.implementation
				pixmap_pointer := pixmap_imp.c_object
			end

			C.c_gtk_clist_set_pixtext (
				list_widget,
				a_row - 1,
				a_column - 1,
				pixmap_pointer,
				$a
			)
		end

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Set row `a_row' pixmap to `a_pixmap'.
		do
			--| Do nothing, implementation not needed for GTK.
		end

feature {NONE} -- Implementation

	expand_column_count_to (a_columns: INTEGER) is
		do
			create_list (a_columns)
		end

	add_to_container (v: EV_MULTI_COLUMN_LIST_ROW) is
			-- Add `v' to the list.
		local
			an_index: INTEGER
			column_i: INTEGER
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			a_curs: CURSOR
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)

			-- update the list of rows of the column list:
			ev_children.force (item_imp)

			if v.count > column_count then
				create_list (v.count)
			else
				-- add row to the existing gtk column list:
				an_index := C.c_gtk_clist_append_row (list_widget)
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
			temp_position: INTEGER
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

	scroll_window: POINTER
		-- Pointer to the scrollable window tree is in.

feature {EV_ANY_I} -- Implementation

	list_widget: POINTER

	interface: EV_MULTI_COLUMN_LIST

end -- class EV_MULTI_COLUMN_LIST_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.63  2000/04/07 17:40:50  king
--| Implemented resetting of mclist pnd attributes
--|
--| Revision 1.62  2000/04/06 23:27:42  brendel
--| Added list_widget.
--|
--| Revision 1.61  2000/04/05 22:37:41  king
--| Basic implementation of row PND
--|
--| Revision 1.60  2000/04/05 21:16:10  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.59  2000/04/05 17:06:19  king
--| Initial PND structure to work with rows
--|
--| Revision 1.58  2000/04/04 20:54:08  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.57  2000/03/31 19:12:29  king
--| Accounted for name change of pebble_over_widget
--|
--| Revision 1.56  2000/03/30 19:30:26  king
--| Changed to one column on creation, added column_* /= Void checks in
--| create_list
--|
--| Revision 1.55.2.2  2000/04/04 23:47:25  brendel
--| Added redefinition of i_th. Item is not necessary anymore.
--|
--| Revision 1.55.2.1  2000/04/04 16:31:08  brendel
--| remove_item_from_position -> remove_i_th.
--|
--| Revision 1.55  2000/03/29 22:14:51  king
--| Added initial row pnd support
--|
--| Revision 1.54  2000/03/29 01:42:02  king
--| Added redundant set_row_pixmap feature
--|
--| Revision 1.53  2000/03/28 21:29:26  king
--| Implemented to deal with setting of titles and widths
--|
--| Revision 1.52  2000/03/28 01:09:43  king
--| Using ev_children for count
--|
--| Revision 1.51  2000/03/28 00:32:48  king
--| Using dirty_child to have for update_children reuse
--|
--| Revision 1.50  2000/03/27 22:36:35  king
--| Corrected add_to_container to deal with all row situations
--|
--| Revision 1.49  2000/03/27 17:18:44  brendel
--| columns -> column_count
--|
--| Revision 1.48  2000/03/25 01:50:25  king
--| Half implemented changes
--|
--| Revision 1.47  2000/03/24 01:50:20  king
--| Changed rows_height -> row_height, optimized create_list
--|
--| Revision 1.46  2000/03/24 01:28:30  king
--| Implemented updating features, needs testing
--|
--| Revision 1.44  2000/03/22 22:02:52  king
--| Implemented pebble_over_widget to deal with mclist and title windows
--|
--| Revision 1.43  2000/03/21 22:40:16  king
--| Made c_object an event box
--|
--| Revision 1.42  2000/03/15 00:56:39  king
--| Converted back to using arrayed_list
--|
--| Revision 1.41  2000/03/15 00:46:13  king
--| Implemented insert_item at position
--|
--| Revision 1.40  2000/03/14 00:13:04  king
--| Optimised item retrieval from position
--|
--| Revision 1.39  2000/03/09 01:17:59  king
--| Corrected spacing of interface attribute in class
--|
--| Revision 1.38  2000/03/06 20:12:29  king
--| Made compatible with new action sequence
--|
--| Revision 1.37  2000/03/04 00:25:54  king
--| Commented out redundant code that deals with setting individual colors of
--| rows
--|
--| Revision 1.35  2000/03/03 20:10:27  king
--| Corrected create_list to deal with resetting col wid and titles to prev
--| values
--|
--| Revision 1.34  2000/03/03 18:18:49  king
--| Implemented set_columns
--|
--| Revision 1.33  2000/03/03 00:14:20  king
--| Changed references to set_selected to enable_select
--|
--| Revision 1.32  2000/03/02 21:41:26  king
--| Renamed selection features to account for interface name change
--|
--| Revision 1.31  2000/02/24 01:50:03  king
--| Removed redundant command association routines
--|
--| Revision 1.30  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.29  2000/02/19 01:19:52  king
--| Changed parameter of callbacks from integer to tuple[integer]
--|
--| Revision 1.28  2000/02/19 00:02:50  oconnor
--| c-ed out old command stuff
--|
--| Revision 1.27  2000/02/18 23:54:11  oconnor
--| released
--|
--| Revision 1.26  2000/02/18 22:26:02  king
--| Added callback features to call action sequences so zero arg of PROCEDURE
--| is of type EV_MULTI_COLUMN_LIST_IMP
--|
--| Revision 1.25  2000/02/18 18:37:46  king
--| Removed redundant command association commands
--|
--| Revision 1.24  2000/02/17 21:52:21  king
--| Implemented to use no column setting on creation
--|
--| Revision 1.23  2000/02/16 20:25:58  king
--| Implemented to fit in with new structure
--|
--| Revision 1.22  2000/02/15 19:24:35  king
--| Made compilable
--|
--| Revision 1.21  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.20.6.3  2000/02/02 23:44:26  king
--| Corrected inheritence from ev_item_list
--|
--| Revision 1.20.6.2  2000/01/27 19:29:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.20.6.1  1999/11/24 17:29:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.20.2.3  1999/11/17 01:53:05  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.20.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
