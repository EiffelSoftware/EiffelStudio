indexing
	description: "This class represents a structure that contains%
					 %information used to set the size and position of%
					 %a WEL_HEADER_CONTROL"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HD_LAYOUT

inherit
	WEL_STRUCTURE
		redefine
			make
		end
	WEL_BIT_OPERATIONS
	WEL_HDI_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization
	make is
		local
			a_window_pos: WEL_WINDOW_POS
		do
			{WEL_STRUCTURE} Precursor
			create a_window_pos.make
			set_window_pos (a_window_pos)
		end
feature -- Access

	
	rectangle: WEL_RECT is
			-- Contains the coordinates of a rectangle that the header control is to occupy
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_hd_layout_get_prc (item))
		end

	window_pos: WEL_WINDOW_POS is
			-- Object that receives information about the appropriate size 
			-- and position of the header control. 
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_hd_layout_get_pwpos (item))
		end
	
		
feature -- Element change

	set_rectangle (a_rect: WEL_RECT) is
			-- Contains the coordinates of a rectangle that the header control is to occupy
		require
			exists: exists
			rect_exists: a_rect.exists
		do
			cwel_hd_layout_set_prc (item, a_rect.item)
		end

	set_window_pos (value: WEL_WINDOW_POS) is
			-- Filled usually by Windows
		require
			exists: exists
			window_pos_exists: value.exists
		do
			cwel_hd_layout_set_pwpos (item, value.item)
		end
		
		
		
feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_hd_layout
		end

feature {NONE} -- Externals

	c_size_of_hd_layout: INTEGER is
		external
			"C [macro %"nmtb.h%"]"
		alias
			"sizeof (HD_LAYOUT)"
		end

	cwel_hd_layout_get_prc (ptr: POINTER): POINTER is
		external
			"C [macro %"hd_layout.h%"] (HD_LAYOUT*): EIF_POINTER"
		end

	cwel_hd_layout_set_prc (ptr: POINTER; value: POINTER) is
		external
			"C [macro %"hd_layout.h%"] (HD_LAYOUT*, RECT FAR*)"
		end

	cwel_hd_layout_get_pwpos (ptr: POINTER): POINTER is
		external
			"C [macro %"hd_layout.h%"] (HD_LAYOUT*): EIF_POINTER"
		end

	cwel_hd_layout_set_pwpos (ptr: POINTER; value: POINTER) is
		external
			"C [macro %"hd_layout.h%"] (HD_LAYOUT*, WINDOWPOS FAR*)"
		end

end -- class WEL_HD_LAYOUT


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

