indexing 

	description:
		"Class to hold a formatter plus its associated visual representations.";
	date: "$Date$";
	revision: "$Revision$"

class FORMAT_HOLDER

creation
	make

feature -- Initialization

	make (a_frmt: like associated_formatter; a_button: like associated_button) is
			-- Initialize Current, with `associated_formatter' as `a_frmt', `associated_button' as `a_button'.
		require
			non_void_formatter: a_frmt /= Void;
			non_void_button: a_button /= Void;
			-- non_void_menu_entry: a_menu_entry /= Void;
		do
			associated_formatter := a_frmt;
			associated_button := a_button;
			-- associated_menu_entry := a_menu_entry;
			associated_formatter.set_holder (Current);
		ensure
			formatter_set: associated_formatter = a_frmt;
			button_set: associated_button = a_button;
			-- menu_entry_set: associated_menu_entry = a_menu_entry
		end;

feature -- Setting

	set_formatter (a_frmt: like associated_formatter) is
			-- Set `associated_formatter' to `a_frmt'.
		require
			non_void_format: a_frmt /= Void
		do
			associated_formatter := a_frmt;
		ensure
			properly_set: associated_formatter = a_frmt
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

	associated_formatter: FORMATTER_2
			-- Command to execute.

	associated_button: EB_BUTTON
			-- Button for on the toolbars.

	-- associated_menu_entry: EB_MENU_ENTRY
			-- -- Menu Entry for in the menus.

end -- class FORMAT_HOLDER
