indexing

	description:
		"Structures for which there exists a traversal policy %
		%that will visit every element exactly once.";

	copyright: "See notice at end of class";
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
			-- Item at cursor position
		require
			not_off: not off	
		deferred
		end;
	

feature -- Status report

	exhausted: BOOLEAN is
			-- Are there no more items to be read?
		do
			Result := off
		end;

	off: BOOLEAN is
			-- Is there no current item?
		deferred
		end;	

feature -- Cursor movement

	start is
			-- Move to first position if any.
		deferred
		ensure
			empty implies off
		end;

invariant

	empty_constraint: empty implies off;
	off_constraint: off implies exhausted

end -- class TRAVERSABLE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
