
class CMD_CUT_PARENT 

inherit

	CMD_CMD_NAMES
		rename
			Cmd_cut_parent_cmd_name as c_name
		export
			{NONE} all
		end;

	CMD_UPDATE_PARENT
	
feature {NONE}

	undo is
		do
			edited_command.save_old_template;
			set_parent (previous_parent);
			edited_command.update_text
		end;

	command_work is
		do
			edited_command.save_old_template;
			previous_parent := edited_command.parent_type;
			remove_parent;
			edited_command.update_text
		end;

end
