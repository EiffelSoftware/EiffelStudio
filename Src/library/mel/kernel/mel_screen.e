indexing

	description: 
		"Implementation of the X screen.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCREEN

inherit

	SHARED_MEL_WIDGET_MANAGER
		export
			{NONE} all
		end;

	MEL_DRAWING
		rename
			window as root_window,
			depth as default_depth
		end

creation 
	make

feature {NONE} -- Initialization

	make (a_screen_ptr: POINTER; a_display: MEL_DISPLAY) is
			-- Create a screen according to a C pointer.
		require
			screen_ptr_not_null: a_screen_ptr /= default_pointer;
			display_not_void: a_display /= Void
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

	root_window: POINTER is
			-- Root window from a screen
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
		require
			is_valid: is_valid
		do
			!! Result.make_from_existing
					(display, default_gc_of_screen (handle))
		end;

	white_pixel: MEL_PIXEL is
			-- White pixel of this screen
		require
			is_valid: is_valid
		do
			!! Result.make_from_existing
					(display, white_pixel_of_screen (handle));
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	black_pixel: MEL_PIXEL is
			-- Black pixel of this screen
		require
			is_valid: is_valid
		do
			!! Result.make_from_existing
					(display, black_pixel_of_screen (handle))
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	default_colormap: MEL_COLORMAP is
			-- Default color map for Current screen
		require
			is_valid: is_valid
		do
			!! Result.make_default (Current)
		end;

	default_depth: INTEGER is
			-- Default depth of screen
		do
			Result := default_depth_of_screen (handle)
		end;

	widgets_pointed: LINKED_LIST [POINTER] is
			-- List of C Widgets currently pointed by the mouse pointer
			-- (Order is based from parent to child)
		require
			is_valid: is_valid
		local
			dp: POINTER;
			widget_c: POINTER;
			void_pointer: POINTER;
		do
			dp := display.handle;
		 	!! Result.make;
			from
				widget_c := x_query_window_pointer (dp, root_window)
			until
				widget_c = default_pointer
			loop
				Result.put_right (xt_window_to_widget (dp, widget_c));
				Result.forth;
				widget_c := x_query_window_pointer (dp, widget_c)
			end;
		end;

	mel_widgets_pointed: LINKED_LIST [MEL_OBJECT] is
			-- List of mel widgets currently pointed by the mouse pointer
			-- (Order is based from parent to child)
		require
			is_valid: is_valid
		local
			l: like widgets_pointed;
			w: POINTER;
			mel_w: MEL_OBJECT
		do
			l := widgets_pointed;
			!TWO_WAY_LIST [MEL_OBJECT]! Result.make;
			from
				l.start
			until
				l.after
			loop
				w := l.item;
				if w /= default_pointer then
					mel_w := Mel_widgets.item (l.item);
					if mel_w /= Void then
						Result.put_right (mel_w);
						Result.forth
					end
				end
				l.forth
			end
		end;

	query_button_pointer (i: INTEGER): BOOLEAN is
			-- Query the state of the `i' th button.
		require
			is_valid: is_valid;
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
		end;

feature {NONE} -- Implementation

	display_handle: POINTER is
			-- Associated C handle for the display
		do	
			Result := display.handle
		end

feature {NONE} -- Implementation

	default_depth_of_screen (screen_ptr: POINTER): INTEGER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_INTEGER"
		alias
			"DefaultDepthOfScreen"
		end;

	root_window_of_screen (screen_ptr: POINTER): POINTER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_POINTER"
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

	white_pixel_of_screen (screen_ptr: POINTER): POINTER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_POINTER"
		alias
			"WhitePixelOfScreen"
		end;

	black_pixel_of_screen (screen_ptr: POINTER): POINTER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_POINTER"
		alias
			"BlackPixelOfScreen"
		end;

	default_gc_of_screen (screen_ptr: POINTER): POINTER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_POINTER"
		alias
			"DefaultGCOfScreen"
		end;

	xt_window_to_widget (a_display: POINTER; a_target: POINTER): POINTER is
		external
			"C (Display *, Window): EIF_POINTER |  <X11/Intrinsic.h>"
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

	x_query_window_pointer (dspl_pointer: POINTER; wndw: POINTER): POINTER is
		external
			"C"
		end;

end -- class MEL_SCREEN


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

