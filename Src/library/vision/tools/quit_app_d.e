--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Message dialog to ensure that the user really want to quit the application.

class QUIT_APP_D 

inherit

	STD_COMMANDS
		export
			{NONE} all
		end;

	QUESTION_D
		rename
			make as question_d_make
		end

creation

	make

feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a predefined question dialog with `a_name' as identifier,
			-- `a_parent' as parent. When `execute' is called, popup the
			-- question dialog and ask the user if he's sure to quit the
			-- application. Exit if OK is pressed.
		require
			name_not_void: not (a_name = Void);
			parent_not_void: not (a_parent = Void)
		local
			nothing: ANY
		do
		end

end
