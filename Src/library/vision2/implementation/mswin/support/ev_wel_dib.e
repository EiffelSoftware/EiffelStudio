indexing
	description:
		"EiffelVision WEL_DIB version. We do not want the file %
		% given as argument to be closed."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_DIB

inherit
	WEL_DIB
	
creation
	make_by_file, make_by_stream

feature {NONE} -- Initialization

	make_by_stream (medium: IO_MEDIUM) is
			-- Create `Current' by reading `medium'.
			-- Contrary to `make_by_file', the medium
			-- is not closed when finished.
		require
			medium_not_void: medium /= Void
			medium_exists: medium.exists
			medium_opened: medium.is_open_read
		local
			bitmap_file_header: WEL_BITMAP_FILE_HEADER						
			s: STRING
			a_wel_string1, a_wel_string2: WEL_STRING
		do
			create bitmap_file_header.make
			create info_header.make
			medium.read_stream (bitmap_file_header.structure_size)
			s := medium.last_string
			create a_wel_string1.make (s)
			bitmap_file_header.memory_copy (a_wel_string1.item,
				bitmap_file_header.structure_size)
			structure_size := bitmap_file_header.size -
				bitmap_file_header.structure_size
			structure_make
			medium.read_stream (structure_size)
			s := medium.last_string
			create a_wel_string2.make (s)
					--| FIXME
					--| In the next line, we should use `structure_size' that is
					--| the size read in the header of the bitmap, instead
					--| of `s.count' that is the size of the bitmap actually 
					--| read directly on the disk.
					--| BUT it seems that `structure_size' can have a wrong
					--| value, leading to a `segmentation violation'.
			memory_copy (a_wel_string2.item, s.count)
			info_header.memory_copy (item, info_header.structure_size)
			calculate_palette
		end

end -- class EV_WEL_DIB

--!-----------------------------------------------------------------------------
--! EiffelVision library: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.2  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.6.2  2000/09/12 21:40:53  rogers
--| Removed fixme not_reviewed. Comments, formatting. Added CVS log.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

