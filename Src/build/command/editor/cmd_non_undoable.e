
class CMD_NON_UNDOABLE

inherit

	CMD_CMD_NAMES
		rename
			Cmd_non_undoable_cmd_name as c_name
		export
			{NONE} all
		end;

	CMD_SET_CMD_TYPE
	
feature {NONE}

	undo is
		do
			set_undoable_command;
		end; -- undo

	command_work is
		do
			set_non_doable_command;
		end;

end
