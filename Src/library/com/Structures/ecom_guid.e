indexing
	description: "COM GUID structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_GUID

inherit
	ECOM_STRUCTURE
		redefine
			is_equal,	
			out
		end

	ECOM_ROUTINES
		undefine
			is_equal,
			out
		end

creation
	make,
	make_from_pointer,
	make_from_string,
	make_from_guid

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Basic operation

	generate is
			-- Generate a new GUID
		do
			ccom_generate_guid (item)
		end

feature {NONE} -- Initialization

	make_from_string (string: STRING) is
			-- Create GUID from string `string'.
		require
			non_void_string: string /= Void
			valid_guid_string: guid_routines.is_valid_guid_string (string)
		local
			wide_string: ECOM_WIDE_STRING
		do
			create wide_string.make_from_string (string)
			make
			ccom_string_to_guid (wide_string.item, item)
		ensure
			valid_item: item /= default_pointer
		end

	make_from_guid (other: ECOM_GUID) is
			-- Create new structure with same GUID as `other'.
		require
			valid_guid: other /= Void and then other.item /= default_pointer
		do
			make
			memory_copy (other.item, structure_size)
		ensure
			valid_item: item /= default_pointer
		end
 
feature -- Status Report

	is_equal (a_guid: ECOM_GUID): BOOLEAN is
			-- Is `a_guid' equal to `Current'?
		do
			Result := ccom_is_equal_guid (item, a_guid.item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of GUID structure
		do
			Result := c_size_of_guid
		end

feature -- Conversion

	to_string: STRING is
			-- String representation
		require
			valid_item: item /= default_pointer
		local
			wide_string: ECOM_WIDE_STRING
		do
			create wide_string.make_from_pointer (ccom_guid_to_wide_string (item))
			wide_string.set_unshared
			Result := wide_string.to_string
		ensure
			non_void_representation: Result /= Void
		end

	to_definition_string: STRING is
			-- String representation needed for code generation.
		require
			valid_item: item /= default_pointer
		do
			Result := ccom_guid_to_defstring (item)
		ensure
			non_void_representation: Result /= Void
		end
	
	out: STRING is
			-- String representation
		do
			Result := to_string
		end

feature {NONE} -- Externals

	c_size_of_guid: INTEGER is
		external 
			"C [macro %"ecom_guid.h%"]"
		alias
			"sizeof(GUID)"
		end

	ccom_string_to_guid (wide_str: POINTER; a_guid: POINTER) is
		external
			"C [macro %"ecom_guid.h%"]"
		end

	ccom_generate_guid (a_guid: POINTER) is
		external
			"C (GUID *)| %"ecom_guid.h%""
		end

	ccom_guid_to_wide_string (a_guid: POINTER): POINTER is
		external
			"C (GUID *): EIF_POINTER | %"ecom_guid.h%""
		end

	ccom_is_equal_guid (giud1, guid2: POINTER): BOOLEAN is
		external
			"C [macro %"ecom_guid.h%"]"
		end

	ccom_guid_to_defstring (a_guid: POINTER): STRING is
		external
			"C (GUID *): EIF_REFERENCE | %"ecom_guid.h%""
		end

end -- class ECOM_GUID

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

