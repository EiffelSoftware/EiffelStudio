
class SEL_MGR_CMD 

inherit

	CMD_LIST
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
		do
			context := argument;
			!!cmd_list.make;
			if context.grouped then
				list := context.group;
				from
					list.start
				until
					list.offright
				loop
					save_context (list.item);
					list.forth
				end;
			else
				save_context (context)
			end;
		end;

	
feature {NONE}

	save_context (a_context: CONTEXT) is
		local
			cmd: SEL_SINGLE_CMD;
		do
			!!cmd;
			cmd.work (a_context);
			cmd_list.add_right (cmd);
		end;

end
