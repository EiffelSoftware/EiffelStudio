
class SEL_MGR_CMD 

inherit

	CMD_LIST
		redefine
			work
		end

feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end;

	c_name: STRING is
		do
			Result := Context_const.geometry_cmd_name
		end;

feature 

	work (argument: CONTEXT) is
		local
			list: LINKED_LIST [CONTEXT];
		do
			context := argument;
			!! cmd_list.make;
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
		end;

	
feature {NONE}

	save_context (a_context: CONTEXT) is
		local
			cmd: SEL_SINGLE_CMD;
		do
			!! cmd;
			cmd.work (a_context);
			cmd_list.put_right (cmd);
		end;

end
