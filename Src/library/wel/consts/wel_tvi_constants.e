indexing
	description: "Tree view item (TVI) constants."
	legal: "See notice at end of class."
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




end -- class WEL_TVI_CONSTANTS

