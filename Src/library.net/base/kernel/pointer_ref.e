indexing

	description: "[
		References to objects containing reference to object
		meant to be exchanged with non-Eiffel software.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class POINTER_REF inherit

	HASHABLE
		redefine
			out, is_hashable
		end

feature -- Access

	item: POINTER
			-- Pointer value

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := item.to_integer_32.abs
		end

feature -- Element change

	frozen set_item (p: POINTER) is
			-- Make `p' the `item' value.
		do
			item := p
		end

feature -- Status report

	is_hashable: BOOLEAN is
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item /= default_pointer
		end

feature -- Operations

	infix "+" (offset: INTEGER): like Current is
			-- Pointer moved by an offset of `offset' bytes.
		do
			create Result
			Result.set_item (c_offset_pointer (item, offset))
		end

feature -- Memory copy

	memory_copy (a_source: POINTER; a_size: INTEGER) is
			-- Copy `a_size' bytes from `a_source' to `Current'.
			-- `a_source' and `Current' should not overlap.
		require
			valid_size: a_size >= 0
			valid_source: a_source /= default_pointer
		do
			c_memcpy (item, a_source, a_size)
		end

	memory_move (a_source: POINTER; a_size: INTEGER) is
			-- Copy `a_size' bytes from `a_source' to `Current'.
			-- `a_source' and `Current' can overlap.
		require
			valid_size: a_size >= 0
			valid_source: a_source /= default_pointer
		do
			c_memmove (item, a_source, a_size)
		end

	memory_set (val, n: INTEGER) is
			-- Fill first `n' bytes of the memory pointed by `Current'
			-- with constant `val'.
		require
			valid_val: val >= 0
			valid_n: n >= 0
		do
			c_memset (item, val, n)	
		end

feature -- Allocation/free

	memory_alloc (a_size: INTEGER): POINTER is
			-- Allocated `size' bytes using `malloc'.
		require
			valid_size: a_size >= 0
		do
			Result := c_malloc (a_size)
		end

	memory_free is
			-- Free allocated memory with `malloc'.
		do
			c_free (item)
			item := default_pointer
		end

feature -- Output

	out: STRING is
			-- Printable representation of pointer value
		do
			create Result.make_from_cil (item.to_string)
		end

feature -- Conversion

	to_integer_32: INTEGER is
			-- Convert `p' to an integer.
		do
			Result := item.to_integer_32
		end
	
	to_integer_64: INTEGER_64 is
			-- Convert `p' to an INTEGER_64.
		do
			Result := item.to_integer_64
		end

feature {NONE} -- Implementation

	c_offset_pointer (p: POINTER; o: INTEGER): POINTER is
			-- Pointer moved by an offset of `o' bytes from `p'.
		external
			"C [macro %"eif_macros.h%"]"
		alias
			"RTPOF"
		end

	c_memcpy (destination, source: POINTER; count: INTEGER) is
			-- C memcpy
		external
			"C (void *, const void *, size_t) | <string.h>"
		alias
			"memcpy"
		end
	
	c_memmove (destination, source: POINTER; count: INTEGER) is
			-- C memmove
		external
			"C (void *, const void *, size_t) | <string.h>"
		alias
			"memmove"
		end

	c_memset (source: POINTER; val: INTEGER; count: INTEGER) is
			-- C memset
		external
			"C (void *, int, size_t) | <string.h>"
		alias
			"memset"
		end

	c_malloc (size: INTEGER): POINTER is
			-- C malloc
		external
			"C (size_t): EIF_POINTER | <stdlib.h>"
		alias
			"malloc"
		end

	c_free (p: POINTER) is
			-- C malloc
		external
			"C (void *) | <stdlib.h>"
		alias
			"free"
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class POINTER_REF



