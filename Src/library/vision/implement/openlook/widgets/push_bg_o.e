--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- PUSH_BG_O: implementation of push button.

indexing

	date: "$Date$";
	revision: "$Revision$"

class PUSH_BG_O 

inherit

	PUSH_BG_I
		export
			{NONE} all
		end;

	PUSH_B_O

creation

	make
	
end 
