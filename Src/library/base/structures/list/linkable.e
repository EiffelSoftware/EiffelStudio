--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Linkable cells with a reference to the right neighbor

indexing

	names: linkable, cell;
	representation: linked;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKABLE [G] inherit

	CELL [G]
		export
			{CELL, CHAIN} put;
			item
		end

feature -- Access

	right: like Current;
			-- Right neighbor

feature {CELL, CHAIN} -- Insertion

	put_right (other: like Current) is
			-- Put `other' to the right of `Current'.
		do
			right := other
		ensure
			chained: right = other
		end;

	put_between (bef, aft: like Current) is
			-- Put `Current' between `bef' and `aft'.
		require
			properly_chained:
				(bef /= Void) implies (bef.right = aft)
		do
			if bef /= Void then
				bef.put_right (Current)
			end;
			put_right (aft)
		ensure
			(bef /= Void) implies (bef.right = Current);
			chained: right = aft
		end;

feature {CELL, CHAIN} -- Deletion

	forget_right is
			-- Remove right link.
		do
			right := Void
		ensure
			not_chained: right = Void
		end;

end
