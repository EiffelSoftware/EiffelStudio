--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- General notion of command history.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class HISTORY 

feature 

	record (a_command: UNDOABLE) is
			-- Record `a_command' in Current
			-- history.
		deferred
		end

end
