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
			replace,
			x_position,
			y_position,
			screen_x,
			screen_y,
			width,
			height,
			is_parentable,
			show
		redefine
			interface,
			initialize,
			make,
			on_key_event,
			on_size_allocate,
			hide,
			internal_set_minimum_size,
			on_widget_mapped,
			destroy,
			has_focus
		end

	EV_GTK_WINDOW_IMP
		undefine
			initialize,
			destroy,
			parent_imp,
			minimum_width,
			minimum_height
		redefine
			interface,
			on_key_event,
			has_focus,
			show
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

feature  -- Access

	has_focus: BOOLEAN is
			-- Does `Current' have the keyboard focus?
		do
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_window_has_toplevel_focus (c_object)
		end

	item: EV_WIDGET
			-- Current item.

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
			a_cs: EV_GTK_C_STRING
		do
			p := {EV_GTK_EXTERNALS}.gtk_window_struct_title (c_object)
			if p /= NULL then
				create a_cs.share_from_pointer (p)
				Result := a_cs.string
				if Result.is_equal ("%T") then
					Result := ""
				end
			else
				Result := ""
			end
		end

	menu_bar: EV_MENU_BAR
			-- Horizontal bar at top of client area that contains menu's.

feature -- Status setting

	internal_disable_border is
			-- Ensure no border is displayed around `Current'.
		do
		end

	internal_enable_border is
			-- Ensure a border is displayed around `Current'.
		do
		end

	block is
			-- Wait until window is closed by the user.
		local
			events_pending: BOOLEAN
			l_app_imp: like app_implementation
		do
			from
				l_app_imp := app_implementation
			until
				is_destroyed or else not is_show_requested
			loop
				if not {EV_GTK_EXTERNALS}.g_main_iteration (False) then
						-- There are no more events pending.
					if l_app_imp.idle_actions_pending then
						l_app_imp.call_idle_actions
					else
						events_pending := {EV_GTK_EXTERNALS}.g_main_iteration (True)
					end
				end
			end
		end

	allow_resize is
			-- Allow the resize of the window.
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_policy (c_object, 0, 1, 0)
		end

	show is
			-- Map the Window to the screen.
		do
			if not is_show_requested then
				call_show_actions := True
				Precursor {EV_GTK_WINDOW_IMP}
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
		local
			a_x_pos, a_y_pos: INTEGER
		do
			if is_show_requested then
				a_x_pos := x_position
				a_y_pos := y_position
				disable_modal
				set_blocking_window (Void)
				Precursor {EV_CONTAINER_IMP}
					-- Setting positions so that if `Current' is reshown then it reappears in the same place, as on Windows.
				set_position (a_x_pos, a_y_pos)
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
			if a_title.is_equal (once "") then
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
		do
			menu_bar := a_menu_bar
			mb_imp ?= menu_bar.implementation
			mb_imp.set_parent_window_imp (Current)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, mb_imp.list_widget, False, True, 0)
			{EV_GTK_EXTERNALS}.gtk_box_reorder_child (vbox, mb_imp.list_widget, 0)
		end

	remove_menu_bar is
			-- Set `menu_bar' to `Void'.
		local
			mb_imp: EV_MENU_BAR_IMP
		do
			if menu_bar /= Void then
				mb_imp ?= menu_bar.implementation
				mb_imp.remove_parent_window
				{EV_GTK_EXTERNALS}.gtk_container_remove (vbox, mb_imp.list_widget)
			end
			menu_bar := Void
		end

feature {EV_ANY_IMP} -- Implementation

	destroy is
			-- Destroy `Current'
		do
			disable_capture
			hide
			Precursor {EV_CONTAINER_IMP}
		end

feature {NONE} -- Implementation

	on_widget_mapped is
			-- `Current' has been mapped to the screen.
		do
			if show_actions_internal /= Void and call_show_actions then
				show_actions_internal.call (Void)
			end
			call_show_actions := False
		end

	internal_set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, -1, -1)
			Precursor {EV_CONTAINER_IMP} (a_minimum_width, a_minimum_height)
		end

	on_size_allocate (a_x, a_y, a_width, a_height: INTEGER) is
			-- Gtk_Widget."size-allocate" happened.
		local
			a_x_pos, a_y_pos: INTEGER
--			a_rect: POINTER
		do
