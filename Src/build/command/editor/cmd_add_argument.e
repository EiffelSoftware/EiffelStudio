
class CMD_ADD_ARGUMENT 

inherit

	CMD_ADD
		rename
			command_work as old_command_work
		redefine
			element
		end;
	CMD_ADD
		redefine
			element, command_work
		select
			command_work
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
		do
			old_command_work;
			edited_command.update_instance_editors
		end

end
