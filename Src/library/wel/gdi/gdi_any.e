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
		require
			exists: exists
		do
			cwin_delete_object (item)
			item := default_pointer
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
