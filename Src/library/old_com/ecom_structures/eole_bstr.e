indexing

	description: "BSTR structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_BSTR

creation 
	make,
	make_from_ptr,
	adapt

feature -- Initialization

	make is
			-- Creation without initialization		
		do
		end

	make_from_ptr (p: POINTER) is
			-- Retrieve existing binary string referenced by `p'.
		do
			ole_ptr := p
		end

	adapt (s: STRING) is
			-- Create binary string from Eiffel string `s'.
		local
			wel_string: WEL_STRING
 		do
			!! wel_string.make (s)
			ole_ptr := ole2_sys_alloc_string (wel_string.item, s.count)
		ensure
			string_set: to_string.is_equal (s)
		end

feature -- Element change

	assign (s: STRING) is
			-- Set binary string value to `s'.
		require
			valid_string: s /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (s)
			ole_ptr := ole2_sys_realloc_string (ole_ptr, wel_string.item)
		ensure
			string_set: to_string.is_equal (s)
		end

	destroy is
			-- Free binary string.
		require
			valid_binary_string: ole_ptr /= default_pointer
		do
			ole2_sys_free_string (ole_ptr)
		end

	to_string: STRING is
			-- Convert into Eiffel string.
		require
			valid_binary_string: ole_ptr /= default_pointer
		do
			Result := ole2_ole_to_eiffel_string (ole_ptr)
		ensure
			result_not_void: Result /= Void
		end
	
feature -- Access

	length: INTEGER is
			-- Length of binary string
		do
			Result := ole2_sys_string_len (ole_ptr)
		end

	ole_ptr: POINTER
			-- Attached OLE pointer
	
feature {NONE} -- Externals

	ole2_sys_alloc_string (str: POINTER; len: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_sys_alloc_string"
		end

	ole2_sys_free_string (bstr_ptr: POINTER) is
		external
			"C"
		alias
			"eole2_sys_free_string"
		end

	ole2_sys_realloc_string (bstr_ptr, new_str_ptr: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_sys_realloc_string"
		end

	ole2_sys_string_len (bstr_ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_sys_string_len"
		end

	ole2_ole_to_eiffel_string (ptr: POINTER): STRING is
		external
			"C"
		alias
			"Ole2EifString"
		end
	
end -- class EOLE_BSTR

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
