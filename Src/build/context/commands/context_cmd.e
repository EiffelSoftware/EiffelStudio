
deferred class CONTEXT_CMD 

inherit

	CONSTANTS;
	EB_UNDOABLE
		redefine
			is_template
		end

feature 

	is_template: BOOLEAN is true;

feature 

	context: CONTEXT;

	associated_form: INTEGER is
		deferred
		end;
	
feature 

	c_name: STRING is
			-- Command name
		deferred
		end;

	name: STRING is
			
		do
			!!Result.make (0);
			
			if context /= Void then
				Result.append (c_name);
				Result.append (" (");
				
				if context.label /= Void then
					Result.append (clone (context.label));
				else
					Result.append (" ");
				end;
				Result.append (")");
			end
			
		end;

	work (argument: ANY) is
		local
			editor: CONTEXT_EDITOR
		do
			editor ?= argument;
			context ?= editor.edited_context;
			context_work;
			editor.apply_current_form;
		end;

feature {NONE}

	context_work is
		deferred
		end;

	context_undo is
		deferred
		end;
	
feature 

	failed: BOOLEAN;

	undo is
		local
			editor: CONTEXT_EDITOR
		do
			context_undo;
			editor := context_catalog.editor (context, associated_form);
			if editor /= Void then
				editor.reset_current_form
			end;
		end;

	redo is
		do
			undo;
		end;

end

