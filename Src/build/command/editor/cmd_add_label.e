
class CMD_ADD_LABEL 

inherit

	CMD_ADD
		redefine
			element, update_information
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

	update_information is
		do
			edited_command.update_text;
			App_editor.update_transitions_list (edited_command)
		end;

end
