class CMD_I_ED_HOLE

inherit

	EDIT_BUTTON

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
		end
	
end
