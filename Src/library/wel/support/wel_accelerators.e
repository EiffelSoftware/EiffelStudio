indexing
	description: "Keyboard accelerators that generates a WM_COMMAND message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ACCELERATORS

inherit
	WEL_RESOURCE

create
	make_by_id,
	make_by_name,
	make_with_array

feature {NONE} -- Initialization

	make_with_array (an_array: WEL_ARRAY [WEL_ACCELERATOR]) is
			-- Initialize with accelerators in `an_array'.
		require
			an_array_not_void: an_array /= Void
			an_array_exists: an_array.exists
		do
 			item := cwin_create_accelerator_table (
				an_array.item, an_array.count)
		end

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
		
	cwin_destroy_accelerator_table (p: POINTER) is
			-- SDK DestroyAcceleratorTable
		external
			"C [macro <wel.h>] (HACCEL)"
		alias
			"DestroyAcceleratorTable"
		end

	cwin_create_accelerator_table (p: POINTER; entries: INTEGER): POINTER is
			-- SDK CreateAcceleratorTable
		external
			"C [macro <wel.h>] (LPACCEL, int): EIF_POINTER"
		alias
			"CreateAcceleratorTable"
		end		

end -- class WEL_ACCELERATORS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

