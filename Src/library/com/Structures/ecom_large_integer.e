indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_LARGE_INTEGER

inherit
	
	ECOM_STRUCTURE

creation
	make_from_integer,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_integer (integer:INTEGER) is
			-- Creation routine
		do
			initializer := ccom_create_c_large_integer;
			ccom_set_from_integer(initializer, integer);
			item := ccom_large_integer (initializer)
		ensure
			initializer /= Default_pointer
			item /= Default_pointer
		end

feature -- Access

	
feature {NONE} -- Implementation

	create_wrapper (a_pointer: POINTER): POINTER is
		do
			Result := ccom_create_from_large_integer (a_pointer)
		end

	free_structure is
			-- Delete C++ object
		do
			ccom_delete_c_large_integer (initializer)
		end

feature {NONE} -- Externals 

	ccom_create_c_large_integer: POINTER is
		external
			"C++ [new E_Large_Integer %"E_Large_Integer.h%"]()"
		end

	ccom_delete_c_large_integer (cpp_obj: POINTER) is
		external
			"C++ [delete E_Large_Integer %"E_Large_Integer.h%"]()"
		end

	ccom_set_from_integer (cpp_obj: POINTER; i: INTEGER) is
		external
			"C++ [E_Large_Integer %"E_Large_Integer.h%"] (EIF_INTEGER)"
		end

	ccom_create_from_large_integer (i: POINTER): POINTER is
		external
			"C++ [new E_Large_Integer %"E_Large_Integer.h%"] (LARGE_INTEGER *)"
		end

	ccom_large_integer (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_Large_Integer %"E_Large_Integer.h%"](): EIF_POINTER"
		end

end -- class ECOM_LARGE_INTEGER

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

