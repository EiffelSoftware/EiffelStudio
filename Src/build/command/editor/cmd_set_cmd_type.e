
deferred class CMD_SET_CMD_TYPE

inherit

	CMD_COMMAND

feature {NONE}

	set_undoable_command is
		do
			edited_command.save_old_template;
			edited_command.set_undoable (True);
			edited_command.update_text;
		end;

	set_non_doable_command is
		do
			edited_command.save_old_template;
			edited_command.set_undoable (False);
			edited_command.update_text;
		end;

	worked_on: STRING is
		do
		end

end
