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
			internal_set_minimum_size,
			interface,
			initialize,
			destroy,
			make,
			on_key_event,
			width,
			height,
			on_size_allocate,
			show,
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
		end

feature  -- Access

	item: EV_WIDGET
			-- Current item.

	screen_x, x_position: INTEGER is
			-- Horizontal position relative to parent.
		do
			if positioned_by_user then
				Result := user_x_position
			else
				Result := inner_screen_x
			end
		end

	screen_y, y_position: INTEGER is
			-- Vertical position relative to parent.
		do
			if positioned_by_user then
				Result := user_y_position
			else
				Result := inner_screen_y
			end
		end
		
	user_x_position, user_y_position: INTEGER
			-- Used to store user x and y positions whilst Window is off screen.

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
			
	maximum_height: INTEGER
			-- Maximum height that application wishes widget
			-- instance to have.
			
	minimum_width: INTEGER is
			-- Minimum width that the widget may occupy.
		do
			if internal_minimum_width /= -1 then
				Result := internal_minimum_width
			else
				Result := Precursor
			end
		end
		
	minimum_height: INTEGER is
			-- Minimum width that the widget may occupy.
		do
			if internal_minimum_height /= -1 then
				Result := internal_minimum_height
			else
				Result := Precursor
			end
		end

	internal_minimum_width: INTEGER	
			-- Minimum width for the window.

	internal_minimum_height: INTEGER
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
				if Result.is_equal ("%T") then
					Result := ""
				end
			else
				Result := ""
			end
		end

	menu_bar: EV_MENU_BAR
			-- Horizontal bar at top of client area that contains menu's.

	is_modal: BOOLEAN is
			-- Must the window be closed before application continues?
		do
			if not is_destroyed then
				Result := C.gtk_window_struct_modal (c_object) = 1
			end
		end
		
	blocking_window: EV_WINDOW is
			-- Window this dialog is a transient for.
		do
			Result := internal_blocking_window
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
				dummy := C.gtk_main_iteration_do (False)
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
			user_x_position := a_x
			user_y_position := a_y
			C.gtk_widget_set_uposition (c_object, a_x, a_y)
			positioned_by_user := True
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
			lower_bar.wipe_out
			upper_bar.wipe_out
			remove_menu_bar
			Precursor {EV_CONTAINER_IMP}
		end
		
	show is
			-- Map the Window to the screen.
		do
			if not is_show_requested then
				{EV_CONTAINER_IMP} Precursor
				if positioned_by_user then
					app_implementation.process_events
					set_position (user_x_position, user_y_position)
					--| This is a hack to make sure window is positioned correctly
					positioned_by_user := False
				end				
			end
		end

	hide is
			-- Unmap the Window from the screen.
		do
			if is_show_requested then
				Precursor		
			end
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
				on_removed_item (item)
				w ?= i.implementation
				check
					item_has_implementation: w /= Void
				end
				C.gtk_object_ref (w.c_object)
				C.gtk_container_remove (hbox, w.c_object)
			end
			if v /= Void then
				w ?= v.implementation
				C.gtk_box_pack_end (hbox, w.c_object, True, True, 0)
				on_new_item (w)
			end
			item := v
		end

	set_maximum_width (max_width: INTEGER) is
			-- Set `maximum_width' to `max_width'.
		local
			a_geometry: POINTER
		do
			a_geometry := C.c_gdk_geometry_struct_allocate
			C.set_gdk_geometry_struct_max_width (a_geometry, max_width)
			C.set_gdk_geometry_struct_max_height (a_geometry, maximum_height)
			C.gtk_window_set_geometry_hints (c_object, NULL, a_geometry, C.Gdk_hint_max_size_enum)
			C.c_gdk_geometry_struct_free (a_geometry)
			maximum_width := max_width
		end 

	set_maximum_height (max_height: INTEGER) is
			-- Set `maximum_height' to `max_height'.
		local
			a_geometry: POINTER
		do
			a_geometry := C.c_gdk_geometry_struct_allocate
			C.set_gdk_geometry_struct_max_width (a_geometry, maximum_width)
			C.set_gdk_geometry_struct_max_height (a_geometry, max_height)
			C.gtk_window_set_geometry_hints (c_object, NULL, a_geometry, C.Gdk_hint_max_size_enum)
			C.c_gdk_geometry_struct_free (a_geometry)
			maximum_height := max_height
		end 

	set_title (new_title: STRING) is
			-- Set `title' to `new_title'.
		local
			a_title: STRING
			a_gs: GEL_STRING
		do
			a_title := new_title
			if a_title.is_equal ("") then
				-- Some window managers do not like empty strings as titles and show it as an error.
				a_title := "%T"
			end
			create a_gs.make (a_title)
			C.gtk_window_set_title (c_object, a_gs.item)

			-- Make sure the gtk window has a corresponding gdk window
			if not has_struct_flag (c_object, C.GTK_REALIZED_ENUM) then
				C.gtk_widget_realize (c_object)
			end
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR) is
			-- Set `menu_bar' to `a_menu_bar'.
		local
			mb_imp: EV_MENU_BAR_IMP
			menu_imp: EV_MENU_IMP
			a_gs: GEL_STRING
		do
			menu_bar := a_menu_bar
			mb_imp ?= menu_bar.implementation
			mb_imp.set_parent_window_imp (Current)
			C.gtk_box_pack_start (vbox, mb_imp.list_widget, False, True, 0)
			C.gtk_box_reorder_child (vbox, mb_imp.list_widget, 0)
			create a_gs.make ("activate_item")
			from
				menu_bar.start
			until
				menu_bar.after
			loop
				menu_imp ?= menu_bar.item.implementation
				if menu_imp /= Void and then menu_imp.key /= 0 then
					C.gtk_widget_add_accelerator (menu_imp.c_object,
						a_gs.item,
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
					if menu_imp /= Void and then menu_imp.key /= 0 then
						C.gtk_widget_remove_accelerator (menu_imp.c_object,
							accel_group,
							menu_imp.key,
							C.gdk_mod1_mask_enum)
					end
					menu_bar.forth
				end
				mb_imp ?= menu_bar.implementation
				mb_imp.remove_parent_window
				C.gtk_object_ref (mb_imp.list_widget)
				C.gtk_container_remove (vbox, mb_imp.list_widget)
			end
			menu_bar := Void
		end
		
	set_blocking_window (a_window: EV_WINDOW) is
			-- Set as transient for `a_window'.
		local
			win_imp: EV_WINDOW_IMP
		do
			internal_blocking_window := a_window
			if a_window /= Void then
				win_imp ?= a_window.implementation
				C.gtk_window_set_transient_for (c_object, win_imp.c_object)
			else
				if not is_destroyed then
					C.gtk_window_set_transient_for (c_object, NULL)
				end		
			end
		end
		
feature {EV_WIDGET_IMP} -- Position retrieval

	inner_screen_x: INTEGER is
			-- Horizontal position of the window on screen, 
		local
			a_x: INTEGER
			a_aux_info: POINTER
		do
			if is_displayed then		
				C.gdk_window_get_root_origin (
					C.gtk_widget_struct_window (c_object),
					$a_x, NULL)
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
		local
			a_y: INTEGER
			a_aux_info: POINTER
		do
			if is_displayed then		
				C.gdk_window_get_root_origin (
					C.gtk_widget_struct_window (c_object),
				    NULL, $a_y)
				Result := a_y
			else
				a_aux_info := aux_info_struct
				if a_aux_info /= NULL then
					Result := C.gtk_widget_aux_info_struct_y (a_aux_info)
				end
			end
		end
		
feature {EV_ANY_IMP} -- Implementation

	set_focus_widget (a_focus_wid: EV_WIDGET_IMP) is
		do
			focus_widget := a_focus_wid
		end

	focus_widget: EV_WIDGET_IMP
			-- Widget that has the focus.
			
	internal_blocking_window: EV_WINDOW
			-- Window that `Current' is relative to.

feature {NONE} -- Implementation

	positioned_by_user: BOOLEAN
		-- Has the Window been positioned by the user?

	internal_set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			internal_minimum_width := a_minimum_width
			internal_minimum_height := a_minimum_height
			C.gtk_widget_set_usize (c_object, a_minimum_width, a_minimum_height)
		end

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
			if x_position /= previous_x or y_position /= previous_y then
				previous_x := x_position
				previous_y := y_position
				if move_actions_internal /= Void then
					move_actions_internal.call ([previous_x, previous_y, width, height])
				end	
			end
		end
		
	previous_x, previous_y: INTEGER

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Used for key event actions sequences.
		local
			a_gs: GEL_STRING
		do
			Precursor (a_key, a_key_string, a_key_press)
			if focus_widget /= Void and then a_key /= Void and then focus_widget.has_focus then
					-- Used to disable certain key behavior such as Tab focus.
				if a_key_press then
					if focus_widget.default_key_processing_blocked (a_key) then
						create a_gs.make ("key-press-event")
						C.gtk_signal_emit_stop_by_name (c_object, a_gs.item)
						focus_widget.on_key_event (a_key, a_key_string, a_key_press)
					end
				else
					if focus_widget.default_key_processing_blocked (a_key) then
						create a_gs.make ("key-release-event")
						C.gtk_signal_emit_stop_by_name (c_object, a_gs.item)
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
			set_title("")
			accel_group := C.gtk_accel_group_new
			C.gtk_window_add_accel_group (c_object, accel_group)
			create upper_bar
			create lower_bar

			maximum_width := 32000
			maximum_height := 32000
			
			signal_connect_true ("delete_event", agent gtk_marshal.on_window_close_request (c_object))
			initialize_client_area
			enable_user_resize
			default_height := -1
			default_width := -1
			internal_minimum_width := -1
			internal_minimum_height := -1
			is_initialized := True
		end
		
	initialize_client_area is
			-- FIXME: Need comments
		local
			bar_imp: EV_VERTICAL_BOX_IMP
		do
			vbox := C.gtk_vbox_new (False, 0)
			C.gtk_widget_show (vbox)
			C.gtk_container_add (c_object, vbox)
			hbox := C.gtk_hbox_new (False, 0)
			C.gtk_widget_show (hbox)

			bar_imp ?= upper_bar.implementation
			check
				bar_imp_not_void: bar_imp /= Void
			end

			C.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)
			C.gtk_box_pack_start (vbox, hbox, True, True, 0)

			bar_imp ?= lower_bar.implementation
			check
				bar_imp_not_void: bar_imp /= Void
			end
			C.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)

			app_implementation.window_oids.extend (object_id)
		end

	vbox: POINTER
			-- Vertical_box to have a possibility for a menu on the
			-- top and a status bar at the bottom.

feature {EV_INTERMEDIARY_ROUTINES}

	call_close_request_actions is
			-- Call the close request actions.
		do
			if close_request_actions_internal /= Void then
				close_request_actions_internal.call ([])
			end
		end

feature {EV_MENU_BAR_IMP} -- Implementation

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

