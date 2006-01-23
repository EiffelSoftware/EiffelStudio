indexing

	description: "General menu button implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	MENU_B_I 

inherit

	BUTTON_I

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	attach_menu (a_menu: MENU_PULL) is
			-- Attach menu `a_menu' to the menu button, it will
			-- be the menu which will appear when the button
			-- is armed.
		deferred
		end;
 
feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MENU_B_I

