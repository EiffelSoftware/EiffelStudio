indexing
	description: "COM ELEMDESC structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ELEM_DESC

inherit
	ECOM_STRUCTURE

creation
	make, make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	type_desc: ECOM_TYPE_DESC is
			-- TYPEDESC structure
		do
			!! Result.make_from_pointer (ccom_elemdesc_typedesc (item))
		end

	idl_desc: ECOM_IDL_DESC is
			-- IDLDESC structure
		do
			!! Result.make_from_pointer (ccom_elemdesc_idldesc (item))
		end

	param_desc: ECOM_PARAM_DESC is
			-- PARAMDESC structure
		do
			!! Result.make_from_pointer (ccom_elemdesc_paramdesc (item))
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of ELEMDESC structure
		do
			Result := c_size_of_elem_desc
		end

feature {NONE} -- Externals

	c_size_of_elem_desc: INTEGER is
		external 
			"C [macro %"E_elemdesc.h%"]"
		alias
			"sizeof(ELEMDESC)"
		end

	ccom_elemdesc_typedesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_elemdesc.h%"]"
		end

	ccom_elemdesc_idldesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_elemdesc.h%"]"
		end

	ccom_elemdesc_paramdesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_elemdesc.h%"]"
		end


end -- class ECOM_PARAM_DESC

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

