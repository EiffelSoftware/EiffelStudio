note
	description:
		"EiffelVision screen. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "screen, root, window, visual, top"
	date: "$Date$"
	revision: "$Revision$"


class
	EV_SCREEN_IMP

inherit
	EV_SCREEN_I
		redefine
			interface,
			widget_at_mouse_pointer
		end

	EV_DRAWABLE_IMP
		redefine
			interface,
			initialize
		end

	EV_GTK_DEPENDENT_ROUTINES

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create an empty drawing area.
		do
			base_make (an_interface)
		end

	initialize
			-- Set up action sequence connections and create graphics context.
		do
			gc := {EV_GTK_EXTERNALS}.gdk_gc_new (drawable)
			{EV_GTK_EXTERNALS}.gdk_gc_set_subwindow (gc, {EV_GTK_EXTERNALS}.gdk_include_inferiors_enum)
			init_default_values
			set_is_initialized (True)
		end

feature -- Status report

	pointer_position: EV_COORDINATE
			-- Position of the screen pointer.
		local
			l_display_data: TUPLE [a_window: POINTER; a_x: INTEGER; a_y: INTEGER; a_mask: NATURAL_32]
		do
			l_display_data := app_implementation.retrieve_display_data
			create Result.set (l_display_data.a_x, l_display_data.a_y)
		end

	widget_at_position (x, y: INTEGER): EV_WIDGET
			-- Widget at position ('x', 'y') if any.
		local
			l_pointer_position: like pointer_position
			l_widget_imp: EV_WIDGET_IMP
			l_change: BOOLEAN
		do
			l_pointer_position := pointer_position
				-- If `x' and `y' are at the pointer position then as an optimization we do not change the position of the mouse.
			l_change := l_pointer_position.x /= x or else l_pointer_position.y /= y
			if l_change then
				set_pointer_position (x, y)
			end
			l_widget_imp := widget_imp_at_pointer_position
			if l_change then
				set_pointer_position (l_pointer_position.x, l_pointer_position.y)
			end
			if l_widget_imp /= Void then
				Result := l_widget_imp.interface
			end
		end

	widget_at_mouse_pointer: EV_WIDGET
			-- Widget at mouse pointer if any.
		local
			l_widget_imp: EV_WIDGET_IMP
		do
			l_widget_imp := widget_imp_at_pointer_position
			if l_widget_imp /= Void then
				Result := l_widget_imp.interface
			end
		end

	widget_imp_at_pointer_position: EV_WIDGET_IMP
			-- Widget implementation at current mouse pointer position (if any)
		local
			a_x, a_y: INTEGER
			gdkwin, gtkwid: POINTER
		do
			gdkwin := {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($a_x, $a_y)
			if gdkwin /= default_pointer then
				from
					{EV_GTK_EXTERNALS}.gdk_window_get_user_data (gdkwin, $gtkwid)
				until
					Result /= Void or else gtkwid = default_pointer
				loop
					Result ?= {EV_GTK_CALLBACK_MARSHAL}.c_get_eif_reference_from_object_id (gtkwid)
					gtkwid := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (gtkwid)
				end
			end
		end

feature -- Status setting

	set_default_colors
			-- Set foreground and background color to their default values.
		local
			a_default_colors: EV_STOCK_COLORS
		do
			create a_default_colors
			set_background_color (a_default_colors.default_background_color)
			set_foreground_color (a_default_colors.default_foreground_color)
		end

feature -- Basic operation

	redraw
			-- Redraw the entire area.
		do
			{EV_GTK_EXTERNALS}.gdk_window_invalidate_rect (drawable, default_pointer, True)
			{EV_GTK_EXTERNALS}.gdk_window_process_updates (drawable, True)
		end

	set_pointer_position (a_x, a_y: INTEGER)
			-- Set pointer position to (a_x, a_y).
		local
			a_success_flag: BOOLEAN
			l_display, l_screen: POINTER
			l_gdk_display_warp_pointer_symbol, l_x_test_fake_motion_event_symbol: POINTER
		do
			l_gdk_display_warp_pointer_symbol := gdk_display_warp_pointer_symbol
			if l_gdk_display_warp_pointer_symbol /= default_pointer then
				l_display := {EV_GTK_EXTERNALS}.gdk_display_get_default
				l_screen := {EV_GTK_EXTERNALS}.gdk_display_get_default_screen (l_display)
				gdk_display_warp_pointer_call (l_gdk_display_warp_pointer_symbol, l_display, l_screen, a_x, a_y)
			else
				l_x_test_fake_motion_event_symbol := x_test_fake_motion_event_symbol
				if l_x_test_fake_motion_event_symbol /= default_pointer then
					a_success_flag := x_test_fake_motion_event_call (l_x_test_fake_motion_event_symbol, gdk_x_display, -1, a_x, a_y, 0)
				end
			end
		end

	fake_pointer_button_press (a_button: INTEGER)
			-- Fake button `a_button' press on pointer.
		local
			a_success_flag: BOOLEAN
			l_p_b_press_symbol: POINTER
			l_window: POINTER
			l_x, l_y: INTEGER
			l_x_test_fake_button_event_symbol: POINTER
		do
			l_p_b_press_symbol := gdk_test_simulate_button_symbol
			if l_p_b_press_symbol /= default_pointer then
				l_window := {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($l_x, $l_y)
				a_success_flag := gdk_test_simulate_call (l_p_b_press_symbol, l_window, l_x, l_y, a_button, 0, {EV_GTK_ENUMS}.gdk_button_press_enum)
			end
			if not a_success_flag then
				l_x_test_fake_button_event_symbol := x_test_fake_button_event_symbol
				if l_x_test_fake_button_event_symbol /= default_pointer then
					a_success_flag := x_test_fake_key_button_event_call (l_x_test_fake_button_event_symbol, gdk_x_display, a_button, True, 0)
				end
			end
		end

	fake_pointer_button_release (a_button: INTEGER)
			-- Fake button `a_button' release on pointer.
		local
			a_success_flag: BOOLEAN
			l_p_b_release_symbol: POINTER
			l_window: POINTER
			l_x, l_y: INTEGER
			l_x_test_fake_button_event_symbol: POINTER
		do
			l_p_b_release_symbol := gdk_test_simulate_button_symbol
			if l_p_b_release_symbol /= default_pointer then
				l_window := {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($l_x, $l_y)
				a_success_flag := gdk_test_simulate_call (l_p_b_release_symbol, l_window, l_x, l_y, a_button, 0, {EV_GTK_ENUMS}.gdk_button_release_enum)
			end
			if not a_success_flag then
				l_x_test_fake_button_event_symbol := x_test_fake_button_event_symbol
				if l_x_test_fake_button_event_symbol /= default_pointer then
					a_success_flag := x_test_fake_key_button_event_call (l_x_test_fake_button_event_symbol, gdk_x_display, a_button, False, 0)
				end
			end
		end

	fake_pointer_wheel_up
			-- Simulate the user rotating the mouse wheel up.
		do
				--| Mouse pointer button number 4 relates to mouse wheel up
			fake_pointer_button_press (4)
		end

	fake_pointer_wheel_down
			-- Simulate the user rotating the mouse wheel down.
		do
				--| Mouse pointer button number 5 relates to mouse wheel up
			fake_pointer_button_press (5)
		end

	fake_key_press (a_key: EV_KEY)
			-- Fake key `a_key' press.
		local
			a_success_flag: BOOLEAN
			a_key_code: INTEGER
			l_window, l_x_test_fake_key_event_symbol, l_x_keysym_to_keycode_symbol, l_gdk_test_simulate_key_symbol: POINTER
			l_x, l_y: INTEGER
		do
			l_x_test_fake_key_event_symbol := x_test_fake_key_event_symbol
			if l_x_test_fake_key_event_symbol /= default_pointer then
				l_x_keysym_to_keycode_symbol := x_keysym_to_keycode_symbol
				if l_x_keysym_to_keycode_symbol /= default_pointer then
					a_key_code := x_keysym_to_keycode_call (l_x_keysym_to_keycode_symbol, gdk_x_display, key_conversion.key_code_to_gtk (a_key.code).to_integer_32)
					a_success_flag := x_test_fake_key_button_event_call (l_x_test_fake_key_event_symbol, gdk_x_display, a_key_code, True, 0)
				end
			end

			if not a_success_flag then
				a_key_code := key_conversion.key_code_to_gtk (a_key.code).to_integer_32
				l_gdk_test_simulate_key_symbol := gdk_test_simulate_key_symbol
				if l_gdk_test_simulate_key_symbol /= default_pointer then
					l_window := {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($l_x, $l_y)
					a_success_flag := gdk_test_simulate_call (l_gdk_test_simulate_key_symbol, l_window, l_x, l_y, a_key_code, 0, {EV_GTK_EXTERNALS}.gdk_key_press_enum)
				end
			end
		end

	fake_key_release (a_key: EV_KEY)
			-- Fake key `a_key' release.
		local
			a_success_flag: BOOLEAN
			a_key_code: INTEGER
			l_window, l_x_test_fake_key_event_symbol, l_x_keysym_to_keycode_symbol, l_gdk_test_simulate_key_symbol: POINTER
			l_x, l_y: INTEGER
		do
			l_x_test_fake_key_event_symbol := x_test_fake_key_event_symbol
			if l_x_test_fake_key_event_symbol /= default_pointer then
				l_x_keysym_to_keycode_symbol := x_keysym_to_keycode_symbol
				if l_x_keysym_to_keycode_symbol /= default_pointer then
					a_key_code := x_keysym_to_keycode_call (l_x_keysym_to_keycode_symbol, gdk_x_display, key_conversion.key_code_to_gtk (a_key.code).to_integer_32)
					a_success_flag := x_test_fake_key_button_event_call (l_x_test_fake_key_event_symbol, gdk_x_display, a_key_code, False, 0)
				end
			end

			if not a_success_flag then
				a_key_code := key_conversion.key_code_to_gtk (a_key.code).to_integer_32
				l_gdk_test_simulate_key_symbol := gdk_test_simulate_key_symbol
				if l_gdk_test_simulate_key_symbol /= default_pointer then
					l_window := {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($l_x, $l_y)
					a_success_flag := gdk_test_simulate_call (l_gdk_test_simulate_key_symbol, l_window, l_x, l_y, a_key_code, 0, {EV_GTK_EXTERNALS}.gdk_key_release_enum)
				end
			end
		end

	key_conversion: EV_GTK_KEY_CONVERSION
			-- Utilities for converting X key codes.
		once
			create Result
		end

feature -- Measurement

	horizontal_resolution: INTEGER
			-- Number of pixels per inch along horizontal axis
		do
			Result := horizontal_resolution_internal
		end

	vertical_resolution: INTEGER
			-- Number of pixels per inch along vertical axis
		do
			Result := vertical_resolution_internal
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			Result := {EV_GTK_EXTERNALS}.gdk_screen_height
		end

	width: INTEGER
			-- Horizontal size in pixels.
		do
			Result := {EV_GTK_EXTERNALS}.gdk_screen_width
		end

feature {NONE} -- Externals (XTEST extension)

	gdk_test_simulate_button_symbol: POINTER
			-- Symbol for `gdk_test_simulate_button'
		once
			Result := app_implementation.symbol_from_symbol_name ("gdk_test_simulate_button")
		end

	x_test_fake_button_event_symbol: POINTER
			-- Symbol for `XTestFakeButtonEvent'
		once
			Result := app_implementation.symbol_from_symbol_name ("XTestFakeButtonEvent")
		end

	x_test_fake_key_event_symbol: POINTER
			-- Symbol for `XTestFakeKeyEvent'
		once
			Result := app_implementation.symbol_from_symbol_name ("XTestFakeKeyEvent")
		end

	x_test_fake_motion_event_symbol: POINTER
			-- Symbol for `XTestFakeMotionEvent'
		once
			Result := app_implementation.symbol_from_symbol_name ("XTestFakeMotionEvent")
		end

	gdk_test_simulate_key_symbol: POINTER
			-- Symbol for `gdk_test_simulate_key'
		once
			Result := app_implementation.symbol_from_symbol_name ("gdk_test_simulate_key")
		end

	gdk_display_warp_pointer_symbol: POINTER
			-- Symbol for `gdk_display_warp_pointer'.
		once
			Result := app_implementation.symbol_from_symbol_name ("gdk_display_warp_pointer")
		end

	gdk_test_simulate_call (a_function, a_window: POINTER; a_x, a_y: INTEGER; a_button, a_modifiers: INTEGER; a_press_release: INTEGER): BOOLEAN
		external
			"C inline use <gtk/gtk.h>"
		alias
			"return (FUNCTION_CAST(gboolean, (GdkWindow*, gint, gint, guint, GdkModifierType, GdkEventType)) $a_function) ((GdkWindow*) $a_window, (gint) $a_x, (gint) $a_y, (guint) $a_button, (GdkModifierType) $a_modifiers, (GdkEventType) $a_press_release)"
		end

	gdk_display_warp_pointer_call (a_function, a_display, a_screen: POINTER; a_x, a_y: INTEGER)
		external
			"C inline use <gtk/gtk.h>"
		alias
			"(FUNCTION_CAST(void, (GdkDisplay*, GdkScreen*, gint, gint)) $a_function) ((GdkDisplay*) $a_display, (GdkScreen*) $a_screen, (gint) $a_x, (gint) $a_y)"
		end

	x_keysym_to_keycode_symbol: POINTER
			-- Symbol for `x_keysym_to_keycode'.
		once
			Result := app_implementation.symbol_from_symbol_name ("XKeysymToKeycode")
		end

	x_keysym_to_keycode_call (a_function, a_display: POINTER; a_keycode: INTEGER): INTEGER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"return (FUNCTION_CAST(EIF_INTEGER, (EIF_POINTER, EIF_INTEGER)) $a_function) ((EIF_POINTER) $a_display, (EIF_INTEGER) $a_keycode)"
		end

	x_test_fake_key_button_event_call (a_function, a_display: POINTER; a_keycode_or_button: INTEGER; a_is_press: BOOLEAN; a_delay: INTEGER): BOOLEAN
		external
			"C inline use <gtk/gtk.h>"
		alias
			"return (FUNCTION_CAST(EIF_BOOLEAN, (EIF_POINTER, EIF_INTEGER, EIF_BOOLEAN, EIF_INTEGER)) $a_function) ((EIF_POINTER) $a_display, (EIF_INTEGER) $a_keycode_or_button, (EIF_BOOLEAN) $a_is_press, (EIF_INTEGER) $a_delay)"
		end

	x_test_fake_motion_event_call (a_function, a_display: POINTER; a_scr_num, a_x, a_y, a_delay: INTEGER): BOOLEAN
		external
			"C inline use <gtk/gtk.h>"
		alias
			"return (FUNCTION_CAST(EIF_BOOLEAN, (EIF_POINTER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER)) $a_function) ((EIF_POINTER) $a_display, (EIF_INTEGER) $a_scr_num, (EIF_INTEGER) $a_x, (EIF_INTEGER) $a_x, (EIF_INTEGER) $a_delay)"
		end

feature {NONE} -- Implementation

	frozen gdk_x_display: POINTER
		local
			l_symbol: POINTER
		do
			l_symbol := gdk_x11_display_get_xdisplay_symbol
			if l_symbol /= default_pointer then
				Result := gdk_x11_display_get_xdisplay_call (l_symbol, {EV_GTK_EXTERNALS}.gdk_display_get_default)
			end
		end

	gdk_x11_display_get_xdisplay_symbol: POINTER
			-- Symbol for `gdk_x11_display_get_xdisplay'.
		once
			Result := app_implementation.symbol_from_symbol_name ("gdk_x11_display_get_xdisplay")
		end

	gdk_x11_display_get_xdisplay_call (a_function, a_display: POINTER): POINTER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"return (FUNCTION_CAST(EIF_POINTER, (GdkDisplay*)) $a_function) ((GdkDisplay*) $a_display)"
		end

	app_implementation: EV_APPLICATION_IMP
			-- Return the instance of EV_APPLICATION_IMP.
		once
			Result ?= (create {EV_ENVIRONMENT}).application.implementation
		end

	flush
			-- Force all queued draw to be called.
		do
			-- By default do nothing
		end

	update_if_needed
			-- Update `Current' if needed
		do
			-- By default do nothing
		end

	destroy
		do
			dispose
			set_is_destroyed (True)
		end

	dispose
			-- Cleanup
		do
			if gc /= default_pointer then
				gdk_gc_unref (gc)
				gc := default_pointer
			end
		end

	drawable: POINTER
			-- Pointer to the screen (root window)
		do
			Result := {EV_GTK_EXTERNALS}.gdk_root_parent
		end

	mask: POINTER
			-- Mask of `Current', which is always NULL
		do
			-- Not applicable to screen
		end

	interface: EV_SCREEN;

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




end -- class EV_SCREEN_IMP

