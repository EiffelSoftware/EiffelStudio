--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Linear, i.e. non circular, one-dimensional structures

indexing

	names: linear, traversing;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class LINEAR [G] inherit

	BIDIRECTIONAL [G]
		rename
			search as sequential_search,
			search_equal as seq_search_equal
		export
			{NONE}
				sequential_search, seq_search_equal
		end;

	BIDIRECTIONAL [G]
		redefine
			search, search_equal
		select
			search, search_equal
		end

feature -- Access

	search (v: like item) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where `item' and `v' are identical.
			-- (According to the `=' discrimination rule)
			-- `exhausted' becomes true if `Current'
			-- does not include `v'.
		do
			if before then forth end;
			sequential_search (v)
		end;

	search_equal (v: like item) is
            -- Move cursor to first position
            -- (at or after current cursor position)
            -- where `item' and `v' are equal.
            -- (According to the `equal' rule)
            -- `exhausted' becomes true if `Current'
            -- does not include `v'.
        do
            if before then forth end;
            seq_search_equal (v)
        end;

feature -- Cursor

	index: INTEGER is
			-- Index of `item'.
		deferred
		end;

	forth is
			-- Move to next position.
		require else
			not_after: not after
		deferred
		ensure then
	--		moved_forth: index = old index + 1
		end;

	back is
			-- Move to previous position.
		require else
			not_before: not before
		deferred
		ensure then
	--		moved_back: index = old index - 1
		end;

	after: BOOLEAN is
			-- Is there no position to the right of current position?
		deferred
		end;

	before: BOOLEAN is
			-- Is there no position to the left of current position?
		deferred
		end;

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := after or before
		end;

invariant

	off_definition: off = after or before

end -- class LINEAR
