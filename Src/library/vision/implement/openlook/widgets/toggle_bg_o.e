--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class TOGGLE_BG_O 

inherit

	TOGGLE_BG_I
		
		export
			{NONE} all
		end;

	TOGGLE_B_O
		rename
			make as toggle_b_o_make
		end;

creation

	make
	
feature 

	make (a_toggle_bg: TOGGLE_BG) is
			-- Create a openlook toggle button.
		
		local
			ext_name: ANY;
		do
			ext_name := a_toggle_bg.identifier.to_c;		
			screen_object := create_toggle_b ($ext_name, a_toggle_bg.parent.implementation.screen_object);
			a_toggle_bg.set_font_imp (Current);
		end;

end 
