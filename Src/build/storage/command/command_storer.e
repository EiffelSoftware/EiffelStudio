

class COMMAND_STORER 

inherit

	STORABLE_HDL
		export
			{NONE} all
		end;
	WINDOWS
		export
			{NONE} all
		end;
	STORAGE_INFO
		export
			{NONE} all
		end



	
feature {COMMAND_STORER}

	stored_data: LINKED_LIST [LINKED_LIST [S_COMMAND]];
	
feature 

	retrieved_data: LINKED_LIST [LINKED_LIST [USER_CMD]];

	store (file_name: STRING) is
		do
			retrieved := Void;
			build_stored_data;
			store_by_name (file_name);
			stored_data := Void
		end;

	
feature {NONE}

	build_stored_data is
		local
			s: S_COMMAND;
			user_cmds: LINKED_LIST [LINKED_LIST [USER_CMD]];
			cmd_list: LINKED_LIST [USER_CMD];
			nl: LINKED_LIST [S_COMMAND]
		do
			!!stored_data.make;
			user_cmds := command_catalog.user_commands;
			from
				user_cmds.start
			until
				user_cmds.after
			loop
				cmd_list := user_cmds.item;
				!!nl.make;
				stored_data.extend (nl);
				from
					cmd_list.start
				until
					cmd_list.after
				loop
					!!s.make (cmd_list.item);
					nl.extend (s);
					cmd_list.forth
				end;
				user_cmds.forth
			end;
		end;

	
feature 

	retrieve (file_name: STRING) is
		local
			sc: S_COMMAND;
			cmd: USER_CMD;
			cmd_list: LINKED_LIST [USER_CMD];
			sc_list: LINKED_LIST [S_COMMAND];
		do
			retrieve_by_name (file_name);
			stored_data := retrieved.stored_data;
			!!retrieved_data.make;
			from
				stored_data.start;
			until
				stored_data.after
			loop
				sc_list := stored_data.item;
				!!cmd_list.make;
				retrieved_data.extend (cmd_list);
				from
					sc_list.start
				until
					sc_list.after
				loop
					sc := sc_list.item;
					cmd := sc.command;
					command_table.put (cmd, sc.identifier);
					cmd_list.put_right (cmd);
					cmd_list.forth;
					sc_list.forth
				end;
				stored_data.forth;
			end;
			from
				stored_data.start;
				retrieved_data.start
			until
				stored_data.after
			loop
				sc_list := stored_data.item;
				cmd_list := retrieved_data.item;
				from
					sc_list.start;
					cmd_list.start
				until
					sc_list.after
				loop
					sc := sc_list.item;
					cmd := cmd_list.item;
					sc.update (cmd, file_name);
					cmd_list.forth;
					sc_list.forth
				end;
				retrieved_data.forth;
				stored_data.forth;
			end;
		end;

end
