indexing

	description:
		"References to objects containing an integer value";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class INTEGER_REF inherit

	NUMERIC
		rename
			infix "/" as infix "//"
		redefine
			out, is_equal
		end;

	COMPARABLE
		redefine
			out, three_way_comparison, is_equal
		end;

	HASHABLE
		redefine
			is_hashable, out, is_equal
		end

feature -- Access

	item: INTEGER;
			-- Integer value

	hash_code: INTEGER is
			-- Hash code value
		do
			if item >= 0 then
				Result := item
			else
					-- The following instruction in case
					-- we hit the minumum negative number,
					-- which could yield a negative result
					-- when negated.
				Result := - (item + 1)
			end
		end;

	sign: INTEGER is
			-- Sign value (0, -1 or 1)
		do
			if item > 0 then
				Result := 1
			elseif item < 0 then
				Result := -1
			end
		ensure
			three_way: Result = three_way_comparison (zero)
		end;

	one: like Current is
			-- Neutral element for "*" and "/"
		do
			create Result
			Result.set_item (1)
		end;

	zero: like Current is
			-- Neutral element for "+" and "-"
		do
			create Result
			Result.set_item (0)
		end;

	ascii_char: CHARACTER is
			-- Returns corresponding ASCII character to `item' value.
		do
			Result := c_ascii_char (item) 
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current integer less than `other'?
		do
			Result := item < other.item
		end;

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := other.item = item
		end;

	three_way_comparison (other: INTEGER_REF): INTEGER is
			-- If current object equal to `other', 0;
			-- if smaller, -1; if greater, 1
		do
			if item < other.item then
				Result := -1
			elseif other.item < item then
				Result := 1
			end
		end;

feature -- Element change

	set_item (i: INTEGER) is
			-- Make `i' the `item' value.
		do
			item := i
		end;

feature -- Status report

	divisible (other: INTEGER_REF): BOOLEAN is
			-- May current object be divided by `other'?
		do
			Result := other.item /= 0
		ensure then
			value: Result = (other.item /= 0)
		end;

	exponentiable (other: NUMERIC): BOOLEAN is
			-- May current object be elevated to the power `other'?
		local
			integer_value: INTEGER_REF;
			double_value: DOUBLE_REF;
			real_value: REAL_REF
		do
			integer_value ?= other;
			real_value ?= other;
			double_value ?= other;
			if integer_value /= Void then
				Result := integer_value.item >= 0 or item /= 0
			elseif real_value /= Void then
				Result := real_value.item >= 0.0 or item /= 0
			elseif double_value /= Void then
				Result := double_value.item >= 0.0 or item /= 0
			end
		ensure then
			safe_values: ((other.conforms_to (0) and item /= 0) or
				(other.conforms_to (0.0) and item > 0)) implies Result
		end;

	is_hashable: BOOLEAN is
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item /= 0
		end;

feature -- Conversion

	to_boolean: BOOLEAN is
			-- True if not `zero'.
		do
			Result := item /= 0
		end

feature -- Basic operations

	abs: INTEGER is
			-- Absolute value
		do
			Result := abs_ref.item
		ensure
			non_negative: Result >= 0;
			same_absolute_value: (Result = item) or (Result = -item)
		end;

	infix "+" (other: like Current): like Current is
			-- Sum with `other'
		do
			!! Result;
			Result.set_item (item + other.item)
		end;

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		do
			!! Result;
			Result.set_item (item - other.item)
		end;

	infix "*" (other: like Current): like Current is
			-- Product by `other'
		do
			!! Result;
			Result.set_item (item * other.item)
		end;

	infix "/" (other: like Current): DOUBLE_REF is
			-- Division by `other'
		require
			other_exists: other /= Void;
			good_divisor: divisible (other)
		do
			!! Result;
			Result.set_item (item / other.item)
		ensure
			result_exists: Result /= Void
		end;

	prefix "+": like Current is
			-- Unary plus
		do
			!! Result;
			Result.set_item (+ item)
		end;

	prefix "-": like Current is
			-- Unary minus
		do
			!! Result;
			Result.set_item (- item)
		end;


	infix "//" (other: like Current): like Current is
			-- Integer division of Current by `other'
		do
			!! Result;
			Result.set_item (item // other.item)
		end;

	infix "\\" (other: like Current): like Current is
			-- Remainder of the integer division of Current by `other'
		require
			other_exists: other /= Void;
			good_divisor: divisible (other)
		do
			!! Result;
			Result.set_item (item \\ other.item)
		ensure
			result_exists: Result /= Void
		end;

	infix "^" (other: NUMERIC): DOUBLE_REF is
			-- Integer power of Current by `other'
		local
			integer_value: INTEGER_REF;
			real_value: REAL_REF;
			double_value: DOUBLE_REF
		do
			!! Result;
			integer_value ?= other;
			real_value ?= other;
			double_value ?= other;
			if integer_value /= Void then
				Result.set_item (item ^ integer_value.item)
			elseif real_value /= Void then
				Result.set_item (item ^ real_value.item)
			elseif double_value /= Void then
				Result.set_item (item ^ double_value.item)
			end
		end;

	infix "|..|" (other: INTEGER): INTEGER_INTERVAL is
			-- Interval from current element to `other'
			-- (empty if `other' less than current integer)
		do
			create Result.make (item, other)
		end

feature -- Bit operations

	bit_and (i: INTEGER): INTEGER is
			-- Bitwise and between Current' and `i'.
		local
			n, exp, src, res: INTEGER
		do
			from
				n := 0
				exp := 1
				src := i.item
			until
				n = 32
			loop
				if (src // exp) \\ 2 = 1 and then (item // exp) \\ 2 = 1 then
					res := res + exp
				end
				exp := exp * 2
				n := n + 1
			end
			Result := res
		end

feature -- Output

	out: STRING is
			-- Printable representation of integer value
		do
			Result := c_outi (item)
		end;


feature {NONE} -- Implementation

	c_outi (i: INTEGER): STRING is
			-- Printable representation of integer value
		external
			"C | %"eif_out.h%""
		end;

	c_ascii_char (code: INTEGER) : CHARACTER is
			-- Character associated to integer value
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"chconv"
		end

	abs_ref: INTEGER_REF is
			-- Absolute value
		do
			if item >= 0 then
				Result := Current
			else
				Result := - Current
			end
		ensure
			result_exists: Result /= Void;
			same_absolute_value: equal (Result, Current) or equal (Result, - Current)
		end;

invariant

	sign_times_abs: sign * abs = item

end -- class INTEGER_REF


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

