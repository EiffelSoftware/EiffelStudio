indexing 
	description:
		"EiffelVision screen. GTK+ implementation."
	status: "See notice at end of class"
	keywords: "screen, root, window, visual, top"
	date: "$Date$"
	revision: "$Revision$"


class
	EV_SCREEN_IMP

inherit
	EV_SCREEN_I
		redefine
			interface
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

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		do
			base_make (an_interface)
			gc := feature {EV_GTK_EXTERNALS}.gdk_gc_new (drawable)
			feature {EV_GTK_EXTERNALS}.gdk_gc_set_subwindow (gc, feature {EV_GTK_EXTERNALS}.gdk_include_inferiors_enum)
			init_default_values
		end

	initialize is
			-- Set up action sequence connections and create graphics context.
		do
			is_initialized := True
			
			--| FIXME IEK Gdk event handling needs implementing
			--connect_signal_to_actions ("expose-event",
			--	interface.expose_actions)
		end

feature -- Status report

	pointer_position: EV_COORDINATE is
			-- Position of the screen pointer.
		local
			a_x, a_y: INTEGER
			temp_pointer: POINTER
		do
			temp_pointer := feature {EV_GTK_EXTERNALS}.gdk_window_get_pointer (default_pointer, $a_x, $a_y, default_pointer)
			create Result.set (a_x, a_y)
		end

	widget_at_position (x, y: INTEGER): EV_WIDGET is
			-- Widget at position ('x', 'y') if any.
		do
		end
		
	widget_imp_at_pointer_position: EV_WIDGET_IMP is
			-- Widget implementation at current mouse pointer position (if any)
		local
			a_x, a_y: INTEGER
			gdkwin, gtkwid: POINTER
		do
			gdkwin := feature {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($a_x, $a_y)
			if gdkwin /= default_pointer then				
				from
					feature {EV_GTK_EXTERNALS}.gdk_window_get_user_data (gdkwin, $gtkwid)
				until
					Result /= Void or else gtkwid = default_pointer
				loop
					Result ?= feature {EV_GTK_CALLBACK_MARSHAL}.c_get_eif_reference_from_object_id (gtkwid)
					gtkwid := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (gtkwid)
				end
			end
		end

feature -- Status setting

	set_default_colors is
			-- Set foreground and background color to their default values.
		local
			a_default_colors: EV_STOCK_COLORS
		do
			create a_default_colors
			set_background_color (a_default_colors.default_background_color)
			set_foreground_color (a_default_colors.default_foreground_color)
		end	

feature -- Basic operation

	x_test_capable: BOOLEAN is
			-- Is current display capable of performing x tests.
		local
			a_event_base, a_error_base, a_maj_ver, a_min_ver: INTEGER
		do
			Result := x_test_query_extension (
					feature {EV_GTK_EXTERNALS}.gdk_display, 
					$a_event_base,
					$a_error_base,
					$a_maj_ver,
					$a_min_ver)
			
		end

	set_pointer_position (a_x, a_y: INTEGER) is
			-- Set pointer position to (a_x, a_y).
		local
			a_success_flag: BOOLEAN
		do
			check
				x_test_capable: x_test_capable
			end
			a_success_flag := x_test_fake_motion_event (feature {EV_GTK_EXTERNALS}.gdk_display, -1, a_x, a_y, 0)
			check
				pointer_position_set: a_success_flag
			end		
		end

	fake_pointer_button_press (a_button: INTEGER) is
			-- Fake button `a_button' press on pointer.
		local
			a_success_flag: BOOLEAN
		do
			check
				x_test_capable: x_test_capable
			end
			a_success_flag := x_test_fake_button_event (feature {EV_GTK_EXTERNALS}.gdk_display, a_button, True, 0)
			check
				fake_pointer_button_press_success: a_success_flag
			end		
		end

	fake_pointer_button_release (a_button: INTEGER) is
			-- Fake button `a_button' release on pointer.
		local
			a_success_flag: BOOLEAN
		do
			check
				x_test_capable: x_test_capable
			end
			a_success_flag := x_test_fake_button_event (feature {EV_GTK_EXTERNALS}.gdk_display, a_button, False, 0)
			check
				fake_pointer_button_release_success: a_success_flag
			end		
		end

	fake_key_press (a_key: EV_KEY) is
			-- Fake key `a_key' press.
		local
			a_success_flag: BOOLEAN
			a_key_code: INTEGER
		do
			check
				x_test_capable: x_test_capable
			end
			a_key_code := key_constants.key_code_to_gtk (a_key.code)
			a_key_code := x_keysym_to_keycode (feature {EV_GTK_EXTERNALS}.gdk_display, a_key_code)
			a_success_flag := x_test_fake_key_event (feature {EV_GTK_EXTERNALS}.gdk_display, a_key_code, True, 0)
			check
				fake_key_press_success: a_success_flag
			end		
		end

	fake_key_release (a_key: EV_KEY) is
			-- Fake key `a_key' release.
		local
			a_success_flag: BOOLEAN
			a_key_code: INTEGER
		do
			check
				x_test_capable: x_test_capable
			end
			a_key_code := key_constants.key_code_to_gtk (a_key.code)
			a_key_code := x_keysym_to_keycode (feature {EV_GTK_EXTERNALS}.gdk_display, a_key_code)
			a_success_flag := x_test_fake_key_event (
								feature {EV_GTK_EXTERNALS}.gdk_display,
								a_key_code,
								False,
								0
					)
			check
				fake_key_release_success: a_success_flag
			end		
		end

	key_constants: EV_GTK_KEY_CONVERSION is
			-- Utilities for converting X key codes.
		once
			create Result
		end

feature -- Measurement

	horizontal_resolution: INTEGER is
			-- Number of pixels per inch along horizontal axis
		do
			Result := horizontal_resolution_internal
		end

	vertical_resolution: INTEGER is
			-- Number of pixels per inch along vertical axis
		do
			Result := vertical_resolution_internal
		end

	height: INTEGER is
			-- Vertical size in pixels.
		do
			Result := feature {EV_GTK_EXTERNALS}.gdk_screen_height
		end

	width: INTEGER is
			-- Horizontal size in pixels.
		do
			Result := feature {EV_GTK_EXTERNALS}.gdk_screen_width
		end

feature {NONE} -- Externals (XTEST extension)

	frozen x_keysym_to_keycode (a_display: POINTER; a_keycode: INTEGER): INTEGER is
			-- (from EV_C_GTK)
		external
			"C: EIF_INTEGER| <X11/Xlib.h>"
		alias
			"XKeysymToKeycode"
		end

	frozen x_test_fake_button_event (a_display: POINTER; a_button: INTEGER; a_is_press: BOOLEAN; a_delay: INTEGER): BOOLEAN is
			-- (from EV_C_GTK)
		external
			"C: EIF_BOOL| <X11/extensions/XTest.h>"
		alias
			"XTestFakeButtonEvent"
		end

	frozen x_test_fake_key_event (a_display: POINTER; a_keycode: INTEGER; a_is_press: BOOLEAN; a_delay: INTEGER): BOOLEAN is
			-- (from EV_C_GTK)
		external
			"C: EIF_BOOL| <X11/extensions/XTest.h>"
		alias
			"XTestFakeKeyEvent"
		end

	frozen x_test_fake_motion_event (a_display: POINTER; a_scr_num, a_x, a_y, a_delay: INTEGER): BOOLEAN is
			-- (from EV_C_GTK)
		external
			"C: EIF_BOOL| <X11/extensions/XTest.h>"
		alias
			"XTestFakeMotionEvent"
		end

	frozen x_test_query_extension (a_display, a_event_base, a_error_base, a_major_version, a_minor_version: POINTER): BOOLEAN is
			-- (from EV_C_GTK)
		external
			"C: EIF_BOOL| <X11/extensions/XTest.h>"
		alias
			"XTestQueryExtension"
		end

feature {NONE} -- Implementation

	app_implementation: EV_APPLICATION_IMP is
			-- Return the instance of EV_APPLICATION_IMP.
			-- (export status {NONE})
		once
			Result ?= (create {EV_ENVIRONMENT}).application.implementation
		end

	flush is
			-- Force all queued draw to be called.
		do
			-- By default do nothing
		end

	destroy is
		do
			feature {EV_GTK_EXTERNALS}.gdk_gc_unref (gc)
			is_destroyed := True
		end
		
	dispose is
			-- Cleanup
		do
			if gc /= default_pointer then
				gdk_gc_unref (gc)
				gc := default_pointer
			end
		end

	drawable: POINTER is
			-- Pointer to the screen (root window)
		do
			Result := feature {EV_GTK_EXTERNALS}.gdk_root_parent
		end

	interface: EV_SCREEN

end -- class EV_SCREEN_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

