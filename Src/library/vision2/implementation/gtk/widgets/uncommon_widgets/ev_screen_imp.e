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

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		do
			base_make (an_interface)
			gc := C.gdk_gc_new (drawable)
			gcvalues := C.c_gdk_gcvalues_struct_allocate
			C.gdk_gc_set_subwindow (gc, C.Gdk_include_inferiors_enum)
			C.gdk_gc_get_values (gc, gcvalues)
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

	destroy is
		do
			C.c_gdk_gcvalues_struct_free (gcvalues)
			C.gdk_gc_unref (gc)
			is_destroyed := True
		end

feature -- Status report

	pointer_position: EV_COORDINATES is
			-- Position of the screen pointer.
		local
			a_x, a_y: INTEGER
			temp_pointer: POINTER
		do
			temp_pointer := C.gdk_window_get_pointer (NULL, $a_x, $a_y, NULL)
			create Result.set (a_x, a_y)
		end

	widget_at_position (x, y: INTEGER): EV_WIDGET is
			-- Widget at position ('x', 'y') if any.
		do
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
			Result := C.x_test_query_extension (
					C.gdk_display, 
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
			a_success_flag := C.x_test_fake_motion_event (C.gdk_display, -1, a_x, a_y, 0)
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
			a_success_flag := C.x_test_fake_button_event (C.gdk_display, a_button, True, 0)
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
			a_success_flag := C.x_test_fake_button_event (C.gdk_display, a_button, False, 0)
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
			a_key_code := C.x_keysym_to_keycode (C.gdk_display, a_key_code)
			a_success_flag := C.x_test_fake_key_event (C.gdk_display, a_key_code, True, 0)
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
			a_key_code := C.x_keysym_to_keycode (C.gdk_display, a_key_code)
			a_success_flag := C.x_test_fake_key_event (
								C.gdk_display,
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

	height: INTEGER is
			-- Vertical size in pixels.
		do
			Result := C.gdk_screen_height
		end

	width: INTEGER is
			-- Horizontal size in pixels.
		do
			Result := C.gdk_screen_width
		end

feature {NONE} -- Implementation

	drawable: POINTER is
			-- Pointer to the screen (root window)
		do
			Result := C.gdk_root_parent
		end

	interface: EV_SCREEN

end -- class EV_SCREEN_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.4.7  2001/05/18 18:20:19  king
--| Removed destroy_just_called code
--|
--| Revision 1.3.4.6  2000/11/06 19:40:33  king
--| Acccounted for default to stock name change
--|
--| Revision 1.3.4.5  2000/10/27 16:54:46  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.3.4.4  2000/10/07 01:39:22  andrew
--| made compilable
--|
--| Revision 1.3.4.3  2000/08/18 18:19:41  king
--| Removed unused local
--|
--| Revision 1.3.4.2  2000/05/03 19:08:53  oconnor
--| mergred from HEAD
--|
--| Revision 1.16  2000/05/02 18:55:32  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.15  2000/04/25 18:39:22  king
--| Implemented pointer_position
--|
--| Revision 1.14  2000/04/21 20:22:18  oconnor
--| Fixed button relase faking
--|
--| Revision 1.13  2000/04/18 19:55:37  king
--| Correctly implemented fake key event features
--|
--| Revision 1.12  2000/04/17 23:41:53  king
--| Correcly implemented all XTest features
--|
--| Revision 1.11  2000/04/14 21:18:34  oconnor
--| commented out x_test_grab_control, not working
--|
--| Revision 1.10  2000/04/14 16:59:14  king
--| Added x_test_grab_control to no effect
--|
--| Revision 1.9  2000/04/11 18:30:14  king
--| Added x extension routines
--|
--| Revision 1.8  2000/04/06 23:26:59  oconnor
--| added implementation comments and new fake event features
--|
--| Revision 1.7  2000/04/06 20:12:30  oconnor
--| added pointer position features
--|
--| Revision 1.6  2000/04/04 20:56:14  oconnor
--| formatting
--|
--| Revision 1.5  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.4.1.2.18  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.3.4.1.2.17  2000/01/27 19:29:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.4.1.2.16  2000/01/25 23:22:16  brendel
--| Changed gc to be created with every screen object instead of once.
--|
--| Revision 1.3.4.1.2.15  2000/01/18 01:12:28  king
--| Removed instantation of feature C
--|
--| Revision 1.3.4.1.2.14  2000/01/17 23:31:26  brendel
--| Moved initialization of `gcvalues' to make.
--|
--| Revision 1.3.4.1.2.13  1999/12/23 01:38:41  king
--| Updated check statement
--|
--| Revision 1.3.4.1.2.12  1999/12/18 02:22:37  king
--| Removed unwanted unreferencing of GC
--|
--| Revision 1.3.4.1.2.11  1999/12/16 09:19:36  oconnor
--| fixed cyclic creation order depenancy
--|
--| Revision 1.3.4.1.2.10  1999/12/16 03:42:23  oconnor
--| improved memory management
--|
--| Revision 1.3.4.1.2.9  1999/12/15 19:35:25  king
--| Changed drawable to use gdk_root_parent external
--| Using ev_color to set default values
--| Removed expose_actions (need GDK event init)
--|
--| Revision 1.3.4.1.2.8  1999/12/09 23:23:41  brendel
--| Added implementation of features `width' and `height'.
--|
--| Revision 1.3.4.1.2.7  1999/12/09 19:00:56  brendel
--| Improved cosmetics and indexing clauses.
--|
--| Revision 1.3.4.1.2.6  1999/12/04 19:17:56  oconnor
--| fixed external access
--|
--| Revision 1.3.4.1.2.5  1999/12/04 19:16:32  oconnor
--| fixed external access
--|
--| Revision 1.3.4.1.2.4  1999/12/04 00:41:24  brendel
--| Started first implementation.
--|
--| Revision 1.3.4.1.2.3  1999/12/03 23:56:43  brendel
--| Added redefine of initialize.
--| Commented out feature destroy.
--|
--| Revision 1.3.4.1.2.2  1999/11/30 23:02:36  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.3.4.1.2.1  1999/11/24 17:30:00  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/04 23:10:31  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.3.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
