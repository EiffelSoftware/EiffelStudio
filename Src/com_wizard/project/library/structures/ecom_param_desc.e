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
		undefine
			copy, is_equal
		end

creation
	make, make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	default_value: ECOM_PARAM_DESCEX is
			--
		require
			has_fopt_and_fhasdefault (flags)
		do
			!! Result.make_from_pointer (ccom_paramdesc_default (item))
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

