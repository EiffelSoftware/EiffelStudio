
class CMD_ADD_LABEL 

inherit

	CMD_CMD_NAMES
		rename
			Cmd_add_label_cmd_name as c_name
		export
			{NONE} all
		end;

	CMD_ADD
		redefine
			element
		
		end

 

	
feature {NONE}

	element: CMD_LABEL;

	icon_box: LABEL_BOX is
		do
			Result := command_editor.labels
		end;

end
