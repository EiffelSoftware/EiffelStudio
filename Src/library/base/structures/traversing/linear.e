indexing

	description:
		"One-dimensional non-circular structures";

	copyright: "See notice at end of class";
	names: linear, traversing;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class LINEAR [G] inherit

	BIDIRECTIONAL [G]
		rename
			search as sequential_search
		export
			{NONE}
				sequential_search
		end;

	BIDIRECTIONAL [G]
		redefine
			search
		select
			search
		end

feature -- Access

	search (v: like item) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where `item' and `v' are equal.
			--  Set `exhausted' to true if structure does not include `v'.
			-- (Reference or object equality, based on `object_comparison'.) 
		do
			if before then forth end;
			sequential_search (v)
		end;

	index: INTEGER is
			-- Index of `item'.
		deferred
		end;

feature -- Status report

	after: BOOLEAN is
			-- Is there no valid position to the right of current position?
		deferred
		end;

	before: BOOLEAN is
			-- Is there no valid position to the left of current position?
		deferred
		end;

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := after or before
		end;

feature -- Cursor movement

	forth is
			-- Move to next position.
		require else
			not_after: not after
		deferred
		ensure then
			--moved_forth: index = old index + 1
		end;

	back is
			-- Move to previous position.
		require else
			not_before: not before
		deferred
		ensure then
			--moved_back: index = old index - 1
		end;

invariant

	off_definition: off = (after or before)

end -- class LINEAR


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
