indexing

	description: 
		"Implementation of the X Display.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_DISPLAY

inherit

	ANY
		redefine
			is_equal
		end

creation 
	make,
	make_from_existing

feature {NONE} -- Initialization

	make (application_context: MEL_APPLICATION_CONTEXT; a_display_name: STRING;
				app_name: STRING; app_class_name: STRING) is
			-- Open the display with `a_display_name', application name `app_name'
			-- and application class name `app_class_name'.
		require
			application_context_not_null: application_context.is_valid;
		local
			disp_name, app_name_ext, app_class_name_ext: ANY;
			nb_screens: INTEGER;
			a_screen: MEL_SCREEN;
			i: INTEGER;
			a_display: POINTER
		do
			if a_display_name /= Void then
				disp_name := a_display_name.to_c
			end;
			if app_name /= Void then
				app_name_ext := app_name.to_c;
			end;
			if app_class_name /= Void then
				app_class_name_ext := app_class_name.to_c;
			end;
			if a_display_name /= Void then
				a_display := xt_open_display (application_context.handle, $disp_name, 
						$app_name_ext, $app_class_name_ext, default_pointer, 0, argc, argv)
			else
				a_display := xt_open_display (application_context.handle, default_pointer, 
						$app_name_ext, $app_class_name_ext, default_pointer, 0, argc, argv)
			end;
			if a_display /= default_pointer then
				make_from_existing (a_display)
			end;
		ensure
			name_set: (is_valid and then a_display_name /= Void and then
				not a_display_name.is_empty) implies 
					name.is_equal (a_display_name)
		end;

	make_from_existing (a_display: POINTER) is
			-- Create display from `a_display'.
		require
			a_display_not_null: a_display /= default_pointer
		local
			i: INTEGER
			nb_screens: INTEGER;
			a_screen: MEL_SCREEN;
		do
			handle := a_display;
			nb_screens := screen_count (a_display);
			check
				nb_screens >= 0
			end;
			!! screens.make (0, nb_screens -1);
			from
				i := 0
			until
				i = nb_screens
			loop
				!! a_screen.make (screen_of_display (a_display, i), Current);
				screens.put (a_screen, i);
				i := i +1
			end
		ensure
			set: a_display = handle
		end;

feature -- Access

	handle: POINTER;
			-- Pointer to the display

	screens: ARRAY [MEL_SCREEN]
			-- Screens attached to this display.

	default_screen: MEL_SCREEN is
			-- The default screen of the display.
		require
			is_valid: is_valid
		do
			Result := screens @ default_scr (handle)
		ensure
			default_screen_not_void: Result /= Void
		end;

	default_root_window: POINTER is
			-- Default root window
		require
			is_valid: is_valid
		do
			Result := default_screen.root_window
		end;

	max_request_size: INTEGER is
			-- Maximum number of request support by Current display
		require
			is_valid: is_valid
		do
			Result := x_max_request_size (handle)
		end;

	name: STRING is
			-- Display name used to open the Current display
		require
			is_valid: is_valid
		do
			!! Result.make (0);
			Result.from_c (display_string (handle))
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is display equal to `other'?
		do
			Result := handle = other.handle
		end;

feature -- Status report

	is_valid: BOOLEAN is
			-- Has the display been opened ?
		do
			Result := handle /= default_pointer
		end;

feature -- Miscellaneous

	flush is
			-- Flush all the events of the display.
		require
			display_not_void: handle /= Void
		do
			x_flush (handle)
		end;

feature -- Removal

	close is
			-- Close the display.
			-- ie. close the connection with
			-- an X server.
		require
			display_is_opened: is_valid
		do
			xt_close_display (handle);
			handle := default_pointer
		ensure
			display_is_closed: not is_valid
		end;

feature {NONE} -- Implementation

	xt_open_display (app_context, disp_name, 
			app_name, app_class, 
			options: POINTER; num_options: INTEGER; 
			a_argc, a_argv: POINTER): POINTER is
		external
			"C (XtAppContext, String, String, String, XrmOptionDescRec *, %
				% Cardinal, int *, String *): EIF_POINTER |<X11/Intrinsic.h>"
		alias
			"XtOpenDisplay"
		end;

	xt_close_display (display_ptr: POINTER) is
		external
			"C (Display *) | <X11/Intrinsic.h>"
		alias
			"XtCloseDisplay"
		end;

	x_max_request_size (display_ptr: POINTER): INTEGER is
		external
			"C (Display *): EIF_INTEGER | <X11/Xlib.h>"
		alias
			"XMaxRequestSize"
		end;

	x_flush (dsp_ptr: POINTER) is
		external
			"C (Display *) | <X11/Xlib.h> "
		alias
			"XFlush"
		end;

	display_string (display_ptr: POINTER): POINTER is
			-- X macro
		external
			"C [macro <X11/Xlib.h>] (Display *): EIF_POINTER"
		alias
			"DisplayString"
		end

	default_scr (display_ptr: POINTER): INTEGER is
			-- X macro
		external
			"C [macro <X11/Xlib.h>] (Display *): EIF_INTEGER"
		alias
			"DefaultScreen"
		end

	argc: POINTER is
			-- Here we need to give the address of the argc value to XtOpenDisplay.
		external
			"C [macro %"eif_argv.h%"]: EIF_POINTER"
		alias
			"&eif_argc"
		end;

	argv: POINTER is
		external
			"C [macro %"eif_argv.h%"] : EIF_POINTER"
		alias
			"eif_argv"
		end;

	screen_count (display_ptr: POINTER): INTEGER is
		external
			"C [macro <X11/Xlib.h>] (Display *): EIF_INTEGER"
		alias
			"ScreenCount"
		end;

	screen_of_display (display_ptr: POINTER; i: INTEGER): POINTER is
		external
			 "C [macro <X11/Xlib.h>] (Display *, int): EIF_POINTER"
		alias
			"ScreenOfDisplay"
		end;

end -- class MEL_DISPLAY

--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

