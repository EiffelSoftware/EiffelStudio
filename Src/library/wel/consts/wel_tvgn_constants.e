indexing
	description: "Tree view selection type constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVGN_CONSTANTS

feature -- Access

	Tvgn_caret: INTEGER is
			-- Sets the selection to the given item or retrieves
			-- the currently selected item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVGN_CARET"
		end

	Tvgn_child: INTEGER is
			-- Retrieves the first child item.
			-- (the hitem parameter must be Void)
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVGN_CHILD"
		end

	Tvgn_drophilite: INTEGER is
			-- Redraws the given item in the style used to indicate
			-- the target of a drag and drop operation or retrieves
			-- the item that is the target of a drag and drop
			-- operation.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVGN_DROPHILITE"
		end

	Tvgn_firstvisible: INTEGER is
			-- Scrolls the tree view vertically so that the given
			-- item is the first visible item or retrieves the
			-- first visible item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVGN_FIRSTVISIBLE"
		end

	Tvgn_next: INTEGER is
			-- Retrieves the next siblings item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVGN_NEXT"
		end

	Tvgn_nextvisible: INTEGER is
			-- Retrieves the next visible item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVGN_NEXTVISIBLE"
		end

	Tvgn_parent: INTEGER is
			-- Retrieves the parent of the specified item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVGN_PARENT"
		end

	Tvgn_previous: INTEGER is
			-- Retrieves the previous siblings item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVGN_PREVIOUS"
		end

	Tvgn_previousvisible: INTEGER is
			-- Retrieves the previous visible item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVGN_PREVIOUSVISIBLE"
		end

	Tvgn_root: INTEGER is
			-- Retrieves the top-most or very-first item
			-- of the tree-view control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVGN_ROOT"
		end

end -- class WEL_TVGN_CONSTANTS

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

