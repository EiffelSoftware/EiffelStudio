indexing

	description:
		"References to objects containing a double-precision real number"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DOUBLE_REF inherit

	NUMERIC
		redefine
			out, is_equal
		end

	COMPARABLE
		redefine
			out, is_equal
		end

	HASHABLE
		redefine
			is_hashable, out, is_equal
		end

feature -- Access

	item: DOUBLE
			-- Numeric double value

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := truncated_to_integer.hash_code
		end

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
		end

	one: like Current is
			-- Neutral element for "*" and "/"
		do
			create Result
			Result.set_item (1.0)
		end

	zero: like Current is
			-- Neutral element for "+" and "-"
		do
			create Result
			Result.set_item (0.0)
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater than current double?
		do
			Result := item < other.item
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := other.item = item
		end

feature -- Element change

	set_item (d: DOUBLE) is
			-- Make `d' the `item' value.
		do
			item := d
		end

feature -- Status report

	divisible (other: DOUBLE_REF): BOOLEAN is
			-- May current object be divided by `other'?
		do
			Result := other.item /= 0.0
		ensure then
			not_exact_zero: Result implies (other.item /= 0.0)
		end

	exponentiable (other: NUMERIC): BOOLEAN is
			-- May current object be elevated to the power `other'?
		local
			integer_value: INTEGER_REF
			double_value: DOUBLE_REF
			real_value: REAL_REF
		do
			integer_value ?= other
			real_value ?= other
			double_value ?= other
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
		end

	is_hashable: BOOLEAN is
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item /= 0.0
		end

feature {NONE} -- Conversion

	make_from_reference (v: DOUBLE_REF) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: v /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: DOUBLE_REF is
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

	truncated_to_integer: INTEGER is
			-- Integer part (Same sign, largest absolute
			-- value no greater than current object's)
		do
			Result := c_truncated_to_integer (item)
		end

	truncated_to_integer_64: INTEGER_64 is
			-- Integer part (Same sign, largest absolute
			-- value no greater than current object's)
		do
			Result := c_truncated_to_integer_64 (item)
		end

	truncated_to_real: REAL is
			-- Real part (Same sign, largest absolute
			-- value no greater than current object's)
		do
			Result := c_truncated_to_real (item)
		end

	ceiling: INTEGER is
			-- Smallest integral value no smaller than current object
		do
			Result := c_ceiling (item).truncated_to_integer
		ensure
			result_no_smaller: Result >= item
			close_enough: Result - item < item.one
		end

	floor: INTEGER is
			-- Greatest integral value no greater than current object
		do
			Result := c_floor (item).truncated_to_integer
		ensure
			result_no_greater: Result <= item
			close_enough: item - Result < Result.one
		end

	rounded: INTEGER is
			-- Rounded integral value
		do
			Result := sign * (c_floor (abs_ref.item + 0.5).truncated_to_integer)
		ensure
			definition: Result = sign * ((abs + 0.5).floor)
		end

	ceiling_real_64: DOUBLE is
			-- Smallest integral value no smaller than current object
		do
			Result := c_ceiling (item)
		ensure
			result_no_smaller: Result >= item
			close_enough: Result - item < item.one
		end

	floor_real_64: DOUBLE is
			-- Greatest integral value no greater than current object
		do
			Result := c_floor (item)
		ensure
			result_no_greater: Result <= item
			close_enough: item - Result < Result.one
		end

	rounded_real_64: DOUBLE is
			-- Rounded integral value
		do
			Result := sign * c_floor (abs_ref.item + 0.5)
		ensure
			definition: Result = sign * ((abs + 0.5).floor_real_64)
		end

feature -- Basic operations

	abs: DOUBLE is
			-- Absolute value
		do
			Result := abs_ref.item
		ensure
			non_negative: Result >= 0.0
			same_absolute_value: (Result = item) or (Result = -item)
		end

	infix "+" (other: like Current): like Current is
			-- Sum with `other'
		do
			create Result
			Result.set_item (item + other.item)
		end

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		do
			create Result
			Result.set_item (item - other.item)
		end

	infix "*" (other: like Current): like Current is
			-- Product with `other'
		do
			create Result
			Result.set_item (item * other.item)
		end

	infix "/" (other: like Current): like Current is
			-- Division by `other'
		do
			create Result
			Result.set_item (item / other.item)
		end

	infix "^" (other: DOUBLE): DOUBLE is
			-- Current double to the power `other'
		do
			Result := item ^ other
		end

	prefix "+": like Current is
			-- Unary plus
		do
			create Result
			Result.set_item (+ item)
		end

	prefix "-": like Current is
			-- Unary minus
		do
			create Result
			Result.set_item (- item)
		end

feature -- Output

	out: STRING is
			-- Printable representation of double value
		do
			Result := c_outr64 (item)
		end

feature {NONE} -- Implementation

	abs_ref: DOUBLE_REF is
			-- Absolute value
		do
			if item >= 0.0 then
				Result := Current
			else
				Result := -Current
			end
		ensure
			result_exists: Result /= Void
			same_absolute_value: equal (Result, Current) or equal (Result, - Current)
		end

	c_outr64 (d: DOUBLE): STRING is
			-- Printable representation of double value
		external
			"C | %"eif_out.h%""
		end

	c_truncated_to_integer (d: DOUBLE): INTEGER is
			-- Integer part of `d' (same sign, largest absolute
			-- value no greater than `d''s)
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"((EIF_INTEGER) ($d))"
		end

	c_truncated_to_integer_64 (d: DOUBLE): INTEGER_64 is
			-- Integer part of `d' (same sign, largest absolute
			-- value no greater than `d''s)
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"((EIF_INTEGER_64) ($d))"
		end

	c_truncated_to_real (d: DOUBLE): REAL is
			-- Real part of `d' (same sign, largest absolute
			-- value no greater than `d''s)
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"((EIF_REAL) ($d))"
		end

	c_ceiling (d: DOUBLE): DOUBLE is
			-- Smallest integral value no smaller than `d'
		external
			"C signature (double): double use <math.h>"
		alias
			"ceil"
		end

	c_floor (d: DOUBLE): DOUBLE is
			-- Greatest integral value no greater than `d'
		external
			"C signature (double): double use <math.h>"
		alias
			"floor"
		end

invariant

	sign_times_abs: sign * abs = item

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







end -- class DOUBLE_REF



