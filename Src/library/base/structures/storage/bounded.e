--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Bounded data structures; notion of "capacity"

indexing

	names: bounded, storage;
	date: "$Date$";
	revision: "$Revision$"

deferred class BOUNDED inherit

	FINITE

feature -- Number of elements

	capacity: INTEGER is
			-- Number of items that may
			-- be stored into `Current'.
		deferred
		end;

	full : BOOLEAN is
			-- Is `Current' full?
		do
			Result := (count = capacity)
		end;

invariant

	valid_count: count <= capacity;
	full_definition: full = (count = capacity)

end -- class BOUNDED
