indexing

	description: 
		"Representation of an X Pixmap.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PIXMAP

inherit

	ANY
		redefine
			is_equal
		end;

	MEL_PIXMAP_CONSTANTS
		redefine
			is_equal
		end;

	MEMORY
		redefine
			dispose, is_equal
		end

creation

	make_from_existing

feature {NONE} -- Initialization

	make_from_existing (a_pixmap: INTEGER; a_screen: MEL_SCREEN) is
			-- Create a MEL_PIXMAP object from an pixmap ID.
		require
			a_screen_not_void: a_screen /= Void
		do
			id := a_pixmap;
			screen_pointer := a_screen.handle;
			is_valid := True;
		ensure
			pixmap_is_valid: is_valid
		end;

feature -- Access

	id: INTEGER;
		-- In fact it is an unsigned long.

	screen_pointer: POINTER;
		-- Screen on which the Pixmap is allocated.

	is_valid: BOOLEAN

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Compares two pixmaps.
		require else
			current_is_valid: is_valid;
			other_is_valid: other /= Void and then other.is_valid
		do
			Result := id = other.id and screen_pointer = other.screen_pointer
		end;

feature -- Removal

	dispose is
			-- destroy the pixmap.
		do
			if is_valid then
				xm_destroy_pixmap (screen_pointer, id)
			end
		end;

feature {NONE} -- Implementation

	xm_destroy_pixmap (a_screen: POINTER; a_pixmap: INTEGER) is
		external
			"C [macro <Xm/Xm.h>] (Screen *, Pixmap)"
		alias
			"XmDestroyPixmap"
		end;

end -- class MEL_PIXMAP

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
