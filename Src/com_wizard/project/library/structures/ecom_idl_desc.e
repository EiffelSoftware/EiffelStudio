indexing
	description: "COM IDLDESC structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_IDL_DESC

inherit
	ECOM_STRUCTURE

	ECOM_IDL_FLAGS

creation
	make, make_by_pointer

feature -- Access

	flags: INTEGER is
			-- Flags
		do
			Result := ccom_idldesc_flags (item)
		ensure
			is_valid_idlflag (Result)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of IDLDESC structure
		do
			Result := c_size_of_idl_desc
		end

feature {NONE} -- Externals

	c_size_of_idl_desc: INTEGER is
		external 
			"C [macro %"E_idldesc.h%"]"
		alias
			"sizeof(IDLDESC)"
		end

	ccom_idldesc_flags(a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_idldesc.h%"]"
		end

end -- class ECOM_IDL_DESC

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

