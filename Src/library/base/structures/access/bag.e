--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Bags, i.e. collections in which duplicates are allowed

indexing

	names: bag, access;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class BAG [G] inherit

	COLLECTION [G]
		redefine
			add
		end

feature -- Insertion

	add (v: G) is
			-- Add `v' to `Current'.
		deferred
		ensure then
	--		new_count: count = old count + 1
		end;

end -- class BAG
