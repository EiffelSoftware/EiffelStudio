indexing
	description: "Format flags for feature format of class WEL_HD_ITEM."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HDF_CONSTANTS

feature -- Access

	Hdf_center: INTEGER is
			-- Centers the contents of the item. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_CENTER"
		end

	Hdf_left: INTEGER is
			-- Left aligns the contents of the item. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_LEFT"
		end

	Hdf_right: INTEGER is
			-- Right aligns the contents of the item. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_RIGHT"
		end

	Hdf_justify_mask: INTEGER is
			-- You can use this mask to isolate the text justification 
			-- portion of the fmt member. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_JUSTIFYMASK"
		end

	Hdf_owner_draw: INTEGER is
			-- The owner window of the header control draws the item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_OWNERDRAW"
		end

	Hdf_bitmap: INTEGER is
			-- The item displays a bitmap.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_BITMAP"
		end

	Hdf_string: INTEGER is
			-- The item displays a string. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_STRING"
		end

	Hdf_rtl_reading: INTEGER is
			-- In addition, on Hebrew or Arabic systems you can specify this flag 
			-- to display text using right-to-left reading order. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_RTLREADING"
		end

end -- class WEL_HDM_CONSTANTS


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

