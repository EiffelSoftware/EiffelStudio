--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Tables, i.e. containers which items are referenced by a key

indexing

	names: table, access;
	access: key, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class TABLE [G, H] inherit

	CONTAINER [G]

feature -- Access

	item, infix "@" (k: H): G is
			-- Entry of key `k'.
			-- Applicable only if `k' is a valid key.
		require
			valid_key: valid_key (k)
		deferred
		end;

feature -- Insertion

	put (v: G; k: H) is
			-- Associate value `v' with key `k'.
			-- Applicable only if `k' is a valid key.
		require
			valid_key: valid_key (k)
		deferred
		ensure
			insertion_done: equal (item (k), v)
		end;

feature -- Assertion check

	valid_key (k: H): BOOLEAN is
			-- Is `k' a valid key?
		deferred
		end;

end -- class TABLE
