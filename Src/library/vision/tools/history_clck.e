--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class HISTORY_CLCK 

inherit

	COMMAND
		redefine
			context_data_useful
		end

feature 

	context_data_useful: BOOLEAN is true;
			-- This command need a context_data structure

	execute (argument: ANY) is
			-- Undo the current command
		local
			history: HISTORY_L_W;
			single_data: SINGLE_DATA
		do
			single_data ?= context_data;
			history ?= argument;
			if not (history.history_list = Void) then
				history.history_list.go (single_data.position)
			end
		end;

end
