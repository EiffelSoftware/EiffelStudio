class CMD_I_ED_HOLE

inherit

	EDIT_BUTTON
		redefine
			process_instance
		end

creation

	make

feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_instance_pixmap
		end;

	focus_string: STRING is 
		do
			Result := Focus_labels.command_instance_label
		end;

	create_empty_editor is
		local
			editor: CMD_INST_EDITOR
		do
			editor := window_mgr.cmd_inst_editor;
			window_mgr.display (editor)
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.instance_type
		end;

	process_instance (dropped: CMD_INST_STONE) is
		do
			dropped.data.create_editor
		end;
	
end
