indexing
	description: "Eiffel Vision window. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WINDOW_IMP

inherit
	EV_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			replace
		redefine
			x_position,
			y_position,
			screen_x,
			screen_y,
			minimum_width,
			minimum_height,
			set_minimum_size,
			interface,
			initialize,
			destroy,
			make,
			on_key_event,
			width,
			height,
			on_size_allocate,
			hide
		end

	EV_WINDOW_ACTION_SEQUENCES_IMP
		redefine
			interface
		end

create
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Create the window.
		do
			base_make (an_interface)
			set_c_object (C.gtk_window_new (C.Gtk_window_toplevel_enum))
			set_title ("")
				-- set title also realizes the window.
			C.gdk_window_set_decorations (C.gtk_widget_struct_window (c_object), 0)
			C.gdk_window_set_functions (C.gtk_widget_struct_window (c_object), 0)
			
			C.gtk_window_set_policy (c_object, 0, 1, 0) -- allow_shrink = False, allow_grow = True, auto_shrink = False
			accel_group := C.gtk_accel_group_new
			C.gtk_window_add_accel_group (c_object, accel_group)
			default_height := -1
			default_width := -1
		end

feature  -- Access

	item: EV_WIDGET is
			-- Current item.
		local
			p: POINTER
			o: EV_ANY_IMP
		do
			p := C.gtk_container_children (hbox)
			if p /= NULL then
				p := C.g_list_nth_data (p, 0)
				if p /= NULL then
					o := eif_object_from_c (p)
					Result ?= o.interface
				end
				C.g_list_free (p)
			end
		end

	screen_x, x_position: INTEGER is
			-- Horizontal position relative to parent.
		do
			Result := inner_screen_x
		end

	screen_y, y_position: INTEGER is
			-- Vertical position relative to parent.
		do
			Result := inner_screen_y
		end

	width: INTEGER is
			-- Horizontal size measured in pixels.
		do
			if default_width /= -1 then
				Result := default_width
			else
				Result := Precursor
			end
		end

	height: INTEGER is
			-- Vertical size measured in pixels.
		do
			if default_height /= -1 then
				Result := default_height
			else
				Result := Precursor
			end
		end
	
 	maximum_width: INTEGER
			-- Maximum width that application wishes widget
			-- instance to have.

	minimum_width: INTEGER	
			-- Minimum width for the window.
	
	maximum_height: INTEGER
			-- Maximum height that application wishes widget
			-- instance to have.

	minimum_height: INTEGER
			-- Minimum height for the window.

	title: STRING is
			-- Application name to be displayed by
			-- the window manager.
		local
			p : POINTER
		do
			p := C.gtk_window_struct_title (c_object)
			if p /= NULL then
				create Result.make_from_c (p)
			else
				create Result.make (0)
			end
		end

	menu_bar: EV_MENU_BAR
			-- Horizontal bar at top of client area that contains menu's.

	is_modal: BOOLEAN is
			-- Must the window be closed before application continues?
		do
			Result := C.gtk_window_struct_modal (c_object) = 1
		end

