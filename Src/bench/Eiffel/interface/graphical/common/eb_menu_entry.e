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

	initialize_button (a_cmd: like associated_command; a_parent: MENU) is
			-- Initialize the button part.
		do
			button_make (a_cmd.name, a_parent);
			add_activate_action (a_cmd, a_cmd.text_window)
		end;

feature -- Properties

	associated_command: TOOL_COMMAND is
			-- Command type that menu entry expects
		do
		end;

end -- class EB_MENU_ENTRY
