--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Hierarchical structures in which each item has (at most)
-- one predecessor and may have several successors

indexing

	names: hierarchical, traversing;
	access: cursor;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class HIERARCHICAL [G] inherit

	TRAVERSABLE [G]

feature -- Cursor

	back is
			-- Move to predecessor.
		require
			not_off: not off
		deferred
		end;

	forth (i: INTEGER) is
			-- Move to `i'-th successor.
		require
			not_off: not off;
 			argument_within_bounds: i >= 1 and i <= nb_of_successors
		deferred
		end;

feature -- Number of elements

	nb_of_successors: INTEGER is
			-- Number of successors of `item'
		require
			not_off: not off
		deferred
		end;

invariant

	positive_number: nb_of_successors >= 0

end -- class HIERARCHICAL