feature -- Status setting

	block is
			-- Wait until window is closed by the user.
		local
			dummy: INTEGER
		do
			from
			until
				is_destroyed or else not is_show_requested
			loop
				dummy := C.gtk_main_iteration_do (True)
			end
		end

	enable_modal is
			-- Set `is_modal' to `True'.
		do
			C.gtk_window_set_modal (c_object, True)
		end

	disable_modal is
			-- Set `is_modal' to `False'.
		do
			C.gtk_window_set_modal (c_object, False)
		end

	set_x_position (a_x: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
		do
			set_position (a_x, y_position)
		end

	set_y_position (a_y: INTEGER) is
			-- Set vertical offset to parent to `a_y'.
		do
			set_position (x_position, a_y)
		end

	set_position (a_x, a_y: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
			-- Set vertical offset to parent to `a_y'.
		do
			C.gtk_widget_set_uposition (c_object, a_x, a_y)
		end

	set_width (a_width: INTEGER) is
			-- Set the horizontal size to `a_width'.
		do
			default_width := a_width
			C.gtk_window_set_default_size (c_object, default_width, height)
		end

	set_height (a_height: INTEGER) is
			-- Set the vertical size to `a_height'.
		do
			default_height := a_height
			C.gtk_window_set_default_size (c_object, width, default_height)
		end

	set_size (a_width, a_height: INTEGER) is
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		do
			default_width := a_width
			default_height := a_height
			C.gtk_window_set_default_size (c_object, default_width, default_height)
		end

	forbid_resize is
			-- Forbid the resize of the window.
		do
			C.gtk_window_set_policy (c_object, 0, 0, 0)
		end

	allow_resize is
			-- Allow the resize of the window.
		do
			C.gtk_window_set_policy (c_object, 0, 1, 0)
		end

	destroy is
			-- Render `Current' unusable.
		do
			remove_menu_bar
			lower_bar.destroy
			upper_bar.destroy
			Precursor
		end

	hide is
		do
			set_position (x_position, y_position)
			Precursor
		end
		

feature -- Element change

	replace (v: like item) is
			-- Replace `item' with `v'.
		local
			w: EV_WIDGET_IMP
			i: EV_WIDGET
		do
			i := item
			if i /= Void then
				on_removed_item (i)
				w ?= i.implementation
				check
					item_has_implementation: w /= Void
				end
				C.gtk_container_remove (hbox, w.c_object)
			end
			if v /= Void then
				w ?= v.implementation
				C.gtk_box_pack_end (hbox, w.c_object, True, True, 0)
				on_new_item (v)
			end
		end

	set_maximum_width (max_width: INTEGER) is
			-- Set `maximum_width' to `max_width'.
		do
			-- to be tested
			C.gdk_window_set_hints (
				C.gtk_widget_struct_window (c_object),
				x_position,
				y_position,
				minimum_width,
				minimum_height,
				max_width,
				maximum_height,
				1
			)
			maximum_width := max_width
		end 

	set_maximum_height (max_height: INTEGER) is
			-- Set `maximum_height' to `max_height'.
		do
			-- to be tested
			C.gdk_window_set_hints (
				C.gtk_widget_struct_window (c_object),
				x_position,
				y_position,
				minimum_width,
				minimum_height,
				maximum_width,
				max_height,
				1
			)
			maximum_height := max_height
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			minimum_width := a_minimum_width
			minimum_height := a_minimum_height
			C.gtk_widget_set_usize (c_object, a_minimum_width, a_minimum_height)
		end

	set_title (new_title: STRING) is
			-- Set `title' to `new_title'.
		do
			C.gtk_window_set_title (c_object, eiffel_to_c (new_title))

			-- Give the gtk window a corresponding gdk window
			C.gtk_widget_realize (c_object)
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR) is
			-- Set `menu_bar' to `a_menu_bar'.
		local
			mb_imp: EV_MENU_BAR_IMP
			menu_imp: EV_MENU_IMP
		do
			menu_bar := a_menu_bar
			mb_imp ?= menu_bar.implementation
			mb_imp.set_parent_window (interface)
			C.gtk_box_pack_start (vbox, mb_imp.list_widget, False, True, 0)
			C.gtk_box_reorder_child (vbox, mb_imp.list_widget, 0)
			from
				menu_bar.start
			until
				menu_bar.after
			loop
				menu_imp ?= menu_bar.item.implementation
				if menu_imp.key /= 0 then
					C.gtk_widget_add_accelerator (menu_imp.c_object,
						eiffel_to_c ("activate_item"),
						accel_group,
						menu_imp.key,
						C.gdk_mod1_mask_enum,
						0)
				end
				menu_bar.forth
			end
		end

	remove_menu_bar is
			-- Set `menu_bar' to `Void'.
		local
			mb_imp: EV_MENU_BAR_IMP
			menu_imp: EV_MENU_IMP
		do
			if menu_bar /= Void then
				from
					menu_bar.start
				until
					menu_bar.after
				loop
					menu_imp ?= menu_bar.item.implementation
					if menu_imp.key /= 0 then
						C.gtk_widget_remove_accelerator (menu_imp.c_object,
							accel_group,
							menu_imp.key,
							C.gdk_mod1_mask_enum)
					end
					menu_bar.forth
				end
				mb_imp ?= menu_bar.implementation
				mb_imp.remove_parent_window
				C.gtk_container_remove (vbox, mb_imp.list_widget)
			end
			menu_bar := Void
		end
		
feature {EV_WIDGET_IMP} -- Position retrieval

	inner_screen_x: INTEGER is
			-- Horizontal position of the window on screen, 
			-- decoration are not taken into account.
		local
			a_x: INTEGER
			a_aux_info: POINTER
		do
				--| The following piece of code works fine with kwn (RH7.1 KDE2.1)
				--| It should be test with other window managers
			if is_displayed then
				C.gdk_window_get_position (
					C.gtk_widget_struct_window (c_object),
					$a_x,
					NULL
				)
				Result := a_x
			else	
				a_aux_info := aux_info_struct
				if a_aux_info /= NULL then
					Result := C.gtk_widget_aux_info_struct_x (a_aux_info)
				end
			end
		end
		
	inner_screen_y: INTEGER is
			-- Vertical position of the window on screen, 
			-- decoration are not taken into account.
		local
			a_y: INTEGER
			a_aux_info: POINTER
		do
				--| The following piece of code works fine with kwn (RH7.1 KDE2.1)
				--| It should be test with other window managers
			if is_displayed then
				
			C.gdk_window_get_position (
				C.gtk_widget_struct_window (c_object),
				NULL,
				$a_y
			)
			Result := a_y
			else	
				a_aux_info := aux_info_struct
				if a_aux_info /= NULL then
					Result := C.gtk_widget_aux_info_struct_y (a_aux_info)
				end
			end
		end
		
