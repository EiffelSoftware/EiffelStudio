
-- Window to enter shell commands 

class SHELL_W 

inherit

	COMMAND_W;
	NAMER;
	PROMPT_D
		rename
			make as prompt_dialog_create
		end

creation

	make
	
feature 

	make (a_composite: COMPOSITE; cmd: SHELL_COMMAND) is
			-- Create a file selection dialog
		do
			prompt_dialog_create (l_Shell_w, a_composite);
			set_title (l_Shell_w);
			set_selection_label ("Specify shell command");
			hide_apply_button;
			hide_help_button;
			!!ok_it;
			!!cancel_it;
			add_ok_action (Current, ok_it);
			add_cancel_action (Current, cancel_it);
			set_width (350);
			associcated_command := cmd;
		end;

	
feature {NONE}

	ok_it, cancel_it: ANY;
			-- Arguments for the command

feature 
	
	call is
		do
			set_exclusive_grab;
			set_selection_text (associcated_command.command_shell_name);
			popup;
			raise
		end;

feature {NONE}

	associcated_command: SHELL_COMMAND;

	work (argument: ANY) is
		local
			cmd_name: STRING;
        do
			warner.popdown;
			if argument = ok_it then
				cmd_name := associcated_command.command_shell_name;
				cmd_name.wipe_out;
				cmd_name.append (clone (selection_text));
				popdown
			elseif argument = cancel_it then
				popdown
			end
		end;

end
