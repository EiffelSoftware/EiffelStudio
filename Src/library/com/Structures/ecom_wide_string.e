indexing
	description: "wrapping of LPWSTR"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_WIDE_STRING

inherit
	Memory
		redefine
			dispose
		end

creation
	make_from_string,
	make_from_wide_str_ptr

feature {NONE} -- Initialization

	make_from_string (string: STRING) is
			-- Create wide string from `string'
		require
			nonvoid_string: string /= Void
		local
			a: ANY
		do
			a := string.to_c
			initializer := ccom_create_e_wide_string
			ccom_create_from_string (initializer, $a)
		ensure
			initializer /= Default_pointer
			item /= Default_pointer
		end

	make_from_wide_str_ptr (wide_str_ptr: POINTER) is
			-- Create wide string from `wide_str_ptr'
		require
			nonnull_pointer: wide_str_ptr /= Default_pointer
		do
			initializer := ccom_create_e_wide_string
			ccom_initialize_wide_string (initializer, wide_str_ptr)
		ensure
			initializer /= Default_pointer
			item /= Default_pointer
		end

feature -- Accsess

	item: POINTER is
			-- pointer to wide string
		do
			Result := ccom_wide_str_pointer (initializer)
		end

	to_string: STRING is
			-- convert wide string to string
		do
			Result := ccom_wide_str_to_string (initializer)
		ensure 
			nonvoid_result: Result /= Void
		end

feature {NONE} -- Implementation

	initializer: POINTER
			-- Pointer to structure

	dispose is
			-- delete structure
		do
			ccom_delete_e_wide_string (initializer)
		end


feature {NONE} -- Externals

	ccom_create_e_wide_string: POINTER is
		external
			"C++ [new E_wide_string %"E_wide_string.h%"]()"
		end

	ccom_delete_e_wide_string (cpp_obj: POINTER) is
		external
			"C++ [delete E_wide_string %"E_wide_string.h%"]()"
		end

	ccom_create_from_string (cpp_obj: POINTER; str: POINTER) is
		external
			"C++ [E_wide_string %"E_wide_string.h%"](EIF_POINTER)"
		end

	ccom_initialize_wide_string (cpp_obj: POINTER; wide_str: POINTER) is
		external
			"C++ [E_wide_string %"E_wide_string.h%"](EIF_POINTER)"
		end

	ccom_wide_str_to_string (cpp_obj: POINTER): STRING is
		external
			"C++ [E_wide_string %"E_wide_string.h%"](): EIF_OBJ"
		end

	ccom_wide_str_pointer (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_wide_string %"E_wide_string.h%"](): EIF_POINTER"
		end

end -- class ECOM_WIDE_STRING
