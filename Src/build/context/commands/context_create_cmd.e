
class CONTEXT_CREATE_CMD 

inherit

	WINDOWS;
	SHARED_CONTEXT;
	CONTEXT_CMD
		redefine
			work, redo, undo
		end;

feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end;
	
	c_name: STRING is
		do
			Result := Command_names.cont_create_cmd_name
		end;

feature 

	destroy_widgets is
		do
			context.widget.destroy
		end;

	work (argument: CONTEXT) is
		do
			context := argument;
			context.select_tree_element_if_parent_selected
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
					if not Shared_window_list.empty then
						tree.display (Shared_window_list.first)
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
