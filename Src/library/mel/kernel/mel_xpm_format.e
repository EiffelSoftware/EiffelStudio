indexing

	description: 
		"Implementation of the XPM Pixmap format.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_XPM_FORMAT

creation
	make_from_file

feature {NONE} -- Initialization

	make_from_file (path: STRING; a_screen: MEL_SCREEN) is
			-- Retrieve the color pixmap with this name.
		require
			path_not_void: path /= Void;
			screen_not_void : a_screen /= Void
		local
			path_ptr: ANY;
			error: INTEGER
		do
			screen_pointer := a_screen.handle;
			path_ptr := path.to_c;
			error := xpm_read_file_to_pixmap 
					(a_screen.display.handle, 
					a_screen.root, $path_ptr, 
					$id, $shape_mask, default_pointer);
			is_valid := (error = XpmSuccess);
		end;

feature -- Access

	shape_mask: INTEGER

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Compares two pixmaps.
		do
			Result := id = other.id and shape_mask = other.shape_mask and screen_pointer = other.screen_pointer
		end;

feature -- Removal

	dispose is
			-- destroy the pixmap.
		do
			if is_valid then
				xm_destroy_pixmap (screen_pointer, id);
				xm_destroy_pixmap (screen_pointer, shape_mask)
			end
		end;

feature {NONE} -- Implementation

	xpm_read_file_to_pixmap (display_ptr: POINTER; 
			root: INTEGER; path: POINTER; 
			pixmap_return, shapemask_return: POINTER; 
			attributes: POINTER): INTEGER is
		external
			"C [macro <xpm.h>] (Display *, Drawable, char *, %
				%Pixmap *, Pixmap *, XpmAttributes *): EIF_INTEGER"
		alias
			"XpmReadFileToPixmap"
		end;

end -- class MEL_XPM_FORMAT

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
