
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

	redo_work is
		do
			remove_parent;
		end;

	undo_work is
		do
			set_parent;
		end;

end
