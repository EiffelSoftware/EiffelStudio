indexing

	description:
		"Holder for the preference tool.";
	date: "$Date$";
	revision: "$Revision$"

class PREFERENCE_HOLDER

inherit
	ISE_CMD_HOLDER
		rename
			make_plain as ise_make_plain
		redefine
			associated_button, associated_menu_entry
		end

creation
	make_plain

feature {NONE} -- Initialization

	make_plain (a_command: like associated_command) is
			-- Initialize Current with `a_command'.
		require
			a_command_not_void: a_command /= Void
		do
			associated_command := a_command
		ensure
			command_set: a_command.is_equal (associated_command)
		end

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
			-- Set both `associated_button' and `associated_menu_entry'
			-- to be selected or not, according `selection'.
		do
			if associated_button /= Void then
				associated_button.set_selected (selection)
			end;
			if associated_menu_entry /= Void then
				associated_menu_entry.set_selected (selection)
			end
		end

feature -- Properties

	associated_command: PREFERENCE_COMMAND;
			-- Command for the preference tool

	associated_button: PREFERENCE_BUTTON;
			-- Button on the toolbar

	associated_menu_entry: PREFERENCE_MENU_ENTRY
			-- Menu entry for in the menu

feature {NONE} -- Useless

	make (a_button: like associated_button; a_menu_entry: like associated_menu_entry) is
			-- Useless here.
		do
		end;

	ise_make_plain is
			-- Useless here.
		do
		end

end -- class PREFERENCE_HOLDER
