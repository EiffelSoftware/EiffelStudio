note

	description: "[
		Objects to which numerical operations are applicable"

		Note: The model is that of a commutative ring.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class

	NUMERIC

inherit
	DEBUG_OUTPUT
		rename
			debug_output as out
		end

feature -- Access

	one: like Current
			-- Neutral element for "*" and "/"
		deferred
		ensure
			result_exists: Result /= Void
		end

	zero: like Current
			-- Neutral element for "+" and "-"
		deferred
		ensure
			result_exists: Result /= Void
		end

feature -- Status report

	divisible (other: like Current): BOOLEAN
			-- May current object be divided by `other'?
		require
			other_exists: other /= Void
		deferred
		end

	exponentiable (other: NUMERIC): BOOLEAN
			-- May current object be elevated to the power `other'?
		require
			other_exists: other /= Void
		deferred
		end

feature -- Basic operations

	infix "+" (other: like Current): like Current
			-- Sum with `other' (commutative).
		require
			other_exists: other /= Void
		deferred
		ensure
			result_exists: Result /= Void
			commutative: equal (Result, other + Current)
		end

	infix "-" (other: like Current): like Current
			-- Result of subtracting `other'
		require
			other_exists: other /= Void
		deferred
		ensure
			result_exists: Result /= Void
		end

	infix "*" (other: like Current): like Current
			-- Product by `other'
		require
			other_exists: other /= Void
		deferred
		ensure
			result_exists: Result /= Void
		end

	infix "/" (other: like Current): like Current
			-- Division by `other'
		require
			other_exists: other /= Void
			good_divisor: divisible (other)
		deferred
		ensure
			result_exists: Result /= Void
		end

	prefix "+": like Current
			-- Unary plus
		deferred
		ensure
			result_exists: Result /= Void
		end

	prefix "-": like Current
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

note
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







end -- class NUMERIC




