--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Motif menu bar implementation.

indexing

	date: "$Date$";
	revision: "$Revision$"

class BAR_M 

inherit

	BAR_I
		export
			{NONE} all
		end;

	MENU_M

creation

	make

feature  -- Creation

	make (a_bar: BAR) is
			-- Create a motif bar menu.
		local
			ext_name_bar: ANY
		do
			ext_name_bar := a_bar.identifier.to_c;
			screen_object := create_bar ($ext_name_bar, a_bar.parent.implementation.screen_object);
			abstract_menu := a_bar
		end;

feature {NONE}

	help_button: MENU_B is
			-- Menu Button which appears at the lower right corner of the
			-- menu bar
        local
            ext_name: ANY
		do
            ext_name := MmenuHelpWidget.to_c;
			Result ?= widget_manager.screen_object_to_oui (get_widget (screen_object, $ext_name))
		end;

	set_help_button (button: MENU_B) is
			-- Set the Menu Button which appears at the lower right corner
			-- of the menu bar.
		local
			ext_name: ANY
		do
			ext_name := MmenuHelpWidget.to_c;
			set_widget (screen_object, button.implementation.screen_object, $ext_name)
		ensure then
			help_button.same (button)
		end

feature {NONE} -- External features

	create_bar (b_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

