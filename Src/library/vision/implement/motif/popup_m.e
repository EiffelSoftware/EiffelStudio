
-- POPUP_M: implementation of popup menu.

indexing

	status: "See notice at end of class";
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
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_popup.identifier.to_c;
			screen_object := create_popup ($ext_name,
					parent_screen_object (a_popup, widget_index));
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



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
