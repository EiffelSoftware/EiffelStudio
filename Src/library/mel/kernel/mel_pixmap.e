indexing

	description: 
		"Representation of an X Pixmap.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PIXMAP

inherit

	MEL_DRAWABLE
		undefine
			is_equal
		end;

	MEL_RESOURCE
		rename
			make_from_existing as resource_make_from_existing,
			handle as identifier 
		end

creation

	make,
	make_from_existing

feature {NONE} -- Initialization

	make (a_drawable: MEL_DRAWABLE; a_width, a_height, a_depth: INTEGER) is
			-- Create a pixmap with `a_width', `a_height' and `a_depth'.
			-- Use `a_drawable' to determine which screen the pixmap is 
			-- stored on. The resulting pixmap can only be used on this
			-- screen.
		require
			valid_drawable: a_drawable /= Void and then a_drawable.is_valid;
			valid_dimensions: a_width > 0 and then a_height > 0 
				and then a_depth >= 0
		local
			c_depth, int1, int2, int3, int4, int5, int6: INTEGER
		do
			display_handle := a_drawable.display_handle;
			identifier := x_create_pixmap (display_handle, 
				a_drawable.identifier, a_width, a_height, a_depth)
			if (x_get_geometry (display_handle,
				identifier, $int1, $int2, $int3, $int4, $int5,
				$int6, $c_depth))
			then
				depth := c_depth
			end;
			is_shared := True	
		ensure
			set: display_handle = a_drawable.display_handle;
			is_shared: is_shared
		end;

	make_from_existing (a_display: MEL_DISPLAY; a_handle: POINTER; a_depth: INTEGER) is
			-- Create a MEL resource from an `a_handle'
			-- for display `a_display'.
		require
			valid_display: a_display /= Void and then a_display.is_valid;
			handle_not_null: a_handle /= default_pointer;
			valid_depth: a_depth > 0
		do
			identifier := a_handle;
			display_handle := a_display.handle;
			depth := a_depth;
			is_shared := True
		ensure
			set: identifier = a_handle and then depth = a_depth;
			has_valid_display: has_valid_display;
			is_shared: is_shared
		end;

feature -- Access

	is_bitmap: BOOLEAN is
			-- Is this pixmap a single plane bitmap?
		do
			Result := depth = 1
		end;

	is_pixmap: BOOLEAN is
			-- Is this pixmap a multi plane pixmap?
		do
			Result := not is_bitmap
		end;

	depth: INTEGER
			-- Depth of drawable

feature -- Removal

	destroy is
			-- Free the pixmap.
		do
			check
				valid_display: display_handle /= default_pointer
			end;
			x_free_pixmap (display_handle, identifier);
			identifier := default_pointer
		end;

feature {NONE} -- External features

	x_create_pixmap (a_display: POINTER; a_pixmap: POINTER; 
				a_width, a_height, a_depth: INTEGER): POINTER is
		external
			"C (Display *, Drawable, %
				%unsigned int, unsigned int, unsigned int): EIF_POINTER | <X11/Xlib.h>"
		alias
			"XCreatePixmap"
		end;

	x_free_pixmap (a_display: POINTER; a_pixmap: POINTER) is
		external
			"C (Display *, Pixmap) | <X11/Xlib.h>"
		alias
			"XFreePixmap"
		end;

	x_get_geometry (dspl_pointer, a_drawable, a_root: POINTER; a_x, a_y,
					a_width, a_hght, a_b_width, a_depth: POINTER): BOOLEAN is
		external
			"C (Display *, Drawable, Window *, %
				%int *, int *, unsigned int *, unsigned int *,%
				%unsigned int *, unsigned int *): EIF_BOOLEAN | <X11/Xlib.h>"
		alias
			"XGetGeometry"
		end;

invariant

	valid_display: has_valid_display

end -- class MEL_PIXMAP


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

