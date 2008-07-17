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
			interface
		end

	EV_CELL_IMP
		undefine
			x_position,
			y_position,
			screen_x,
			screen_y,
			minimum_width,
			minimum_height,
			width,
			height,
			show
		redefine
			interface,
			initialize,
			make,
			on_size_allocate,
			hide,
			on_widget_mapped,
			on_widget_unmapped,
			destroy,
			has_focus,
			on_focus_changed,
			container_widget
		end

	EV_GTK_WINDOW_IMP
		undefine
			initialize,
			destroy,
			parent_imp
		redefine
			interface,
			has_focus,
			show,
			hide
		end

	EV_WINDOW_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the window.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_window_new ({EV_GTK_EXTERNALS}.Gtk_window_toplevel_enum))
		end

	initialize is
			-- Create the vertical box `vbox' and horizontal box `container_widget'
			-- to put in the window.
			-- The `vbox' will be able to contain the menu bar, the `container_widget'
			-- and the status bar.
			-- The `container_widget' will contain the child of the window.
		local
			app_imp: like app_implementation
			l_gtk_marshal: EV_GTK_CALLBACK_MARSHAL
			l_c_object: POINTER
		do
			set_is_initialized (False)
			l_c_object := c_object

			create accel_list.make (10)

			create upper_bar
			create lower_bar

			maximum_width := interface.maximum_dimension
			maximum_height := interface.maximum_dimension
			app_imp := app_implementation
			l_gtk_marshal := app_imp.gtk_marshal

			initialize_client_area

			l_gtk_marshal.signal_connect (l_c_object, app_imp.set_focus_event_string, agent (l_gtk_marshal).on_set_focus_event_intermediary (internal_id, ?), l_gtk_marshal.set_focus_event_translate_agent, True)
				-- Used to propagate focus events between internal gtk widgets.

			{EV_GTK_EXTERNALS}.gtk_window_set_default_size (l_c_object, 1, 1)
			Precursor {EV_CELL_IMP}
				-- Need to set decorations after window is realized.
			{EV_GTK_EXTERNALS}.gdk_window_set_decorations ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (l_c_object), default_wm_decorations)
			internal_is_border_enabled := True
			configure_event_pending := True
			user_can_resize := True
			set_is_initialized (True)
		end

feature  -- Access

	has_focus: BOOLEAN
			-- Does `Current' have the keyboard focus?
		do
			Result := internal_has_focus
		end

 	maximum_width: INTEGER
			-- Maximum width that application wishes widget
			-- instance to have.

	maximum_height: INTEGER
			-- Maximum height that application wishes widget
			-- instance to have.

	title: STRING_32 is
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

	add_transient_child (a_child: EV_GTK_WINDOW_IMP)
			-- Add `a_child' as transient child for `Current'.
		require
			a_child_not_void: a_child /= Void
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_transient_for (a_child.c_object, c_object)
		end

	remove_transient_child (a_child: EV_GTK_WINDOW_IMP)
			-- Remove `a_child' as transient child for `Current'.
		require
			a_child_not_void: a_child /= Void
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_transient_for (a_child.c_object, default_pointer)
		end

	internal_disable_border is
			-- Ensure no border is displayed around `Current'.
		local
			l_decor: INTEGER
			l_x, l_y: INTEGER
			l_temp: INTEGER
		do
				-- We are disabling the border so we need to reset the position in the exact place
			l_temp := {EV_GTK_EXTERNALS}.gdk_window_get_origin ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), $l_x, $l_y)
			l_decor := default_wm_decorations.bit_and ({EV_GTK_EXTERNALS}.gdk_decor_border_enum.bit_not)
			{EV_GTK_EXTERNALS}.gdk_window_set_decorations ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), l_decor)
			set_position (l_x, l_y)
		end

	internal_enable_border is
			-- Ensure a border is displayed around `Current'.
		local
			l_decor: INTEGER
		do
			l_decor := default_wm_decorations.bit_or ({EV_GTK_EXTERNALS}.gdk_decor_border_enum)
			{EV_GTK_EXTERNALS}.gdk_window_set_decorations ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), l_decor)
		end

	disable_user_resize_called: BOOLEAN
		-- Has `disable_user_resize' been called?

	disable_user_resize is
			-- Forbid the resize of the window.
		do
			disable_user_resize_called := True
			user_can_resize := False
			if is_displayed then
				forbid_resize
			end
		end

	enable_user_resize is
			-- Allow the resize of the window.
		do
			if not user_can_resize then
				disable_user_resize_called := False
				user_can_resize := True
				if is_displayed then
					allow_resize
				end
			end
		end

	allow_resize is
			-- Allow the resize of the window.
		local
			l_geometry: POINTER
		do
			l_geometry := {EV_GTK_EXTERNALS}.c_gdk_geometry_struct_allocate
			{EV_GTK_EXTERNALS}.set_gdk_geometry_struct_max_width (l_geometry, maximum_width)
			{EV_GTK_EXTERNALS}.set_gdk_geometry_struct_max_height (l_geometry, maximum_height)
			{EV_GTK_EXTERNALS}.set_gdk_geometry_struct_min_width (l_geometry, minimum_width)
			{EV_GTK_EXTERNALS}.set_gdk_geometry_struct_min_height (l_geometry, minimum_height)
			{EV_GTK_EXTERNALS}.gtk_window_set_geometry_hints (c_object, NULL, l_geometry, {EV_GTK_EXTERNALS}.Gdk_hint_max_size_enum | {EV_GTK_EXTERNALS}.gdk_hint_min_size_enum)
			l_geometry.memory_free
			internal_enable_border
		end

	show is
			-- Map the Window to the screen.
		do
			if not is_show_requested then
				call_show_actions := True
				if disable_user_resize_called then
					if not user_can_resize then
						forbid_resize
					else
							-- Forbid the window manager from resizing window.
						allow_resize
					end
				end
				Precursor {EV_GTK_WINDOW_IMP}
			end
			if blocking_window /= Void then
				set_blocking_window (Void)
			end
		end

	call_show_actions: BOOLEAN
		-- Should the show actions be called?

	call_hide_actions: BOOLEAN
		-- Should the hide actions be called?

	hide is
			-- Unmap the Window from the screen.
		do
			if is_show_requested then
				call_hide_actions := True
				disable_capture
				Precursor {EV_GTK_WINDOW_IMP}
				if disable_user_resize_called then
					allow_resize
				end
			end
		end

feature -- Element change

	set_maximum_width (a_max_width: INTEGER) is
			-- Set `maximum_width' to `a_max_width'.
		do
			internal_set_maximum_size (a_max_width, maximum_height)
		end

	set_maximum_height (a_max_height: INTEGER) is
			-- Set `maximum_height' to `a_max_height'.
		do
			internal_set_maximum_size (maximum_width, a_max_height)
		end

	set_title (new_title: STRING_GENERAL) is
			-- Set `title' to `new_title'.
		local
			a_title: STRING_32
			a_cs: EV_GTK_C_STRING
		do
			a_title := new_title
			if a_title.is_empty then
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

