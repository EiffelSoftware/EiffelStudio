indexing

	description: 
		"Motif Eiffel Library widget manager.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_WIDGET_MANAGER

inherit

	ANY
		undefine
			is_equal, copy, setup, consistent
		end;

	HASH_TABLE [MEL_OBJECT, POINTER]
		rename
			make as hash_table_make
		end

creation 
	make

feature {NONE} -- Initialization

	make is
			-- Create a widget manager.
		do
			hash_table_make (0)
		end;

feature -- Miscellaneous

	window_to_widget (a_display: POINTER; a_window: POINTER): MEL_WIDGET is
			-- Mel widget associated with window `a_window' in
			-- display 	`a_display' (Useful in MEL_EVENTS or external
			-- routines returning window identifier instead of a
			-- widget handle.)
		require
			a_display_not_null: a_display /= default_pointer;
			a_window_not_null: a_window /= default_pointer
		local
			w: POINTER
		do
			w := xt_window_to_widget (a_display, a_window);
			if w /= default_pointer then
				Result ?= item (w)
			end
		end;

    xt_window_to_widget (a_display, a_window: POINTER): POINTER is
        external
            "C [macro <X11/Intrinsic.h>] (Display *, Window): EIF_POINTER"
        alias
            "XtWindowToWidget"
        end;

end -- class MEL_WIDGET_MANAGER

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
