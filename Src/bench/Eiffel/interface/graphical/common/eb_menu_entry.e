indexing

	description:
		"Menu entry for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class EB_MENU_ENTRY

inherit
	ISE_MENU_ENTRY
		redefine
			associated_command
		end;
	PUSH_B
		rename
			make as button_make
		end

creation
	make, make_button_only,
	make_tools_menu

feature {NONE} -- Initialization

	initialize_button (a_cmd: like associated_command; a_parent: MENU) is
			-- Initialize the button part.
			-- Add activate action with argument to be
			-- `associated_command.text_window'.
		do
			make_button_only (a_cmd, a_parent);
			add_activate_action (a_cmd, a_cmd.tool);
		end;

	make_button_only (a_cmd: like associated_command; a_parent: MENU) is
			-- Initialize the button part.
			-- Do not add any action.
		require
			non_void_cmd: a_cmd /= Void;
			non_void_parent: a_parent /= Void
		local
			act: STRING;
			st: STRING
		do
			st := a_cmd.menu_name;
			if st = Void then
print ("command name: ")
print (a_cmd.name);
print ("%N")
				st := "TOTOOTOTOTOOT"
			end;
			button_make (st, a_parent);
			act := a_cmd.accelerator;
			if act /= Void then	
				set_accelerator_action (act)
			end
		end;

	make_tools_menu (a_cmd: like associated_command; a_parent: MENU) is
			-- Initialize Current with `associated_command' set
			-- to `a_cmd' and `parent' set to `a_parent'.
		require
			non_void_cmd: a_cmd /= Void;
			non_void_parent: a_parent /= Void
		do
			associated_command := a_cmd;
			initialize_button (a_cmd, a_parent)
		end

feature -- Properties

	associated_command: TOOL_COMMAND
			-- Command type that menu entry expects

end -- class EB_MENU_ENTRY
