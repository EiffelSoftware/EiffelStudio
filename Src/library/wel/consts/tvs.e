indexing
	description: "Tree view style (TVS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVS_CONSTANTS

feature -- Access

	Tvs_hasbuttons: INTEGER is
			-- Displays plus (+) and minus (-) buttons next to
			-- parent items. The user clicks the buttons to expand
			-- or collapse a parent item's list of child items. To
			-- include buttons with items at the root of the tree
			-- view, Tvs_linesatroot must also be specified.
		external
			"C [macro <cctrl.h>]"
		alias
			"TVS_HASBUTTONS"
		end

	Tvs_haslines: INTEGER is
			-- Uses lines to show the hierarchy of items.
		external
			"C [macro <cctrl.h>]"
		alias
			"TVS_HASLINES"
		end

	Tvs_linesatroot: INTEGER is
			-- Uses lines to link items at the root of the
			-- tree-view control. This value is ignored if
			-- Tvs_haslines is not also specified.
		external
			"C [macro <cctrl.h>]"
		alias
			"TVS_LINESATROOT"
		end

	Tvs_editlabels: INTEGER is
			-- Allows the user to edit the labels of tree-view
			-- items.
		external
			"C [macro <cctrl.h>]"
		alias
			"TVS_EDITLABELS"
		end

	Tvs_disabledragdrop: INTEGER is
			-- Prevents the tree-view control from sending
			-- Tvn_begindrag notification messages.
		external
			"C [macro <cctrl.h>]"
		alias
			"TVS_DISABLEDRAGDROP"
		end

	Tvs_showselalways: INTEGER is
			-- Causes a selected item to remain selected when the
			-- tree-view control loses focus.
		external
			"C [macro <cctrl.h>]"
		alias
			"TVS_SHOWSELALWAYS"
		end

end -- class WEL_TVS_CONSTANTS

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
