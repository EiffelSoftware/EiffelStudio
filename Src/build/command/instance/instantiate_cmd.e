
class INSTANTIATE_CMD 

inherit

	EB_UNDOABLE
		redefine
			is_template, execute
		end;
		
creation

	make 

	
feature {NONE}

	previous_context, current_context: CONTEXT;
	
feature 

	make (argument: ARG_INSTANCE) is
		do
			current_argument := argument
		end;

feature {NONE}

	work (argument: ANY) is
		do
		end;

feature 

	execute (argument: CONTEXT) is
		do
			if not (current_argument.context = Void) then
				previous_context := current_argument.context.data;
			end;
			current_context := argument;
			current_argument.set_context (current_context);
			update_history
		end;

	redo is 
		do
			current_argument.set_context (current_context)	
		end;

	undo is		
		do
			if (previous_context = Void) then
				current_argument.reset_context
			else
				current_argument.set_context (previous_context)
			end
		end;

	name: STRING is
		do
			!!Result.make (0);
			Result.append (Command_names.cmd_instantiated_cmd_name);
			Result.append (" (");
			if current_argument.type /= Void then
				Result.append (current_argument.type.label);
			end
			Result.append (" - ");
			if current_context /= Void then
				Result.append (current_context.label); 
            end

			Result.append (")");
		end;

	
feature {NONE}

	failed: BOOLEAN;

	
feature 

	is_template: BOOLEAN is True;

	
feature {NONE}

	current_argument: ARG_INSTANCE;

end
