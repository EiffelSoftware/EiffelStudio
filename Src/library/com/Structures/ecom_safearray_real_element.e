indexing
	description: "Real element of SAFEARRAY"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_SAFEARRAY_REAL_ELEMENT

inherit
	ECOM_SAFEARRAY_ELEMENT

	ECOM_STRUCTURE

creation
	make, make_from_real

feature {NONE} -- Initialization

	make_from_real (a_real: Real) is
			-- Initialize
		do
			make
			ccom_safearray_el_from_value (item, a_real)
		ensure then
			correct_value: value = a_real
		end

feature -- Access

	type: INTEGER is
			-- Type of SAFEARRAY element
			-- See ECOM_VAR_TYPE for possible values
		once
			Result := Vt_r4
		end

	value: REAL is
			-- Value of element
		do
			Result := ccom_safearray_el_real_value (item)
		end
		
feature -- Measurement

	structure_size: INTEGER is
			-- Size of VARIANT structure
		do
			Result := c_size_of_real
		end

feature {NONE} -- Implementation

	c_size_of_real: INTEGER is
		external 
			"C [macro %"E_safearray_element.h%"]"
		alias
			"sizeof(float)"
		end

	ccom_safearray_el_from_value (a_ptr: POINTER; a_real: REAL) is
		external
			"C [macro %"E_safearray_element.h%"](EIF_POINTER, EIF_REAL)"
		end

	ccom_safearray_el_real_value (a_ptr: POINTER): REAL is
		external
			"C [macro %"E_safearray_element.h%"](EIF_POINTER): EIF_REAL"
		end

end -- class ECOM_SAFEARRAY_REAL_ELEMENT

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

