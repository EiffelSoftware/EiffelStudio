indexing

	description:
		"Abstract notion of a command holder with a button and %
		%a menu entry.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ISE_CMD_HOLDER

feature -- Initialization

	make (a_command: like associated_command; a_button: like associated_button; a_menu_entry: like associated_menu_entry) is
			-- Initialize Current, with `associated_command' as `a_command',
			-- and `associated_button' as `a_button'.
		require
			non_void_command: a_command /= Void;
			non_void_button: a_button /= Void;
			non_void_menu_entry: a_menu_entry /= Void;
		deferred
		ensure
			command_set: associated_command = a_command;
			button_set: associated_button = a_button;
			menu_entry_set: associated_menu_entry = a_menu_entry;
			sensitive: is_sensitive
		end;

	make_plain (a_command: like associated_command) is
			-- Initialize Current, with `associated_command' as `a_command'.
		require
			non_void_command: a_command /= Void;
		deferred
		ensure
			command_set: associated_command = a_command;
			sensitive: is_sensitive
		end;

feature -- Setting

	set_command (a_command: like associated_command) is
			-- Set `associated_command' to `a_command'.
		require
			non_void_command: a_command /= Void
		deferred
		ensure
			properly_set: associated_command = a_command
		end;

	set_button (a_button: like associated_button) is
			-- Set `associated_button' to `a_button'.
		require
			non_void_button: a_button /= Void
		deferred
		ensure
			properly_set: associated_button = a_button
		end;

	set_menu_entry (a_menu_entry: like associated_menu_entry) is
			-- Set `associated_menu_entry' to `a_menu_entry'.
		require
			non_void_menu_entry: a_menu_entry /= Void
		deferred
		ensure
			properly_set: associated_menu_entry = a_menu_entry
		end;

	set_selected (selection: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be selected or not, according to `selection'.
		deferred
		end;

	set_sensitive (sensitivity: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be sensitive or not, according to `sensitivity'.
		deferred
		end;

feature -- Execution

	execute (a: ANY) is
			-- Executes `associated_command' with `s'.
		do
			associated_command.execute (a)
		end;

feature -- Properties

	associated_command: COMMAND;
			-- Command to execute.

	associated_button: ISE_BUTTON;
			-- Button on the toolbars.

	associated_menu_entry: ISE_MENU_ENTRY;
			-- Menu entry in the menus.

	is_sensitive: BOOLEAN
			-- Can `associated_command' be executed?

invariant
	command_known: associated_command /= Void

end -- class ISE_CMD_HOLDER
