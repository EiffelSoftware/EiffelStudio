
class ARROW_MOVE_CMD 

inherit

	CMD_LIST
		export
			{ANY} all
		redefine
			work
		
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			G_eometry_cmd_name as c_name
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
		local
			list: LINKED_LIST [CONTEXT];
			last_cmd: ARROW_MOVE_CMD
		do
			context := argument;
			if not history.before then
				last_cmd ?= history.item;
			end;
			if (last_cmd = Void) or else last_cmd.context /= context then 
					-- If the previous command in the history
					-- is an arrow_move cmd then do nothing
				!!cmd_list.make;
				if context.grouped then
					list := context.group;
					from
						list.start
					until
						list.after
					loop
						save_context (list.item);
						list.forth
					end;
				else
					save_context (context)
				end;
			else
				failed := True
			end;
		end;

	
feature {NONE}

	save_context (a_context: CONTEXT) is
		local
			cmd: SEL_SINGLE_CMD;
		do
			!!cmd;
			cmd.work (a_context);
			cmd_list.put_right (cmd);
		end;

end
