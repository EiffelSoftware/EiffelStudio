--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- MENU_B_M: Implementation of menu button.

indexing

	date: "$Date$";
	revision: "$Revision$"

class MENU_B_M 

inherit

	MENU_B_R_M
		export
			{NONE} all
		end;

	MENU_B_I
		export
			{NONE} all
		end;

	BUTTON_M;

	FONTABLE_M
		rename
			resource_name as MfontList
		end

creation

	make

feature -- Creation

	make (a_menu_b: MENU_B) is
			-- Create a motif menu button.
		local
			ext_name: ANY
		do
			ext_name := a_menu_b.identifier.to_c;
			screen_object := create_menu_b ($ext_name,
					a_menu_b.parent.implementation.screen_object);
			a_menu_b.set_font_imp (Current)
		end

feature 

	attach_menu (a_menu: MENU_PULL) is
			-- Attach menu `a_menu' to the menu button, it will
			-- be the menu which will appear when the button
			-- is armed.
		do
			xm_attach_menu (screen_object,
					a_menu.implementation.screen_object)
		end

feature {NONE} -- External features

	xm_attach_menu (scr_obj1, scr_obj2: POINTER) is
		external
			"C"
		end;

	create_menu_b (m_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end

end

