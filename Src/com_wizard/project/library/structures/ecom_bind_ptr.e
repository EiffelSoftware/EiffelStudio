indexing
	description: "BINDPTR structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_BIND_PTR

inherit
	ECOM_STRUCTURE

creation
	make,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	func_desc: ECOM_FUNC_DESC is
			-- FUNCDESC structure
		do
			create Result.make_from_pointer (ccom_bindptr_funcdesc (item))
		end

	var_desc: ECOM_VAR_DESC is
			-- VARDESC structure
		do
			create Result.make_from_pointer (ccom_bindptr_vardesc (item))
		end

	type_comp: ECOM_TYPE_COMP is
			-- ITypeComp interface
		do
			create Result.make_from_pointer (ccom_bindptr_itypecomp (item))
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of BINDPTR structure
		do
			Result := c_size_of_bind_ptr
		end

feature {NONE} -- Externals

	c_size_of_bind_ptr: INTEGER is
		external 
			"C [macro %"E_bindptr.h%"]"
		alias
			"sizeof(BINDPTR)"
		end

	ccom_bindptr_funcdesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_bindptr.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_bindptr_vardesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_bindptr.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_bindptr_itypecomp (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_bindptr.h%"](EIF_POINTER): EIF_POINTER"
		end

end -- class ECOM_BIND_PTR

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

