indexing
	description: "This class is an ancestor to all GDI classes."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDI_ANY

inherit
	WEL_ANY

feature -- Removal

	delete is
			-- Delete the current gdi object
		local
			p: POINTER
		do
			if item /= p then
				cwin_delete_object (item)
				item := p
			end
		ensure
			not_exists: not exists
		end

feature {NONE} -- Removal

	destroy_item is
			-- Ensure the current gdi object is deleted when
			-- garbage collected.
		do
			delete
		end

feature {NONE} -- Externals

	cwin_delete_object (a_item: POINTER) is
			-- SDK DeleteObject
		external
			"C [macro <wel.h>] (HGDIOBJ)"
		alias
			"DeleteObject"
		end

end -- class WEL_GDI_ANY

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

