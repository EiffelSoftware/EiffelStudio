indexing
	description: "SAFEARRAYBOUND structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_SAFE_ARRAY_BOUND

inherit
	ECOM_STRUCTURE

creation
	make,
	make_by_pointer

feature -- Access

	element_count: INTEGER is
			-- Number of elements in dimension
		do
			Result := ccom_safearraybound_elements (item)
		end

	lower_bound: INTEGER is
			-- Lower bound of dimension
		do
			Result := ccom_safearraybound_low_bound (item)
		end

feature -- Element change

	set_count (a_count: INTEGER) is
			-- Set number of elements
		do
			ccom_safearraybound_set_elements (item, a_count)
		end

	set_lower_bound (a_bound: INTEGER) is
			-- Set lower bound
		do
			ccom_safearraybound_set_low_bound (item, a_bound)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of SAFEARRAYBOUND structure
		do
			Result := c_size_of_safe_array_bound
		end

feature {NONE} -- Externals

	c_size_of_safe_array_bound: INTEGER is
		external 
			"C [macro %"E_safearraybound.h%"]"
		alias
			"sizeof(SAFEARRAYBOUND)"
		end

	ccom_safearraybound_elements (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_safearraybound.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_safearraybound_low_bound (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_safearraybound.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_safearraybound_set_elements (a_ptr: POINTER; a_int: INTEGER) is
		external
			"C [macro %"E_safearraybound.h%"](EIF_POINTER, EIF_INTEGER)"
		end

	ccom_safearraybound_set_low_bound (a_ptr: POINTER; a_int: INTEGER) is
		external
			"C [macro %"E_safearraybound.h%"](EIF_POINTER, EIF_INTEGER)"
		end

end -- class ECOM_SAFE_ARRAY_BOUND

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

