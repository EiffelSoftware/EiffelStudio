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
	COMMAND;
	REMOVABLE

creation

	make

feature {NONE}

	remove_yourself is
		do
			command_editor.clear
		end;

	create_focus_label is	
		do
			set_focus_string (Focus_labels.command_label)
		end
	
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
			initialize_transport;
			add_activate_action (Current, Void)
		end -- Create

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_pixmap
		end;

	full_symbol: PIXMAP is
		do
			Result := Pixmaps.command_dot_pixmap
		end;

feature

	data: CMD is
		do
			if command_editor.current_command /= Void then
				Result := command_editor.current_command.data
			end
		end;

	set_empty_symbol is
		do
			if pixmap /= symbol then
				set_symbol (symbol)
			end
		end

	set_full_symbol is
		do
			if pixmap /= full_symbol then
				set_symbol (full_symbol)
			end
		end

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

feature {NONE} -- resync

	execute (arg: ANY) is
		local
			mp: MOUSE_PTR
		do
			if command_editor.edited_command /= Void then
				!! mp;
				mp.set_watch_shape;
				command_editor.update_user_eiffel_text_from_disk
				mp.restore;
			end;
		end;

end 
