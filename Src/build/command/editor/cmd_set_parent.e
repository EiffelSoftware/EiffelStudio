
class CMD_SET_PARENT 

inherit

	CMD_UPDATE_PARENT

feature -- Access

	set_previous_parent (c: CMD) is
		do
			previous_parent := c
		end
 
	set_parent_type (c: CMD) is
		do	
			parent := c
		end

	name: STRING is
		do
			Result := Command_names.cmd_set_parent_cmd_name
		end

feature {NONE} -- Implementation

	parent: CMD

	undo is
		do
			edited_command.save_old_template
			if previous_parent = Void then
				remove_parent
			else
				set_parent (previous_parent)
			end
			edited_command.update_text
		end

	command_work is
		do
			edited_command.save_old_template
			set_parent (parent)
			edited_command.update_text
		end

end -- class CMD_SET_PARENT

