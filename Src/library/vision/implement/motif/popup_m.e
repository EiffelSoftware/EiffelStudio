--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- POPUP_M: implementation of popup menu.

indexing

	date: "$Date$";
	revision: "$Revision$"

class POPUP_M 

inherit

	POPUP_I;

	MENU_M
		export
			{NONE} all
		end

creation

	make

feature 

	make (a_popup: POPUP) is
			-- Create a motif popup menu.
		local
			ext_name: ANY
		do
			ext_name := a_popup.identifier.to_c;
			screen_object := create_popup ($ext_name,
					a_popup.parent.implementation.screen_object);
			abstract_menu := a_popup
		end;

	popup is
			-- Popup current popup menu on screen.
		do
			xt_manage_child (screen_object)
		end

feature {NONE} -- External features

	create_popup (p_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

