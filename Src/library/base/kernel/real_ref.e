indexing

	description:
		"References to objects containing a real value";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class REAL_REF inherit

	NUMERIC
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

	item: REAL;
			-- Numeric real value

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := abs_ref.truncated_to_integer + 1
		end;

	sign: INTEGER is
			-- Sign value (0, -1 or 1)
		do
			if item > 0.0 then
				Result := 1
			elseif item < 0.0 then
				Result := -1
			end
		ensure
			three_way: Result = three_way_comparison (zero)
		end;

	one: like Current is
			-- Neutral element for "*" and "/"
		do
			!! Result;
			Result.set_item (1.0)
		end;

	zero: like Current is
			-- Neutral element for "+" and "-"
		do
			!! Result;
			Result.set_item (0.0)
		end;

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater than current real?
		do
			Result := item < other.item
		end;

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := other.item = item
		end;

	three_way_comparison (other: REAL_REF): INTEGER is
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

	set_item (r: REAL) is
			-- Make `r' the value of `item'.
		do
			item := r
		end;

feature -- Status report

	divisible (other: REAL_REF): BOOLEAN is
			-- May current object be divided by `other'?
		do
			Result := other.item /= 0.0
		ensure then
			ref_not_exact_zero: Result implies (other.item /= 0.0)
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
				Result := integer_value.item >= 0 or item /= 0.0
			elseif real_value /= Void then
				Result := real_value.item >= 0.0 or item /= 0.0
			elseif double_value /= Void then
				Result := double_value.item >= 0.0 or item /= 0.0
			end
		ensure then
			safe_values: ((other.conforms_to (0) and item /= 0.0) or
				(other.conforms_to (0.0) and item > 0.0)) implies Result
		end;

	is_hashable: BOOLEAN is
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item /= 0.0
		end;

feature -- Conversion

	truncated_to_integer: INTEGER is
			-- Integer part (same sign, largest absolute
			-- value no greater than current object's)
		do
			Result := c_truncated_to_integer (item)
		end;

	ceiling: INTEGER is
			-- Smallest integral value no smaller than current object
		do
			Result := c_ceiling (item).truncated_to_integer
		ensure
			result_no_smaller: Result >= item;
			close_enough: Result - item < item.one
		end;

	floor: INTEGER is
			-- Greatest integral value no greater than current object
		do
			Result := c_floor (item).truncated_to_integer
		ensure
			result_no_greater: Result <= item;
			close_enough: item - Result < Result.one
		end;

	rounded: INTEGER is
			-- Rounded integral value
		do
			Result := sign * ((abs + 0.5).floor)
		ensure
			definition: Result = sign * ((abs + 0.5).floor)
		end;

feature -- Basic operations

	abs: REAL is
			-- Absolute value
		do
			Result := abs_ref.item
		ensure
			non_negative: Result >= 0.0;
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

	infix "/" (other: like Current): like Current is
			-- Division by `other'
		do
			!! Result;
			Result.set_item (item / other.item)
		end;

	infix "^" (other: NUMERIC): DOUBLE_REF is
			-- Current real to the power `other'
		local
			integer_value: INTEGER_REF;
			real_value: REAL_REF;
			double_value: DOUBLE_REF
		do
			!! Result
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

feature -- Output

	out: STRING is
			-- Printable representation of real value
		do
			Result := c_outr (item)
		end;

feature {NONE} -- Implementation

	abs_ref: REAL_REF is
			-- Absolute value
		do
			if item >= 0.0 then
				Result := Current
			else
				Result := - Current
			end
		ensure
			result_exists: Result /= Void;
			same_absolute_value: equal (Result, Current) or equal (Result, - Current)
		end;

	c_outr (r: REAL): STRING is
			-- Printable representation of real value
		external
			"C | %"eif_out.h%""
		end;

	c_truncated_to_integer (r: REAL): INTEGER is
			-- Integer part of `r' (same sign, largest absolute
			-- value no greater than `r''s)
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"conv_ri"
		end;

	c_ceiling (r: REAL): REAL is
			-- Smallest integral value no smaller than `r'
		external
			"C (double): EIF_REAL | <math.h>"
		alias
			"ceil"
		end;

	c_floor (r: REAL): REAL is
			-- Greatest integral value no greater than `r'
		external
			"C (double): EIF_REAL | <math.h>"
		alias
			"floor"
		end;

invariant

--FIXME	sign_times_abs: item /= 1/0 and item /= 0/0 implies sign * abs = item
--This is not accepted by the Microsoft C compiler.

			-- IEEE 754 specifies that certain floating point operations
			-- have a result that is not a number (NaN). sign_times_abs
			-- does not hold when item is not a number.

end -- class REAL_REF


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

