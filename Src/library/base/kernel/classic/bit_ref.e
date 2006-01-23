indexing

	description: "Bit sequences of length `count', with binary operations"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

--| Caution:
--| For implementation reasons, additional operations on BIT types can
--| only be introduced by ISE

class BIT_REF inherit

	ANY
		redefine
			out,
			generator,
			conforms_to
		end
	
convert
	to_reference: {BIT_REF, ANY}
	
feature -- Access

	item alias "[]", infix "@" (i: INTEGER): BOOLEAN assign put is
			-- `i'-th bit
		require
			index_large_enough: i >= 1
			index_small_enough: i <= count
		do
			Result := b_item ($Current, i)
		end

	generator: STRING is
			-- Name of the current object's generating class.
		do
			create Result.make (10)
			Result.append ("BIT ")
			Result.append_integer (count)
		end

	conforms_to (other: ANY): BOOLEAN is
			-- Is dynamic type of current object a descendant of
			-- dynamic type of `other'?
		local
			b: BIT_REF
		do
			b ?= other
			if b /= Void then
				Result := count <= b.count
			end
		end

feature -- Measurement

	count: INTEGER is
			-- Size of the current bit object
		do
			Result := b_count ($Current)
		end

feature -- Element change

	put (value: BOOLEAN; i: INTEGER) is
			-- Set the `i'-th bit to 1 if `value' is True, 0 if False
		require
			index_large_enough: i >= 1
			index_small_enough: i <= count
		do
			b_put ($Current, value, i)
		ensure
			value_inserted: item (i) = value
		end

feature -- Basic operations

	infix "^" (s: INTEGER): like Current is
			-- Result of shifting bit sequence by `s' positions
			-- (Positive `s' shifts right, negative `s' shifts left;
			-- bits falling off the sequence's bounds are lost.)
		do
			Result := b_shift ($Current, s)
		end

	infix "#" (s: INTEGER): like Current is
			-- Result of rotating bit sequence by `s' positions
			-- (Positive `s' rotates right, negative `s' rotates left.)
		do
			Result := b_rotate ($Current, s)
		end

	infix "and" (other: BIT_REF): like Current is
			-- Bit-by-bit boolean conjunction with `other'
		require
			other_exists: other /= Void
			conformance: other.count <= count
		do
			Result := b_and ($Current, $other)
		end

	infix "implies" (other: BIT_REF): like Current is
			-- Bit-by-bit boolean implication of `other'
		require
			other_exists: other /= Void
			conformance: other.count <= count
		do
			Result := b_implies ($Current, $other)
		end

	infix "or", infix "|" (other: BIT_REF): like Current is
			-- Bit-by-bit boolean disjunction with `other'
		require
			other_exists: other /= Void
			conformance: other.count <= count
		do
			Result := b_or ($Current, $other)
		end

	infix "xor" (other: BIT_REF): like Current is
			-- Bit-by-bit exclusive or with `other'
		require
			other_exists: other /= Void
			conformance: other.count <= count
		do
			Result := b_xor ($Current, $other)
		end

	prefix "not": like Current is
			-- Bit-by-bit negation
		do
			Result := b_not ($Current)
		end

feature -- Output

	out: STRING is
			-- Tagged printable representation.
		do
			Result := c_out ($Current)
		end

feature -- Conversion

	to_reference: BIT_REF is
			-- Associated reference of Current.
		local
			l_out: ANY
		do
			l_out := out.to_c
			Result := b_makebit_from ($l_out, count)
		end
		
feature {NONE} -- Implementation

	b_item (a_bit: POINTER; index: INTEGER): BOOLEAN is
			-- Boolean item at position `i' in `a_bit'
		external
			"C signature (EIF_REFERENCE, EIF_INTEGER): EIF_BOOLEAN use %"eif_bits.h%""
		end

	b_count (a_bit: POINTER): INTEGER is
			-- Size of `a_bit'
		external
			"C signature (EIF_REFERENCE): EIF_INTEGER use %"eif_bits.h%""
		end

	b_shift (a_bit: POINTER; s: INTEGER): like Current is
			-- Result of shifting `a_bit' by `s' positions
		external
			"C signature (EIF_REFERENCE, EIF_INTEGER): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_rotate (a_bit: POINTER; s: INTEGER): like Current is
			-- Result of rotating `a_bit' by `s' positions
		external
			"C signature (EIF_REFERENCE, EIF_INTEGER): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_and (a_bit1, a_bit2: POINTER): like Current is
			-- Conjunction of `a_bit1' with `a_bit2'
		external
			"C signature (EIF_REFERENCE, EIF_REFERENCE): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_implies (a_bit1, a_bit2: POINTER): like Current is
			-- Implication for `a_bit1' of `a_bit2'
		external
			"C signature (EIF_REFERENCE, EIF_REFERENCE): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_or (a_bit1, a_bit2: POINTER): like Current is
			-- Disjunction of `a_bit1' with `a_bit2'
		external
			"C signature (EIF_REFERENCE, EIF_REFERENCE): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_xor (a_bit1, a_bit2: POINTER): like Current is
			-- Exclusive or of `a_bit1' with `a_bit2'
		external
			"C signature (EIF_REFERENCE, EIF_REFERENCE): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_not (a_bit: POINTER): like Current is
			-- Negation of `a_bit'
		external
			"C signature (EIF_REFERENCE): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_put (a_bit: POINTER; val: BOOLEAN; index: INTEGER) is
			-- Put `val' in `a_bit' at position `index'.
		external
			"C signature (EIF_REFERENCE, char, int) use %"eif_bits.h%""
		end

	c_out (b: POINTER): STRING is
			-- Out representation of Current
		external
			"C signature (EIF_REFERENCE): EIF_REFERENCE use %"eif_bits.h%""
		alias
			"b_eout"
		end

	b_makebit_from (p: POINTER; n: INTEGER): BIT_REF is
			-- From Eiffel object `p' generate a new BIT_REF instance of count `n'
		external
			"C signature (EIF_REFERENCE, EIF_INTEGER): EIF_REFERENCE use %"eif_bits.h%""
		alias
			"RTMB"
		end
		
invariant
	valid_count: count > 0
	
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







end -- class BIT_REF


