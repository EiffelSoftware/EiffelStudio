indexing
	description: "Tree view selection type constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVGN_CONSTANTS

feature -- Access

	Tvgn_caret: INTEGER is 9
			-- Sets the selection to the given item or retrieves
			-- the currently selected item.
			--
			-- Declared in Windows as TVGN_CARET

	Tvgn_child: INTEGER is 4
			-- Retrieves the first child item.
			-- (the hitem parameter must be Void)
			--
			-- Declared in Windows as TVGN_CHILD

	Tvgn_drophilite: INTEGER is 8
			-- Redraws the given item in the style used to indicate
			-- the target of a drag and drop operation or retrieves
			-- the item that is the target of a drag and drop
			-- operation.
			--
			-- Declared in Windows as TVGN_DROPHILITE

	Tvgn_firstvisible: INTEGER is 5
			-- Scrolls the tree view vertically so that the given
			-- item is the first visible item or retrieves the
			-- first visible item.
			--
			-- Declared in Windows as TVGN_FIRSTVISIBLE

	Tvgn_next: INTEGER is 1
			-- Retrieves the next siblings item.
			--
			-- Declared in Windows as TVGN_NEXT

	Tvgn_nextvisible: INTEGER is 6
			-- Retrieves the next visible item.
			--
			-- Declared in Windows as TVGN_NEXTVISIBLE

	Tvgn_parent: INTEGER is 3
			-- Retrieves the parent of the specified item.
			--
			-- Declared in Windows as TVGN_PARENT

	Tvgn_previous: INTEGER is 2
			-- Retrieves the previous siblings item.
			--
			-- Declared in Windows as TVGN_PREVIOUS

	Tvgn_previousvisible: INTEGER is 7
			-- Retrieves the previous visible item.
			--
			-- Declared in Windows as TVGN_PREVIOUSVISIBLE

	Tvgn_root: INTEGER is 0
			-- Retrieves the top-most or very-first item
			-- of the tree-view control.
			--
			-- Declared in Windows as TVGN_ROOT

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

