indexing 

	description:
		"Class to hold a formatter plus its associated visual representations.";
	date: "$Date$";
	revision: "$Revision$"

class FORMAT_HOLDER

inherit
	TWO_STATE_CMD_HOLDER
		rename
			change_state as set_selected
		redefine
			associated_menu_entry, set_selected,
			associated_command, associated_button,
			make_plain
		end

create
	make, 
	make_plain

feature -- Initialization

	make_plain (a_command: like associated_command) is
			-- Initialize Current, with `associated_command' as `a_command'.
		do
			associated_command := a_command;
			a_command.set_holder (Current)
		end;

feature -- Properties

	associated_command: FORMATTER;
			-- Command to execute

	associated_button: FORMAT_BUTTON;
			-- Button to represent `associated_command'
			-- in the toolbar

	associated_menu_entry: EB_TICKABLE_MENU_ENTRY
			-- Menu entry with a tick

feature -- Status setting

	set_selected (selection: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be selected or not, according `selection'.
		do
			if associated_button /= Void then
				associated_button.set_selected (selection)
			end;
			if associated_menu_entry /= Void then
				associated_menu_entry.set_selected (selection);
			end;
		end;

end -- class FORMAT_HOLDER
