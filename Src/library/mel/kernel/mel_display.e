indexing

	description: 
		"Implementation of the X Display.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_DISPLAY

inherit

	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end

creation 
	make,
	make_from_existing

feature {NONE} -- Initialization

	make (application_context: MEL_APPLICATION_CONTEXT; display_name: STRING;
				app_name: STRING; app_class_name: STRING) is
			-- Open the display with `display_name', application name `app_name'
			-- and application class name `app_class_name'.
		require
			application_context_not_null: application_context.is_valid;
			application_name_not_void: app_name /= Void;
			application_class_name_not_void: app_class_name /= Void
		local
			disp_name, app_name_ext, app_class_name_ext: ANY;
			nb_screens: INTEGER;
			a_screen: MEL_SCREEN;
			i: INTEGER;
			a_display: POINTER
		do
			if display_name /= Void then
				disp_name := display_name.to_c
			end;
			app_name_ext := app_name.to_c;
			app_class_name_ext := app_class_name.to_c;
			if display_name /= Void then
				a_display := xt_open_display (application_context.handle, $disp_name, 
						$app_name_ext, $app_class_name_ext, default_pointer, 0, argc, argv)
			else
				a_display := xt_open_display (application_context.handle, default_pointer, 
						$app_name_ext, $app_class_name_ext, default_pointer, 0, argc, argv)
			end;
			if a_display /= default_pointer then
				make_from_existing (a_display)
			end;
		end;

	make_from_existing (a_display: POINTER) is
			-- Create display from `a_display'.
		require
			a_display_not_null: a_display /= Void
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
			display_not_void: handle /= Void
		do
			Result := screens @ default_scr (handle)
		ensure
			default_screen_not_void: Result /= Void
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
			-- Colse the display.
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

	dispose is
			-- Close the display if this one is valid.
		do
			if is_valid then
				close
			end
		end;

feature {NONE} -- Implementation

	xt_open_display (app_context, disp_name, 
			app_name, app_class, 
			options: POINTER; num_options: INTEGER; 
			a_argc, a_argv: POINTER): POINTER is
		external
			"C [macro <X11/Intrinsic.h>] (XtAppContext, String, String, String, XrmOptionDescRec *, Cardinal, Cardinal *, String *): EIF_POINTER"
		alias
			"XtOpenDisplay"
		end;

	xt_close_display (display_ptr: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (Display *)"
		alias
			"XtCloseDisplay"
		end;

	x_flush (dsp_ptr: POINTER) is
		external
			"C [macro <X11/Xlib.h>] (Display *)"
		alias
			"XFlush"
		end;

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
			"C [macro <argv.h>]: EIF_POINTER"
		alias
			"&eif_argc"
		end;

	argv: POINTER is
		external
			"C [macro <argv.h>]: EIF_POINTER"
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
