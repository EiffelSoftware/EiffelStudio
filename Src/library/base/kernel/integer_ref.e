indexing

	description:
		"References to objects containing an integer value";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class INTEGER_REF inherit

	NUMERIC
		rename
			infix "/" as infix "//",
			one as one_ref,
			zero as zero_ref
		redefine
			out, is_equal
		end;

	COMPARABLE
		rename
			max as max_ref,
			min as min_ref
		export
			{NONE} max_ref, min_ref
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
			if item > 0 then
				Result := item
			else
				Result := - item
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

	one: INTEGER is
			-- Neutral element for "*" and "/"
		do
			Result := 1
		ensure
			value: Result = 1
		end;

	zero: INTEGER is
			-- Neutral element for "+" and "-"
		do
			Result := 0
		ensure
			value: Result = 0
		end;

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

	max (other: INTEGER_REF): INTEGER is
			-- The greater of current object and `other'
		require
			other_exists: other /= Void
		do
			Result := max_ref (other).item
		end;

	min (other: INTEGER_REF): INTEGER is
			-- The smaller of current object and `other'
		require
			other_exists: other /= Void
		do
			Result := min_ref (other).item
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
			"C"
		end;

	one_ref: INTEGER_REF is
			-- Neutral element for "*" and "/"
		do
			!! Result;
			Result.set_item (one)
		end;

	zero_ref: INTEGER_REF is
			-- Neutral element for "+" and "-"
		do
			!! Result;
			Result.set_item (zero)
		end;

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
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
