
class CMD_CUT_ARGUMENT 

inherit

	CMD_CUT
		redefine
			element
		end;
	
feature {NONE}

	element: ARG;

	c_name: STRING is
		do
			Result := Command_names.cmd_cut_argument_cmd_name
		end;

	list: EB_LINKED_LIST [ARG] is
		do
			Result := edited_command.arguments
		end;

end
