
deferred class CMD_COMMAND 

inherit

	UNDOABLE
		rename
			history as history_window
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

	redo is
		do
			command_work
		end;

	execute (argument: ANY) is
		do
			edited_command ?= argument;
			if
				edited_command /= Void
			then
				command_work;
				update_history
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
			Result.append (edited_command.label);
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

	edited_command: USER_CMD;

end
