--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Ancestors of user commands for a history based on a linear list.
-- This command will create an history of class HISTORY_LIST
--
-- Deferred features : is_error, n_ame, redo, undo, work

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class UNDOABLE_L 

inherit

	UNDOABLE

feature 

	history: HISTORY_LIST is
			-- Trace of previously executed commands
		once
			!! Result.make
		ensure then
			not (Result = Void)
		end

end
