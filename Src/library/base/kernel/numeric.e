indexing

	description:
		"Objects to which numerical operations are applicable";

	note: "The model is that of a commutative ring."
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	NUMERIC

feature -- Access

	one: like Current is
			-- Neutral element for "*" and "/"
		deferred
		ensure
			result_exists: Result /= Void
		end;

	zero: like Current is
			-- Neutral element for "+" and "-"
		deferred
		ensure
			result_exists: Result /= Void
		end;

feature -- Status report

	divisible (other: like Current): BOOLEAN is
			-- May current object be divided by `other'?
		require
			other_exists: other /= Void
		deferred
		end;

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
			result_exists: Result /= Void;
			commutative: equal (Result, other + Current)
		end;

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		require
			other_exists: other /= Void
		deferred
		ensure
			result_exists: Result /= Void
		end;

	infix "*" (other: like Current): like Current is
			-- Product by `other'
		require
			other_exists: other /= Void
		deferred
		ensure
			result_exists: Result /= Void
		end;

	infix "/" (other: like Current): like Current is
			-- Division by `other'
		require
			other_exists: other /= Void;
			good_divisor: divisible (other)
		deferred
		ensure
			result_exists: Result /= Void
		end;

	infix "^" (other: NUMERIC): NUMERIC is
			-- Current object to the power `other'
		require
			other_exists: other /= Void;
			good_exponent: exponentiable (other)
		deferred
		ensure
			result_exists: Result /= Void
		end;

	prefix "+": like Current is
			-- Unary plus
		deferred
		ensure
			result_exists: Result /= Void
		end;

	prefix "-": like Current is
			-- Unary minus
		deferred
		ensure
			result_exists: Result /= Void
		end;

invariant

	neutral_addition: equal (Current + zero, Current);
	self_subtraction: equal (Current - Current, zero);
	neutral_multiplication: equal (Current * one, Current);
	self_division: divisible (Current) implies equal (Current / Current, one)

end -- class NUMERIC


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
