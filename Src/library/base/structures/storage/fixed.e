--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Data structures with a constant number of items

indexing

	names: fixed, storage;
	size: fixed;
	date: "$Date$";
	revision: "$Revision$"

deferred class FIXED inherit

	BOUNDED
		redefine
			full
		end

feature -- Number of elements

	full: BOOLEAN is true;
			-- Is `Current' full?

invariant

	always_full: full;
	whole_capacity_used: count = capacity;

end -- class FIXED
