indexing
	description: "wrapping of LPWSTR"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_WIDE_STRING

inherit
	
	ECOM_STRUCTURE

creation
	make_from_string,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_string (string: STRING) is
			-- Create wide string from `string'
		require
			nonvoid_string: string /= Void
		local
			wel_string: WEL_STRING
		do
			!!wel_string.make (string)
			initializer := ccom_create_e_wide_string
			ccom_create_from_string (initializer, wel_string.item)
			item := ccom_wide_str_pointer (initializer)
		ensure
			non_default_initializer: initializer /= Default_pointer
			non_default_item: item /= Default_pointer
		end

feature -- Accsess

	
	to_string: STRING is
			-- convert wide string to string
		do
			Result := ccom_wide_str_to_string (initializer)
		ensure 
			nonvoid_result: Result /= Void
		end

feature {NONE} -- Implementation

	create_wrapper (a_pointer: POINTER): POINTER is
		do
			Result := ccom_create_from_pointer (a_pointer)
		end

	free_structure is
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

	ccom_create_from_pointer (wide_str: POINTER): POINTER is
		external
			"C++ [new E_wide_string %"E_wide_string.h%"](EIF_POINTER)"
		end

	ccom_wide_str_to_string (cpp_obj: POINTER): STRING is
		external
			"C++ [E_wide_string %"E_wide_string.h%"](): EIF_REFERENCE"
		end

	ccom_wide_str_pointer (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_wide_string %"E_wide_string.h%"](): EIF_POINTER"
		end

end -- class ECOM_WIDE_STRING

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

