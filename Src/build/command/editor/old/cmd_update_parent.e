
deferred class CMD_UPDATE_PARENT 

inherit

	CMD_COMMAND
		redefine
			current_command
		end

feature {NONE}

	current_command: USER_CMD;
 
	inherited_command: CMD;
 
	undo is
		do
			undo_work;
			command_editor.update_text
		end;
 
	redo is
		do
			redo_work;
			command_editor.update_text
		end;
 
feature {NONE}
 
	undo_work is
		deferred
		end;
 
	redo_work is
		deferred
		end;

	set_parent is
		do
			command_editor.inh_cmd_stone.set_inherit_command (inherited_command);
			current_command.set_parent (inherited_command);
			command_editor.inh_cmd_stone.show
		end; -- redo
 
	remove_parent is
		do
			command_editor.inh_cmd_stone.hide;
			current_command.remove_parent;
		end; -- undo
 
	command_work is
		do
			inherited_command := current_command.parent_type;
			update_history
		end;
 
	worked_on: STRING is
		do
			!!Result.make (0);
			Result.append (inherited_command.label);
		end; -- worked_on
 
end
 