--			a_rect := {EV_GTK_EXTERNALS}.c_gdk_rectangle_struct_allocate
--			{EV_GTK_EXTERNALS}.gdk_window_get_frame_extents ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), a_rect)
--
--			print ("Frame extents width = " +{EV_GTK_EXTERNALS}.gdk_rectangle_struct_width (a_rect).out + "%N")
--			print ("Frame extents height = " +{EV_GTK_EXTERNALS}.gdk_rectangle_struct_height (a_rect).out + "%N")
--			print ("Frame extents x = " +{EV_GTK_EXTERNALS}.gdk_rectangle_struct_x (a_rect).out + "%N")
--			print ("Frame extents y = " +{EV_GTK_EXTERNALS}.gdk_rectangle_struct_y (a_rect).out + "%N")
--
--			print ("Window x position = " + x_position.out + "%N")
--			print ("Window y position = " + y_position.out + "%N")
--			print ("Window width = " + width.out + "%N")
--			print ("Window height = " + height.out + "%N")
--			a_rect.memory_free

			--| `default_width' and `default_height' are not useful anymore.
			a_x_pos := x_position
			a_y_pos := y_position
			default_width := -1
			default_height := -1
			positioned_by_user := False
			Precursor (a_x_pos, a_y_pos, a_width, a_height)
			if a_x_pos  /= previous_x_position or a_y_pos /= previous_y_position then
				previous_x_position := a_x_pos
				previous_y_position := a_y_pos
				if move_actions_internal /= Void then
					move_actions_internal.call (app_implementation.gtk_marshal.dimension_tuple (previous_x_position, previous_y_position, a_width, a_height))
				end
			end
		end

	previous_x_position, previous_y_position: INTEGER
		-- Positions of previously set x and y coordinates of `Current'.

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Used for key event actions sequences.
		local
			a_cs: EV_GTK_C_STRING
			l_app_imp: like app_implementation
			a_focus_widget: EV_WIDGET_IMP
			a_gtk_focus_widget: POINTER
		do
			Precursor {EV_CONTAINER_IMP} (a_key, a_key_string, a_key_press)
				-- Fire the widget events.
			a_gtk_focus_widget := {EV_GTK_EXTERNALS}.gtk_window_get_focus (c_object)
			if a_gtk_focus_widget /= default_pointer then
				a_focus_widget ?= eif_object_from_gtk_object (a_gtk_focus_widget)
			end

			if a_focus_widget /= Void and then a_focus_widget.is_sensitive and then a_focus_widget.has_focus then
				if a_key /= Void and then a_focus_widget.default_key_processing_blocked (a_key) then
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
			on_key_event_intermediary_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE [EV_KEY, STRING, BOOLEAN]]
			app_imp: like app_implementation
		do
			create upper_bar
			create lower_bar

			maximum_width := interface.maximum_dimension
			maximum_height := interface.maximum_dimension

			signal_connect_true (once "delete_event", agent (App_implementation.gtk_marshal).on_window_close_request (c_object))
			initialize_client_area

			enable_user_resize
			default_height := -1
			default_width := -1

			app_imp := app_implementation
			on_key_event_intermediary_agent := agent (app_imp.gtk_marshal).on_key_event_intermediary (c_object, ?, ?, ?)
			signal_connect (c_object, app_imp.key_press_event_string, on_key_event_intermediary_agent, key_event_translate_agent, False)
			signal_connect (c_object, app_imp.key_release_event_string, on_key_event_intermediary_agent, key_event_translate_agent, False)
				--| "button-press-event" is a special case, see below.

			real_signal_connect (c_object, once "configure-event", agent (App_implementation.gtk_marshal).on_size_allocate_intermediate (internal_id, ?, ?, ?, ?), configure_translate_agent)

			{EV_GTK_EXTERNALS}.gtk_window_set_default_size (c_object, 1, 1)
			Precursor {EV_CONTAINER_IMP}
					-- Set appropriate WM decorations
			if has_wm_decorations then
				a_decor := {EV_GTK_EXTERNALS}.Gdk_decor_all_enum
			else
				a_decor := {EV_GTK_EXTERNALS}.Gdk_decor_border_enum
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

			{EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, hbox, True, True, 0)

			bar_imp ?= lower_bar.implementation

			{EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)

			app_implementation.window_oids.extend (internal_id)
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
--			{EV_GTK_EXTERNALS}.gtk_widget_set_app_paintable (c_object, True)
--			{EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_freeze_updates ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object))
		end

	event_mask: INTEGER
		-- Current events mask of GdkWindow

	unlock_update is
			-- Restore drawing updates for `Current'
		do
			Precursor {EV_WINDOW_I}
--			{EV_GTK_EXTERNALS}.gtk_widget_set_app_paintable (c_object, False)
--			{EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_thaw_updates ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object))
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

	interface: EV_WINDOW;
		-- Interface object of `Current'

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

