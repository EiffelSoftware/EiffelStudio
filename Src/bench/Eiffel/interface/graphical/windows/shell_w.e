
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

	make (a_composite: COMPOSITE) is
			-- Create a file selection dialog
		do
			prompt_dialog_create (l_Shell_w, a_composite);
			hide_apply_button;
			hide_help_button;
			!!ok_it;
			!!cancel_it;
			add_ok_action (Current, ok_it);
			add_cancel_action (Current, cancel_it);
			set_width (100);
		end;

	
feature {NONE}

	ok_it, cancel_it: ANY;
			-- Arguments for the command

feature 
	
	call (cmd: SHELL_COMMAND) is
		do
			associcated_command := cmd;
			set_exclusive_grab;
			set_selection_text (associcated_command.command_shell_name);
			popup
		end;

feature {NONE}

	associcated_command: SHELL_COMMAND;

	work (argument: ANY) is
		local
			cmd_name: STRING;
        do
			if argument = ok_it then
				cmd_name := associcated_command.command_shell_name;
				if not selection_text.empty then
					cmd_name.wipe_out;
					cmd_name.append (selection_text.duplicate);
					popdown;
				else
					set_selection_text (cmd_name);
				end;
			elseif argument = cancel_it then
				associcated_command := Void;
				popdown
			end
		end;

end
