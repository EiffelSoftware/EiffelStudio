--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- MENU_PULL_O: implementation of pulldown for menu buttons.

indexing

	date: "$Date$";
	revision: "$Revision$"

class MENU_PULL_O 

inherit

	MENU_PULL_I
		export
			{NONE} all
		end;

	PULLDOWN_O
		redefine
			button
		end;

	PULLDOWN_R_O
		export
			{NONE} all
		end

creation

	make
	
feature 

	button: MENU_B;

 	make (a_pulldown: MENU_PULL) is
			-- Create an openlook pulldown menu.
		
		local
			ext_name: ANY;
		do
			!!button.make (a_pulldown.identifier,a_pulldown.parent);
			ext_name := OmenuPane.to_c;
			screen_object := get_widget (button.implementation.screen_object, $ext_name);
			abstract_menu := a_pulldown;
			menu_button := button
		end;

end 

