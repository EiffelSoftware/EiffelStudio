indexing
	description: "Real element of SAFEARRAY"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_SAFEARRAY_DOUBLE_ELEMENT

inherit
	ECOM_SAFEARRAY_ELEMENT

	ECOM_STRUCTURE

creation
	make, make_from_double

feature {NONE} -- Initialization

	make_from_double (a_double: DOUBLE) is
			-- Initialize
		do
			make
			ccom_safearray_el_from_value (item, a_double)
		ensure then
			correct_value: value = a_double
		end

feature -- Access

	type: INTEGER is
			-- Type of SAFEARRAY element
			-- See ECOM_VAR_TYPE for possible values
		once
			Result := Vt_r8
		end

	value: DOUBLE is
			-- Value of element
		do
			Result := ccom_safearray_el_double_value (item)
		end
		
feature -- Measurement

	structure_size: INTEGER is
			-- Size of VARIANT structure
		do
			Result := c_size_of_double
		end

feature {NONE} -- Implementation

	c_size_of_double: INTEGER is
		external 
			"C [macro %"E_safearray_element.h%"]"
		alias
			"sizeof(double)"
		end

	ccom_safearray_el_from_value (a_ptr: POINTER; a_double: DOUBLE) is
		external
			"C [macro %"E_safearray_element.h%"](EIF_POINTER, EIF_DOUBLE)"
		end

	ccom_safearray_el_double_value (a_ptr: POINTER): DOUBLE is
		external
			"C [macro %"E_safearray_element.h%"](EIF_POINTER): EIF_DOUBLE"
		end

end -- class ECOM_SAFEARRAY_DOUBLE_ELEMENT

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

