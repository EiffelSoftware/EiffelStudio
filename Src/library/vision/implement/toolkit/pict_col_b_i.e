indexing

	description: "Button represented with a pixmap";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	PICT_COL_B_I 

inherit

	BUTTON_I

feature -- Access

	pixmap: PIXMAP is
			-- Pixmap used
		deferred
		ensure
			valid_result: Result.is_valid
		end;

	is_pressed: BOOLEAN is
			-- Is the pict color button pressed?
		deferred
		end

feature -- Element change

	set_pixmap (a_pixmap: PIXMAP) is
			-- Draw `a_pixmap' into the picture_button.
		require
			a_pixmap_exists: a_pixmap /= Void
			a_pixmap_valid: a_pixmap.is_valid
		deferred
		ensure
			pixmap = a_pixmap
		end;

	set_pressed (b: like is_pressed) is
			-- Set `is_pressed' to `b'.
		deferred
		ensure
			set: b = is_pressed
		end;

end -- class PICT_COLOR_B

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

