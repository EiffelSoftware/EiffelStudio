indexing
	description: "Tree view selection type constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVGN_CONSTANTS

feature -- Access

	Tvgn_caret: INTEGER is
			-- Sets the selection to the given item.
		external
			"C [macro <cctrl.h>]"
		alias
			"TVGN_CARET"
		end

	Tvgn_drophilite: INTEGER is
			-- Redraws the given item in the style used to indicate
			-- the target of a drag and drop operation.
		external
			"C [macro <cctrl.h>]"
		alias
			"TVGN_DROPHILITE"
		end

	Tvgn_firstvisible: INTEGER is
			-- Scrolls the tree view vertically so that the given
			-- item is the first visible item.
		external
			"C [macro <cctrl.h>]"
		alias
			"TVGN_FIRSTVISIBLE"
		end

end -- class WEL_TVGN_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
