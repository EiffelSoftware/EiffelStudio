indexing

	description:
		"Abstract notion of a command holder with a button and %
		%a menu entry.";
	date: "$Date$";
	revision: "$Revision$"

class HOLDER

feature -- Initialization

	make (a_command: like associated_command; a_button: like associated_button; a_menu_entry: like associated_menu_entry) is
			-- Initialize Current, with `associated_command' as `a_command',
			-- and `associated_button' as `a_button'.
		require
			non_void_command: a_command /= Void;
			non_void_button: a_button /= Void;
			non_void_menu_entry: a_menu_entry /= Void;
		do
			associated_command := a_command;
			associated_button := a_button;
			associated_menu_entry := a_menu_entry;
			associated_command.set_holder (Current)
			is_sensitive := True;
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
		do
			associated_command := a_command;
			associated_command.set_holder (Current);
			is_sensitive := True
		ensure
			command_set: associated_command = a_command;
			sensitive: is_sensitive
		end;

feature -- Setting

	set_command (a_command: like associated_command) is
			-- Set `associated_command' to `a_command'.
		require
			non_void_command: a_command /= Void
		do
			associated_command := a_command
		ensure
			properly_set: associated_command = a_command
		end;

	set_button (a_button: like associated_button) is
			-- Set `associated_button' to `a_button'.
		require
			non_void_button: a_button /= Void
		do
			associated_button := a_button
		ensure
			properly_set: associated_button = a_button
		end;

	set_menu_entry (a_menu_entry: like associated_menu_entry) is
			-- Set `associated_menu_entry' to `a_menu_entry'.
		require
			non_void_menu_entry: a_menu_entry /= Void
		do
			associated_menu_entry := a_menu_entry
		ensure
			properly_set: associated_menu_entry = a_menu_entry
		end;

	set_selected (selection: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be selected or not, according to `selection'.
		do
		end;

	set_sensitive (sensitivity: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be sensitive or not, according to `sensitivity'.
		do
			if sensitivity then
				associated_button.set_sensitive;
				associated_menu_entry.set_sensitive
			else
				associated_button.set_insensitive;
				associated_menu_entry.set_insensitive
			end;
			is_sensitive := sensitivity
		end;

feature -- Execution

	execute (a: ANY) is
			-- Executes `associated_command' with `s'.
		do
			associated_command.execute (a)
		end;

feature -- Properties

	associated_command: ICONED_COMMAND;
			-- Command to execute.

	associated_button: EB_BUTTON;
			-- Button on the toolbars.

	associated_menu_entry: MENU_ENTRY;
			-- Menu entry in the menus.

	is_sensitive: BOOLEAN
			-- Can `associated_command' be executed?

invariant
	command_known: associated_command /= Void

end -- class HOLDER
