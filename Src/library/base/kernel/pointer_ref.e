indexing

	description:
		"References to objects containing a reference to objects %
		%meant to be exchanged with non-Eiffel software.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class POINTER_REF inherit

	HASHABLE
		redefine
			out, is_hashable
		end

feature -- Access

	item: POINTER;
			-- Pointer value

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := (c_hashcode (item)).abs
		end;

feature -- Element change

	set_item (p: POINTER) is
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
		end;

feature -- Operations

	infix "+" (offset: INTEGER): POINTER is
			-- Pointer moved by an offset of `offset' bytes.
		do
			Result := c_offset_pointer (item, offset)
		end

feature -- Memory copy

	memory_copy (a_source: POINTER; a_size: INTEGER) is
			-- Copy `a_size' bytes from `a_source' to `Current'.
			-- `a_source' and `Current' should not overlap.
		require
			valid_size: a_size >= 0
			valid_source: a_source /= default_pointer
		do
			item := c_memcpy (item, a_source, a_size)
		end

	memory_move (a_source: POINTER; a_size: INTEGER) is
			-- Copy `a_size' bytes from `a_source' to `Current'.
			-- `a_source' and `Current' can overlap.
		require
			valid_size: a_size >= 0
			valid_source: a_source /= default_pointer
		do
			item := c_memmove (item, a_source, a_size)
		end

feature -- Output

	out: STRING is
			-- Printable representation of pointer value
		do
			Result := c_outp (item)
		end;

feature {NONE} -- Implementation

	c_outp (p: POINTER): STRING is
			-- Printable representation of pointer value
		external
			"C | %"eif_out.h%""
		end;

	c_hashcode (p: POINTER): INTEGER is
			-- Hash code value of `p'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"conv_pi"
		end;

	c_offset_pointer (p: POINTER; o: INTEGER): POINTER is
			-- Pointer moved by an offset of `o' bytes from `p'.
		external
			"C [macro %"eif_macros.h%"]"
		alias
			"RTPOF"
		end

	c_memcpy (destination, source: POINTER; count: INTEGER): POINTER is
			-- C memcpy
		external
			"C (void *, const void *, size_t): EIF_POINTER | <string.h>"
		alias
			"memcpy"
		end
	
	c_memmove (destination, source: POINTER; count: INTEGER): POINTER is
			-- C memmove
		external
			"C (void *, const void *, size_t): EIF_POINTER | <string.h>"
		alias
			"memmove"
		end
	
end -- class POINTER_REF


--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

