--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Containers: the most general data structures
-- in the Eiffel universe

indexing

	names: container, access;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class CONTAINER [G]

feature -- Access

	has (v: G): BOOLEAN is
			-- Does `Current' include `v'?
			-- (According to the currently 
			-- discrimination rule used in `search')
		deferred
		end;

feature -- Deletion

	wipe_out is
			-- Empty `Current'.
		deferred
		ensure
			wiped_out: empty
		end;

feature -- Transformation

	sequential_representation: SEQUENTIAL [G] is
			-- Sequential representation of `Current'.
			-- This feature enables you to manipulate each
			-- item of `Current' regardless of its
			-- actual structure.
		deferred
		end;

feature -- Number of elements

	count: INTEGER is
			-- Number of elements in `Current'
		deferred
		end;

	empty: BOOLEAN is
			-- Is `Current' empty?
		do
			Result := count = 0
		end;

	full: BOOLEAN is
			-- Is `Current' full?
		deferred
		end;

invariant

	empty_definition: empty = (count = 0);
	positive_count: count >= 0

end -- class CONTAINER
