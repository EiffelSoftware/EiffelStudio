
class CMD_CUT_ARGUMENT 

inherit

	CMD_CUT
		rename
			undo as old_undo,
			command_work as old_command_work
		redefine
			element
		end;
	CMD_CUT
		redefine
			element, command_work, undo
		select
			command_work, undo
		end;
	
feature {NONE}

	element: ARG;

    cmd_instance_list: LINKED_LIST [CMD_INSTANCE];
    cmd_instance_arg_list: LINKED_LIST [ARG_INSTANCE];
			-- Argument removed corresponding to
			-- cmd_instance_list

	c_name: STRING is
		do
			Result := Command_names.cmd_cut_argument_cmd_name
		end;

	list: EB_LINKED_LIST [ARG] is
		do
			Result := edited_command.arguments
		end;

    undo is
        local
			cmd_instance: CMD_INSTANCE
        do
            old_undo;
            from
                cmd_instance_list.start
                cmd_instance_arg_list.start
            until
                cmd_instance_list.after
            loop
                cmd_instance_list.item.add_argument_at (index,
						cmd_instance_arg_list.item);
                cmd_instance_arg_list.start
                cmd_instance_list.forth
            end
        end;

    command_work is
        local
			args: EB_LINKED_LIST [ARG_INSTANCE]
        do
            old_command_work;
			if cmd_instance_list = Void then
				!! cmd_instance_arg_list.make;
            	cmd_instance_list := edited_command.instances;
            	from
                	cmd_instance_list.start
            	until
                	cmd_instance_list.after
            	loop
					args := cmd_instance_list.item.arguments;
                	args.go_i_th (index);
					cmd_instance_arg_list.extend (args.item);
                	cmd_instance_list.forth
            	end
			end;
            from
                cmd_instance_list.start
            until
                cmd_instance_list.after
            loop
                cmd_instance_list.item.remove_argument (index);
                cmd_instance_list.forth
            end
        end;

end
