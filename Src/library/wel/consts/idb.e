indexing
	description: "System-defined toolbar bitmap constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IDB_CONSTANTS

feature -- Access

	Idb_std_large_color: INTEGER is
			-- Large, color standard bitmaps.
		external
			"C [macro <cctrl.h>]"
		alias
			"IDB_STD_LARGE_COLOR"
		end

	Idb_std_small_color: INTEGER is
			-- Small, color standard bitmaps.
		external
			"C [macro <cctrl.h>]"
		alias
			"IDB_STD_SMALL_COLOR"
		end

	Idb_view_large_color: INTEGER is
			-- Large, color view bitmaps.
		external
			"C [macro <cctrl.h>]"
		alias
			"IDB_VIEW_LARGE_COLOR"
		end

	Idb_view_small_color: INTEGER is
			-- Small, color view bitmaps.
		external
			"C [macro <cctrl.h>]"
		alias
			"IDB_VIEW_SMALL_COLOR"
		end

feature -- Status report

	valid_tool_bar_bitmap_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid tool bar bitmap constant?
		do
			Result := c = Idb_std_large_color or else
				c = Idb_std_small_color or else
				c = Idb_view_large_color or else
				c = Idb_view_small_color
		end

end -- class WEL_IDB_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
