
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
		
		end

 

	
feature {NONE}

	element: ARG;

	icon_box: ARG_BOX is
		do
			Result := command_editor.arguments
		end;

end
