--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Cells containing one item

indexing

	names: cell;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class CELL [G]

creation

	put

feature -- Access

	item: G;
			-- Content of `Current'

feature -- Insertion

	put (v : like item) is
			-- Assign `v' to `item'.
		do
			item := v
		ensure
			item_inserted: item = v
		end;

end
