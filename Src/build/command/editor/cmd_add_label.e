
class CMD_ADD_LABEL 

inherit

	CMD_ADD
		redefine
			element
		end;
	
feature {NONE}

	element: CMD_LABEL;

	c_name: STRING is
		do
			Result := Command_names.cmd_add_label_cmd_name
		end;

	list: EB_LINKED_LIST [CMD_LABEL] is
		do
			Result := edited_command.labels
		end;

end
