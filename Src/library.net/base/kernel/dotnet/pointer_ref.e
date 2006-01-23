indexing

	description: "[
		References to objects containing reference to object
		meant to be exchanged with non-Eiffel software.
		]"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class POINTER_REF inherit

	HASHABLE
		redefine
			is_hashable, out
		end

feature -- Access

	item: POINTER
			-- Pointer value

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := item.to_integer_32.hash_code
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

feature {NONE} -- Initialization

	make_from_reference (v: POINTER_REF) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: v /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: POINTER_REF is
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
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
			valid_size: a_size > 0
		do
			Result := c_malloc (a_size)
		end

	memory_calloc (a_count, a_element_size: INTEGER): POINTER is
			-- Allocate `a_count' elements of size `a_element_size' bytes using `calloc.
		require
			valid_element_count: a_count > 0
			valid_element_size: a_element_size > 0
		do
			Result := c_calloc (a_count, a_element_size)
		end

	memory_realloc (a_size: INTEGER): POINTER is
			-- Realloc `Current'.
		require
			valid_size: a_size >= 0
		do
			Result := c_realloc (item, a_size)
		end

	memory_free is
			-- Free allocated memory with `malloc'.
		do
			c_free (item)
			item := default_pointer
		end

feature -- Comparison

	memory_compare (other: POINTER; a_size: INTEGER): BOOLEAN is
			-- True if `Current' and `other' are identical on `a_size' bytes.
		require
			valid_size: a_size > 0
			valid_other: other /= default_pointer
		do
			Result := c_memcmp (item, other, a_size) = 0
		end

feature -- Output

	out: STRING is
			-- Printable representation of pointer value
		local
			l_obj: SYSTEM_OBJECT
		do
			l_obj := item
			create Result.make_from_cil (l_obj.to_string)
			Result.prepend ("0x")
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

	c_memcmp (source, other: POINTER; count: INTEGER): INTEGER is
			-- C memcmp
		external
			"C (void *, void *, size_t): EIF_INTEGER | <string.h>"
		alias
			"memcmp"
		end

	c_malloc (size: INTEGER): POINTER is
			-- C malloc
		external
			"C (size_t): EIF_POINTER | <stdlib.h>"
		alias
			"malloc"
		end

	c_calloc (nmemb, size: INTEGER): POINTER is
			-- C calloc
		external
			"C (size_t, size_t): EIF_POINTER | <stdlib.h>"
		alias
			"calloc"
		end

	c_realloc (source: POINTER; size: INTEGER): POINTER is
			-- C realloc
		external
			"C (void *, size_t): EIF_POINTER | <stdlib.h>"
		alias
			"realloc"
		end

	c_free (p: POINTER) is
			-- C free
		external
			"C (void *) | <stdlib.h>"
		alias
			"free"
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class POINTER_REF



