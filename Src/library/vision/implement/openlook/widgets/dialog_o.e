--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- DIALOG_O

indexing

	date: "$Date$";
	revision: "$Revision$"

class DIALOG_O 

inherit

	DIALOG_I
		export
			{NONE} all
		end;

	G_ANY_O
		export
			{NONE} all
		end;

	WM_SHELL_O
		export
			{NONE} all
		end;

	POPUP_S_O
		export
			{NONE} all
		end;

end 