feature {EV_DRAWING_AREA_IMP, EV_LIST_ITEM_LIST_IMP} -- Implementation

	set_focus_widget (a_focus_wid: EV_WIDGET_IMP) is
		do
			focus_widget := a_focus_wid
		end

	focus_widget: EV_WIDGET_IMP
			-- Widget that has the focus.

	disable_default_key_processing is
		do
			enable_key_processing := False
		end

	enable_default_key_processing is
		do
			enable_key_processing := True
		end

	enable_key_processing: BOOLEAN
			-- Should default gtk key handler be enabled, used to prevent default keys
			-- losing the widget focus, useful for when using drawing area as a text processor.

feature {NONE} -- Implementation

	default_width: INTEGER
			-- Default width for the window if set, -1 otherwise.
			-- (see. `gtk_window_set_default_size' for more information)
		
	default_height: INTEGER
			-- Default height for the window if set, -1 otherwise.
			-- (see. `gtk_window_set_default_size' for more information)

	on_size_allocate (a_x, a_y, a_width, a_height: INTEGER) is
			-- Gtk_Widget."size-allocate" happened.
		do
				--| `default_width' and `default_height' are not useful anymore
			default_width := -1
			default_height := -1
			Precursor (a_x, a_y, a_width, a_height)
		end

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Used for key event actions sequences.
		do
			Precursor (a_key, a_key_string, a_key_press)
			if focus_widget /= Void and then a_key /= Void then
					-- focus_widget drawing_area or gtklist.
				if a_key_press then 
					if focus_widget.default_key_processing_blocked (a_key) then
						C.gtk_signal_emit_stop_by_name (c_object, eiffel_to_c ("key-press-event"))
						focus_widget.on_key_event (a_key, a_key_string, a_key_press)
					end
					
				else
					if focus_widget.default_key_processing_blocked (a_key) then
						C.gtk_signal_emit_stop_by_name (c_object, eiffel_to_c ("key-release-event"))
						focus_widget.on_key_event (a_key, a_key_string, a_key_press)
					end
				end	
			end
		end

	initialize is
			-- Create the vertical box `vbox' and horizontal box `hbox'
			-- to put in the window.
			-- The `vbox' will be able to contain the menu bar, the `hbox'
			-- and the status bar.
			-- The `hbox' will contain the child of the window.
		do
			Precursor
			is_initialized := False
			create upper_bar
			create lower_bar
			
			signal_connect_true ("delete_event", agent call_close_request_actions)
			initialize_client_area
			enable_user_resize
			is_initialized := True
		end
		
	initialize_client_area is
			-- FIXME: Need comments
		local
			scr: EV_SCREEN
			bar_imp: EV_VERTICAL_BOX_IMP
		do
			vbox := C.gtk_vbox_new (False, 0)
			C.gtk_widget_show (vbox)
			C.gtk_container_add (c_object, vbox)
			hbox := C.gtk_hbox_new (False, 0)
			C.gtk_widget_show (hbox)

			create upper_bar
			bar_imp ?= upper_bar.implementation
			check
				bar_imp_not_void: bar_imp /= Void
			end

			C.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)
			C.gtk_box_pack_start (vbox, hbox, True, True, 0)

			create lower_bar
			bar_imp ?= lower_bar.implementation
			check
				bar_imp_not_void: bar_imp /= Void
			end

			C.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)

			create scr
			set_maximum_width (scr.width)
			set_maximum_height (scr.height)
			
			app_implementation.window_oids.extend (object_id)
		end

	call_close_request_actions is
			-- Call the close request actions.
		do
			if close_request_actions_internal /= Void then
				close_request_actions_internal.call ([])
			end
		end

	vbox: POINTER
			-- Vertical_box to have a possibility for a menu on the
			-- top and a status bar at the bottom.

	accel_group: POINTER
			-- Pointer to GtkAccelGroup struct.
			
feature {EV_CLIPBOARD_IMP} -- Implementation

	hbox: POINTER
			-- Horizontal box for the child.

feature {EV_ANY_I} -- Implementation

	interface: EV_WINDOW

end -- class EV_WINDOW_IMP

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

