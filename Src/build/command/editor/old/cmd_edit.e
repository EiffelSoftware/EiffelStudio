
class CMD_EDIT 
	

inherit

	CMD_CMD_NAMES
		rename
			Cmd_edit_cmd_name as c_name
		export
			{NONE} all
		end;
	CMD_COMMAND
		

 

	
feature {NONE}

	previous_command: CMD;

	
feature 

	undo is
		do
			if (previous_command = Void) then
				command_editor.clear
			else
				command_editor.update_editor (previous_command)
			end
		end; -- redo

	redo is
		do
			if  
				not (previous_command = Void) and
				(not (previous_command.command_editor = Void)) 
			then
				current_command.set_editor (previous_command.command_editor);
			end;
			command_editor.update_editor (current_command)
		end; -- undo

	set_previous_command (c: like previous_command) is
		do
			previous_command := c	
		end;

	
feature {NONE}

	command_work is
		do
			update_history
		end; 

	worked_on: STRING is
		do
		end; -- worked_on

end
