indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ULARGE_INTEGER

inherit
	
	MEMORY
		redefine
			dispose
		end

creation
	make_from_integer,
	make_from_ularge_integer_ptr

feature {NONE} -- Initialization

	make_from_integer (integer:INTEGER) is
			-- 
		do
			initializer := ccom_create_c_ularge_integer;
			ccom_set_from_integer(initializer, integer);
		ensure
			initializer /= Default_pointer
			item /= Default_pointer
		end

	make_from_ularge_integer_ptr (ularge_integer_ptr: POINTER) is
			-- Creation routine
		require
			valid_ptr: ularge_integer_ptr /= Default_pointer
		do
			initializer := ccom_create_c_ularge_integer;
			ccom_set_from_ularge_integer(initializer, ularge_integer_ptr);
		ensure
			initializer /= Default_pointer
			item /= Default_pointer
		end

feature -- Access

	item: POINTER is
			-- pointer to ULARGE_INTEGER (64-bit unsigned integer)
		do
			Result := ccom_ularge_integer (initializer)
		end

feature {NONE} -- Implementation

	initializer: POINTER
			-- Pointer to E_ULarge_Integer which is wrapper of ULARGE_INTEGER

	dispose is
			-- Delete structure
		do
			ccom_delete_c_ularge_integer (initializer)
		end

feature {NONE} -- Externals

	ccom_create_c_ularge_integer: POINTER is
		external
			"C++ [new E_ULarge_Integer %"E_ULarge_Integer.h%"]()"
		end

	ccom_delete_c_ularge_integer (cpp_obj: POINTER) is
		external
			"C++ [delete E_ULarge_Integer %"E_ULarge_Integer.h%"]()"
		end

	ccom_set_from_integer (cpp_obj: POINTER; i: INTEGER) is
		external
			"C++ [E_ULarge_Integer %"E_ULarge_Integer.h%"] (EIF_INTEGER)"
		end

	ccom_set_from_ularge_integer (cpp_obj: POINTER; i: POINTER) is
		external
			"C++ [E_ULarge_Integer %"E_ULarge_Integer.h%"] (ULARGE_INTEGER *)"
		end

	ccom_ularge_integer (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_ULarge_Integer %"E_ULarge_Integer.h%"](): EIF_POINTER"
		end

end -- class ECOM_ULARGE_INTEGER
