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
		redefine
			associated_command
		end

create
	make

feature -- Initialization

	make (a_cmd: like associated_command; a_parent: MENU) is
			-- Initialize the button in preference tool.
		do
			button_make (menu_entry_name, a_parent)
			set_text (a_cmd.name)
			add_activate_action (a_cmd, Void)
		end

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

feature -- Properties

	associated_command: PREFERENCE_CATEGORY is
			-- Command type that menu entry expects
		do
		end;

end -- class PREFERENCE_TICKABLE_MENU_ENTRY
