indexing
	description: "COM VARDESC structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_VAR_DESC

inherit
	ECOM_STRUCTURE
		redefine
			dispose
		end

	ECOM_VAR_FLAGS

	ECOM_VAR_KIND

creation
	make,
	make_by_pointer

feature -- Access

	member_id: INTEGER is
			-- Member identifier
		do
			Result := ccom_vardesc_memid (item)
		end

	instance_offset: INTEGER is
			-- Offset of this variable within instance
			-- `varkind' must be `Var_perinstance'.
		require
			valid_var_kind: var_kind = Var_perinstance
		do
			Result := ccom_vardesc_offset (item)
		end

	constant_variant: ECOM_VARIANT is
			-- Value of the constant
			-- `varkind' must be `Var_const'.
		require
			valid_var_kind: var_kind = Var_const
		do
			!! Result.make_by_pointer (ccom_vardesc_const_variant (item))
		end

	elem_desc: ECOM_ELEM_DESC is
			-- Corresponding ELEMDESC structure
		do
			!! Result.make_by_pointer (ccom_vardesc_elemdesc (item))
		end

	var_flags: INTEGER is
			-- Flags
			-- See ECOM_VAR_FLAGS for returnvalue
		do
			Result := ccom_vardesc_var_flags (item)
		ensure
			valid_varflags: is_valid_varflag (Result)
		end

	var_kind: INTEGER is
			-- Kind of variable
			-- See ECOM_VAR_KIND for return value
		do
			Result := ccom_vardesc_var_kind (item)
		ensure
			valid_result: is_valid_var_kind (Result)
		end

feature -- Status report

	parent: ECOM_TYPE_INFO
			-- ITypeInfo inteface that returned structure

	is_parent_valid: BOOLEAN
			-- Is `parent' attribute valid?

feature -- Status setting

	set_parent (a_parent: ECOM_TYPE_INFO) is
			-- Set `parent attribute.
		do
			parent := a_parent
			is_parent_valid := true
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of VARDESC structure
		do
			Result := c_size_of_var_desc
		end

feature {NONE} -- Implementation

	dispose is
		do
			Precursor
		end

feature {NONE} -- Externals

	c_size_of_var_desc: INTEGER is
		external 
			"C [macro %"E_vardesc.h%"]"
		alias
			"sizeof(VARDESC)"
		end

	ccom_vardesc_memid (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_vardesc.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_vardesc_offset (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_vardesc.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_vardesc_const_variant (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_vardesc.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_vardesc_elemdesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_vardesc.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_vardesc_var_flags (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_vardesc.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_vardesc_var_kind (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_vardesc.h%"](EIF_POINTER): EIF_INTEGER"
		end

end -- class ECOM_VAR_DESC

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

