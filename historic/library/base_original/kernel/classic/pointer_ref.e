note

	description: "[
		References to objects containing reference to object
		meant to be exchanged with non-Eiffel software.
		]"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class POINTER_REF
inherit
	HASHABLE
		redefine
			out, is_equal, is_hashable
		end
		
	REFACTORING_HELPER
		redefine
			out, is_equal
		end
		
feature -- Access

	item: POINTER
			-- Pointer value

	hash_code: INTEGER
			-- Hash code value
		do
			Result := item.hash_code
		end

feature -- Element change

	frozen set_item (p: POINTER)
			-- Make `p' the `item' value.
		do
			item := p
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := other.item = item
		end

feature -- Status report

	is_hashable: BOOLEAN
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item /= default_pointer
		end

feature -- Operations

	infix "+" (offset: INTEGER): POINTER
			-- Pointer moved by an offset of `offset' bytes.
		do
			Result := c_offset_pointer (item, offset)
		end

feature {NONE} -- Initialization

	make_from_reference (v: POINTER_REF)
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: v /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: POINTER_REF
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

	frozen to_integer_32: INTEGER
			-- Convert `item' into an INTEGER_32 value.
		require
--			not_too_small: item >= feature {INTEGER}.Min_value
--			not_too_big: item <= feature {INTEGER}.Max_value
		do
			fixme (once "Do not forget to add proper precondition to ensure we can convert pointer %
				%value into an INTEGER")
			fixme (once "Change return type to INTEGER_32")
			Result := item.to_integer_32
		end

feature -- Memory copy

	memory_copy (a_source: POINTER; a_size: INTEGER)
			-- Copy `a_size' bytes from `a_source' to `Current'.
			-- `a_source' and `Current' should not overlap.
		require
			valid_size: a_size >= 0
			valid_source: a_source /= default_pointer
		do
			c_memcpy (item, a_source, a_size)
		end

	memory_move (a_source: POINTER; a_size: INTEGER)
			-- Copy `a_size' bytes from `a_source' to `Current'.
			-- `a_source' and `Current' can overlap.
		require
			valid_size: a_size >= 0
			valid_source: a_source /= default_pointer
		do
			c_memmove (item, a_source, a_size)
		end

	memory_set (val, n: INTEGER)
			-- Fill first `n' bytes of the memory pointed by `Current'
			-- with constant `val'.
		require
			valid_val: val >= 0
			valid_n: n >= 0
		do
			c_memset (item, val, n)	
		end

feature -- Allocation/free

	memory_alloc (a_size: INTEGER): POINTER
			-- Allocated `size' bytes using `malloc'.
		require
			valid_size: a_size > 0
		do
			Result := c_malloc (a_size)
		end

	memory_calloc (a_count, a_element_size: INTEGER): POINTER
			-- Allocate `a_count' elements of size `a_element_size' bytes using `calloc.
		require
			valid_element_count: a_count > 0
			valid_element_size: a_element_size > 0
		do
			Result := c_calloc (a_count, a_element_size)
		end
		
	memory_realloc (a_size: INTEGER): POINTER
			-- Realloc `Current'.
		require
			valid_size: a_size >= 0
		do
			Result := c_realloc (item, a_size)
		end

	memory_free
			-- Free allocated memory with `malloc'.
		do
			c_free (item)
			item := default_pointer
		end

feature -- Comparison

	memory_compare (other: POINTER; a_size: INTEGER): BOOLEAN
			-- True if `Current' and `other' are identical on `a_size' bytes.
		require
			valid_size: a_size > 0
			valid_other: other /= default_pointer
		do
			Result := c_memcmp (item, other, a_size) = 0
		end

feature -- Output

	out: STRING
			-- Printable representation of pointer value
		do
			Result := c_outp (item)
		end

feature {NONE} -- Implementation

	c_outp (p: POINTER): STRING
			-- Printable representation of pointer value
		external
			"C | %"eif_out.h%""
		end

	c_offset_pointer (p: POINTER; o: INTEGER): POINTER
			-- Pointer moved by an offset of `o' bytes from `p'.
		external
			"C [macro %"eif_macros.h%"]"
		alias
			"RTPOF"
		end

	c_memcpy (destination, source: POINTER; count: INTEGER)
			-- C memcpy
		external
			"C (void *, const void *, size_t) | <string.h>"
		alias
			"memcpy"
		end
	
	c_memmove (destination, source: POINTER; count: INTEGER)
			-- C memmove
		external
			"C (void *, const void *, size_t) | <string.h>"
		alias
			"memmove"
		end

	c_memset (source: POINTER; val: INTEGER; count: INTEGER)
			-- C memset
		external
			"C (void *, int, size_t) | <string.h>"
		alias
			"memset"
		end

	c_memcmp (source, other: POINTER; count: INTEGER): INTEGER
			-- C memcmp
		external
			"C (void *, void *, size_t): EIF_INTEGER | <string.h>"
		alias
			"memcmp"
		end

	c_malloc (size: INTEGER): POINTER
			-- C malloc
		external
			"C (size_t): EIF_POINTER | <stdlib.h>"
		alias
			"malloc"
		end

	c_calloc (nmemb, size: INTEGER): POINTER
			-- C calloc
		external
			"C (size_t, size_t): EIF_POINTER | <stdlib.h>"
		alias
			"calloc"
		end

	c_realloc (source: POINTER; size: INTEGER): POINTER
			-- C realloc
		external
			"C (void *, size_t): EIF_POINTER | <stdlib.h>"
		alias
			"realloc"
		end

	c_free (p: POINTER)
			-- C free
		external
			"C (void *) | <stdlib.h>"
		alias
			"free"
		end

note
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



