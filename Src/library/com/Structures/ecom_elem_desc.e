indexing
	description: "COM ELEMDESC structure"
	status: "See notice at end of class"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ELEM_DESC

inherit
	ECOM_STRUCTURE

creation
	make, make_by_pointer

feature -- Access

	type_desc: ECOM_TYPE_DESC is
			-- TYPEDESC structure
		do
			!!Result.make_by_pointer (ccom_elemdesc_typedesc (item))
		end

	idl_desc: ECOM_IDL_DESC is
			-- IDLDESC structure
		do
			!!Result.make_by_pointer (ccom_elemdesc_idldesc (item))
		end

	param_desc: ECOM_PARAM_DESC is
			-- PARAMDESC structure
		do
			!!Result.make_by_pointer (ccom_elemdesc_paramdesc (item))
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

