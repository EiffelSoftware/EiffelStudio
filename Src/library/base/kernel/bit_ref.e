--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Bit sequence of length 'count'
-- Enable binary operations 

indexing

	date: "$Date$";
	revision: "$Revision$"

--| Beware:
--|  For implementation reasons, additional operations on BIT types can
--|  only be introduced by I.S.E.

class BIT_REF

inherit

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
			-- I_th bit
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		do
			Result := b_item ($Current, i)
		end;

	generator: STRING is
			-- Name of the current object's generating class.
		do
			!!Result.make (10);
			Result.append ("BIT ");
			Result.append (count.out)
		end;

	conforms_to (other: BIT_REF): BOOLEAN is
			-- Is dynamic type of current object a descendant of
			-- dynamic type of `other' ?
		do
			Result := count <= other.count
		end;


feature -- Measurement


	count: INTEGER is
			-- Size of the current bit object
		do
			Result := b_count ($Current)
		end;

feature -- Basic operation


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
			-- Conjunction with `other'
		require
			other_exists: other /= Void;
			conformance: other.count <= count
		do
			Result := b_and ($Current, $other)
		end;

	infix "implies" (other: BIT_REF): BIT_REF is
			-- Implication of `other'
		require
			other_exists: other /= Void;
			conformance: other.count <= count
		do
			Result := b_implies ($Current, $other)
		end;

	infix "or" (other: BIT_REF): BIT_REF is
			-- Disjunction with `other'
		require
			other_exists: other /= Void;
			conformance: other.count <= count
		do
			Result := b_or ($Current, $other)
		end;

	infix "xor" (other: BIT_REF): BIT_REF is
			-- Exclusive or with `other'
		require
			other_exists: other /= Void;
			conformance: other.count <= count
		do
			Result := b_xor ($Current, $other)
		end;

	prefix "not": like Current is
			-- Negation
		do
			Result := b_not ($Current)
		end;


feature -- Modification & Insertion

	put (value: BOOLEAN; i: INTEGER) is
			-- Set the i_th bit to 1 if `value' is True, 0 if False
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count;
		do
			b_put ($Current, value, i)
		ensure
			value_inserted: item (i) = value
		end;

feature -- Ouput

	out: STRING is
			-- Tagged printable representation of 'Current'.
		do
			Result := c_out($Current);
		end;

feature  {NONE} -- External, Access

	b_item (a_bit: BIT_REF; index: INTEGER): BOOLEAN is
			-- Boolean item at position `i' in `a_bit'
		external
			"C"
		end;

feature  {NONE} -- External, Measurement

	b_count (a_bit: BIT_REF): INTEGER is
			-- Size of `a_bit'
		external
			"C"
		end;

feature  {NONE} -- External, Comparison
		
	c_standard_is_equal (target, source: BIT_REF): BOOLEAN is
			-- C external performing standard equality
		external
			"C"
		alias
			"b_equal"
		end;

feature  {NONE} -- External, Basic operation

	b_shift (a_bit: BIT_REF; s: INTEGER): BIT_REF is
			-- Result of shifting `a_bit' by `s' positions
		external
			"C"
		end;

	b_rotate (a_bit: BIT_REF; s: INTEGER): BIT_REF is
			-- Result of rotating `a_bit' by `s' positions
		external
			"C"
		end;

	b_and (a_bit1, a_bit2: BIT_REF): BIT_REF is
			-- Conjunction of `a_bit1' with `a_bit2'
		external
			"C"
		end;

	b_implies (a_bit1, a_bit2: BIT_REF): BIT_REF is
			-- Implication for `a_bit1' of `a_bit2'
		external
			"C"
		end;

	b_or (a_bit1, a_bit2: BIT_REF): BIT_REF is
			-- Disjunction of `a_bit1' with `a_bit2'
		external
			"C"
		end;

	b_xor (a_bit1, a_bit2: BIT_REF): BIT_REF is
			-- Exclusive or of `a_bit1' with `a_bit2'
		external
			"C"
		end;

	b_not (a_bit: BIT_REF): BIT_REF is
			-- Negation of `a_bit'
		external
			"C"
		end;


feature  {NONE} -- External, Duplication

	c_standard_copy (source, target: ANY) is
			-- C external performing standard copy
		external
			"C"
		alias
			"b_copy"
		end;

	c_standard_clone (other: ANY): like other is
			-- New object of same dynamic type as `other'
		external
			"C"
		alias
			"b_clone"
		end;


feature  {NONE} -- External, Modification & Insertion

	b_put (a_bit: BIT_REF; val: BOOLEAN; index: INTEGER) is
			-- Put `val' in `a_bit' at positino `index'.
		external
			"C"
		end;


feature  {NONE} -- External, Ouput

	c_out (b: BIT_REF): STRING is
			-- Out representation of Current
		external
			"C"
		alias
			"b_eout"
		end;

end -- class BIT_REF
