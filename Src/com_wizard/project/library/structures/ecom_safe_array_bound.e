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
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

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

