indexing

	description:
		"Structures that may be traversed forward and backward";

	status: "See notice at end of class";
	names: bidirectional, traversing;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class BILINEAR [G] inherit

	LINEAR [G]
		rename
			search as sequential_search
		export
			{NONE}
				sequential_search
		redefine
			off
		end;

	LINEAR [G]
		redefine
			search, off
		select
			search
		end

feature -- Access

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := before or after
		end;

feature -- Cursor movement

	before: BOOLEAN is
			-- Is there no valid position to the left of current one?
		deferred
		end;

	back is
			-- Move to previous position.
		require
			not_before: not before
		deferred
		ensure then
			moved_back: index = old index - 1
		end;

	search (v: like item) is
			-- Move to first position (at or after current
			-- position) where `item' and `v' are equal.
			-- If structure does not include `v' ensure that
			-- `exhausted' will be true.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		do
			if before and not empty then
				forth
			end;
			sequential_search (v)
		end;

invariant

	not_both: not (after and before);
	empty_property: empty implies (after or before);
	before_constraint: before implies off

end -- class BILINEAR


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
