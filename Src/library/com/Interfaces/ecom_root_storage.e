indexing
	description: "Implementation of IRootStorage interface"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ROOT_STORAGE

inherit
	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_c_iroot_storage(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	swith_to_file (a_name: STRING) is
			-- Copy current file associated with storage object 
			-- to new file `a_name'. New file is then used for storage 
			-- object and any uncommitted changes.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			wide_string: ECOM_WIDE_STRING
		do
			create wide_string.make_from_string (a_name)
			ccom_switch_to_file (initializer, wide_string.item)
		end

feature {NONE} -- Implementation

	delete_wrapper is
			-- delete structure
		do
			ccom_delete_c_iroot_storage (initializer);
		end

feature {NONE} -- Externals

	ccom_create_c_iroot_storage(a_pointer: POINTER): POINTER is
		external
			"C++ [new E_IRootStorage %"E_IRootStorage.h%"](IUnknown *)"
		end

	ccom_delete_c_iroot_storage (cpp_obj: POINTER) is
		external
			"C++ [delete E_IRootStorage %"E_IRootStorage.h%"]()"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_IRootStorage %"E_IRootStorage.h%"](): EIF_POINTER"
		end

	ccom_switch_to_file (cpp_obj: POINTER; name: POINTER) is
		external
			"C++ [E_IRootStorage %"E_IRootStorage.h%"](EIF_POINTER)"
		end

end -- class ECOM_ROOT_STORAGE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

