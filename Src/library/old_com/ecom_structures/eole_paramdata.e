indexing

	description: "PARAMDATA structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_PARAMDATA

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate
		end
	
feature -- Element change

	allocate: POINTER is
			-- Create associated C++ structure.
		do
			Result := ole2_paramdata_allocate
		end
		
	set_name (s: STRING) is
			-- Set name with `s'.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_name: s /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (s)
			ole2_paramdata_set_name (ole_ptr, wel_string.item)
		ensure
			name_set: name.is_equal (s)
		end

	set_vartype (type: INTEGER) is
			-- Set type with `type'.
			-- See class EOLE_VARTYPE for `type' value.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_paramdata_set_vartype (ole_ptr, type)
		ensure
			vartype_set: vartype = type
		end

feature -- Access

	name: STRING is
			-- Parameter name
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result.make (0)
			Result.from_c (ole2_paramdata_get_name (ole_ptr))
		end

	vartype: INTEGER is
			-- Parameter type
			-- See class EOLE_VARTYPE for `Result' value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_paramdata_get_vartype (ole_ptr)
		end
	
feature {NONE} -- Externals

	ole2_paramdata_allocate: POINTER is
		external
			"C"
		alias
			"eole2_paramdata_allocate"
		end

	ole2_paramdata_destroy (ptr: POINTER) is
		external
			"C"
		alias
			"eole2_paramdata_destroy"
		end
		
	ole2_paramdata_set_name (ptr, str: POINTER) is
		external
			"C"
		alias
			"eole2_paramdata_set_name"
		end

	ole2_paramdata_set_vartype (ptr: POINTER; typ: INTEGER) is
		external
			"C"
		alias
			"eole2_paramdata_set_vartype"
		end

	ole2_paramdata_get_name (ptr: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_paramdata_get_name"
		end

	ole2_paramdata_get_vartype (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_paramdata_get_vartype"
		end
	
end -- class EOLE_PARAMDATA

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