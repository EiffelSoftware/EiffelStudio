indexing
	description: "COM LARGE_INTEGER 64-bit integer"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_LARGE_INTEGER

inherit
	
	ECOM_STRUCTURE

creation
	make, make_by_pointer,
	make_from_integer

feature {NONE} -- Initialization

	make_from_integer (integer:INTEGER) is
			-- Creation routine
		do
			make
			ccom_set_large_integer (item, integer)
		ensure	
			exists
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of LARGE_INTEGER structure
		do
			Result := c_size_of_large_integer 
		end
	
feature {NONE} -- Externals 

	c_size_of_large_integer: INTEGER is
		external 
			"C [macro <objbase.h>]"
		alias
			"sizeof(LARGE_INTEGER)"
		end

	ccom_set_large_integer (ptr: POINTER; i: INTEGER) is
		external
			"C [macro %"E_Large_Integer.h%"](EIF_POINTER, EIF_INTEGER)"
		end

end -- class ECOM_LARGE_INTEGER

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

