class CMD_ED_HOLE

inherit

	EDIT_BUTTON
        rename
            make as parent_make
		redefine
			process_command, process_instance,
			compatible
		end;

creation
	make

feature {NONE}

    make (a_parent: COMPOSITE) is
        do
            parent_make (a_parent)
            set_focus_string (Focus_labels.command_type_label)
        end

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_pixmap
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.command_type
		end;

	compatible (st: STONE): BOOLEAN is
		do
			Result :=
				st.stone_type = Stone_types.command_type or else
				st.stone_type = Stone_types.instance_type
		end;

	process_command (dropped: CMD_STONE) is
		do
			dropped.data.create_editor
		end;

	process_instance (dropped: CMD_INST_STONE) is
		do
			dropped.associated_command.create_editor
		end;

-- samik	focus_string: STRING is 
-- samik		do
-- samik			Result := Focus_labels.command_type_label
-- samik		end;

	create_empty_editor is
		local
			editor: CMD_EDITOR
		do
			editor := window_mgr.cmd_editor;
			window_mgr.display (editor)	
		end;

end
