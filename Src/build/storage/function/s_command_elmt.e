
class S_COMMAND_ELMT 

inherit

	STORAGE_INFO
		export
			{NONE} all
		end


creation

	make

	
feature 

	make (other: CMD_INSTANCE) is
		local
			args: LIST [ARG_INSTANCE]
		do
			identifier := other.identifier;
			!!arguments.make;
			from
				args := other.arguments;
				args.start
			until
				args.after
			loop
				arguments.add (args.item.identifier);
				args.forth
			end;
		end;

	command: CMD_INSTANCE is
		local
			arg: ARG_INSTANCE;
			arg_list: EB_LINKED_LIST [ARG_INSTANCE];
			cmd: CMD;
			ct: CONTEXT_TYPE;
			cs: CONTEXT
		do
			if (identifier > 0) then
				cmd := command_table.item (identifier);	
			else
				cmd := predefined_command_table.item (- identifier);
			end;
			!!arg_list.make;
			from
				arguments.start		
			until
				arguments.after
			loop
				if arguments.item > 0 then
					cs := context_table.item (arguments.item);
					ct := cs.context_type
				else
					ct := context_type_table.item (- arguments.item);
					cs := Void
				end;
				!!arg.storage_init (ct, cs);
				arg_list.add (arg);
				arguments.forth
			end;
			!!Result.storage_init (cmd, arg_list);
		end;

	
feature {NONE}

	identifier: INTEGER;

	arguments: LINKED_LIST [INTEGER];

end
