
deferred class FUNC_COMMAND 

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

	execute (argument: FUNCTION) is
		do
			edited_function := argument;
			function_work;
		end;

	n_ame: STRING is
		do
			!!Result.make (0);
			Result.append (c_name);
			Result.append (" (");
			Result.append (edited_function.label);
			if	
				not (worked_on = Void)
			then
				Result.append ("-");
				Result.append (worked_on);
			end;
			Result.append (")");
		end;

	undo is 
		do
			undo_work;
			update_page_number
		end;

	redo is
		do
			redo_work;
			update_page_number
		end

feature {NONE}

	update_page_number is
		do
			if edited_function.func_editor /= Void then
				edited_function.func_editor.display_page_number
			end
		end;

	undo_work is
			-- Undo the command
		deferred
		end;

	redo_work is
			-- Redo the command
		deferred
		end;

	function_work is
		deferred
		end; -- function_work

	work (argument: ANY) is
		do
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

	is_template: BOOLEAN is True;

	edited_function: FUNCTION;
			-- function being edited 

	history: HISTORY_WND is
		once
			Result := history_window
		end; -- history
	
	update_history is
		do
			history.record (Current);
			update_page_number
		end;

end -- class APP_COMMAND


