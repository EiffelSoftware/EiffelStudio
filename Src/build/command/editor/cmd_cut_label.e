
class CMD_CUT_LABEL 

inherit

	CMD_CMD_NAMES
		rename
			Cmd_cut_label_cmd_name as c_name
		export
			{NONE} all
		end;

	CMD_CUT
		redefine
			element, undo
		end
	
feature {NONE}

	element: CMD_LABEL;

	list: EB_LINKED_LIST [CMD_LABEL] is
		do
			Result := edited_command.labels
		end;


	undo is
		do
			edited_command.save_old_template;
			if
				index = 1 and list.empty
			then
				list.extend (element)
			else
				if edited_command.label_exist (element.label) then
					list.go_i_th (index - 1);
					list.put_right (element);
					edited_command.refresh_parent;
				else
					list.go_i_th (index - 1);
					list.put_right (element);
				end;
			end;
			edited_command.update_text
		end; -- undo
end
