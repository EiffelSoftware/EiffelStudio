--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Infinite data structures
-- E.g. the set of all natural numbers

indexing

	names: infinite, storage ;
	date: "$Date$";
	revision: "$Revision$"

deferred class INFINITE inherit

	BOX

feature -- Number of elements

	empty: BOOLEAN is false
			-- Is `Current' empty?

	full: BOOLEAN is true
			-- Is `Current' full?
			-- (You can't add something to an infinite
			-- data structure.)

invariant

	never_empty: not empty
	always_full: full

end -- class INFINITE
