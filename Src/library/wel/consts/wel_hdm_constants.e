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
		
	Hdm_set_image_list: INTEGER is
			-- Assigns an image list to an existing header control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDM_SETIMAGELIST"
		end
		
	Hdm_get_image_list: INTEGER is
			-- Retrieves the handle to the image list that has been set for an existing header control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDM_GETIMAGELIST"
		end
		

end -- class WEL_HDM_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

