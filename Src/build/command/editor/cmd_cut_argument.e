
class CMD_CUT_ARGUMENT 

inherit

	CMD_CMD_NAMES
		rename
			Cmd_cut_argument_cmd_name as c_name
		export
			{NONE} all
		end;
	CMD_CUT
		redefine
			element
		end;
	
feature {NONE}

	element: ARG;

	list: EB_LINKED_LIST [ARG] is
		do
			Result := edited_command.arguments
		end;

end
