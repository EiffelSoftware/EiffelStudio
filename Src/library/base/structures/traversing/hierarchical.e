indexing

	description:
		"Hierarchical structures in which each item has zero or %
		%one immediate predecessor, and zero or more successors.";

	status: "See notice at end of class";
	names: hierarchical, traversing;
	access: cursor;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class HIERARCHICAL [G] inherit

	TRAVERSABLE [G]

feature -- Access

	successor_count: INTEGER is
			-- Number of successors of current element
		require
			not_off: not off
		deferred
		end;

feature -- Cursor movement

	up is
			-- Move to predecessor.
		require
			not_off: not off
		deferred
		end;

	down (i: INTEGER) is
			-- Move to `i'-th successor.
		require
			not_off: not off;
 			argument_within_bounds: i >= 1 and i <= successor_count
		deferred
		end;

invariant

	non_negative_successor_count: successor_count >= 0

end -- class HIERARCHICAL


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

