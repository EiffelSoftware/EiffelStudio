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
		redefine
			get,
			release,
			destroy_item
		end

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

feature -- Basic operations

	get is
			-- Get the device context
		do
		end

	release is
			-- Release the device context
		do
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


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

