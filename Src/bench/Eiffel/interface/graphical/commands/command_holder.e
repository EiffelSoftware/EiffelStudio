indexing 

	description:
		"Class to hold a command plus its associated visual representations.";
	date: "$Date$";
	revision: "$Revision$"

class COMMAND_HOLDER

creation
	make

feature -- Initialization

	make (a_cmd: like associated_command; a_button: like associated_button) is
			-- Initialize Current, with `associated_command' as `a_cmd', `associated_button' as `a_button'.
		require
			non_void_command: a_cmd /= Void;
			non_void_button: a_button /= Void;
			-- non_void_menu_entry: a_menu_entry /= Void;
		do
			associated_command := a_cmd;
			associated_button := a_button;
			-- associated_menu_entry := a_menu_entry;
		ensure
			command_set: associated_command = a_cmd;
			button_set: associated_button = a_button;
			-- menu_entry_set: associated_menu_entry = a_menu_entry
		end;

feature -- Setting

	set_command (a_cmd: like associated_command) is
			-- Set `associated_command' to `a_cmd'.
		require
			non_void_command: a_cmd /= Void
		do
			associated_command := a_cmd;
		ensure
			properly_set: associated_command = a_cmd
		end;

	set_button (a_button: like associated_button) is
			-- Set `associated_button' to `a_button'.
		require
			non_void_button: a_button /= Void
		do
			associated_button := a_button;
		ensure
			properly_set: associated_button = a_button
		end;

	-- set_menu_entry (a_menu_entry: like associated_menu_entry) is
			-- -- Set `associated_menu_entry' to `a_menu_entry'.
		-- require
			-- non_void_menu_entry: a_menu_entry /= Void
		-- do
			-- associated_menu_entry := a_menu_entry;
		-- ensure
			-- properly_set: associated_menu_entry = a_menu_entry
		-- end;

feature -- Properties

	associated_command: ICONED_COMMAND_2
			-- Command to execute.

	associated_button: EB_BUTTON
			-- Button for on the toolbars.

	-- associated_menu_entry: EB_MENU_ENTRY
			-- -- Menu Entry for in the menus.

end -- class COMMAND_HOLDER
