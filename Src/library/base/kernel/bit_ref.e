indexing

	description:
		"Bit sequences of length `count', with binary operations"; 

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

--| Caution:
--|  For implementation reasons, additional operations on BIT types can
--|  only be introduced by ISE

class BIT_REF inherit

	ANY
		redefine
			c_standard_is_equal,
			c_standard_copy,
			c_standard_clone,
			out,
			generator,
			conforms_to
		end

feature -- Access

	item, infix "@" (i: INTEGER): BOOLEAN is
			-- `i'-th bit
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		do
			Result := b_item ($Current, i)
		end;

	generator: STRING is
			-- Name of the current object's generating class.
		do
			!! Result.make (10);
			Result.append ("BIT ");
			Result.append (count.out)
		end;

	conforms_to (other: BIT_REF): BOOLEAN is
			-- Is dynamic type of current object a descendant of
			-- dynamic type of `other'?
		do
			Result := count <= other.count
		end;


feature -- Measurement

	count: INTEGER is
			-- Size of the current bit object
		do
			Result := b_count ($Current)
		end;

feature -- Element change

	put (value: BOOLEAN; i: INTEGER) is
			-- Set the `i'-th bit to 1 if `value' is True, 0 if False
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count;
		do
			b_put ($Current, value, i)
		ensure
			value_inserted: item (i) = value
		end;

feature -- Basic operations

	infix "^" (s: INTEGER): like Current is
			-- Result of shifting bit sequence by `s' positions
			-- (Positive `s' shifts right, negative `s' shifts left;
			-- bits failling off the sequence's bounds are lost.)
		do
			Result := b_shift ($Current, s)
		end;

	infix "#" (s: INTEGER): like Current is
			-- Result of rotating bit sequence by `s' positions
			-- (Positive `s' rotates right, negative `s' rotates left.)
		do
			Result := b_rotate ($Current, s)
		end;

	infix "and" (other: BIT_REF): BIT_REF is
			-- Bit-by-bit boolean conjunction with `other'
		require
			other_exists: other /= Void;
			conformance: other.count <= count
		do
			Result := b_and ($Current, $other)
		end;

	infix "implies" (other: BIT_REF): BIT_REF is
			-- Bit-by-bit boolean implication of `other'
		require
			other_exists: other /= Void;
			conformance: other.count <= count
		do
			Result := b_implies ($Current, $other)
		end;

	infix "or" (other: BIT_REF): BIT_REF is
			-- Bit-by-bi boolean disjunction with `other'
		require
			other_exists: other /= Void;
			conformance: other.count <= count
		do
			Result := b_or ($Current, $other)
		end;

	infix "xor" (other: BIT_REF): BIT_REF is
			-- Bit-by-bit exclusive or with `other'
		require
			other_exists: other /= Void;
			conformance: other.count <= count
		do
			Result := b_xor ($Current, $other)
		end;

	prefix "not": like Current is
			-- Bit-by-bit negation
		do
			Result := b_not ($Current)
		end;

feature -- Output

	out: STRING is
			-- Tagged printable representation.
		do
			Result := c_out($Current);
		end;

feature {NONE} -- Implementation

	b_item (a_bit: POINTER; index: INTEGER): BOOLEAN is
			-- Boolean item at position `i' in `a_bit'
		external
			"C"
		end;

	b_count (a_bit: POINTER): INTEGER is
			-- Size of `a_bit'
		external
			"C"
		end;

	c_standard_is_equal (target, source: POINTER): BOOLEAN is
			-- C external performing standard equality
		external
			"C"
		alias
			"b_equal"
		end;

	b_shift (a_bit: POINTER; s: INTEGER): BIT_REF is
			-- Result of shifting `a_bit' by `s' positions
		external
			"C"
		end;

	b_rotate (a_bit: POINTER; s: INTEGER): BIT_REF is
			-- Result of rotating `a_bit' by `s' positions
		external
			"C"
		end;

	b_and (a_bit1, a_bit2: POINTER): BIT_REF is
			-- Conjunction of `a_bit1' with `a_bit2'
		external
			"C"
		end;

	b_implies (a_bit1, a_bit2: POINTER): BIT_REF is
			-- Implication for `a_bit1' of `a_bit2'
		external
			"C"
		end;

	b_or (a_bit1, a_bit2: POINTER): BIT_REF is
			-- Disjunction of `a_bit1' with `a_bit2'
		external
			"C"
		end;

	b_xor (a_bit1, a_bit2: POINTER): BIT_REF is
			-- Exclusive or of `a_bit1' with `a_bit2'
		external
			"C"
		end;

	b_not (a_bit: POINTER): BIT_REF is
			-- Negation of `a_bit'
		external
			"C"
		end;

	c_standard_copy (source, target: POINTER) is
			-- Copy of bit sequence
		external
			"C"
		alias
			"b_copy"
		end;

	c_standard_clone (other: POINTER): BIT_REF is
			-- New object of same dynamic type as `other'
		external
			"C"
		alias
			"b_clone"
		end;

	b_put (a_bit: POINTER; val: BOOLEAN; index: INTEGER) is
			-- Put `val' in `a_bit' at position `index'.
		external
			"C"
		end;

	c_out (b: POINTER): STRING is
			-- Out representation of Current
		external
			"C"
		alias
			"b_eout"
		end;

end -- class BIT_REF


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
