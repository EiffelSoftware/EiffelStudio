indexing
	description: "Small picture whose location on the screen is controlled %
		%by a pointing device."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CURSOR

inherit
	WEL_RESOURCE

creation
	make_by_id,
	make_by_name,
	make_by_predefined_id,
	make_by_pointer

feature -- Basic operations

	set is
			-- Set the current cursor for the entire application.
		require
			exists: exists
		do
			cwin_set_cursor (item)
		end

feature {NONE} -- Implementation

	load_item (hinstance, id: POINTER) is
			-- Load cursor.
		do
			item := cwin_load_cursor (hinstance, id)
		end

	destroy_item is
			-- Destroy cursor.
		do
			cwin_destroy_cursor (item)
			item := default_pointer
		end

feature {NONE} -- Externals

	cwin_set_cursor (hcursor: POINTER) is
			-- SDK SetCursor
		external
			"C [macro <wel.h>] (HCURSOR)"
		alias
			"SetCursor"
		end

	cwin_load_cursor (hinstance: POINTER; id: POINTER): POINTER is
			-- SDK LoadCursor
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR): EIF_POINTER"
		alias
			"LoadCursor"
		end

	cwin_destroy_cursor (hcursor: POINTER) is
			-- SDK DestroyCursor
		external
			"C [macro <wel.h>] (HCURSOR)"
		alias
			"DestroyCursor"
		end

end -- class WEL_CURSOR

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