feature {EV_GTK_WINDOW_IMP} -- Access

	accel_list: HASH_TABLE [EV_ACCELERATOR, NATURAL_32]
		-- Lookup table for accelerator access.

feature {NONE} -- Accelerators

	connect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Connect key combination `an_accel' to this window.
		local
			acc_imp: EV_ACCELERATOR_IMP
			a_property, a_origin, a_value: EV_GTK_C_STRING
		do
			if an_accel /= Void then
				acc_imp ?= an_accel.implementation
				accel_list.put (an_accel, acc_imp.accel_id)
				if acc_imp.key.code = {EV_KEY_CONSTANTS}.key_f10 then
						-- F10 is used as a default window accelerator key, if we use F10 in a custom accelerator then we override the default setting
					a_property := once "gtk-menu-bar-accel"
					a_value := once "<Shift><Control><Mod1><Mod2><Mod3><Mod4><Mod5>F10"
						-- This is a value that is highly unlikely to be used
					a_origin := once "Vision2"
					{EV_GTK_EXTERNALS}.gtk_settings_set_string_property (app_implementation.default_gtk_settings, a_property.item, a_value.item, a_origin.item)
				end
			end
		end

	disconnect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Disconnect key combination `an_accel' from this window.
		local
			acc_imp: EV_ACCELERATOR_IMP
		do
			if an_accel /= Void then
				acc_imp ?= an_accel.implementation
				accel_list.remove (acc_imp.accel_id)
			end
		end

