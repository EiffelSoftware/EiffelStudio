indexing
	description: "IMalloc interface wrapper."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IMALLOC

inherit
	WEL_STRUCTURE
		redefine
			make,
			destroy_item
		end

creation
	make

feature -- Initialization

	make is
			-- Initialize interface.
		do
			cwin_coinitialize
			{WEL_STRUCTURE} Precursor
			cwin_sh_get_malloc (item)
		end

feature -- Access

	allocated_buffer (an_integer: INTEGER): POINTER is
			-- Pointer to newly allocated buffer of `an_integer' bytes
			-- `default_pointer' if no enough memory is available
		do
			Result := cwel_imalloc_alloc (item, an_integer)
		end
	
	reallocated_buffer (a_pointer: POINTER; an_integer: INTEGER): POINTER is
			-- Pointer to newly allocated buffer of `an_integer' bytes
			-- Allocated buffer contains same information as memory pointed by
			-- `a_pointer' (if `an_integer' is greater than orginal memory block
			-- pointed by `a_pointer' then additional bytes are not initialized).
		require
			was_allocated: allocated (a_pointer)
		do
			Result := cwel_imalloc_realloc (item, a_pointer, an_integer)
		end

	size (a_pointer: POINTER): INTEGER is
			-- Size (in bytes) of previously allocated memory block pointed by
			-- `a_pointer'
		require
			was_allocated: allocated (a_pointer)
		do
			Result := cwel_imalloc_get_size (item, a_pointer)
		end
	
	allocated (a_pointer: POINTER): BOOLEAN is
			-- Was memory block pointed by `a_pointer' allocated with
			-- `allocated_buffer'?
			-- Default result is `True'.
			-- See `allocated_not_reliable' for validity of result.
		local
			an_integer: INTEGER
		do
			an_integer := cwel_imalloc_did_alloc (item, a_pointer)
			Result := (an_integer = 1 or an_integer = -1)
			allocated_not_reliable := an_integer = -1
		end

	allocated_not_reliable: BOOLEAN
			-- Is `allocated' reliable?
			
feature -- Basic Operations
	
	free_buffer (a_pointer: POINTER) is
			-- Free memory block pointed by `a_pointer'.
		require
			was_allocated: allocated (a_pointer)
		do
			cwel_imalloc_free (item, a_pointer)
		end
	
feature {NONE} -- Removal

		destroy_item is
				-- Called by the `dispose' routine to
				-- destroy `item' by calling the
				-- corresponding Windows function and
				-- set `item' to `default_pointer'.
			do
				cwel_imalloc_release (item)
				cwin_couninitialize
				Precursor
			end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		do
			Result := c_size_of_lpmalloc
		end

feature {NONE}-- Externals

	c_size_of_lpmalloc: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"sizeof (LPMALLOC)"
		end

	cwin_coinitialize is
			external
				"C [macro %"wel_imalloc.h%"]"
			alias
				"CoInitialize (NULL)"
			end

	cwin_couninitialize is
			external
				"C | %"wel_imalloc.h%""
			alias
				"CoUninitialize"
			end

	cwin_sh_get_malloc (a_pointer: POINTER) is
			external
				"C [macro <shlobj.h>] (LPMALLOC*)"
			alias
				"SHGetMalloc"
			end

	cwel_imalloc_alloc (a_pointer: POINTER; an_integer: INTEGER): POINTER is
			external
				"C [macro %"wel_imalloc.h%"] (LPMALLOC, ULONG): EIF_POINTER"
			end

	cwel_imalloc_realloc (a_pointer1, a_pointer2: POINTER; an_integer: INTEGER): POINTER is
			external
				"C [macro %"wel_imalloc.h%"] (LPMALLOC, void*, ULONG): EIF_POINTER"
			end

	cwel_imalloc_get_size (a_pointer1, a_pointer2: POINTER): INTEGER is
			external
				"C [macro %"wel_imalloc.h%"] (LPMALLOC, void*): EIF_INTEGER"
			end
	
	cwel_imalloc_did_alloc (a_pointer1, a_pointer2: POINTER): INTEGER is
			external
				"C [macro %"wel_imalloc.h%"] (LPMALLOC, void*): EIF_INTEGER"
			end
	
	cwel_imalloc_free (a_pointer1, a_pointer2: POINTER) is
			external
				"C [macro %"wel_imalloc.h%"] (LPMALLOC, void*)"
			end
	
	cwel_imalloc_release (a_pointer: POINTER) is
			external
				"C [macro %"wel_imalloc.h%"] (LPMALLOC)"
			end
	
end -- class WEL_IMALLOC


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

