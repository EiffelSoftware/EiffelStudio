
deferred class CONTEXT_CMD 

inherit

	WINDOWS
		export
			{NONE} all
		end;
	UNDOABLE
		redefine
			is_template
		end



	
feature 

	is_template: BOOLEAN is true;

feature {NONE}

	context: CONTEXT;

	associated_form: INTEGER is
		deferred
		end;
	
feature 

	c_name: STRING is
			-- Command name
		deferred
		end;

	n_ame: STRING is
		do
			!!Result.make (0);
			Result.append (c_name);
			Result.append (" (");
			Result.append (context.label.duplicate);
			Result.append (")");
		end;

	work (argument: ANY) is
		local
			editor: CONTEXT_EDITOR
		do
			editor ?= argument;
			context ?= editor.edited_context;
			context_work;
			editor.current_form.apply;
		end;

	
feature {NONE}

	context_work is
		deferred
		end;

	context_undo is
		deferred
		end;

	
feature 

	history: HISTORY_WND is
		once
			Result := history_window;
		end;

	failed: BOOLEAN;

	undo is
		local
			editor: CONTEXT_EDITOR
		do
			context_undo;
			editor := context_catalog.editor (context, associated_form);
			if editor /= Void then
				editor.current_form.reset_form
			end;
		end;

	redo is
		do
			undo;
		end;

end

