indexing

	description: 
		"Implementation of Drawable object.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	MEL_DRAWABLE

feature -- Access

	identifier: POINTER is
			-- C identifier for drawable object
		deferred
		end;

	display: MEL_DISPLAY is
			-- Assocated display
		deferred
		end;

	is_valid: BOOLEAN is
			-- Is the drawable valid?
		deferred
		end;

	depth: INTEGER is
			-- Depth of drawable
		require
			is_valid: is_valid
		deferred
		ensure
			depth_large_enough: Result > 0
		end

feature -- Element change

	copy_area (a_drawable: MEL_DRAWABLE; gc: MEL_GC;
			src_x, src_y, a_width, a_height: INTEGER;
			dest_x, dest_y: INTEGER) is
			-- Copy the area specified by `src_x', `src_x', `src_x', `a_width' and
			-- `a_height' of `a_drawable' at `dest_x' and `dest_y' of Current drawable.
		require
			is_valid: is_valid;
			identifier_not_null: identifier /= default_pointer;
			valid_gc: gc /= Void and then gc.is_valid;
			valid_drawable: a_drawable /= Void and then a_drawable.is_valid;
			valid_args: a_width >= 0 and a_height >= 0;
			same_depth: a_drawable.depth = depth
		do
			x_copy_area (display_handle, a_drawable.identifier, identifier, gc.handle,
				src_x, src_y, a_width, a_height, dest_x, dest_y)
		end;

	copy_plane (a_drawable: MEL_DRAWABLE; gc: MEL_GC;
			src_x, src_y, a_width, a_height: INTEGER;
			dest_x, dest_y: INTEGER;
			a_plane: INTEGER) is
			-- Copy the area specified by `src_x', `src_x', `src_x', `a_width' and
			-- `a_height' of `a_drawable' at `dest_x' and `dest_y' of Current drawable
			-- with source bit-plane `a_plane'.
		require
			is_valid: is_valid;
			identifier_not_null: identifier /= default_pointer;
			valid_gc: gc /= Void and then gc.is_valid;
			valid_drawable: a_drawable /= Void and then a_drawable.is_valid;
			valid_args: a_width >= 0 and a_height >= 0 and a_plane >= 0;
		do
			x_copy_plane (display_handle, a_drawable.identifier, identifier, gc.handle,
				src_x, src_y, a_width, a_height, dest_x, dest_y, a_plane)
		end;

feature {MEL_DRAWABLE, MEL_GC, MEL_OBJECT}

	display_handle: POINTER is
			-- Associated C handle to the display
		deferred
		end;

feature {NONE} -- External features

	x_copy_area (dspl_pointer, src_d, target_d, gc: POINTER; val1, val2,
					bm_wdth, bm_hght, x_val, y_val: INTEGER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, Drawable, Drawable, %
				%GC, int, int, unsigned int, unsigned int, int, int)"
		alias
			"XCopyArea"
		end;

	x_copy_plane (dspl_pointer, res_x, wndw_obj, gc: POINTER; val1, val2,
					bm_wdth, bm_hght, x_val, y_val, val3: INTEGER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, Drawable, Drawable, %
				%GC, int, int, unsigned int, unsigned int, int, int, unsigned long)"
		alias
			"XCopyPlane"
		end;

end -- class MEL_DRAWABLE

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
