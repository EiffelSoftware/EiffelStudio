indexing
	description: "Memory device context compatible with a given %
		%device context or the application's current screen."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	WEL_MEMORY_DC

inherit
	WEL_DC

creation
	make,
	make_by_dc

feature {NONE} -- Initialization

	make is
			-- Make a memory dc compatible with the application's
			-- current screen.
		do
			item := cwin_create_compatible_dc (default_pointer)
		end

	make_by_dc (a_dc: WEL_DC) is
			-- Make a memory dc compatible with `a_dc'.
		require
			a_dc_not: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			item := cwin_create_compatible_dc (a_dc.item)
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

end -- class WEL_MEMORY_DC

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

