indexing

	description:
		"Abstract notion of a menu entry.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ISE_MENU_ENTRY feature

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

	associated_command: COMMAND;
			-- The associated command.

	entry_text: STRING is
			-- Text as displayed on the button.
		deferred
		end;

	insensitive: BOOLEAN is
			-- Is Current insensitive for input from
			-- the user?
		deferred
		end;

feature -- Status setting

	set_sensitive is
			-- Make Current sensitive for input from
			-- the user.
		deferred
		end;

	set_insensitive is
			-- Make Current insensitive for input from
			-- the user.
		deferred
		end;

	set_text (a_string: STRING) is
			-- Set the text to `a_string'.
		deferred
		end;

feature {NONE} -- Properties

	menu_entry_name: STRING is "menu_entry"

end -- class MENU_ENTRY
