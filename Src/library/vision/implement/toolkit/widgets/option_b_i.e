indexing

	description: "Rectangle which displays an option menu when armed"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	OPTION_B_I 

inherit

	BUTTON_I

feature -- Access

	selected_button: BUTTON is
			-- Current Push Button selected in the option menu
		deferred
		end;

	title: STRING is
		deferred
		end;

	title_width: INTEGER is
		deferred
		end;

feature -- Element change

	set_selected_button (button: BUTTON) is
			-- Set `selected_button' to `button'
		require
			button_exists: button /= Void
		deferred
		ensure
			button = selected_button
		end;

	attach_menu (a_menu: OPT_PULL) is
			-- Attach menu `a_menu' to the menu button, it will
			-- be the menu which will appear when the button
			-- is armed.
		require
			menu_not_void: a_menu /= Void
		deferred
		end;

	set_title (a_title: STRING) is
		deferred
		end;

	remove_title is
		deferred
		end;
	
	add_activate_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
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




end -- class OPTION_B_I

