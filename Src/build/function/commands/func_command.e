
deferred class FUNC_COMMAND 

inherit

	EB_UNDOABLE
		redefine
			is_template, update_history, execute
		end;

feature 

	execute (argument: BUILD_FUNCTION) is
		do
			edited_function := argument;
			function_work;
		end;

	name: STRING is
		do
			!!Result.make (0);
			Result.append (c_name);
			Result.append (" (");
			if edited_function /= Void then
				Result.append (edited_function.label);
			end
			if	worked_on /= Void then
				Result.append ("-");
				Result.append (worked_on);
			end;
			Result.append (")");
		end;

	undo is 
		do
			undo_work;
			update_interface;
			update_page_number
		end;

	redo is
		do
			redo_work;
			update_interface;
			update_page_number;
		end

feature {NONE}

	update_page_number is
		do
			if edited_function.func_editor /= Void then
				edited_function.func_editor.display_page_number
			end
		end;

	update_interface is
		do
			App_editor.update_transitions_list (Void)
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

	edited_function: BUILD_FUNCTION;
			-- function being edited 

	update_history is
		do
			history.record (Current);
			update_page_number
		end;

end -- class APP_COMMAND


