indexing

	description:
		"Menu entry for the preference tool.";
	date: "$Date$";
	revision: "$Revision$"

class PREFERENCE_MENU_ENTRY

inherit
	PUSH_B
		rename
			make as button_make
		end;
	ISE_MENU_ENTRY
		redefine
			associated_command
		end

creation
	make

feature -- Command Setting

	set_command_argument (a_cmd: like associated_command; arg: ANY) is
		require
			cmd_not_void: a_cmd /= Void
		do
			add_activate_action (a_cmd, arg)
		end

	associated_command: PREFERENCE_COMMAND is
			-- Command type that menu entry expects
		do
		end;

feature -- Initialization

	initialize_button (a_cmd: like associated_command; a_parent: MENU) is
			-- Initialize button.
		do
			button_make (a_cmd.name, a_parent);
			set_text (a_cmd.name);
			add_activate_action (a_cmd, Void)
		end;

	set_selected (b:BOOLEAN) is
			-- Set the tick or un set it, according to `b'.
		do
		end

end -- class PREFERENCE_MENU_ENTRY
