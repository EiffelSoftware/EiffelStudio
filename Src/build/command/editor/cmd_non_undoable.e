
class CMD_NON_UNDOABLE

inherit

	CMD_SET_CMD_TYPE
	
feature {NONE}

	c_name: STRING is
		do
			Result := Command_names.cmd_non_undoable_cmd_name
		end;

	undo is
		do
			set_undoable_command;
		end; -- undo

	command_work is
		do
			set_non_doable_command;
		end;

end
