indexing
	description: "Eiffel Vision window. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			on_widget_mapped,
			is_parentable
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
			set_c_object ({EV_GTK_EXTERNALS}.gtk_window_new ({EV_GTK_EXTERNALS}.Gtk_window_toplevel_enum))
		end

	is_parentable: BOOLEAN is False

feature  -- Access

	item: EV_WIDGET
			-- Current item.
			
	screen_x, x_position: INTEGER is
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
						{EV_GTK_EXTERNALS}.gdk_window_get_root_origin (
							{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
							$a_x, NULL)
							Result := a_x					
					else
							Result := client_screen_x
					end
				else
					a_aux_info := aux_info_struct
					if a_aux_info /= NULL then
						Result := {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_x (a_aux_info)
					end
				end
			end
		end
		
	screen_y, y_position: INTEGER is
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
						{EV_GTK_EXTERNALS}.gdk_window_get_root_origin (
							{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
					    	NULL, $a_y)
						Result := a_y					
					else
						Result := client_screen_y
					end
				else
					a_aux_info := aux_info_struct
					if a_aux_info /= NULL then
						Result := {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_y (a_aux_info)
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
			p := {EV_GTK_EXTERNALS}.gtk_window_struct_title (c_object)
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
				Result := {EV_GTK_EXTERNALS}.gtk_window_struct_modal (c_object) = 1
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
				dummy := {EV_GTK_EXTERNALS}.gtk_main_iteration_do (True)
				App_implementation.call_idle_actions
			end
		end

	enable_modal is
			-- Set `is_modal' to `True'.
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_modal (c_object, True)
		end

	disable_modal is
			-- Set `is_modal' to `False'.
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_modal (c_object, False)
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
			{EV_GTK_EXTERNALS}.gtk_widget_set_uposition (c_object, a_x, a_y)
			{EV_GTK_EXTERNALS}.gdk_window_move ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), a_x, a_y)
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
			{EV_GTK_EXTERNALS}.gdk_window_resize ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), default_width.max (minimum_width), default_height.max (minimum_height))
			{EV_GTK_EXTERNALS}.gtk_window_set_default_size (c_object, default_width.max (minimum_width), default_height.max (minimum_height))
		end

	forbid_resize is
			-- Forbid the resize of the window.
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_policy (c_object, 0, 0, 0)
		end

	allow_resize is
			-- Allow the resize of the window.
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_policy (c_object, 0, 1, 0)
		end

	destroy is
			-- Render `Current' unusable.
		do
			Precursor {EV_CONTAINER_IMP}
			hide
		end
		
	show is
			-- Map the Window to the screen.
		do
			if not is_show_requested then
				call_show_actions := True
				if is_positioned or positioned_by_user then
					{EV_GTK_EXTERNALS}.gtk_window_set_position (c_object, {EV_GTK_EXTERNALS}.Gtk_win_pos_none_enum)
					app_implementation.process_events
					Precursor {EV_CONTAINER_IMP}
					set_position (user_x_position, user_y_position)
				else
					{EV_GTK_EXTERNALS}.gtk_window_set_position (c_object, {EV_GTK_EXTERNALS}.Gtk_win_pos_center_enum)
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
				disable_modal
				set_blocking_window (Void)
				Precursor {EV_CONTAINER_IMP}
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
				{EV_GTK_DEPENDENT_EXTERNALS}.object_ref (w.c_object)
				{EV_GTK_EXTERNALS}.gtk_container_remove (hbox, w.c_object)
			end
			if v /= Void then
				w ?= v.implementation
				{EV_GTK_EXTERNALS}.gtk_box_pack_end (hbox, w.c_object, True, True, 0)
				on_new_item (w)
			end
			item := v
		end

	set_maximum_width (max_width: INTEGER) is
			-- Set `maximum_width' to `max_width'.
		local
			a_geometry: POINTER
		do
			a_geometry := {EV_GTK_EXTERNALS}.c_gdk_geometry_struct_allocate
			{EV_GTK_EXTERNALS}.set_gdk_geometry_struct_max_width (a_geometry, max_width)
			{EV_GTK_EXTERNALS}.set_gdk_geometry_struct_max_height (a_geometry, maximum_height)
			{EV_GTK_EXTERNALS}.gtk_window_set_geometry_hints (c_object, NULL, a_geometry, {EV_GTK_EXTERNALS}.Gdk_hint_max_size_enum)
			a_geometry.memory_free
			maximum_width := max_width
		end 

	set_maximum_height (max_height: INTEGER) is
			-- Set `maximum_height' to `max_height'.
		local
			a_geometry: POINTER
		do
			a_geometry := {EV_GTK_EXTERNALS}.c_gdk_geometry_struct_allocate
			{EV_GTK_EXTERNALS}.set_gdk_geometry_struct_max_width (a_geometry, maximum_width)
			{EV_GTK_EXTERNALS}.set_gdk_geometry_struct_max_height (a_geometry, max_height)
			{EV_GTK_EXTERNALS}.gtk_window_set_geometry_hints (c_object, NULL, a_geometry, {EV_GTK_EXTERNALS}.Gdk_hint_max_size_enum)
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
			a_cs := a_title
			{EV_GTK_EXTERNALS}.gtk_window_set_title (c_object, a_cs.item)
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR) is
			-- Set `menu_bar' to `a_menu_bar'.
		local
			mb_imp: EV_MENU_BAR_IMP
			menu_imp: EV_MENU_IMP
			a_cs: EV_GTK_C_STRING
		do
			menu_bar := a_menu_bar
			mb_imp ?= menu_bar.implementation
			mb_imp.set_parent_window_imp (Current)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, mb_imp.list_widget, False, True, 0)
			{EV_GTK_EXTERNALS}.gtk_box_reorder_child (vbox, mb_imp.list_widget, 0)
			a_cs := "activate_item"
			from
				menu_bar.start
			until
				menu_bar.after
			loop
				menu_imp ?= menu_bar.item.implementation
				if menu_imp /= Void and then menu_imp.key /= 0 then
					{EV_GTK_EXTERNALS}.gtk_widget_add_accelerator (menu_imp.c_object,
						a_cs.item,
						accel_group,
						menu_imp.key,
						{EV_GTK_EXTERNALS}.gdk_mod1_mask_enum,
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
						{EV_GTK_EXTERNALS}.gtk_widget_remove_accelerator (menu_imp.c_object,
							accel_group,
							menu_imp.key,
							{EV_GTK_EXTERNALS}.gdk_mod1_mask_enum)
					end
					menu_bar.forth
				end
				mb_imp ?= menu_bar.implementation
				mb_imp.remove_parent_window
				{EV_GTK_DEPENDENT_EXTERNALS}.object_ref (mb_imp.list_widget)
				{EV_GTK_EXTERNALS}.gtk_container_remove (vbox, mb_imp.list_widget)
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
				{EV_GTK_EXTERNALS}.gtk_window_set_transient_for (c_object, win_imp.c_object)
			else
				if not is_destroyed then
					{EV_GTK_EXTERNALS}.gtk_window_set_transient_for (c_object, NULL)
				end		
			end
		end
		
feature {EV_WIDGET_IMP} -- Position retrieval

	client_screen_x: INTEGER is
			-- Horizontal position of the client area on screen, 
		local
			a_x: INTEGER
			a_aux_info: POINTER
			i: INTEGER
		do
			if is_displayed then
					i := {EV_GTK_EXTERNALS}.gdk_window_get_origin (
						{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
				    	$a_x, NULL)
					Result := a_x
			else
				a_aux_info := aux_info_struct
				if a_aux_info /= NULL then
					Result := {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_x (a_aux_info)
				end
			end
		end
		
	client_screen_y: INTEGER is
			-- Vertical position of the client area on screen, 
		local
			a_y: INTEGER
			a_aux_info: POINTER
			i: INTEGER
		do
			if is_displayed then
					i := {EV_GTK_EXTERNALS}.gdk_window_get_origin (
						{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
				    	NULL, $a_y)
					Result := a_y
			else
				a_aux_info := aux_info_struct
				if a_aux_info /= NULL then
					Result := {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_y (a_aux_info)
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
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, -1, -1)
			Precursor {EV_CONTAINER_IMP} (a_minimum_width, a_minimum_height)
			{EV_GTK_EXTERNALS}.gtk_window_set_default_size (c_object, a_minimum_width, a_minimum_height)
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
			a_gtk_focus_widget: POINTER
			a_focus_widget: EV_WIDGET_IMP
			l_app_imp: EV_APPLICATION_IMP
		do
			Precursor (a_key, a_key_string, a_key_press)
			
			-- Fire the widget events.
			
			a_gtk_focus_widget := {EV_GTK_EXTERNALS}.gtk_window_struct_focus_widget (c_object)
			if a_gtk_focus_widget /= default_pointer then
				a_focus_widget ?= eif_object_from_gtk_object (a_gtk_focus_widget)
			end

			if a_focus_widget /= Void and a_key /= Void and then a_focus_widget.is_sensitive and then a_focus_widget.has_focus then
				if a_focus_widget.default_key_processing_blocked (a_key) then
						-- Block event from losing focus should the widget want to keep it.
					l_app_imp := app_implementation
					if a_key_press then
						a_cs := l_app_imp.key_press_event_string
					else
						a_cs := l_app_imp.key_release_event_string
					end
					{EV_GTK_EXTERNALS}.signal_emit_stop_by_name (c_object, a_cs.item)				
				end
				a_focus_widget.on_key_event (a_key, a_key_string, a_key_press)
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
			app_imp: EV_APPLICATION_IMP
			on_key_event_intermediary_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE [EV_KEY, STRING, BOOLEAN]]
		do
			set_title("")
			accel_group := {EV_GTK_EXTERNALS}.gtk_accel_group_new
			{EV_GTK_EXTERNALS}.gtk_window_add_accel_group (c_object, accel_group)
			create upper_bar
			create lower_bar

			maximum_width := 32000
			maximum_height := 32000
			app_imp := app_implementation
			
			signal_connect_true ("delete_event", agent (App_imp.gtk_marshal).on_window_close_request (c_object))
			initialize_client_area

			
			on_key_event_intermediary_agent := agent (app_imp.gtk_marshal).on_key_event_intermediary (c_object, ?, ?, ?)
			signal_connect (c_object, app_imp.key_press_event_string, on_key_event_intermediary_agent, key_event_translate_agent, False)
			signal_connect (c_object, app_imp.key_release_event_string, on_key_event_intermediary_agent, key_event_translate_agent, False)
			
			real_signal_connect (c_object, once "configure-event", agent (App_imp.gtk_marshal).on_size_allocate_intermediate (internal_id, ?, ?, ?, ?), configure_translate_agent)
			
			{EV_GTK_EXTERNALS}.gtk_window_set_default_size (c_object, 1, 1)
			
			enable_user_resize
			default_height := -1
			default_width := -1
			Precursor {EV_CONTAINER_IMP}
				-- Set appropriate WM decorations
			if has_wm_decorations then
				a_decor := {EV_GTK_EXTERNALS}.Gdk_decor_all_enum
			else
				a_decor := {EV_GTK_EXTERNALS}.gdk_decor_border_enum
			end	
			{EV_GTK_EXTERNALS}.gdk_window_set_decorations ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), a_decor)

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
			vbox := {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0)
			{EV_GTK_EXTERNALS}.gtk_widget_show (vbox)
			{EV_GTK_EXTERNALS}.gtk_container_add (client_area, vbox)
			hbox := {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			{EV_GTK_EXTERNALS}.gtk_widget_show (hbox)

			bar_imp ?= upper_bar.implementation
			check
				bar_imp_not_void: bar_imp /= Void
			end

			{EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, hbox, True, True, 0)

			bar_imp ?= lower_bar.implementation
			check
				bar_imp_not_void: bar_imp /= Void
			end
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)

			app_implementation.window_oids.extend (object_id)
		end

	vbox: POINTER
			-- Vertical_box to have a possibility for a menu on the
			-- top and a status bar at the bottom.
			
feature {EV_ANY_I} -- Implementation
			
	lock_update is
			-- Lock drawing updates for `Current'
		do
			Precursor {EV_WINDOW_I}
			event_mask := {EV_GTK_EXTERNALS}.gdk_window_get_events ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object))
			{EV_GTK_EXTERNALS}.gdk_window_set_events ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), 0)
		end
		
	event_mask: INTEGER
		-- Current events mask of GdkWindow
		
	unlock_update is
			-- Restore drawing updates for `Current'
		do
			Precursor {EV_WINDOW_I}
			{EV_GTK_EXTERNALS}.gdk_window_set_events ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), event_mask)
		end

feature {EV_INTERMEDIARY_ROUTINES}

	call_close_request_actions is
			-- Call the close request actions.
		do
			if close_request_actions_internal /= Void and then not App_implementation.is_in_transport then
				close_request_actions_internal.call (Void)
			end
		end

feature {EV_MENU_BAR_IMP} -- Implementation

	accel_group: POINTER
			-- Pointer to GtkAccelGroup struct.
			
feature {EV_CLIPBOARD_IMP} -- Implementation

	hbox: POINTER
			-- Horizontal box for the child.

feature {EV_ANY_I} -- Implementation

	interface: EV_WINDOW;

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




end -- class EV_WINDOW_IMP

