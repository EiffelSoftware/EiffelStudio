indexing
	description: "Tree view item (TVI) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVI_CONSTANTS

feature -- Access

	Tvi_root: POINTER is
			-- Inserts the item as the root of the list.
		external
			"C [macro %"cctrl.h%"] : HTREEITEM"
		alias
			"TVI_ROOT"
		end

	Tvi_first: POINTER is
			-- Inserts the item at the beginning of the list.
		external
			"C [macro %"cctrl.h%"] : HTREEITEM"
		alias
			"TVI_FIRST"
		end

	Tvi_last: POINTER is
			-- Inserts the item at the end of the list.
		external
			"C [macro %"cctrl.h%"] : HTREEITEM"
		alias
			"TVI_LAST"
		end

	Tvi_sort: POINTER is
			-- Inserts the item into the list in alphabetical order.
		external
			"C [macro %"cctrl.h%"] : HTREEITEM"
		alias
			"TVI_SORT"
		end

end -- class WEL_TVI_CONSTANTS

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

