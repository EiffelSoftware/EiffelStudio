indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_LARGE_INTEGER

inherit
	
	MEMORY
		redefine
			dispose
		end

creation
	make_from_integer,
	make_from_large_integer_ptr

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

	make_from_large_integer_ptr (large_integer_ptr: POINTER) is
			-- Creation routine
		require
			large_integer_ptr /= Default_pointer
		do
			initializer := ccom_create_c_large_integer;
			ccom_set_from_large_integer(initializer, large_integer_ptr);
			item := ccom_large_integer (initializer)
		ensure
			initializer /= Default_pointer
			item /= Default_pointer
		end

feature -- Access

	item: POINTER 
			-- pointer to LARGE_INTEGER (64-bit integer)

feature {NONE} -- Implementation

	initializer: POINTER
			-- Pointer to C++ object

	dispose is
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

	ccom_set_from_large_integer (cpp_obj: POINTER; i: POINTER) is
		external
			"C++ [E_Large_Integer %"E_Large_Integer.h%"] (LARGE_INTEGER *)"
		end

	ccom_large_integer (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_Large_Integer %"E_Large_Integer.h%"](): EIF_POINTER"
		end

end -- class ECOM_LARGE_INTEGER
