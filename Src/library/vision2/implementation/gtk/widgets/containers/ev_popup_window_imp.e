note
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
			old_make,
			make,
			default_wm_decorations,
			client_area,
			show,
			hide,
			internal_enable_border,
			internal_disable_border,
			grab_keyboard_and_mouse,
			release_keyboard_and_mouse,
			allow_resize,
			forbid_resize,
			on_focus_changed
		end

create
	make, initialize_with_shadow

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Connect interface and initialize `c_object'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			client_area := {EV_GTK_EXTERNALS}.gtk_event_box_new
			Precursor {EV_WINDOW_IMP}
			{EV_GTK_EXTERNALS}.gtk_widget_show (client_area)
			{EV_GTK_EXTERNALS}.gtk_container_add (c_object, client_area)

			if not override_redirect then
--				{EV_GTK_EXTERNALS}.gtk_window_set_type_hint (c_object, {EV_GTK_ENUMS}.gdk_window_type_hint_popup_menu_enum)
				{EV_GTK_EXTERNALS}.gtk_window_set_skip_taskbar_hint (c_object, True)
			end

				-- This completely disconnects the window from the window manager.
			if override_redirect then
				{EV_GTK_EXTERNALS}.gdk_window_set_override_redirect ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), True)
			end

			disable_border
			disable_user_resize
			set_background_color ((create {EV_STOCK_COLORS}).black)
			set_is_initialized (True)
		end

feature {EV_ANY_I} -- Implementation

	override_redirect: BOOLEAN = False

	on_focus_changed (a_has_focus: BOOLEAN)
			-- Called from focus intermediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		do
			if override_redirect then
				if a_has_focus then
					app_implementation.set_focused_popup_window (Current)
				else
					app_implementation.set_focused_popup_window (Void)
				end
			end
			Precursor {EV_WINDOW_IMP} (a_has_focus)
		end

	grab_keyboard_and_mouse
			-- Perform a global mouse and keyboard grab.
		do
			if not is_disconnected_from_window_manager then
				Precursor
			end
		end

	release_keyboard_and_mouse
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

	border_width: INTEGER = 1
		-- Border width of `Current'.

	internal_enable_border
			-- Ensure a border is displayed around Current.
		do
			{EV_GTK_EXTERNALS}.gtk_container_set_border_width (c_object, border_width)
		end

	internal_disable_border
			-- Ensure no border is displayed around Current.
		do
			{EV_GTK_EXTERNALS}.gtk_container_set_border_width (c_object, 0)
		end

feature {EV_APPLICATION_IMP} -- Implementation

	show
			-- Map the Window to the screen.
		do
			Precursor
			if override_redirect then
				if not has_focus then
					grab_keyboard_and_mouse
				end
			end
		end

	hide
			-- Unmap the Window from the screen.
		do
			if override_redirect then
				if has_focus then
					release_keyboard_and_mouse
						-- We reset the focused popup window here in case hide is called as part of destroy
						-- in which case the focus out event will not be called.
					if is_in_destroy then
						app_implementation.set_focused_popup_window (Void)
					end
				end
			end
			Precursor;
		end

	handle_mouse_button_event (a_type: INTEGER_32; a_button: INTEGER_32; a_screen_x, a_screen_y: INTEGER_32)
			-- A mouse event has occurred.
		do
			if override_redirect then
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
		end

feature {NONE} -- Implementation

	default_wm_decorations: INTEGER
			-- Default Window Manager decorations of `Current'.
		do
			Result := 0
		end

	client_area: POINTER
		-- Container area of `Current'.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_POPUP_WINDOW note option: stable attribute end;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

note
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
