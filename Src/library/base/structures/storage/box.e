--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Boxes: the most general data-structures
-- from the storage perspective

indexing

	names: box, storage;
	date: "$Date$";
	revision: "$Revision$"

deferred class BOX

feature -- Number of elements

	empty: BOOLEAN is
			-- Is `Current' empty?
		deferred
		end;

	full: BOOLEAN is
			-- Is `Current' full?
		deferred
		end;

end -- class BOX
