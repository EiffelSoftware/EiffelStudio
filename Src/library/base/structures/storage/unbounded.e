--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Unbounded data structures

indexing

	names: unbounded, storage;
	date: "$Date$";
	revision: "$Revision$"

deferred class UNBOUNDED inherit

	FINITE

feature -- Number of elements
	
	full: BOOLEAN is false;
			-- Is `Current' full?

invariant

	never_full: not full

end -- class UNBOUNDED
