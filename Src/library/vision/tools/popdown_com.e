--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Command to popdown a shell.

class POPDOWN_COM 

inherit

	COMMAND

feature 

	execute (argument: ANY) is
			-- Popdown a shell.
		local
			shell: POPUP_SHELL;
			dialog: DIALOG
		do
			shell ?= argument;
			if (shell = Void) then
				dialog ?= argument;
				dialog.popdown;
				io.putstring("------> dialog popdown%N");
			else
				shell.popdown;
				io.putstring("------> shell popdown%N");
			end
		end

end
