indexing
	description: "Menu entry for Bench with a tick.";
	date: "$Date$";
	revision: "$Revision$"

class EB_TICKABLE_MENU_ENTRY

inherit
	TOGGLE_B
		rename
			make as button_make
		end

	ISE_MENU_ENTRY
		redefine
			associated_command
		end

create
	make

feature {NONE} -- Initialization

	make (a_cmd: like associated_command; a_parent: MENU) is
			-- Initializes the button part.
		local
			act: STRING
		do
			button_make (a_cmd.menu_name, a_parent)
			act := a_cmd.accelerator
			if act /= Void then
				set_accelerator_action (act)
			end
			add_activate_action (a_cmd, a_cmd.tool)
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
		end

feature -- Properties

	associated_command: TOOL_COMMAND is
			-- The associated_command
		do	
		end

end -- class EB_TICKABLE_MENU_ENTRY
