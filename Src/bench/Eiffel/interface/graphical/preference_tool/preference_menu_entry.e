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
		rename
			make as ime_make
		end

creation
	make

feature {NONE} -- Initialization

	make (cmd: PREFERENCE_COMMAND; a_parent: MENU;) is
		require
			cmd_not_void: cmd /= Void;
			a_parent_not_void: a_parent /= Void;
		do
			button_make (menu_entry_name, a_parent);
			entry_text := cmd.name;
			set_text (cmd.name);
			add_activate_action (cmd, Void)
		end
	
feature -- Properties

	entry_text: STRING;

feature -- Command Setting

	set_command_argument (cmd: PREFERENCE_COMMAND; arg: ANY) is
		require
			cmd_not_void: cmd /= Void
		do
			add_activate_action (cmd, arg)
		end

feature -- Useless

	initialize_button (a_parent: MENU) is
			-- Useless here
		do
			--| Do nothing
		end;

	set_selected (b:BOOLEAN) is
			-- Useless here.
		do
			--| Do Nothing
		end

end -- class PREFERENCE_MENU_ENTRY
