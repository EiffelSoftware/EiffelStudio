indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STORAGE_ROUTINES

feature -- Basic Operations

	is_compound_file (a_name: STRING): BOOLEAN is
			-- Indicates whether a particular disk file contains 
			-- storage object
		local
			wide_string: ECOM_WIDE_STRING
			i: INTEGER
		do
			!!wide_string.make_from_string (a_name)
			i := ccom_is_compound_file (initializer_routines, wide_string.item)
			if (i = 1) then
				Result := true
			end
			
		end

feature {NONE} -- Implementation

	initializer_routines: POINTER is
			-- Pointer to structure
		once
			Result := ccom_create_e_storage_routines
		end


feature {NONE} -- Externals

	ccom_create_e_storage_routines: POINTER is
		external
			"C++ [new E_Storage_Routines %"E_Storage_Routines.h%"]()"
		end

	ccom_is_compound_file (cpp_obj: POINTER; a_name: POINTER): INTEGER is
		external
			"C++ [E_Storage_Routines %"E_Storage_Routines.h%"] (WCHAR *):EIF_INTEGER"
		end

end -- class ECOM_STORAGE_ROUTINES


