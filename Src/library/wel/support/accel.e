indexing
	description: "Keyboard accelerators that generates a WM_COMMAND message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ACCELERATORS

inherit
	WEL_RESOURCE

creation
	make_by_id,
	make_by_name

feature {NONE} -- Implementation

	load_item (hinstance, id: POINTER) is
			-- Load accelerators.
		do
			item := cwin_load_accelerators (hinstance, id)
		end

	destroy_item is
			-- Destroy accelerators.
		do
			-- We don't need to destroy accelerators.
			item := default_pointer
		end

feature {NONE} -- Externals

	cwin_load_accelerators (hinstance: POINTER; id: POINTER): POINTER is
			-- SDK LoadAccelerators
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR): EIF_POINTER"
		alias
			"LoadAccelerators"
		end

end -- class WEL_ACCELERATORS

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
