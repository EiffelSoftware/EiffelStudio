indexing

	description: 	
		"Implementation of the X bitmap format.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_BITMAP_FORMAT

creation

	make_from_file

feature {NONE} -- Initialization

	make_from_file (a_screen: MEL_SCREEN; filename: STRING) is
			-- Retrieve the pixmap with file name `path'
			-- for `a_display'.
		require
			valid_screen: a_screen /= Void and then a_screen.is_valid;
			filename_not_void: filename /= Void
		local
			path_ptr: ANY;
			identifier, display_handle: POINTER;
			a_height, a_width: INTEGER;
			x1, y1: INTEGER;
			a_status: INTEGER
		do
			path_ptr := filename.to_c;
			display_handle := a_screen.display.handle;
			identifier := x_read_bitmap_from_file 
					(a_screen.handle, $path_ptr, 
					$a_status, $a_width, $a_height, $x1, $y1);
			if identifier /= default_pointer then
				!! bitmap.make_from_existing (a_screen.display, identifier, 1)
				width := a_width;
				height := a_height;
				x_hot := x1;
				y_hot := y1;
			end;
			status := a_status;
		end;

feature -- Access

	bitmap: MEL_PIXMAP
			-- One plane bitmap

	height: INTEGER;
			-- Height of `bitmap'

	width: INTEGER;
			-- Width of `bitmap'

	x_hot: INTEGER;
			-- Horizontal position of "hot" point

	y_hot: INTEGER;
			-- Vertical position of "hot" point

	is_valid: BOOLEAN is
			-- Is Current `pixmap' valid?
		do
			Result := status = BitmapSuccess
		end;

	is_bitmap_file_invalid: BOOLEAN is
			-- Was the filename used to retrieve the
			-- bitmap invalid?
		do
			Result := status = BitmapFileInvalid
		end;

	is_bitmap_no_memory: BOOLEAN is
			-- Did the retrieval of the bitmap failed
			-- due to no memory?
		do
			Result := status = BitmapNoMemory
		end;

feature -- Transformation

	to_pixmap (a_screen: MEL_SCREEN; a_gc: MEL_GC): MEL_PIXMAP is
			-- Convert bitmap to a pixmap using the default	
			-- depth of `a_screen' and values from `a_gc'
		require
			is_valid: is_valid	
		do
			!! Result.make (a_screen, width, height,
					a_screen.default_depth);
			Result.copy_plane (bitmap, a_gc, 0, 0, width, height,
				0, 0, 1)
		end;

feature {NONE} -- Implementation

	status: INTEGER;
			-- Stored status from last attempt of
			-- retrieving a pixmap
			
feature {NONE} -- External features

	x_read_bitmap_from_file (a_screen: POINTER; fname: POINTER;
			a_status, a_width, a_height, x1, y1: POINTER): POINTER is
		external
			"C"
		end;

	BitmapSuccess: INTEGER is 
		external
			"C [macro <X11/Intrinsic.h>]: EIF_INTEGER"
		alias
			"BitmapSuccess"
		end;

	BitmapFileInvalid: INTEGER is
		external
			"C [macro <X11/Intrinsic.h>]: EIF_INTEGER"
		alias
			"BitmapFileInvalid"
		end;

	BitmapNoMemory: INTEGER is 
		external
			"C [macro <X11/Intrinsic.h>]: EIF_INTEGER"
		alias
			"BitmapNoMemory"
		end;

invariant

	valid_bitmap: is_valid implies bitmap /= Void

end -- class MEL_BITMAP_FORMAT


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

