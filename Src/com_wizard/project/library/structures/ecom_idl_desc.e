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

