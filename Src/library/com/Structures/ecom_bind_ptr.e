indexing
	description: "BINDPTR structure"
	status: "See notice at end of class"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_BIND_PTR

inherit
	ECOM_STRUCTURE

creation
	make,
	make_by_pointer


feature -- Access

	func_desc: ECOM_FUNC_DESC is
			-- FUNCDESC structure
		do
			!!Result.make_by_pointer (ccom_bindptr_funcdesc (item))
		end

	var_desc: ECOM_VAR_DESC is
			-- VARDESC structure
		do
			!!Result.make_by_pointer (ccom_bindptr_vardesc (item))
		end

	type_comp: ECOM_TYPE_COMP is
			-- ITypeComp interface
		do
			!!Result.make_from_pointer (ccom_bindptr_itypecomp (item))
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

