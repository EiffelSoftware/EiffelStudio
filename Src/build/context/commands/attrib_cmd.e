
class ATTRIB_CMD 

inherit

	CMD_LIST
		redefine
			work
		end;

creation

	make

feature 

	make (a_cmd: CONTEXT_CMD) is
		do
			command := a_cmd;
			c_name := a_cmd.c_name;
		end;
	
feature {NONE}

	command: CONTEXT_CMD;

	associated_form: INTEGER is
		do
			Result := 0
		end;
	
feature 

	c_name: STRING;

	work (argument: CONTEXT) is
		local
			list: LINKED_LIST [CONTEXT];
			final_list: LINKED_LIST [CONTEXT]
		do
			context := argument;
			!!cmd_list.make;
			if context.grouped then
				list := context.group;
				!! final_list.make;
				from
					list.start
				until
					list.after
				loop
					final_list.append (list.item.children_list_plus_current);
					list.forth
				end;
				from
					final_list.start
				until
					final_list.after
				loop
					save_attribute (final_list.item);
					final_list.forth
				end;
			else
				save_attribute (context)
			end;
			if cmd_list.empty then
				failed := True
			end
		end;

	
feature {NONE}

	save_attribute (a_context: CONTEXT) is
		local
			cmd: CONTEXT_CMD;
		do
			cmd := clone (command);
			cmd.work (a_context);
			if not cmd.failed then
				cmd_list.put_right (cmd);
			end;
		end;

end
