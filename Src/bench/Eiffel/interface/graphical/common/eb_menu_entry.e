indexing

	description:
		"Menu entry for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class EB_MENU_ENTRY

inherit
	ISE_MENU_ENTRY
		redefine
			associated_command
		end;
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

feature -- Properties

	associated_command: ICONED_COMMAND;
			-- The associated_command

	entry_text: STRING is
			-- Text as displayed on the button
		do
			Result := associated_command.name
		end

end -- class EB_MENU_ENTRY
