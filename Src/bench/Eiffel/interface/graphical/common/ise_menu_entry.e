indexing

	description:
		"Abstract notion of a menu entry.";
	date: "$Date$";
	revision: "$Revision$"

deferred class MENU_ENTRY feature

feature {NONE} -- Initialization

	make (cmd: like associated_command; a_parent: MENU) is
		require
			non_void_cmd: cmd /= Void;
			non_void_parent: a_parent /= Void;
		do
			associated_command := cmd;
			initialize_button (a_parent);
		end;

	initialize_button (a_parent: MENU) is
			-- Initialize the button part of Current.
		deferred
		end;

feature -- Properties

	associated_command: ICONED_COMMAND;
			-- The associated command.

	entry_text: STRING is
			-- Text as displayed on the button.
		do
			Result := associated_command.name
		end;

feature {NONE} -- Properties

	menu_entry_name: STRING is "menu_entry"

end -- class MENU_ENTRY
