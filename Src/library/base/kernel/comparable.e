indexing

	description:
		"Objects that may be compared according to a total order relation";

	note:
		"The basic operation is `<' (less than); others are defined %
		%in terms of this operation and `is_equal'."

	status: "See notice at end of class";
	names: comparable, comparison;
	date: "$Date$";
	revision: "$Revision$"

deferred class COMPARABLE inherit

	PART_COMPARABLE
		redefine
			infix "<", infix "<=",
			infix ">", infix ">=",
			is_equal
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		deferred
		ensure then
			asymmetric: Result implies not (other < Current)
		end;

	infix "<=" (other: like Current): BOOLEAN is
			-- Is current object less than or equal to `other'?
		do
			Result := not (other < Current)
		ensure then
			definition: Result = (Current < other) or is_equal (other)
		end;

	infix ">" (other: like Current): BOOLEAN is
			-- Is current object greater than `other'?
		do
			Result := other < Current
		ensure then
			definition: Result = (other < Current)
		end;

	infix ">=" (other: like Current): BOOLEAN is
			-- Is current object greater than or equal to `other'?
		do
			Result := not (Current < other)
 		ensure then
			definition: Result = (other <= Current)
		end;

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := (not (Current < other) and not (other < Current))
		ensure then
			trichotomy: Result = (not (Current < other) and not (other < Current))
		end;

	three_way_comparison (other: like Current): INTEGER is
			-- If current object equal to `other', 0;
			-- if smaller, -1; if greater, 1
		require
			other_exists: other /= Void
		do
			if Current < other then
				Result := -1
			elseif other < Current then
				Result := 1
			end
		ensure
			equal_zero: (Result = 0) = is_equal (other);
			smaller_negative: (Result = -1) = (Current < other);
			greater_positive: (Result = 1) = (Current > other)
		end;

	max (other: like Current): like Current is
			-- The greater of current object and `other'
		require
			other_exists: other /= Void
		do
			if Current >= other then
				Result := Current
			else
				Result := other
			end
		ensure
			current_if_not_smaller: Current >= other implies Result = Current;
			other_if_smaller: Current < other implies Result = other
		end;

	min (other: like Current): like Current is
			-- The smaller of current object and `other'
		require
			other_exists: other /= Void
		do
			if Current <= other then
				Result := Current
			else
				Result := other
			end
		ensure
			current_if_not_greater: Current <= other implies Result = Current;
			other_if_greater: Current > other implies Result = other
		end;

invariant

	irreflexive_comparison: not (Current < Current)

end -- class COMPARABLE


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
