--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Redo button.

indexing

	date: "$Date$";
	revision: "$Revision$"

class HISTORY_REDO 

inherit

	COMMAND

feature 

	execute (argument: ANY) is
			-- Redo the last command undone.
		local
			history: HISTORY_L_W
		do
			history ?= argument;
			if (not (history.history_list = Void)) and then (not history.history_list.islast) then
				history.history_list.forth
			end
		end;

end
