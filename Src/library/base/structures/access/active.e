--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Active data structures, i.e. data structures with a notion
-- of "current item" that may be accessed and changed through 
-- specific operations

indexing

	names: active, access;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class ACTIVE [G] inherit

	BAG [G]

feature -- Access

	item: G is
			-- Current item
		require
			readable: readable
		deferred
		end;

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		deferred
		end;

feature -- Insertion

	replace (v: G) is
			-- Replace current item by `v'.
		require
			writable: writable
		deferred
		ensure
			item_replaced: item = v;
	--		same_count: count = old count
		end;

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		deferred
		end;

feature -- Deletion

	remove is
			-- Remove current item.
		require
			contractable
		deferred
		ensure
			not_full: not full;
	--		new_count: count = (old count - 1)
		end;

invariant

	empty_constraint: empty implies (not readable) and (not writable)

end
