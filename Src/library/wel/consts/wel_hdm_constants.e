indexing
	description: "Messages associated with WEL_HEADER_CONTROL."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HDM_CONSTANTS

feature -- Access
 
 
	Hdm_delete_item: INTEGER is
			-- Deletes an item from a header control
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDM_DELETEITEM"
		end

	Hdm_get_item: INTEGER is
			-- Retrieves information about an item in a header control
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDM_GETITEM"
		end

	Hdm_get_item_count: INTEGER is
			-- Retrieves number of items in a header control
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDM_GETITEMCOUNT"
		end

	Hdm_hit_test: INTEGER is
			-- Tests a point to determine which header item, if any, is at the specified point.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDM_HITTEST"
		end

	Hdm_insert_item: INTEGER is
			-- Inserts a new item into a header control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDM_INSERTITEM"
		end

	Hdm_layout: INTEGER is
			-- Retrieves the size and position of a header control within a given rectangle.
			-- This message is used to determine the appropriate dimensions for a new header 
			-- control that is to occupy the given rectangle.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDM_LAYOUT"
		end

	Hdm_set_item: INTEGER is
			-- Sets the attributes of the specified item in a header control
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDM_SETITEM"
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

