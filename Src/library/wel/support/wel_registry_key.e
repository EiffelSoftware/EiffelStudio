indexing

	description: "Registry manager"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_REGISTRY_KEY

inherit
	MEMORY
		redefine
			dispose
		end

creation
	make_from_pointer
	
feature -- Initialization

	make_from_pointer (ptr: POINTER) is
			-- Set `item' with `ptr'
		do
			item := ptr
		end
		
feature -- Access

	name: STRING is
			-- Name of key
		do
			!! Result.make (0)
			Result.from_c (cwin_reg_key_name (item))
		end
		
	class_id: STRING is
			-- Class of key
		do
			!! Result.make (0)
			Result.from_c (cwin_reg_key_class (item))
		end
		
	last_change: WEL_FILETIME is
			-- Last modification time
		do
			!! Result.make_from_pointer (cwin_reg_key_time (item))
		end
		
	item: POINTER
			-- Pointer to C structure.

feature {NONE} -- Removal

	dispose is
			-- Free C structure
		do
			cwin_reg_key_destroy (item)
		end

feature {NONE} -- Externals

	cwin_reg_key_name (ptr: POINTER): POINTER is
		external
			"C [macro %"registry_key.h%"]"
		end
		
	cwin_reg_key_class (ptr: POINTER): POINTER is
		external
			"C [macro %"registry_key.h%"]"
		end
		
	cwin_reg_key_time (ptr: POINTER): POINTER is
		external
			"C [macro %"registry_key.h%"]"
		end
	
	cwin_reg_key_destroy (ptr: POINTER) is
		external
			"C [macro %"registry_key.h%"]"
		end

end -- class WEL_REGISTRY_KEY

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

