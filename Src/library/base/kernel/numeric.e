indexing

	description:
		"Objects to which numerical operations are applicable"

	note: "The model is that of a commutative ring."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	NUMERIC

feature -- Access

	one: like Current is
			-- Neutral element for "*" and "/"
		deferred
		ensure
			result_exists: Result /= Void
		end

	zero: like Current is
			-- Neutral element for "+" and "-"
		deferred
		ensure
			result_exists: Result /= Void
		end

feature -- Status report

	divisible (other: like Current): BOOLEAN is
			-- May current object be divided by `other'?
		require
			other_exists: other /= Void
		deferred
		end

	exponentiable (other: NUMERIC): BOOLEAN is
			-- May current object be elevated to the power `other'?
		require
			other_exists: other /= Void
		deferred
		end

feature -- Basic operations

	infix "+" (other: like Current): like Current is
			-- Sum with `other' (commutative).
		require
			other_exists: other /= Void
		deferred
		ensure
			result_exists: Result /= Void
			commutative: equal (Result, other + Current)
		end

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		require
			other_exists: other /= Void
		deferred
		ensure
			result_exists: Result /= Void
		end

	infix "*" (other: like Current): like Current is
			-- Product by `other'
		require
			other_exists: other /= Void
		deferred
		ensure
			result_exists: Result /= Void
		end

	infix "/" (other: like Current): like Current is
			-- Division by `other'
		require
			other_exists: other /= Void
			good_divisor: divisible (other)
		deferred
		ensure
			result_exists: Result /= Void
		end

	prefix "+": like Current is
			-- Unary plus
		deferred
		ensure
			result_exists: Result /= Void
		end

	prefix "-": like Current is
			-- Unary minus
		deferred
		ensure
			result_exists: Result /= Void
		end

invariant

--	neutral_addition: equal (Current + zero, Current);
--	self_subtraction: equal (Current - Current, zero);
--	neutral_multiplication: equal (Current * one, Current);
--	self_division: divisible (Current) implies equal (Current / Current, one)

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class NUMERIC




