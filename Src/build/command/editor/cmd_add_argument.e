
class CMD_ADD_ARGUMENT 

inherit

	CMD_ADD
		rename
			undo as old_undo,
			command_work as old_command_work
		redefine
			element
		end;
	CMD_ADD
		redefine
			element, command_work, undo
		select
			command_work, undo
		end

feature {NONE}

	element: ARG;

	c_name: STRING is
		do
			Result := Command_names.cmd_add_argument_cmd_name
		end;

	list: EB_LINKED_LIST [ARG] is
		do
			Result := edited_command.arguments
		end;

	command_work is
		local
			cmd_instance_list: LINKED_LIST [CMD_INSTANCE]
		do
			if cmd_instance_list = Void then
				cmd_instance_list := edited_command.instances;
			end;
			old_command_work;
			from
				cmd_instance_list.start
			until
				cmd_instance_list.after
			loop
				cmd_instance_list.item.add_argument;
				cmd_instance_list.forth
			end
		end

	undo is
		local
			cmd_instance_list: LINKED_LIST [CMD_INSTANCE]
		do
			old_undo;
			cmd_instance_list := edited_command.instances;
			from
				cmd_instance_list.start
			until
				cmd_instance_list.after
			loop
				cmd_instance_list.item.remove_argument (edited_command.arguments.count + 1);
				cmd_instance_list.forth
			end
		end;

end
