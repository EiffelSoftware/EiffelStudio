indexing
	description: "Abstract notions of a Windows data structure."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_STRUCTURE

inherit
	WEL_ANY

feature {NONE} -- Initialization

	make is
			-- Allocate `item'
		do
			item := c_calloc (1, structure_size)
			if item = default_pointer then
				-- Memory allocation problem
				c_enomem
			end
			shared := False
		ensure
			not_shared: not shared
		end

feature -- Basic operations

	memory_copy (source_pointer: POINTER; length: INTEGER) is
			-- Copy `length' bytes from `source_pointer' to `item'.
		require
			length_small_enough: length <= structure_size
			length_large_enough: length > 0
			exists: exists
		do
			check
				source_pointer_exists: source_pointer /= default_pointer
			end
			c_memcpy (item, source_pointer, length)
		end

	initialize is
			-- Fill Current with zeros.
		require
			exists: exists
		do
			initialize_with_character ('%U')
		end

	initialize_with_character (a_character: CHARACTER) is
			-- Fill current with `a_character'.
		require
			exists: exists
		do
			c_memset (item, a_character, structure_size)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		deferred
		ensure
			positive_result: Result > 0
		end

feature {NONE} -- Removal

	destroy_item is
			-- Free `item'
		do
			if item /= default_pointer then
				c_free (item)
				item := default_pointer
			end
		end

feature {NONE} -- Externals

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

	c_memset (destination: POINTER; filling_char: CHARACTER; count: INTEGER) is
			-- C function 
		external
			"C (void *, int, size_t) | <memory.h>"
		alias
			"memset"
		end

end -- class WEL_STRUCTURE

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

