indexing
	description: "COM ULARGE_INTEGER 64-bit integer"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ULARGE_INTEGER

inherit	
	ECOM_STRUCTURE
		redefine
			make
		end

creation
	make,
	make_from_integer,
	make_from_pointer

feature {NONE} -- Initialization

	make is
			-- Make.
		do
			Precursor {ECOM_STRUCTURE}
		end

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

	make_from_integer (integer:INTEGER) is
			-- Creation routine
		do
			make
			set_quad_part (integer)
		ensure	
			exists
		end

feature -- Access

	quad_part: INTEGER_64 is
			-- `QuadPart' field.
		do
			Result := ccom_x_ularge_integer_quad_part (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_x_ularge_integer
		end

feature -- Basic Operations

	set_quad_part (a_quad_part: INTEGER_64) is
			-- Set `quad_part' with `a_quad_part'.
		do
			ccom_x_ularge_integer_set_quad_part (item, a_quad_part)
		end

feature {NONE}  -- Externals

	c_size_of_x_ularge_integer: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom__ULARGE_INTEGER_impl.h%"]"
		alias
			"sizeof(ULARGE_INTEGER)"
		end

	ccom_x_ularge_integer_quad_part (a_pointer: POINTER): INTEGER_64 is
			-- `QuadPart' field.
		external
			"C++ [macro %"ecom__ULARGE_INTEGER_impl.h%"](ULARGE_INTEGER *):EIF_INTEGER_64"
		end

	ccom_x_ularge_integer_set_quad_part (a_pointer: POINTER; arg2: INTEGER_64) is
			-- Set `quad_part' with `a_quad_part'.
		external
			"C++ [macro %"ecom__ULARGE_INTEGER_impl.h%"](ULARGE_INTEGER *, ULONGLONG)"
		end

end -- class ECOM_ULARGE_INTEGER

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

