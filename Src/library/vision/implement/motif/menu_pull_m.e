--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- MENU_PULL_M: implementation of pulldown for menu buttons.

indexing

	date: "$Date$";
	revision: "$Revision$"

class MENU_PULL_M 

inherit
	MENU_PULL_I
		export
			{NONE} all
		end;

	MENU_M

creation

	make

feature -- Creation

	make (a_pulldown: MENU_PULL) is
			-- Create a motif pulldown menu.
		local
			pulldown_identifier: STRING;
			ext_name: ANY
		do
			pulldown_identifier := a_pulldown.identifier.duplicate;
			pulldown_identifier.append ("_pull");
			!! menu_button.make (a_pulldown.identifier,a_pulldown.parent);
			ext_name := pulldown_identifier.to_c;
			screen_object := create_pulldown ($ext_name,
					a_pulldown.parent.implementation.screen_object);
			abstract_menu := a_pulldown;
			xm_attach_menu (menu_button.implementation.screen_object, screen_object);
		end;

feature

	text: STRING is
			-- Label of option button
		do
			Result := menu_button.text
		end; -- text

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		do
			menu_button.set_text(a_text)
		end;

feature {NONE} -- External features

	create_pulldown (p_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	xm_attach_menu (scr_obj1, scr_obj2: POINTER) is
		external
			"C"
		end;

end

