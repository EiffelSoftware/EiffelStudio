indexing

	description:
		"Menu entry for Bench with a tick.";
	date: "$Date$";
	revision: "$Revision$"

class EB_TICKABLE_MENU_ENTRY

inherit
	TOGGLE_B
		rename
			make as button_make
		end
	MENU_ENTRY

creation
	make

feature {NONE} -- Initialization

	initialize_button (a_parent: MENU) is
			-- Initializes the button part.
		do
			button_make (menu_entry_name, a_parent);
			set_text (entry_text);
			add_activate_action (associated_command, associated_command.text_window)
		end;

feature -- Status setting

	set_selected (b:BOOLEAN) is
			-- Set the tick or un set it, according to `b'.
		do
			if b then
				set_toggle_on
			else
				set_toggle_off
			end
		end;

end -- class EB_TICKABLE_MENU_ENTRY
