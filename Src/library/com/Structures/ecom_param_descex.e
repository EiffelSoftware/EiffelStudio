indexing
	description: "COM PARAMDESCEX structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_PARAM_DESCEX

inherit
	ECOM_STRUCTURE

creation
	make, make_by_pointer

feature -- Access

	default_value: ECOM_VARIANT is
			-- VARIANT structure with default value 
			-- of parameter, described by PARAMDESC
		do
			!!Result.make_by_pointer (ccom_paramdescex_variant (item))
		end

	bytes: INTEGER is
			-- Bytes
		do
			Result := ccom_paramdescex_bytes (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of PARAMDESCEX structure
		do
			Result := c_size_of_param_descex
		end

feature {NONE} -- Externals

	c_size_of_param_descex: INTEGER is
		external 
			"C [macro %"E_paramdescex.h%"]"
		alias
			"sizeof(PARAMDESCEX)"
		end

	ccom_paramdescex_variant (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_paramdescex.h%"]"
		end

	ccom_paramdescex_bytes (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_paramdescex.h%"]"
		end

end -- class ECOM_PARAM_DESCEX

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

