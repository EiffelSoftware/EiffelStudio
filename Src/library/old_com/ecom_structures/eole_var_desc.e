indexing

	description: "OLE VARDESC structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_VAR_DESC

inherit
	EOLE_OBJECT_WITH_POINTER

	EOLE_VAR_KIND

	EOLE_VAR_FLAGS
		
feature -- Access

	member_id: INTEGER is
			-- Member identifier
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_vardesc_get_member_id (ole_ptr)
		end

	instance_offset: INTEGER is
			-- Offset of variable in instance
			-- `varkind' must be `Var_perinstance'.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_var_kind: var_kind = Var_perinstance
		do
			Result := ole2_vardesc_get_instance_offset (ole_ptr)
		end

	constant_variant: EOLE_VARIANT is
			-- Value of the constant
			-- `varkind' must be `Var_const'.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_var_kind: var_kind = Var_const
		do
			!! Result
			Result.attach (ole2_vardesc_get_constant_variant (ole_ptr))
		end

	var_kind: INTEGER is
			-- Kind of variable
			-- See EOLE_VAR_KIND for `Result' value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_vardesc_get_varkind (ole_ptr)
		ensure
			valid_result: is_valid_var_kind (Result)
		end

	elem_desc: EOLE_ELEM_DESC is
			-- Corresponding EOLE_ELEMDESC structure
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_vardesc_get_elemdesc (ole_ptr))
		end

	var_flags: INTEGER is
			-- Flags
			-- See EOLE_VAR_FLAGS for `Result' value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_vardesc_get_varflags (ole_ptr)
		ensure
			valid_varflags: is_valid_varflag (Result)
		end

feature {NONE} -- Externals

	ole2_vardesc_get_member_id (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_vardesc_get_member_id"
		end

	ole2_vardesc_get_instance_offset (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_vardesc_get_instance_offset"
		end

	ole2_vardesc_get_constant_variant (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_vardesc_get_constant_variant"
		end

	ole2_vardesc_get_varkind (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_vardesc_get_varkind"
		end

	ole2_vardesc_get_elemdesc (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_vardesc_get_elemdesc"
		end

	ole2_vardesc_get_varflags (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_vardesc_get_varflags"
		end
		
end -- class EOLE_VARDESC

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

