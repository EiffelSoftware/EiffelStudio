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
		do
			check
				source_pointer_exists: source_pointer /= default_pointer
			end
			c_memcpy (item, source_pointer, length)
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
			c_free (item)
			item := default_pointer
		end

feature {NONE} -- Externals

	c_calloc (a_num, a_size: INTEGER): POINTER is
			-- C calloc
		external
			"C [macro <malloc.h>] (size_t, size_t): EIF_POINTER"
		alias
			"calloc"
		end

	c_free (ptr: POINTER) is
			-- C free
		external
			"C [macro <malloc.h>] (void *)"
		alias
			"free"
		end

	c_memcpy (destination, source: POINTER; count: INTEGER) is
			-- C memcpy
		external
			"C [macro <memory.h>] (void *, void *, size_t)"
		alias
			"memcpy"
		end

	c_enomem is
			-- Eiffel run-time function to raise an
			-- "Out of memory" exception.
		external
			"C"
		alias
			"enomem"
		end

invariant
	exists: exists

end -- class WEL_STRUCTURE

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
