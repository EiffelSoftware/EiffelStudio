indexing
	description: "Memory device context compatible with a given %
		%device context."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMPATIBLE_DC

obsolete
	"use WEL_MEMORY_DC"

inherit
	WEL_DC

creation
	make

feature {NONE} -- Initialization

	make (a_dc: WEL_DC) is
			-- Make a compatible dc with `a_dc'
		require
			a_dc_not: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			item := cwin_create_compatible_dc (a_dc.item)
		ensure
			exists: exists
		end

feature {NONE} -- Removal

	destroy_item is
		do
			unselect_all
			delete
		end

feature {NONE} -- Externals

	cwin_create_compatible_dc (hdc: POINTER): POINTER is
			-- SDK CreateCompatibleDC
		external
			"C [macro <wel.h>] (HDC): EIF_POINTER"
		alias
			"CreateCompatibleDC"
		end

end -- class WEL_COMPATIBLE_DC

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
