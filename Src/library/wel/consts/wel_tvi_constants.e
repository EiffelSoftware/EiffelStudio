indexing
	description: "Tree view item (TVI) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVI_CONSTANTS

feature -- Access

	Tvi_root: INTEGER is
			-- Inserts the item as the root of the list.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVI_ROOT"
		end

	Tvi_first: INTEGER is
			-- Inserts the item at the beginning of the list.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVI_FIRST"
		end

	Tvi_last: INTEGER is
			-- Inserts the item at the end of the list.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVI_LAST"
		end

	Tvi_sort: INTEGER is
			-- Inserts the item into the list in alphabetical order.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVI_SORT"
		end

end -- class WEL_TVI_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

