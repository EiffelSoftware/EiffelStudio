class CMD_ED_HOLE

inherit

	EDIT_BUTTON
		redefine
			process_stone
		end;

creation
	make

feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_pixmap
		end

	process_stone is
		local
			cmd_type: CMD;
			cmd_inst: CMD_INSTANCE
		do
			cmd_type ?= stone.original_stone;
			cmd_inst ?= stone.original_stone;
			if cmd_type /= Void then
				cmd_type.create_editor
			elseif cmd_inst /= Void then
				cmd_inst.associated_command.create_editor
			end;
		end;

	focus_string: STRING is 
		do
			Result := Focus_labels.command_type_label
		end;

	create_empty_editor is
		local
			editor: CMD_EDITOR
		do
			editor := window_mgr.cmd_editor;
			window_mgr.display (editor)	
		end;

end
