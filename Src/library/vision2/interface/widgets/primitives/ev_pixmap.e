indexing
	description: "EiffelVision pixmap. Pixmap is a data structure that contains a picture."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXMAP

creation
	make,
	make_from_file

	
feature {NONE} -- Initialization

	make (par: EV_PIXMAP_CONTAINER) is
			-- Pixmap with 'par' as parent and 'txt' as 
			-- text label
		do
			!EV_PIXMAP_IMP!implementation.make (par)
			par.implementation.add_pixmap (Current)
		end			
	
	make_from_file (par: EV_PIXMAP_CONTAINER; file_name: STRING) is
			-- Load the pixmap described in 'file_name'.
			-- If the file does not exist, an exception is
			-- raised, (but the pixmap object is created 
			-- with an empty pixmap).
		require
			file_name_exists: file_name /= Void
		do
			!EV_PIXMAP_IMP!implementation.make (par)
			read_from_file (file_name)
			par.implementation.add_pixmap (Current)
		end

feature -- Measurement

	width: INTEGER is
		do
			Result := implementation.width
		end

	height: INTEGER is
		do
			Result := implementation.height
		end

feature -- Element change
	
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



