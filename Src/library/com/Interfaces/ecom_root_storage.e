indexing
	description: "Implementation of IRootStorage interface"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ROOT_STORAGE

inherit

	ECOM_INTERFACE

creation
	make_from_pointer


feature -- Basic Operations

	swith_to_file (name: STRING) is
			-- Copies the current file associated with the storage object 
			-- to a new file. The new file is then used for the storage 
			-- object and any uncommitted changes
		local
			wide_string: ECOM_WIDE_STRING
		do
			!!wide_string.make_from_string (name)
			ccom_switch_to_file (initializer, wide_string.item)
		end

feature {NONE} -- Implementation

	create_wrapper (a_pointer: POINTER): POINTER is
		do
			Result := ccom_create_c_iroot_storage(a_pointer)
		end

	release_interface is
			-- delete structure
		do
			ccom_delete_c_iroot_storage (initializer);
		end


feature {ECOM_ROOT_STORAGE}

feature {NONE} -- Externals

	ccom_create_c_iroot_storage(a_pointer: POINTER): POINTER is
		external
			"C++ [new E_IRootStorage %"E_IRootStorage.h%"](EIF_POINTER)"
		end

	ccom_delete_c_iroot_storage (cpp_obj: POINTER) is
		external
			"C++ [delete E_IRootStorage %"E_IRootStorage.h%"]()"
		end

	ccom_iroot_storage (cpp_obj: POINTER): POINTER is
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
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

