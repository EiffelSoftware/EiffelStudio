indexing
	description: "EiffelVision pixmap. Pixmap is a data structure that contains a picture."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXMAP

inherit
	EV_DRAWABLE
		redefine
			implementation
		end

creation
	make_with_size,
	make_from_file

feature {NONE} -- Initialization

	make_with_size (w, h: INTEGER) is
			-- Create a pixmap with 'w' and `h' as size.
		require
			valid_width: w > 0
			valid_height: h > 0
		do
			!EV_PIXMAP_IMP! implementation.make_with_size (w, h)
			implementation.set_interface (Current)
			implementation.unlock
		end

	make_from_file (file_name: STRING) is
			-- Load the pixmap described in 'file_name'.
			-- If the file does not exist, an exception is
			-- raised, (but the pixmap object is created 
			-- with an empty pixmap).
		require
			file_name_exists: file_name /= Void
		do
			!EV_PIXMAP_IMP! implementation.make
			implementation.set_interface (Current)
			implementation.unlock
			read_from_file (file_name)
		end

feature -- Status report

	is_locked: BOOLEAN is
			-- Is the pixmap already set in a drawing area?
			-- If so, we can not set it to other pixmapable
			-- widgets.
		require
			exists: not destroyed
		do
			Result := implementation.is_locked
		end

feature -- Measurement

	width: INTEGER is
			-- Width of the pixmap in pixels.
		require
			exists: not destroyed
		do
			Result := implementation.width
		ensure
			positive_result: Result > 0
		end

	height: INTEGER is
			-- Height of the pixmap in pixels.
		require
			exists: not destroyed
		do
			Result := implementation.height
		ensure
			positive_result: Result > 0
		end

feature -- Basic operation	

	read_from_file (file_name: STRING) is
			-- Load the pixmap described in 'file_name'.
			-- If the file does not exist, an exception is
			-- raised.  
			-- What about a file in wrong format?
		require
			file_name_exists: file_name /= Void
		local
			file: RAW_FILE
			e: EXCEPTIONS
			str: STRING
		do
			-- Check if the file exists
			!!file.make (file_name)
			if not file.exists then
				str := "File not found: "
				str.append (file_name)
				!!e
				e.raise (str)
			end
			implementation.read_from_file (file_name)
		end
	
feature -- Implementation

	implementation: EV_PIXMAP_I
			-- Implementation of pixmap

end -- class EV_PIXMAP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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



