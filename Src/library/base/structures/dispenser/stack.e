--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Stacks (last-in, first-out dispensers),
-- without commitment to a particular representation

indexing

	names: stack, dispenser;
	access: fixed, lifo, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class STACK [G] inherit

	DISPENSER [G]
		redefine
			add, fill, put
		end

feature -- Insertion

	add (v: like item) is
			-- Push `v' onto `Current'.
		deferred
		ensure then
			item_pushed: item = v
		end;

	put (v: like item) is
			-- Push `v' onto `Current'.
			-- (Synonym for `add').
		do
			add (v)
		end;

	replace (v: like item) is
			-- Replace top item by `v'.
		do
			remove;
			add (v)
		end;

	fill (other: CONTAINER [G]) is
			-- Fill `Current' with as many elements of `other'
			-- as possible.
			-- Fill items with greatest index from `other' first.
			-- Item inserted with lowest index (from `other') will
			-- always be on the top of stack.
			-- The representations of `other' and `Current'
			-- need not be the same. (This feature enables you
			-- to map one implementation to another.)
		local
			lin_rep: SEQUENTIAL [G];
			temp: FIXED_STACK [G]
		do
			lin_rep := other.sequential_representation;
			!! temp.make (other.count);
			from
				lin_rep.start
			until
				lin_rep.off
			loop
				temp.add (lin_rep.item);
				lin_rep.forth
			end;
			from
			until
				temp.empty or else not extensible
			loop
				add (temp.item);
				temp.remove
			end
		end;

end
