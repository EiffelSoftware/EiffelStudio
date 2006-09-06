indexing
	description: "EiffelVision popup window, GTK+ implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POPUP_WINDOW_IMP

inherit
	EV_POPUP_WINDOW_I
		undefine
			propagate_background_color,
			propagate_foreground_color,
			lock_update,
			unlock_update
		redefine
			interface
		end

	EV_WINDOW_IMP
		redefine
			interface,
			make,
			initialize,
			default_wm_decorations,
			client_area,
			show,
			hide,
			has_focus,
			internal_enable_border,
			internal_disable_border,
			on_mouse_button_event,
			set_size
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_window_new ({EV_GTK_EXTERNALS}.gtk_window_toplevel_enum))
		end

	initialize is
			-- Initialize `Current'.
		do
			{EV_GTK_EXTERNALS}.gtk_window_set_skip_pager_hint (c_object, True)
			{EV_GTK_EXTERNALS}.gtk_window_set_skip_taskbar_hint (c_object, True)
			client_area := {EV_GTK_EXTERNALS}.gtk_event_box_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (client_area)
			{EV_GTK_EXTERNALS}.gtk_container_add (c_object, client_area)
			Precursor {EV_WINDOW_IMP}

				-- This completely disconnects the window from the window manager.
			{EV_GTK_EXTERNALS}.gdk_window_set_override_redirect ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), True)
			disable_border
			disable_user_resize
			set_background_color ((create {EV_STOCK_COLORS}).black)
			set_is_initialized (True)
		end

feature {NONE} -- Implementation

	set_size (a_width, a_height: INTEGER)
		do
			Precursor (a_width, a_height)
			if is_displayed then
				{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (c_object, default_width.max (internal_minimum_width), default_height.max (internal_minimum_height))
			end
		end

	on_mouse_button_event (a_type: INTEGER_32; a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32) is
		do
			Precursor (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			if a_type = {EV_GTK_EXTERNALS}.gdk_button_press_enum then
				if
					a_screen_x >= x_position and then
					a_screen_x <= (x_position + width) and then
					a_screen_y >= y_position and then
					a_screen_y <= (y_position + height)
				then
					grab_keyboard_and_mouse
				else
						-- Emulate WM handling when clicking off window.
					release_keyboard_and_mouse
					{EV_GTK_EXTERNALS}.gtk_window_set_focus (c_object, default_pointer)
				end
			end
		end

	border_width: INTEGER is 1
		-- Border width of `Current'.

	internal_enable_border is
			-- Ensure a border is displayed around Current.
		do
			{EV_GTK_EXTERNALS}.gtk_container_set_border_width (c_object, border_width)
		end

	internal_disable_border is
			-- Ensure no border is displayed around Current.
		do
			{EV_GTK_EXTERNALS}.gtk_container_set_border_width (c_object, 0)
		end

	show is
			-- Map the Window to the screen.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (c_object, default_width.max (minimum_width), default_height.max (minimum_height))
			Precursor
			grab_keyboard_and_mouse
		end

	hide is
			-- Unmap the Window from the screen.
		do
			release_keyboard_and_mouse
			Precursor;
			{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (c_object, internal_minimum_width, internal_minimum_height)
		end

	has_focus: BOOLEAN is
			-- Does Current have the keyboard focus?
		do
			Result := {EV_GTK_EXTERNALS}.gtk_grab_get_current = c_object
		end

	default_wm_decorations: INTEGER is
			-- Default Window Manager decorations of `Current'.
		do
			Result := 0
		end

	client_area: POINTER

feature {NONE} -- Implementation

feature {EV_ANY_I} -- Implementation

	interface: EV_POPUP_WINDOW;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

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




end -- class EV_POPUP_WINDOW_IMP

