
deferred class CMD_COMMAND 

inherit

	UNDOABLE
		redefine
			is_template, execute
		end;
	WINDOWS
		export
			{NONE} all
		end
		

 

	
feature {NONE}

	work (argument: ANY) is
		do
		end;

	
feature 

	execute (argument: ANY) is
		do
			current_command ?= argument;
			if
				not (current_command = Void)
			then
				command_work
			end
		end;

	
feature {NONE}

	command_work is
		deferred
		end;

	
feature 

	n_ame: STRING is
		do
			!!Result.make (0);
			Result.append (c_name);
			Result.append (" (");
			Result.append (current_command.label);
			if
				not (worked_on = Void)
			then
				Result.append ("-");
				Result.append (worked_on);
			end;
			Result.append (")");
		end;

	
feature {NONE}

	worked_on: STRING is
			-- What the command changed
		deferred
		end; 

	c_name: STRING is
			-- Name of the command
		deferred
		end;

	failed: BOOLEAN;

	
feature 

	is_template: BOOLEAN is True;

	
feature {NONE}

	current_command: CMD;

	command_editor: CMD_EDITOR is		
		do
			if (current_command.command_editor = Void) then
				Result := window_mgr.empty_cmd_editor;
				Result.update_editor (current_command);
				window_mgr.display (Result);	
			else	
				Result := current_command.command_editor
			end
		end;

	
feature 

	history: HISTORY_WND is
        once
            Result := history_window;
        end;

end
