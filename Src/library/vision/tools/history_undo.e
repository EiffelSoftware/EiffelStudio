--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Undo button.

indexing

	date: "$Date$";
	revision: "$Revision$"

class HISTORY_UNDO 

inherit

	COMMAND

feature 

	execute (argument: ANY) is
			-- Undo the current command
		local
			history: HISTORY_L_W
		do
			history ?= argument;
			if (not (history.history_list = Void)) and then (not history.history_list.offleft) then
				history.history_list.back
			end
		end

end
