indexing

	description: 
		"Implemenation of a Graphic Context.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_GC

inherit

	MEL_GC_CONSTANTS

creation
	make, make_from_existing

feature {NONE} -- Initialization

	make (a_screen: MEL_SCREEN) is
			-- Create a graphic context.
		require
			a_screen_not_void: a_screen /= Void
		do
			gc_pointer := x_create_gc (a_screen.display.handle, a_screen.root, 0, default_pointer);
			screen := a_screen
		ensure
			gc_created: is_valid
		end;

	make_from_existing (a_gc_pointer: POINTER; a_screen: MEL_SCREEN) is
			-- Encapsulate an already created graphic context.
		require
			a_gc_pointer_not_null: a_gc_pointer /= default_pointer;
			a_screen_not_void: a_screen /= Void
		do
			gc_pointer := a_gc_pointer;
			screen := a_screen
		ensure
			gc_created: is_valid
		end;

feature -- Access

	gc_pointer: POINTER;

	screen: MEL_SCREEN;

feature -- Status report

	is_valid: BOOLEAN is
			-- Is the cureent GC valid, i.e. is the gc_pointer
			-- not NULL ?
		do
			Result := gc_pointer /=  default_pointer
		end;

	-- The following functions might be tricky.
	-- They access the internal structure of a _XGC structure
	-- and the value retrieved might not be accurate when you want
	-- some information of a default gc.
	-- The function XGetGCValues does the same thing so there is
	-- no better way to access the informations of a GC.
	-- Maybe a next release of X11 will solve that problem.
	-- Some could think that we can keep a trace of these
	-- informations when we create and modify a GC
	-- but we have no idea of the validity of the default values of
	-- a GC when we create an object encapsulating an already existing
	-- GC (for example, the default GC of a screen).

	function: INTEGER is
			-- Return the `function' of athe Graphic Context.
		require
			gc_is_valid: is_valid
		do
		end;

feature -- Status setting

	set_function (a_function: INTEGER) is
			-- Set the function of the GC.
		require
			gc_is_valid: is_valid
		do
			x_set_function (screen.display.handle, gc_pointer, a_function)
		end;

feature -- Removal

	dispose is
			-- Free the Graphic Context
		do
			if is_valid then
				x_free_gc (screen.display.handle, gc_pointer)
			end
		end;

feature {NONE} -- Implementation

	x_create_gc (display_ptr: POINTER; drawable: INTEGER; value_mask: INTEGER; values: POINTER): POINTER is
		external
			"C [macro <X11/Xlib.h>] (Display *, Drawable, unsigned long, XGCValues *): EIF_POINTER"
		alias
			"XCreateGC"
		end;

	x_free_gc (display_ptr: POINTER; a_pointer: POINTER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC)"
		alias
			"XFreeGC"
		end;

	x_set_function (display_ptr: POINTER; a_pointer: POINTER; a_function: INTEGER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC, int)"
		alias
			"XSetFunction"
		end;

end -- class MEL_GC

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
