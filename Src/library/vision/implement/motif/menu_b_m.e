indexing

	description: "Implementation of menu button";
	status: "See notice at end of class";
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

feature {NONE} -- Creation

	make (a_menu_b: MENU_B; man: BOOLEAN) is
			-- Create a motif menu button.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_menu_b.identifier.to_c;
			screen_object := create_menu_b ($ext_name,
					parent_screen_object (a_menu_b, widget_index),
					man);
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
		end;

feature

	add_activate_action (a_command: COMMAND; argument: ANY) is
		do
		end

	add_release_action (a_command: COMMAND; argument: ANY) is
		do
		end

	add_arm_action (a_command: COMMAND; argument: ANY) is
		do
		end

	remove_activate_action (a_command: COMMAND; argument: ANY) is
		do
		end

	remove_release_action (a_command: COMMAND; argument: ANY) is
		do
		end

	remove_arm_action (a_command: COMMAND; argument: ANY) is
		do
		end

feature {NONE} -- External features

	xm_attach_menu (scr_obj1, scr_obj2: POINTER) is
		external
			"C"
		end;

	create_menu_b (m_name: POINTER; scr_obj: POINTER;
			man: BOOLEAN): POINTER is
		external
			"C"
		end

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
