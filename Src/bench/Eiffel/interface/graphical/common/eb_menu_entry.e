indexing

	description:
		"Menu entry for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class EB_MENU_ENTRY

inherit
	MENU_ENTRY;
	PUSH_B
		rename
			make as button_make
		end

creation
	make

feature {NONE} -- Initialization

	initialize_button (a_parent: MENU) is
			-- Initialize the button part.
		do
			button_make (menu_entry_name, a_parent);
			set_text (entry_text);
			add_activate_action (associated_command, associated_command.text_window)
		end;

end -- class EB_MENU_ENTRY
