indexing

	description:
		"Menu entry for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class EB_MENU_ENTRY

inherit
	ISE_MENU_ENTRY
		redefine
			make,
			associated_command
		end;
	PUSH_B
		rename
			make as button_make
		end;
	SYSTEM_CONSTANTS

create
	make, 
	make_default,
	make_button_only

feature {NONE} -- Initialization

	make (a_cmd: TOOL_COMMAND; a_parent: MENU) is
			-- Initialize button with tool command `a_cmd' and parent `a_parent'.
			-- The action will pass `tool' to the argument of the command.
		do
			make_button_only (a_cmd, a_parent);
			add_activate_action (a_cmd, a_cmd.tool);
		end;

	make_default (a_cmd: like associated_command; a_parent: MENU) is
			-- Initialize button with default command type `a_cmd' and parent `a_parent'.
			-- The action will pass Void to the argument of the command.
		require
			non_void_cmd: a_cmd /= Void;
			non_void_parent: a_parent /= Void;
		do
			make_button_only (a_cmd, a_parent);
			add_activate_action (a_cmd, Void);
		end;

	make_button_only (a_cmd: like associated_command; a_parent: MENU) is
			-- Initialize the button part.
			-- Do not add any action.
		require
			non_void_cmd: a_cmd /= Void;
			non_void_parent: a_parent /= Void
		local
			act: STRING;
		do
			button_make (a_cmd.menu_name, a_parent);	
			act := a_cmd.accelerator;
			if act /= Void then
				set_accelerator_action (act)
			end
		end;

	associated_command: ISE_COMMAND is
			-- Command type that menu entry expects
		do
		end

end -- class EB_MENU_ENTRY
