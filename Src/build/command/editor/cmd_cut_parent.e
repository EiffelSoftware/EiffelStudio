
class CMD_CUT_PARENT 

inherit
	CMD_UPDATE_PARENT

feature -- Access

	name: STRING is
		do
			Result := Command_names.cmd_cut_parent_cmd_name
		end

feature {NONE} -- Implementation

	undo is
		do
			edited_command.save_old_template
			set_parent (previous_parent)
			edited_command.update_text
		end

	command_work is
		do
			edited_command.save_old_template
			previous_parent := edited_command.ancestor_type
			remove_parent
			edited_command.update_text
		end

end -- class CMD_CUT_PARENT