feature {EV_ANY_IMP} -- Implementation

	destroy is
			-- Destroy `Current'
		do
			disable_capture
			hide
			Precursor {EV_CELL_IMP}
		end

feature {EV_APPLICATION_IMP} -- Implementation

	on_widget_mapped is
			-- `Current' has been mapped to the screen.
		do
			Precursor
			if show_actions_internal /= Void and call_show_actions then
				show_actions_internal.call (Void)
			end
			call_show_actions := False
		end

	on_widget_unmapped is
			-- `Current' has been unmapped from the screen.
		do
			Precursor
			if hide_actions_internal /= Void then
				hide_actions_internal.call (Void)
			end
		end

feature {NONE} -- Implementation

	internal_has_focus: BOOLEAN
			-- Does `Current' have the keyboard focus?

	internal_set_maximum_size (a_max_width, a_max_height: INTEGER)
			-- Set maximum width and height of `Current' to `a_max_width' and `a_max_height'.
		local
			l_geometry: POINTER
		do
			l_geometry := {EV_GTK_EXTERNALS}.c_gdk_geometry_struct_allocate
			{EV_GTK_EXTERNALS}.set_gdk_geometry_struct_max_width (l_geometry, a_max_width)
			{EV_GTK_EXTERNALS}.set_gdk_geometry_struct_max_height (l_geometry, a_max_height)
			{EV_GTK_EXTERNALS}.gtk_window_set_geometry_hints (c_object, NULL, l_geometry, {EV_GTK_EXTERNALS}.Gdk_hint_max_size_enum)
			l_geometry.memory_free
			maximum_width := a_max_width
			maximum_height := a_max_height
		end

	previously_focused_widget: POINTER
		-- Widget that was previously focused within `Current'.

	set_focused_widget (a_widget: EV_WIDGET_IMP) is
			-- Set currently focused widget to `a_widget'.
		do
			if a_widget /= Void then
				previously_focused_widget := a_widget.c_object
			else
				previously_focused_widget := default_pointer
			end
		end

	previous_x_position, previous_y_position: INTEGER
		-- Positions of previously set x and y coordinates of `Current'.

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
			container_widget := {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			{EV_GTK_EXTERNALS}.gtk_widget_show (container_widget)

			bar_imp ?= upper_bar.implementation

			{EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, container_widget, True, True, 0)

			bar_imp ?= lower_bar.implementation

			{EV_GTK_EXTERNALS}.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)

			app_implementation.window_oids.extend (internal_id)
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_APPLICATION_IMP} -- Implementation

	on_size_allocate (a_x, a_y, a_width, a_height: INTEGER) is
			-- GdkEventConfigure event occurred.
		local
			l_x_pos, l_y_pos: INTEGER
		do
			{EV_GTK_EXTERNALS}.gtk_window_get_position (c_object, $l_x_pos, $l_y_pos)
			configure_event_pending := False
			Precursor (l_x_pos, l_y_pos, a_width, a_height)
			if l_x_pos  /= previous_x_position or else l_y_pos /= previous_y_position then
				previous_x_position := l_x_pos
				previous_y_position := l_y_pos
				if move_actions_internal /= Void then
					move_actions_internal.call (app_implementation.gtk_marshal.dimension_tuple (l_x_pos, l_y_pos, a_width, a_height))
				end
			end
		end

	call_window_state_event (a_changed_mask, a_new_state: INTEGER) is
			-- Call either minimize, maximize or restore actions for window
		do
			-- Move implementation from EV_TITLED_WINDOW_IMP when necessary
		end

	on_set_focus_event (a_widget_ptr: POINTER) is
			-- The focus of a widget has changed within `Current'.
		local
			l_previously_focused_widget: EV_WIDGET_IMP
			a_widget: EV_WIDGET_IMP
		do
			a_widget ?= app_implementation.eif_object_from_gtk_object (a_widget_ptr)
			l_previously_focused_widget ?= app_implementation.eif_object_from_gtk_object (previously_focused_widget)
			set_focused_widget (a_widget)
				-- If `a_widget_ptr' is null then `a_widget' is Void.
			if a_widget /= Void then
				a_widget.on_focus_changed (True)
			end
			if l_previously_focused_widget /= Void and then l_previously_focused_widget /= a_widget then
				l_previously_focused_widget.on_focus_changed (False)
			end
		end

feature {EV_GTK_WINDOW_IMP, EV_PICK_AND_DROPABLE_IMP, EV_APPLICATION_IMP} -- Implementation

	modal_window_count: INTEGER
		-- Number of windows modal to current.

	increase_modal_window_count
			-- Increase modal window count.
		do
			if modal_window_count = 0 then
				disallow_window_manager_focus
			end
			modal_window_count := modal_window_count + 1
		end

	decrease_modal_window_count
			-- Decrease modal window count.
		require
			modal_window_count_decreasable: modal_window_count > 0
		do
			modal_window_count := modal_window_count - 1
			if modal_window_count = 0 then
				allow_window_manager_focus
			end
		end

	has_modal_window: BOOLEAN
			-- Does `Current' have a transient window that is modal to `Current'.
		do
			Result := modal_window_count > 0
		end

	allow_window_manager_focus is
			-- Allow the window manager to give the focus to `Current'.
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_accept_focus (c_object, True)
		end

	disallow_window_manager_focus is
			-- Disallow the window manager to give the focus to `Current'.
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_accept_focus (c_object, False)
		end

feature {EV_MENU_BAR_IMP, EV_ACCELERATOR_IMP, EV_APPLICATION_IMP} -- Implementation

	on_focus_changed (a_has_focus: BOOLEAN) is
			-- Called from focus intermediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		do
			internal_has_focus := a_has_focus
			Precursor {EV_CELL_IMP} (a_has_focus)
			if a_has_focus then
				on_set_focus_event ({EV_GTK_EXTERNALS}.gtk_window_struct_focus_widget (c_object))
			else
				on_set_focus_event (default_pointer)
			end
		end

feature {EV_ACCELERATOR_IMP} -- Implementation

	vbox: POINTER
			-- Vertical_box to have a possibility for a menu on the
			-- top and a status bar at the bottom.

feature {EV_INTERMEDIARY_ROUTINES}

	call_close_request_actions is
			-- Call the close request actions.
		do
			if close_request_actions_internal /= Void and then not App_implementation.is_in_transport and then not has_modal_window and then not is_destroyed then
				close_request_actions_internal.call (Void)
			end
		end

feature {EV_CLIPBOARD_IMP} -- Implementation

	container_widget: POINTER
			-- Horizontal box container for the child.

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

