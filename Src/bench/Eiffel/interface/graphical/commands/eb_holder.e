indexing

	description:
		"Abstract notion of a command holder with a button and %
		%a menu entry for EBench.";
	date: "$Date$";
	revision: "$Revision$"

class EB_HOLDER

inherit
	ISE_CMD_HOLDER
		redefine
			associated_command, associated_button
		end

feature -- Initialization

	make (a_command: like associated_command; a_button: like associated_button; a_menu_entry: like associated_menu_entry) is
			-- Initialize Current, with `associated_command' as `a_command',
			-- and `associated_button' as `a_button'.
		do
			associated_command := a_command;
			associated_button := a_button;
			associated_menu_entry := a_menu_entry;
			associated_command.set_holder (Current)
			is_sensitive := True;
		end;

	make_plain (a_command: like associated_command) is
			-- Initialize Current, with `associated_command' as `a_command'.
		do
			associated_command := a_command;
			associated_command.set_holder (Current);
			is_sensitive := True
		end;

feature -- Setting

	set_command (a_command: like associated_command) is
			-- Set `associated_command' to `a_command'.
		do
			associated_command := a_command
		end;

	set_button (a_button: like associated_button) is
			-- Set `associated_button' to `a_button'.
		do
			associated_button := a_button
		end;

	set_menu_entry (a_menu_entry: like associated_menu_entry) is
			-- Set `associated_menu_entry' to `a_menu_entry'.
		do
			associated_menu_entry := a_menu_entry
		end;

	set_selected (selection: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be selected or not, according to `selection'.
		do
		end;

	set_sensitive (sensitivity: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be sensitive or not, according to `sensitivity'.
		local
			b: like associated_button;
			m: like associated_menu_entry
		do
			b := associated_button;
			m := associated_menu_entry
			if sensitivity then
				if b /= Void then
					b.set_sensitive
				end;
				if m /= Void then
					m.set_sensitive
				end
			else
				if b /= Void then
					b.set_insensitive
				end;
				if m /= Void then
					m.set_insensitive
				end
			end;
			is_sensitive := sensitivity
		end;

feature -- Properties

	associated_command: ICONED_COMMAND;
			-- Command to execute.

	associated_button: EB_BUTTON
			-- Button to represent `associated_command'

end -- class EB_HOLDER
