-- Editing hole for command editor
class CMD_EDIT_HOLE 

inherit

	CMD_EDITOR_HOLE
		rename
			make as old_make
		redefine
			process_command, process_instance,
			compatible
		end;
	DRAG_SOURCE;
	CMD_STONE;
	REMOVABLE

creation

	make

feature {NONE}

	remove_yourself is
		do
			command_editor.clear
		end;

	focus_string: STRING is	
		do
			Result := Focus_labels.command_label
		end;
	
	source: WIDGET is
		do
			Result := Current
		end;
	
feature {NONE}

	make (cmd_editor: CMD_EDITOR; a_parent: COMPOSITE) is
			-- Create the cmd_edit_hole with `cmd_editor' 
			-- as command_editor.
		do
			old_make (cmd_editor, a_parent);
			initialize_transport
		end -- Create

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_pixmap
		end;

feature

	data: CMD is
		do
			Result := 
				command_editor.current_command.data
		end;

feature {NONE}

	compatible (st: STONE): BOOLEAN is
		do
			Result := 
				st.stone_type = Stone_types.command_type or else
				st.stone_type = Stone_types.instance_type 
		end;

	process_command (dropped: CMD_STONE) is
		do
			if dropped.data.edited then
				dropped.data.command_editor.raise
			else
				command_editor.set_command (dropped.data)
			end
		end;

	process_instance (dropped: CMD_INST_STONE) is
		do
			if dropped.associated_command.edited then
				dropped.associated_command.command_editor.raise
			else	
				command_editor.set_command (dropped.associated_command)
			end
		end 

end 
