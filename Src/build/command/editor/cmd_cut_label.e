indexing
	description: "Command used to remove a transition label %
				% that belong to a command."
	id: "$ID: $"
	date: "$Date$"
	revision: "$Revision$"

class CMD_CUT_LABEL 

inherit

	CMD_CUT
		redefine
			element, undo, redo, update
		end
	
feature {NONE}

	element: CMD_LABEL

	c_name: STRING is
		do
			Result := Command_names.cmd_cut_label_cmd_name
		end

	list: EB_LINKED_LIST [CMD_LABEL] is
		do
			Result := edited_command.labels
		end

	undo is
		do
			edited_command.save_old_template
			if
				index = 1 and list.empty
			then
				list.extend (element)
			else
				if edited_command.label_exist (element.label) then
					list.go_i_th (index - 1)
					list.put_right (element)
					edited_command.refresh_parent
				else
					list.go_i_th (index - 1)
					list.put_right (element)
				end
			end
			update
				--| Add displayed label if needed.
			if edited_command.command_editor.shown then
				edited_command.command_editor.labels.extend (element)
			end
		end

	redo is
		do
			{CMD_CUT} Precursor
				--| Remove displayed label if needed.
			if edited_command.command_editor.shown then
				edited_command.command_editor.labels.finish
				edited_command.command_editor.labels.remove
			end
		end


	update is
		do
			edited_command.update_text
			App_editor.update_transitions_list (edited_command)
		end

end
