indexing

	description:	
		"Window to enter shell commands.";
	date: "$Date$";
	revision: "$Revision$"

class SHELL_W 

inherit

	COMMAND_W;
	NAMER;
	PROMPT_D
		rename
			make as prompt_dialog_create
		end;
	WINDOW_ATTRIBUTES

creation

	make
	
feature -- Initialization

	make (a_composite: COMPOSITE; cmd: SHELL_COMMAND) is
			-- Create a file selection dialog
		do
			prompt_dialog_create (Interface_names.n_X_resource_name, a_composite);
			set_title (Interface_names.t_Shell_w);
			set_selection_label ("Specify shell command");
			hide_apply_button;
			hide_help_button;
			!!ok_it;
			!!cancel_it;
			add_ok_action (Current, ok_it);
			add_cancel_action (Current, cancel_it);
			set_width (350);
			associcated_command := cmd;
			set_composite_attributes (Current)
		end;

feature -- Access

	call is
		do
			set_exclusive_grab;
			set_selection_text (associcated_command.command_shell_name);
			popup;
			raise
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
		local
			cmd_name: STRING
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			if argument = ok_it then
				cmd_name := associcated_command.command_shell_name;
				cmd_name.wipe_out;
				cmd_name.append (clone (selection_text));
				unrealize;
				popdown
			elseif argument = cancel_it then
				unrealize;
				popdown
			end
		end;

feature {NONE} -- Properties

	associcated_command: SHELL_COMMAND;

	ok_it, cancel_it: ANY;
			-- Arguments for the command

end -- class SHELL_W
