indexing

	description:
		"Menu entry for the preference tool with a tick.";
	date: "$Date$";
	revision: "$Revision$"

class PREFERENCE_TICKABLE_MENU_ENTRY

inherit
	TOGGLE_B
		rename
			make as button_make
		end;
	ISE_MENU_ENTRY
		rename
			make as ime_make
		end

creation
	make

feature {NONE} -- Initialization

	make (cmd: PREFERENCE_CATEGORY; a_parent: MENU) is
		require
			cmd_not_void: cmd /= Void;
			a_parent_not_void: a_parent /= Void;
		do
			button_make (menu_entry_name, a_parent);
			entry_text := cmd.name;
			set_text (cmd.name);
			add_activate_action (cmd, cmd.name)
		end;
	
feature -- Properties

	entry_text: STRING;

feature -- Status setting

	set_selected (b:BOOLEAN) is
			-- Set the tick or un set it, according to `b'.
		do
			if b then
				set_toggle_on
			else
				set_toggle_off
			end
		end

feature -- Useless

	initialize_button (a_parent: MENU) is
			-- Useless here
		do
			--| Do nothing
		end

end -- class PREFERENCE_TICKABLE_MENU_ENTRY
