indexing
	description: "COM PARAMDESC structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_PARAM_DESC

inherit
	ECOM_STRUCTURE

	ECOM_PARAM_FLAGS

creation
	make, make_by_pointer

feature -- Access

	default_value: ECOM_PARAM_DESCEX is
			--
		require
			has_fopt_and_fhasdefault (flags)
		do
			!!Result.make_by_pointer (ccom_paramdesc_default (item))
		end

	flags: INTEGER is
			-- Flags
		do
			Result := ccom_paramdesc_flags (item)
		ensure
			is_valid_paramflag (Result)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of PARAMDESC structure
		do
			Result := c_size_of_param_desc
		end

feature {NONE} -- Externals

	c_size_of_param_desc: INTEGER is
		external 
			"C [macro %"E_paramdesc.h%"]"
		alias
			"sizeof(PARAMDESC)"
		end

	ccom_paramdesc_default (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_paramdesc.h%"]"
		end

	ccom_paramdesc_flags(a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_paramdesc.h%"]"
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

