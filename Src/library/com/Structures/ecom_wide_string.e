indexing
	description: "wrapping of LPWSTR"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_WIDE_STRING

inherit
	MEMORY
		redefine
			dispose
		end

creation
	make_from_string,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_string (string: STRING) is
			-- Create wide string from `string'
		require
			nonvoid_string: string /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (string)
			item := ccom_create_from_string (wel_string.item)	
			shared := False
		ensure
			non_default_item: exists
			not_shared: not shared
		end

	make_from_pointer (a_wide_string: POINTER) is
			-- Creation procedure
			-- Set `item' to `a_wide_string'
		require
			valid_pointer: a_wide_string /= default_pointer
		do
			item := a_wide_string
			shared := True
		ensure
			valid_item: item = a_wide_string
			shared: shared
		end
			
feature -- Accsess

	item: POINTER
			-- Pointer to wide string

	shared: BOOLEAN
				-- Is `item' shared by another object?
			-- If False (by default), `item' will
			-- be destroyed by `destroy_item'.
			-- If True, `item' will not be destroyed.

	exists: BOOLEAN is
			-- Does the `item' exist?
		do
			Result := item /= default_pointer
		ensure
			Result = (item /= default_pointer)
		end

feature -- Basic Operations

	to_string: STRING is
			-- Convert wide string to string
		do
			Result := ccom_wide_str_to_string (item)
		ensure 
			nonvoid_result: Result /= Void
		end

	set_shared is
			-- Set `shared' to True.
		do
			shared := True
		ensure
			shared: shared
		end

	set_unshared is
			-- Set `shared' to False.
		do
			shared := False
		ensure
			not_shared: not shared
		end

feature {NONE} -- Implementation

	dispose is
			-- Ensure `item' is destroyed when
			-- garbage collected by calling `destroy_item'
		do
			if not shared then
				destroy_item
			end
		end

	destroy_item is
			-- Free `item'
		do
			if item /= default_pointer then
				c_free (item)
				item := default_pointer
			end
		end

feature {NONE} -- Externals

	ccom_create_from_string (str: POINTER): POINTER is
		external
			"C (char *): EIF_POINTER | %"E_wide_string.h%""
		end


	ccom_wide_str_to_string (a_wstring: POINTER): STRING is
		external
			"C (WCHAR *): EIF_REFERENCE | %"E_wide_string.h%""
		end

	c_calloc (a_num, a_size: INTEGER): POINTER is
			-- C calloc
		external
			"C (size_t, size_t): EIF_POINTER | <malloc.h>"
		alias
			"calloc"
		end

	c_free (ptr: POINTER) is
			-- C free
		external
			"C (void *) | <malloc.h>"
		alias
			"free"
		end

	c_memcpy (destination, source: POINTER; count: INTEGER) is
			-- C memcpy
		external
			"C (void *, void *, size_t) | <memory.h>"
		alias
			"memcpy"
		end

	c_enomem is
			-- Eiffel run-time function to raise an
			-- "Out of memory" exception.
		external
			"C | %"eif_except.h%""
		alias
			"enomem"
		end

invariant
	exists: exists

end -- class ECOM_WIDE_STRING

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

