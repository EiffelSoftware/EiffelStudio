indexing

	description: "OLE VARDESC structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_VARDESC

inherit
	EOLE_OBJECT_WITH_POINTER

	EOLE_VARKIND

	EOLE_VARFLAGS
		
feature -- Access

	memberid: INTEGER is
			-- Member identifier
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_vardesc_get_member_id (ole_ptr)
		end

	instance_offset: INTEGER is
			-- Instance offset
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_vardesc_get_instance_offset (ole_ptr)
		end

	constant_variant: EOLE_VARIANT is
			-- Value of the constant
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_vardesc_get_constant_variant (ole_ptr))
		end

	varkind: INTEGER is
			-- Kind of variable
			-- See EOLE_VARKIND for `Result' value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_vardesc_get_varkind (ole_ptr)
		ensure
			valid_result: is_valid_var_kind (Result)
		end

	elemdesc: EOLE_ELEMDESC is
			-- Corresponding EOLE_ELEMDESC structure
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_vardesc_get_elemdesc (ole_ptr))
		end

	varflags: INTEGER is
			-- Flags
			-- See EOLE_VARFLAGS for `Result' value
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
