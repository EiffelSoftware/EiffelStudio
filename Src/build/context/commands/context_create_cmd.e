
class CONTEXT_CREATE_CMD 

inherit

	WINDOWS
		export
			{NONE} all
		end;
	CONTEXT_SHARED
		export
			{NONE} all
		end;
	CONTEXT_CMD
		redefine
			work, redo, undo
		
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			C_reate_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := geometry_form_number
		end;

	
feature 

	work (argument: CONTEXT) is
		do
			context := argument;
		end;

	
feature {NONE}

	command: CONTEXT_CUT_CMD;

	
feature 

	undo is
		do
			context_undo
		end;

	
feature {NONE}

	context_undo is
		local
			group: LINKED_LIST [CONTEXT];
			a_parent: CONTEXT;
		do
			if (command = Void) then
					-- First call
				if context.grouped then
						-- Cut only on context even if it is
						-- grouped with other contexts
					context.set_grouped (False);
					group := context.group;
					group.start;
					group.search (context);
					group.remove;
				end;
				a_parent := context.parent;
				!!command;
					-- work does not put the command in the history list
				command.work (context);
				if (a_parent = Void) then
					if not window_list.empty then
						tree.display (window_list.first)
					else
						tree.display (context)
					end;
				else
					tree.display (a_parent);
				end;
			else
				command.redo
			end;
		end;

	
feature 

	redo is
		do
			command.undo
		end;

	
feature {NONE}

	context_work is
		do
		end;

end
