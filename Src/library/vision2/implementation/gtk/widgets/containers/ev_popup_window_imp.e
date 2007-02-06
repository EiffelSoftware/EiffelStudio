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
			grab_keyboard_and_mouse,
			release_keyboard_and_mouse,
			allow_resize,
			forbid_resize,
			on_focus_changed
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

feature {EV_ANY_I} -- Implementation

	on_focus_changed (a_has_focus: BOOLEAN) is
			-- Called from focus intermediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		do
			if a_has_focus then
				app_implementation.set_focused_popup_window (Current)
			else
				app_implementation.set_focused_popup_window (Void)
			end
			Precursor {EV_WINDOW_IMP} (a_has_focus)
		end

	grab_keyboard_and_mouse is
			-- Perform a global mouse and keyboard grab.
		do
			if not is_disconnected_from_window_manager then
				Precursor
			end
		end

	release_keyboard_and_mouse is
			-- Release mouse and keyboard grab.
		do
			if not is_disconnected_from_window_manager then
				Precursor
			end
		end

feature {NONE} -- implementation

	allow_resize
			-- Allow user resizing of `Current'.
		do
			internal_enable_border
		end

	forbid_resize
			-- Forbid user resizing of `Current'.
		do
			-- Nothing needed at present as user cannot current resize the popup window.
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

feature {EV_APPLICATION_IMP} -- Implementation

	show is
			-- Map the Window to the screen.
		do
			Precursor
			if not has_focus then
				grab_keyboard_and_mouse
			end
		end

	hide is
			-- Unmap the Window from the screen.
		do
			if has_focus then
				release_keyboard_and_mouse
					-- We reset the focused popup window here in case hide is called as part of destroy
					-- in which case the focus out event will not be called.
				app_implementation.set_focused_popup_window (Void)
			end
			Precursor;
		end

	has_focus: BOOLEAN is
			-- Does Current have the keyboard focus?
		do
			if not is_disconnected_from_window_manager then
				Result := app_implementation.focused_popup_window = Current
			end
		end

	handle_mouse_button_event (a_type: INTEGER_32; a_button: INTEGER_32; a_screen_x, a_screen_y: INTEGER_32) is
			-- A mouse event has occurred.
		do
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
					if has_focus then
						release_keyboard_and_mouse
					end
				end
			end
		end

feature {NONE} -- Implementation

	default_wm_decorations: INTEGER is
			-- Default Window Manager decorations of `Current'.
		do
			Result := 0
		end

	client_area: POINTER
		-- Container area of `Current'.

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

