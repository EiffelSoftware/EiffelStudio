
class CMD_SET_PARENT 

inherit

	CMD_CMD_NAMES
		rename
			Cmd_set_parent_cmd_name as c_name
		export
			{NONE} all
		end;

	CMD_UPDATE_PARENT
	
feature

    set_previous_parent (c: CMD) is
        do
            previous_parent := c
        end;
 
	set_parent_type (c: CMD) is
		do	
			parent := c
		end;

feature {NONE}

	parent: CMD;

	undo is
		do
			edited_command.save_old_template;
			remove_parent;
			if previous_parent /= Void then
				set_parent (previous_parent);
			end;
			edited_command.update_text
		end; -- undo

	command_work is
		do
			edited_command.save_old_template;
			set_parent (parent);
			edited_command.update_text
		end;

end
