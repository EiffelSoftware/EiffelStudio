
deferred class APP_COMMAND 

inherit

	UNDOABLE
		redefine
			is_template, update_history, execute
		end;
	WINDOWS
		export
			{NONE} all
		end
	
feature 

	is_template: BOOLEAN is True;

	execute (argument: ANY) is
		do
			work (argument)
		end;

	n_ame: STRING is
		do
			!!Result.make (0);
			Result.append (c_name);
			if
				not (worked_on = Void)
			then
				Result.append (" (");
				Result.append (worked_on);
				Result.append (")");
			end;
		end;

	history: HISTORY_WND is
		once
			Result := history_window
		end; -- history
	
	redo is
			-- Redo a command
		do
			do_specific_work
		end; -- redo

	set_for_macro is
		do
			for_macro := True
		end; -- set_for_macro

feature {NONE}

	for_macro: BOOLEAN;

	worked_on: STRING is
			-- What the command changed
		deferred
		end; 

	c_name: STRING is
			-- Name of the command
		deferred
		end;

	failed: BOOLEAN;

	application_editor: APP_EDITOR is
			-- Associated application editor
		do
			Result := app_editor
		end;

	do_specific_work is
			-- Do work more specific for the command executed.
		deferred
		end;

	perform_update_display is
			-- Update the display if the command is not
			-- a macro
		do
			if
				not for_macro
			then
				update_display
			end
		end;

	update_display is
			-- Updates the display of the application_editor. 
		deferred
		end;

	update_history is
		do
			if
				not for_macro
			then
				history.record (Current)
			end
		end;

end 
