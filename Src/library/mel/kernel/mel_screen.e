indexing

	description: 
		"Implementation of the X screen.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCREEN

creation 
	make

feature {NONE} -- Initialization

	make (a_screen_ptr: POINTER; a_display: MEL_DISPLAY) is
			-- Create a screen according to a C pointer.
		require
			a_screen_ptr_not_null: a_screen_ptr /= default_pointer;
			a_display_not_void: a_display /= Void
		do
			handle := a_screen_ptr;
			display := a_display;
		ensure
			set: display = a_display and then handle = a_screen_ptr
		end;

feature -- Access

	handle: POINTER
			-- Associated C handle

	display: MEL_DISPLAY;
			-- Associated display

	root: INTEGER is
			-- Root window from a screen
		require
			is_valid: is_valid
		do
			Result := root_window_of_screen (handle)
		end;

	planes: INTEGER is
			-- Number of plane of the root window
		require
			is_valid: is_valid
		do
			Result := planes_of_screen (handle)
		ensure
			planes_large_enough: Result >= 0
		end;

	default_gc: MEL_GC is
			-- Default graphic context for current screen
		do
			!! Result.make_from_existing
					(default_gc_of_screen (handle), Current)
		end;

	white_pixel: MEL_PIXEL is
			-- White pixel of this screen
		do
			!! Result.make_from_existing
					(white_pixel_of_screen (handle), Current)
		end;

	black_pixel: MEL_PIXEL is
			-- Black pixel of this screen
		do
			!! Result.make_from_existing
					(black_pixel_of_screen (handle), Current)
		end

	widgets_pointed: LINKED_LIST [POINTER] is
			-- List of C Widgets currently pointed by the mouse pointer
		local
			dp: POINTER;
			widget_c: INTEGER;
			void_pointer: POINTER;
		do
			dp := display.handle;
		 	!! Result.make;
			from
				widget_c := x_query_window_pointer (dp, root)
			until
				widget_c = 0
			loop
				Result.put_right (xt_window_to_widget (dp, widget_c));
				Result.forth;
				widget_c := x_query_window_pointer (dp, widget_c)
			end;
		end;

	query_button_pointer (i: INTEGER): BOOLEAN is
			-- Query the state of the `i' th button.
		require
			valid_i: i >= 1 and then i <= 5
		do
			Result := x_query_button_pointer (display.handle, 
									handle, i)	
		end;

feature -- Measurement

	x: INTEGER is
			-- Current absolute horizontal coordinate of the mouse
		require
			is_valid: is_valid
		do
			Result := x_query_x_pointer (display.handle, handle)
		ensure
			position_positive: Result >= 0;
			position_small_enough: Result < width
		end;

	y: INTEGER is
			-- Current absolute vertical coordinate of the mouse
		require
			is_valid: is_valid
		do
			Result := x_query_y_pointer (display.handle, handle)
		ensure
			position_positive: Result >= 0;
			position_small_enough: Result < height
		end;

	width: INTEGER is
			-- Width in pixel of the screen
		require
			is_valid: is_valid
		do
			Result := width_of_screen (handle)
		ensure
			width_large_enough: Result >= 0
		end;

	height: INTEGER is
			-- Height in pixel of the screen
		require
			is_valid: is_valid
		do
			Result := height_of_screen (handle)
		ensure
			height_large_enough: Result >= 0
		end;

	width_mm: INTEGER is
			-- Width in millimeters of the screen
		require
			is_valid: is_valid
		do
			Result := width_mm_of_screen (handle)
		ensure
			width_mm_large_enough: Result >= 0
		end;

	height_mm: INTEGER is
			-- Height in millimeters of the screen
		require
			is_valid: is_valid
		do
			Result := height_mm_of_screen (handle)
		ensure
			height_mm_large_enough: Result >= 0
		end;

feature -- Status report

	is_valid: BOOLEAN is
			-- Is the screen valid?
		do
			Result := display.is_valid
		ensure
			valid_if_display_is_valid: Result = display.is_valid
		end;

feature {NONE} -- Implementation

	root_window_of_screen (screen_ptr: POINTER): INTEGER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_INTEGER"
		alias
			"RootWindowOfScreen"
		end;

	width_of_screen (screen_ptr: POINTER): INTEGER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_INTEGER"
		alias
			"WidthOfScreen"
		end;

	height_of_screen (screen_ptr: POINTER): INTEGER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_INTEGER"
		alias
			"HeightOfScreen"
		end;

	width_mm_of_screen (screen_ptr: POINTER): INTEGER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_INTEGER"
		alias
			"WidthMMOfScreen"
		end;

	height_mm_of_screen (screen_ptr: POINTER): INTEGER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_INTEGER"
		alias
			"HeightMMOfScreen"
		end;

	planes_of_screen (screen_ptr: POINTER): INTEGER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_INTEGER"
		alias
			"PlanesOfScreen"
		end;

	white_pixel_of_screen (screen_ptr: POINTER): INTEGER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_INTEGER"
		alias
			"WhitePixelOfScreen"
		end;

	black_pixel_of_screen (screen_ptr: POINTER): INTEGER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_INTEGER"
		alias
			"BlackPixelOfScreen"
		end;

	default_gc_of_screen (screen_ptr: POINTER): POINTER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_POINTER"
		alias
			"DefaultGCOfScreen"
		end;

	xt_window_to_widget (a_display: POINTER; a_target: INTEGER): POINTER is
		external
			"C [macro <X11/Intrinsic.h>] (Display *, Window): EIF_POINTER"
		alias
			"XtWindowToWidget"
		end;

	x_query_button_pointer (dp, sp: POINTER; pos: INTEGER): BOOLEAN is
		external
			"C"
		end;

	x_query_y_pointer (dp, sp: POINTER): INTEGER is
		external
			"C"
		end;

	x_query_x_pointer (dp, sp: POINTER): INTEGER is
		external
			"C"
		end;

	x_query_window_pointer (dspl_pointer: POINTER; wndw: INTEGER): INTEGER is
		external
			"C"
		end;

invariant

	handle_not_null: handle /= default_pointer

end -- class MEL_SCREEN

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
