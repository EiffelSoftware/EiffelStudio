--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- General notion of traversable data structures

indexing

	names: traversable, traversing;
	access: cursor;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class TRAVERSABLE [G]

feature -- Access

	item: G is
			-- Current item of `Current'
		require
			is_readable: readable	
		deferred
		end;

	readable: BOOLEAN is
			-- Is there a current item to be read?
		deferred 
		end;

	exhausted: BOOLEAN is
			-- Are there no more items to be read?
			-- By default, `exhausted' is equal to `off'
		do
			Result := off
		end;

feature -- Cursor

	off: BOOLEAN is
			-- Is there no current item?
		deferred
		end;

	start is
			-- Move to first position.
		deferred
		end;

invariant

	off_constraint: off implies exhausted;
	exhausted_constraint: exhausted implies not readable

end -- class TRAVERSABLE
