indexing
	description: "System-defined toolbar bitmap constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IDB_CONSTANTS

feature -- Access

	Idb_std_large_color: INTEGER is
			-- Large, color standard bitmaps.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"IDB_STD_LARGE_COLOR"
		end

	Idb_std_small_color: INTEGER is
			-- Small, color standard bitmaps.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"IDB_STD_SMALL_COLOR"
		end

	Idb_view_large_color: INTEGER is
			-- Large, color view bitmaps.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"IDB_VIEW_LARGE_COLOR"
		end

	Idb_view_small_color: INTEGER is
			-- Small, color view bitmaps.
		external
			"C [macro %"cctrl.h%"]"
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_IDB_CONSTANTS

