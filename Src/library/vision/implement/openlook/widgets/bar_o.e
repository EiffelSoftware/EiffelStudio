--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- OpenLook menu bar implementation.

indexing

	date: "$Date$";
	revision: "$Revision$"

class BAR_O 

inherit

	BAR_I
		
		export
			{NONE} all
		end;

	MENU_O
		redefine 
			set_title
		end

creation

	make
	
feature 

	make (a_bar: BAR) is
			-- Create a openlook bar menu using `a_bar'.
		local
			ext_name: ANY;
		do
			ext_name := a_bar.identifier.to_c;
			screen_object := create_bar ($ext_name, 
							a_bar.parent.implementation.screen_object);
			abstract_menu := a_bar
		end; 
	
feature {NONE}

	help_button_id : INTEGER;
			-- TO FIX : to remove

	help_button: MENU_B is
			-- Menu Button which appears at the lower right corner of the
			-- menu bar
			-- TO FIX : to remove
		do
		end; 

	set_help_button (button: MENU_B) is
			-- Set the Menu Button which appears at the lower right corner
			-- of the menu bar
			-- TO FIX : to remove
		do
		end; 
	
feature 

	set_title (a_title: STRING) is
			-- TO FIX
		require else
			not_title_void: not (a_title = Void)
		local
		do
		end;

feature {NONE} -- External features

	create_bar (name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end; 

end 
