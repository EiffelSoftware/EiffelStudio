--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Collections, i.e. containers which 
-- items are there solely by themselves

indexing

	names: collection, access;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class COLLECTION [G] inherit

	CONTAINER [G]

feature -- Insertion

	add (v: G) is
			-- Include `v' in `Current'.
		require
			extensible: extensible
		deferred
		ensure
	--		new_count: count >= old count;
			item_inserted: has (v)
		end;

	fill (other: CONTAINER [G]) is
			-- Fill `Current' with as many elements of `other'
			-- as possible.
			-- The representations of `other' and `Current'
			-- need not be the same. (This feature enables you
			-- to map one implementation to another.)
		local
			lin_rep: SEQUENTIAL [G]
		do
			lin_rep := other.sequential_representation;
			from
				lin_rep.start
			until
				not extensible or else lin_rep.off
			loop
				add (lin_rep.item);
				lin_rep.forth
			end
		end;

	extensible: BOOLEAN is
			-- May new items be added to `Current'?
		deferred
		end;

feature -- Deletion

	remove_item (v: G) is
			-- Remove `v' from `Current'.
		require
			contractable: contractable
		deferred
		ensure
	--		new_count: count <= old count
		end;

	contractable: BOOLEAN is
			-- May items be removed from `Current'?
		deferred
		end;

invariant

	empty_constraint: empty implies not contractable

end -- class COLLECTION
