indexing

	description:
		"Structures for which there exists a traversal policy %
		%that will visit every element exactly once.";

	status: "See notice at end of class";
	names: traversable, traversing;
	access: cursor;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class
	TRAVERSABLE [G]

inherit

	CONTAINER [G]

feature -- Access

	item: G is
			-- Item at current position
		require
			not_off: not off
		deferred
		end;

feature -- Status report

	off: BOOLEAN is
			-- Is there no current item?
		deferred
		end

feature -- Cursor movement

	start is
			-- Move to first position if any.
		deferred
		end;

invariant

	empty_constraint: empty implies off;

end -- class TRAVERSABLE


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

