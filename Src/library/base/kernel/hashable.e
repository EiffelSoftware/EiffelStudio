--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Hashable elements

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class HASHABLE

feature -- Access

	hash_code: INTEGER is
			-- Hash code value
		deferred
		end;

end -- class HASHABLE
