indexing
	description: "Ancestor of all standard dialog boxes."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_STANDARD_DIALOG

inherit
	WEL_STRUCTURE
		rename
			initialize as structure_initialize
		end

feature -- Basic operations

	activate (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Activate the dialog box (modal mode) with
			-- `a_parent' as owner.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		deferred
		end

feature -- Status report

	selected: BOOLEAN
			-- Has the user selected something (file, color, etc.)?
			-- If True, the Ok button has been chosen. If False,
			-- the Cancel button has been chosen.

end -- class WEL_STANDARD_DIALOG

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

