
class NAME_CHOOSER_W 

inherit

	COMMAND_W;
	NAMER;
	FILE_SEL_D
		rename
			make as file_sel_d_create
		end

creation

	make
	
feature 

	make (a_composite: COMPOSITE) is
			-- Create a file selection dialog
		do
			file_sel_d_create (l_file_selection, a_composite);
			set_title (l_file_selection);
			hide_help_button;
			add_ok_action (Current, Current);
			add_cancel_action (Current, Void);
			set_title (l_Select_a_file);
		end;

	call (a_command: COMMAND_W) is
			-- Record calling command `a_command' and popup current.
		do
			last_caller := a_command;
			popup
		ensure
			last_caller_recorded: last_caller = a_command
		end;

	
feature {NONE}

	work (argument: ANY) is
        do
			popdown;
			if argument = Current then
				last_caller.execute (Current)
			else
				set_global_cursor (watch_cursor);
                project_tool.set_changed (false);
				exit
			end
		end;

	last_caller: COMMAND_W
			-- Last command which popped up current

end
