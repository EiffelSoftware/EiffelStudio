indexing
	description: "Ancestor of all standard dialog boxes."
	legal: "See notice at end of class."
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

	selected: BOOLEAN;
			-- Has the user selected something (file, color, etc.)?
			-- If True, the Ok button has been chosen. If False,
			-- the Cancel button has been chosen.

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




end -- class WEL_STANDARD_DIALOG

