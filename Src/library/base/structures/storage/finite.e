--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Finite data structures; notion of "count"

indexing

	names: finite, storage;
	date: "$Date$";
	revision: "$Revision$"

deferred class FINITE inherit

	BOX

feature -- Number of elements

	empty: BOOLEAN is
			-- Is `Current' empty ?
		do
			Result := count = 0
		end;

	count: INTEGER is
			-- Number of elements in `Current'
		deferred
		end;

invariant

    empty_definition: empty = (count = 0);
    positive_count: count >= 0

end -- class FINITE
		
