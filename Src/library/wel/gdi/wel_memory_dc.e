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
		redefine
			destroy_item
		end

creation
	make,
	make_by_dc

feature {NONE} -- Initialization

	make is
			-- Make a memory dc compatible with the application's
			-- current screen.
		local
			a_default_pointer: POINTER
		do
			item := cwin_create_compatible_dc (a_default_pointer)
		end

	make_by_dc (a_dc: WEL_DC) is
			-- Make a memory dc compatible with `a_dc'.
		require
			a_dc_not: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			item := cwin_create_compatible_dc (a_dc.item)
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
			-- Delete the current device context.
		local
			p: POINTER	-- Default_pointer
		do
				-- Protect the call to DeleteDC, because `destroy_item' can 
				-- be called by the GC so without assertions.
			if item /= p then
				unselect_all
				cwin_delete_dc (item)
			end
			item := p
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

