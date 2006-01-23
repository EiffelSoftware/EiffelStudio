indexing
	description: "[
		Invertible object with an internal + operation.

		Note: The model is that of a commutative group.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GROUP_ELEMENT

feature -- Access

	zero: like Current is
			-- Neutral element for "+" and "-"
		deferred
		ensure
			result_exists: Result /= Void
		end

feature -- Basic operations

	infix "+" (other: like Current): like Current is
			-- Sum with `other' (commutative)
		require
			other_exists: other /= Void
		deferred
		ensure
			result_exists: Result /= Void
			commutative: Result.is_equal (other + Current)
		end

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		require
			other_exists: other /= Void
		deferred
		ensure
			result_exists: Result /= Void
		end

	prefix "+": like Current is
			-- Unary plus
		deferred
		ensure
			result_exists: Result /= Void
			result_definition: Result.is_equal (Current)
		end

	prefix "-": like Current is
			-- Unary minus
		deferred
		ensure
			result_exists: Result /= Void
			result_definition: (Result + Current).is_equal (zero)
		end

invariant

	neutral_addition: Current.is_equal (Current + zero)
	self_subtraction: zero.is_equal (Current - Current)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class GROUP_ELEMENT



