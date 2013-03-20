note
	description: "Bit sequences of length `count', with binary operations"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2004, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class BIT_REF inherit

	ANY
		redefine
			out,
			generator,
			conforms_to
		end

feature -- Access

	item alias "[]", at alias "@" (i: INTEGER): BOOLEAN assign put
			-- `i'-th bit
		require
			index_large_enough: i >= 1
			index_small_enough: i <= count
		do
			Result := b_item ($Current, i)
		end

	generator: STRING
			-- Name of the current object's generating class.
		do
			create Result.make (10)
			Result.append ("BIT ")
			Result.append_integer (count)
		end

	conforms_to (other: ANY): BOOLEAN
			-- Is dynamic type of current object a descendant of
			-- dynamic type of `other'?
		do
			if attached {BIT_REF} other as b then
				Result := count <= b.count
			end
		end

feature -- Measurement

	count: INTEGER
			-- Size of the current bit object
		do
			Result := b_count ($Current)
		end

feature -- Element change

	put (value: BOOLEAN; i: INTEGER)
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

	shift alias "^" (s: INTEGER): like Current
			-- Result of shifting bit sequence by `s' positions
			-- (Positive `s' shifts right, negative `s' shifts left;
			-- bits falling off the sequence's bounds are lost.)
		do
			Result := b_shift ($Current, s)
		end

	rotate alias "#" (s: INTEGER): like Current
			-- Result of rotating bit sequence by `s' positions
			-- (Positive `s' rotates right, negative `s' rotates left.)
		do
			Result := b_rotate ($Current, s)
		end

	conjuncted alias "and", bit_and alias "&" (other: BIT_REF): like Current
			-- Bit-by-bit boolean conjunction with `other'
		require
			other_exists: other /= Void
			conformance: other.count <= count
		do
			Result := b_and ($Current, $other)
		end

	implication alias "implies" (other: BIT_REF): like Current
			-- Bit-by-bit boolean implication of `other'
		require
			other_exists: other /= Void
			conformance: other.count <= count
		do
			Result := b_implies ($Current, $other)
		end

	disjuncted alias "or", bit_or alias "|" (other: BIT_REF): like Current
			-- Bit-by-bit boolean disjunction with `other'
		require
			other_exists: other /= Void
			conformance: other.count <= count
		do
			Result := b_or ($Current, $other)
		end

	disjuncted_exclusive alias "xor" (other: BIT_REF): like Current
			-- Bit-by-bit exclusive or with `other'
		require
			other_exists: other /= Void
			conformance: other.count <= count
		do
			Result := b_xor ($Current, $other)
		end

	negated alias "not": like Current
			-- Bit-by-bit negation
		do
			Result := b_not ($Current)
		end

feature -- Output

	out: STRING
			-- Tagged printable representation.
		do
			Result := c_out ($Current)
		end

feature -- Conversion

	to_reference: BIT_REF
			-- Associated reference of Current.
		local
			l_out: ANY
		do
			l_out := out.to_c
			Result := b_makebit_from ($l_out, count)
		end

feature {NONE} -- Implementation

	b_item (a_bit: POINTER; index: INTEGER): BOOLEAN
			-- Boolean item at position `i' in `a_bit'
		external
			"C signature (EIF_REFERENCE, EIF_INTEGER): EIF_BOOLEAN use %"eif_bits.h%""
		end

	b_count (a_bit: POINTER): INTEGER
			-- Size of `a_bit'
		external
			"C signature (EIF_REFERENCE): EIF_INTEGER use %"eif_bits.h%""
		end

	b_shift (a_bit: POINTER; s: INTEGER): like Current
			-- Result of shifting `a_bit' by `s' positions
		external
			"C signature (EIF_REFERENCE, EIF_INTEGER): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_rotate (a_bit: POINTER; s: INTEGER): like Current
			-- Result of rotating `a_bit' by `s' positions
		external
			"C signature (EIF_REFERENCE, EIF_INTEGER): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_and (a_bit1, a_bit2: POINTER): like Current
			-- Conjunction of `a_bit1' with `a_bit2'
		external
			"C signature (EIF_REFERENCE, EIF_REFERENCE): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_implies (a_bit1, a_bit2: POINTER): like Current
			-- Implication for `a_bit1' of `a_bit2'
		external
			"C signature (EIF_REFERENCE, EIF_REFERENCE): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_or (a_bit1, a_bit2: POINTER): like Current
			-- Disjunction of `a_bit1' with `a_bit2'
		external
			"C signature (EIF_REFERENCE, EIF_REFERENCE): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_xor (a_bit1, a_bit2: POINTER): like Current
			-- Exclusive or of `a_bit1' with `a_bit2'
		external
			"C signature (EIF_REFERENCE, EIF_REFERENCE): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_not (a_bit: POINTER): like Current
			-- Negation of `a_bit'
		external
			"C signature (EIF_REFERENCE): EIF_REFERENCE use %"eif_bits.h%""
		end

	b_put (a_bit: POINTER; val: BOOLEAN; index: INTEGER)
			-- Put `val' in `a_bit' at position `index'.
		external
			"C signature (EIF_REFERENCE, char, int) use %"eif_bits.h%""
		end

	c_out (b: POINTER): STRING
			-- Out representation of Current
		external
			"C signature (EIF_REFERENCE): EIF_REFERENCE use %"eif_bits.h%""
		alias
			"b_eout"
		end

	b_makebit_from (p: POINTER; n: INTEGER): BIT_REF
			-- From Eiffel object `p' generate a new BIT_REF instance of count `n'
		external
			"C signature (EIF_REFERENCE, EIF_INTEGER): EIF_REFERENCE use %"eif_bits.h%""
		alias
			"RTMB"
		end

invariant
	valid_count: count > 0

end
