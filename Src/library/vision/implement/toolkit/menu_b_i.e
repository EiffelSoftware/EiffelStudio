indexing

	description: "General menu button implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class MENU_B_I 

inherit

	BUTTON_I

feature 

	add_activate_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	remove_activate_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	attach_menu (a_menu: MENU_PULL) is
			-- Attach menu `a_menu' to the menu button, it will
			-- be the menu which will appear when the button
			-- is armed.
		deferred
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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
