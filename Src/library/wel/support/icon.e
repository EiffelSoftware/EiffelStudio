indexing
	description: "Picture that consists of a bitmapped image."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ICON

inherit
	WEL_RESOURCE

creation
	make_by_id,
	make_by_name,
	make_by_predefined_id,
	make_by_pointer

feature {NONE} -- Implementation

	load_item (hinstance, id: POINTER) is
			-- Load icon.
		do
			item := cwin_load_icon (hinstance, id)
		end

	destroy_item is
			-- Destroy icon.
		do
			cwin_destroy_icon (item)
			item := default_pointer
		end

feature {NONE} -- Externals

	cwin_load_icon (hinstance: POINTER; id: POINTER): POINTER is
			-- SDK LoadIcon
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR): EIF_POINTER"
		alias
			"LoadIcon"
		end

	cwin_destroy_icon (hicon: POINTER) is
			-- SDK DestroyIcon
		external
			"C [macro <wel.h>] (HICON)"
		alias
			"DestroyIcon"
		end

end -- class WEL_ICON

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
