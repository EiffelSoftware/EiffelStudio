indexing

	description:
		"Abstract notion of a command holder with a button and %
		%a menu entry.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ISE_CMD_HOLDER

feature -- Initialization

	make (a_button: like associated_button; a_menu_entry: like associated_menu_entry) is
			-- Initialize Current, with `associated_command' as `a_command',
			-- and `associated_button' as `a_button'.
		require
			non_void_button: a_button /= Void;
			non_void_menu_entry: a_menu_entry /= Void;
		deferred
		ensure
			button_set: associated_button = a_button;
			menu_entry_set: associated_menu_entry = a_menu_entry;
		end;

	make_plain is
			-- Initialize Current, with `associated_command' as `a_command'.
		deferred
		end;

feature -- Setting

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

feature -- Properties

	associated_button: ISE_BUTTON;
			-- Button on the toolbars.

	associated_menu_entry: ISE_MENU_ENTRY;
			-- Menu entry in the menus.

end -- class ISE_CMD_HOLDER
