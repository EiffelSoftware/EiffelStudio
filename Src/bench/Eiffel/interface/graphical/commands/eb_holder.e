indexing

	description:
		"Abstract notion of a command holder with a button and %
		%a menu entry for EBench.";
	date: "$Date$";
	revision: "$Revision$"

class EB_HOLDER

inherit
	ISE_CMD_HOLDER
		rename
			make as ise_make,
			make_plain as ise_make_plain
		redefine
			associated_button
		end

feature -- Initialization

	make (a_command: like associated_command; a_button: like associated_button; a_menu_entry: like associated_menu_entry) is
			-- Initialize Current, with `associated_command' as `a_command',
			-- and `associated_button' as `a_button'.
		do
			associated_button := a_button;
			associated_menu_entry := a_menu_entry;
			make_plain (a_command);
		ensure then
			command_set: associated_command.is_equal (a_command)
		end;

	make_plain (a_command: like associated_command) is
			-- Initialize Current, with `associated_command' as `a_command'.
		do
			associated_command := a_command;
		end;

feature -- Execution

	execute (arg: ANY) is
			-- Execute `associated_command'.
		do
			associated_command.execute (arg)
		end

feature -- Setting

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
		end;

feature -- Properties

	associated_command: PIXMAP_COMMAND;
			-- Command held by Current

	associated_button: EB_BUTTON
			-- Button to represent `associated_command'

feature {NONE} -- Useless

	ise_make (a_button: like associated_button; a_menu_entry: like associated_menu_entry) is
			-- Initialize Current, with `associated_command' as `a_command',
			-- and `associated_button' as `a_button'.
		do
		end;

	ise_make_plain is
			-- Initialize Current, with `associated_command' as `a_command'.
		do
		end;

end -- class EB_HOLDER
