
deferred class CMD_COMMAND 

inherit

	EB_UNDOABLE
		redefine
			is_template, execute
		end;

feature 

	is_template: BOOLEAN is True;
	
	redo is
		do
			command_work
		end;

	execute (argument: ANY) is
		do
			edited_command ?= argument;
			if edited_command /= Void then
				command_work;
				update_history
			end
		end;

feature 
	
	name: STRING is
		do
			!!Result.make (0);
			Result.append (c_name);
			Result.append (" (");
			if edited_command /= Void then
				Result.append (edited_command.label);
			end
			if
				worked_on /= Void
			then
				Result.append ("-");
				Result.append (worked_on);
			end;
			Result.append (")");
		end;
	
	edited_command: USER_CMD

feature {NONE}

	work (argument: ANY) is
		do
		end;

	command_work is
		deferred
		end;
	
	worked_on: STRING is
			-- What the command changed
		deferred
		end; 

	c_name: STRING is
			-- Name of the command
		deferred
		end;

	failed: BOOLEAN;
	
end
