indexing
	description: "Ancestor of all standard dialog boxes."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_STANDARD_DIALOG

inherit
	WEL_STRUCTURE

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
