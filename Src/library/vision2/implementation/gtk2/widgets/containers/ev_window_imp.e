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
			interface,
			lock_update,
			unlock_update
		end

	EV_CONTAINER_IMP
		undefine
			replace
		redefine
			x_position,
			y_position,
			screen_x,
			screen_y,
			interface,
			initialize,
			destroy,
			make,
			on_key_event,
			width,
			height,
			on_size_allocate,
			show,
			hide,
			internal_set_minimum_size,
			on_widget_mapped
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
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_window_new (feature {EV_GTK_EXTERNALS}.Gtk_window_toplevel_enum))
		end

feature  -- Access

	item: EV_WIDGET
			-- Current item.

	x_position: INTEGER is
			-- X coordinate of `Current'
		do
			Result := screen_x
		end
			
	y_position: INTEGER is
			-- Y coordinate of `Current'
		do
			Result := screen_y
		end
			
	screen_x: INTEGER is
			-- Horizontal position of the window on screen, 
		local
			a_x: INTEGER
			a_aux_info: POINTER
		do
			if positioned_by_user then
				Result := user_x_position
			else
				if is_displayed then
					if has_wm_decorations then
						feature {EV_GTK_EXTERNALS}.gdk_window_get_root_origin (
							feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
							$a_x, NULL)
							Result := a_x					
					else
							Result := Precursor {EV_CONTAINER_IMP}
					end
				else
					a_aux_info := aux_info_struct
					if a_aux_info /= NULL then
						Result := feature {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_x (a_aux_info)
					end
				end
			end
		end
		
	screen_y: INTEGER is
			-- Vertical position of the window on screen, 
		local
			a_y: INTEGER
			a_aux_info: POINTER
		do
			if positioned_by_user then
				Result := user_y_position
			else
				if is_displayed then
					if has_wm_decorations then
						feature {EV_GTK_EXTERNALS}.gdk_window_get_root_origin (
							feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
					    	NULL, $a_y)
						Result := a_y					
					else
						Result := Precursor {EV_CONTAINER_IMP}
					end
				else
					a_aux_info := aux_info_struct
					if a_aux_info /= NULL then
						Result := feature {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_y (a_aux_info)
					end
				end
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

	title: STRING is
			-- Application name to be displayed by
			-- the window manager.
		local
			p : POINTER
		do
			p := feature {EV_GTK_EXTERNALS}.gtk_window_struct_title (c_object)
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
				Result := feature {EV_GTK_EXTERNALS}.gtk_window_struct_modal (c_object) = 1
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
				dummy := feature {EV_GTK_EXTERNALS}.gtk_main_iteration_do (True)
				App_implementation.call_idle_actions
			end
		end

	enable_modal is
			-- Set `is_modal' to `True'.
		do
			feature {EV_GTK_EXTERNALS}.gtk_window_set_modal (c_object, True)
		end

	disable_modal is
			-- Set `is_modal' to `False'.
		do
			feature {EV_GTK_EXTERNALS}.gtk_window_set_modal (c_object, False)
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
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_uposition (c_object, a_x, a_y)
			feature {EV_GTK_EXTERNALS}.gdk_window_move (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), a_x, a_y)
			positioned_by_user := True
		end

	set_width (a_width: INTEGER) is
			-- Set the horizontal size to `a_width'.
		do
			update_request_size
			set_size (a_width, height)
		end

	set_height (a_height: INTEGER) is
			-- Set the vertical size to `a_height'.
		do
			update_request_size
			set_size (width, a_height)
		end

	set_size (a_width, a_height: INTEGER) is
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		do
			update_request_size
			default_width := a_width
			default_height := a_height
			feature {EV_GTK_EXTERNALS}.gdk_window_resize (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), default_width.max (minimum_width), default_height.max (minimum_height))
			feature {EV_GTK_EXTERNALS}.gtk_window_set_default_size (c_object, default_width.max (minimum_width), default_height.max (minimum_height))
		end

	forbid_resize is
			-- Forbid the resize of the window.
		do
			feature {EV_GTK_EXTERNALS}.gtk_window_set_policy (c_object, 0, 0, 0)
		end

	allow_resize is
			-- Allow the resize of the window.
		do
			feature {EV_GTK_EXTERNALS}.gtk_window_set_policy (c_object, 0, 1, 0)
		end

	destroy is
			-- Render `Current' unusable.
		do
			if not is_destroyed then
				lower_bar.wipe_out
				upper_bar.wipe_out
				remove_menu_bar
				Precursor {EV_CONTAINER_IMP}
			end
		end
		
	show is
			-- Map the Window to the screen.
		do
			if not is_show_requested then
				call_show_actions := True
				if is_positioned or positioned_by_user then
					feature {EV_GTK_EXTERNALS}.gtk_window_set_position (c_object, feature {EV_GTK_EXTERNALS}.Gtk_win_pos_none_enum)
					app_implementation.process_events
					Precursor {EV_CONTAINER_IMP}
					set_position (user_x_position, user_y_position)
				else
					feature {EV_GTK_EXTERNALS}.gtk_window_set_position (c_object, feature {EV_GTK_EXTERNALS}.Gtk_win_pos_center_enum)
					Precursor {EV_CONTAINER_IMP}
				end
				is_positioned := True
			end
			if blocking_window /= Void then
				set_blocking_window (Void)
			end
		end
		
	is_positioned: BOOLEAN
		-- Has the Window been previously positioned on screen?
		
	call_show_actions: BOOLEAN
		-- Should the show actions be called?

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
				w ?= i.implementation
				on_removed_item (w)
				check
					item_has_implementation: w /= Void
				end
				feature {EV_GTK_DEPENDENT_EXTERNALS}.object_ref (w.c_object)
				feature {EV_GTK_EXTERNALS}.gtk_container_remove (hbox, w.c_object)
			end
			if v /= Void then
				w ?= v.implementation
				feature {EV_GTK_EXTERNALS}.gtk_box_pack_end (hbox, w.c_object, True, True, 0)
				on_new_item (w)
			end
			item := v
		end

	set_maximum_width (max_width: INTEGER) is
			-- Set `maximum_width' to `max_width'.
		local
			a_geometry: POINTER
		do
			a_geometry := feature {EV_GTK_EXTERNALS}.c_gdk_geometry_struct_allocate
			feature {EV_GTK_EXTERNALS}.set_gdk_geometry_struct_max_width (a_geometry, max_width)
			feature {EV_GTK_EXTERNALS}.set_gdk_geometry_struct_max_height (a_geometry, maximum_height)
			feature {EV_GTK_EXTERNALS}.gtk_window_set_geometry_hints (c_object, NULL, a_geometry, feature {EV_GTK_EXTERNALS}.Gdk_hint_max_size_enum)
			a_geometry.memory_free
			maximum_width := max_width
		end 

	set_maximum_height (max_height: INTEGER) is
			-- Set `maximum_height' to `max_height'.
		local
			a_geometry: POINTER
		do
			a_geometry := feature {EV_GTK_EXTERNALS}.c_gdk_geometry_struct_allocate
			feature {EV_GTK_EXTERNALS}.set_gdk_geometry_struct_max_width (a_geometry, maximum_width)
			feature {EV_GTK_EXTERNALS}.set_gdk_geometry_struct_max_height (a_geometry, max_height)
			feature {EV_GTK_EXTERNALS}.gtk_window_set_geometry_hints (c_object, NULL, a_geometry, feature {EV_GTK_EXTERNALS}.Gdk_hint_max_size_enum)
			a_geometry.memory_free
			maximum_height := max_height
		end 

	set_title (new_title: STRING) is
			-- Set `title' to `new_title'.
		local
			a_title: STRING
			a_cs: EV_GTK_C_STRING
		do
			a_title := new_title
			if a_title.is_equal ("") then
				-- Some window managers do not like empty strings as titles and show it as an error.
				a_title := "%T"
			end
			create a_cs.make (a_title)
			feature {EV_GTK_EXTERNALS}.gtk_window_set_title (c_object, a_cs.item)
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR) is
			-- Set `menu_bar' to `a_menu_bar'.
		local
			mb_imp: EV_MENU_BAR_IMP
		do
			menu_bar := a_menu_bar
			mb_imp ?= menu_bar.implementation
			mb_imp.set_parent_window_imp (Current)
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, mb_imp.list_widget, False, True, 0)
			feature {EV_GTK_EXTERNALS}.gtk_box_reorder_child (vbox, mb_imp.list_widget, 0)
		end

	remove_menu_bar is
			-- Set `menu_bar' to `Void'.
		local
			mb_imp: EV_MENU_BAR_IMP
		do
			if menu_bar /= Void then
				mb_imp ?= menu_bar.implementation
				mb_imp.remove_parent_window
				feature {EV_GTK_DEPENDENT_EXTERNALS}.object_ref (mb_imp.list_widget)
				feature {EV_GTK_EXTERNALS}.gtk_container_remove (vbox, mb_imp.list_widget)
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
				feature {EV_GTK_EXTERNALS}.gtk_window_set_transient_for (c_object, win_imp.c_object)
			else
				if not is_destroyed then
					feature {EV_GTK_EXTERNALS}.gtk_window_set_transient_for (c_object, NULL)
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

	on_widget_mapped is
			-- `Current' has been mapped to the screen.
		do
			if show_actions_internal /= Void and call_show_actions then
				show_actions_internal.call (Void)
			end
			call_show_actions := False
		end

	has_wm_decorations: BOOLEAN is
			-- Does current Window object have WM decorations.
		do
			Result := False
		end

	positioned_by_user: BOOLEAN
		-- Has the Window been positioned by the user?

	internal_set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, -1, -1)
			Precursor {EV_CONTAINER_IMP} (a_minimum_width, a_minimum_height)
			feature {EV_GTK_EXTERNALS}.gtk_window_set_default_size (c_object, a_minimum_width, a_minimum_height)
		end

	default_width: INTEGER
			-- Default width for the window if set, -1 otherwise.
			-- (see. `gtk_window_set_default_size' for more information)
		
	default_height: INTEGER
			-- Default height for the window if set, -1 otherwise.
			-- (see. `gtk_window_set_default_size' for more information)

	on_size_allocate (a_x_invalid, a_y_invalid, a_width_invalid, a_height_invalid: INTEGER) is
			-- Gtk_Widget."size-allocate" happened.
		local
			x_pos, y_pos, wid, hght: INTEGER
		do
			-- We completely ignore passed in arguments as they are sometimes bogus, therefore we query ourselves.
			x_pos := x_position
			y_pos := y_position
			wid := width
			hght := height
			--| `default_width' and `default_height' are not useful anymore
			default_width := -1
			default_height := -1
			positioned_by_user := False
			Precursor (x_pos, y_pos, wid, hght)
			if x_pos /= user_x_position or y_pos /= user_y_position then
				user_x_position := x_pos
				user_y_position := screen_y			
				if move_actions_internal /= Void then
					move_actions_internal.call ([user_x_position, user_y_position, wid, hght])
				end	
			end
		end

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Used for key event actions sequences.
		local
			a_cs: EV_GTK_C_STRING
		do
			Precursor (a_key, a_key_string, a_key_press)
			if focus_widget /= Void and then a_key /= Void and then focus_widget.has_focus then
					-- Used to disable certain key behavior such as Tab focus.
				if a_key_press then
					if focus_widget.default_key_processing_blocked (a_key) then
						create a_cs.make ("key-press-event")
						feature {EV_GTK_EXTERNALS}.signal_emit_stop_by_name (c_object, a_cs.item)
						focus_widget.on_key_event (a_key, a_key_string, a_key_press)
					end
				else
					if focus_widget.default_key_processing_blocked (a_key) then
						create a_cs.make ("key-release-event")
						feature {EV_GTK_EXTERNALS}.signal_emit_stop_by_name (c_object, a_cs.item)
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
		local
			a_decor: INTEGER
		do
			Precursor
			is_initialized := False
			create upper_bar
			create lower_bar

			maximum_width := 32000
			maximum_height := 32000
			
			signal_connect_true ("delete_event", agent (App_implementation.gtk_marshal).on_window_close_request (c_object))
			initialize_client_area

					-- Set appropriate WM decorations
			if has_wm_decorations then
				a_decor := feature {EV_GTK_EXTERNALS}.Gdk_decor_all_enum
			else
				a_decor := feature {EV_GTK_EXTERNALS}.Gdk_decor_border_enum
			end	
			feature {EV_GTK_EXTERNALS}.gdk_window_set_decorations (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), a_decor)
			
			enable_user_resize
			default_height := -1
			default_width := -1
			is_initialized := True
		end
		
	client_area: POINTER is
			-- Pointer to the widget that is treated as the main holder of the client area within the window.
		do
			Result := c_object
		end
	
	initialize_client_area is
			-- Initialize the client area of 'Current'.
		local
			bar_imp: EV_VERTICAL_BOX_IMP
		do
			vbox := feature {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0)
			
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (vbox)
			feature {EV_GTK_EXTERNALS}.gtk_container_add (client_area, vbox)
			hbox := feature {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (hbox)

			bar_imp ?= upper_bar.implementation

			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, hbox, True, True, 0)

			bar_imp ?= lower_bar.implementation

			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)

			app_implementation.window_oids.extend (object_id)
		end

feature {EV_ACCELERATOR_IMP} -- Implementation

	vbox: POINTER
			-- Vertical_box to have a possibility for a menu on the
			-- top and a status bar at the bottom.
			
feature {EV_ANY_I} -- Implementation
			
	lock_update is
			-- Lock drawing updates for `Current'
		do
			Precursor {EV_WINDOW_I}			
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_freeze_updates (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object))
		end
		
	event_mask: INTEGER
		-- Current events mask of GdkWindow
		
	unlock_update is
			-- Restore drawing updates for `Current'
		do
			Precursor {EV_WINDOW_I}
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_thaw_updates (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object))
		end

feature {EV_INTERMEDIARY_ROUTINES}

	call_close_request_actions is
			-- Call the close request actions.
		do
			if close_request_actions_internal /= Void and then not App_implementation.is_in_transport then
				close_request_actions_internal.call (Void)
			end
		end
			
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

