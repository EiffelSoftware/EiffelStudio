indexing

	description: "OLE TYPEDESC structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_TYPE_DESC

inherit
	EOLE_OBJECT_WITH_POINTER

feature -- Access

	var_type: INTEGER is
			-- Type
			-- See class EOLE_VAR_TYPE for Result value.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_typedesc_vartype (ole_ptr)
		end

	type_desc: EOLE_TYPE_DESC is
			-- Pointed at type (if pointed type)
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_typedesc_typedesc (ole_ptr))
		end
		
	array_desc: EOLE_ARRAY_DESC is
			-- Array description (if array)
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_typedesc_arraydesc (ole_ptr))
		end		
		
	href_type: INTEGER is
			-- Handle to type description (if custom)
		do
			Result := ole2_typedesc_href_type (ole_ptr)
		end
	
feature {NONE} -- Externals

	ole2_typedesc_vartype (this: POINTER): INTEGER is
		external
			"C [macro %"typedesc.h%"](EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_typedesc_vartype"
		end

	ole2_typedesc_typedesc (this: POINTER): POINTER is
		external
			"C [macro %"typedesc.h%"](EIF_POINTER): EIF_POINTER"
		alias
			"eole2_typedesc_typedesc"
		end

	ole2_typedesc_arraydesc (this: POINTER): POINTER is
		external
			"C [macro %"typedesc.h%"](EIF_POINTER): EIF_POINTER"
		alias
			"eole2_typedesc_arraydesc"
		end

	ole2_typedesc_href_type (this: POINTER): INTEGER is
		external
			"C [macro %"typedesc.h%"](EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_typedesc_href_type"
		end
		
end -- class EOLE_TYPE_DESC

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
