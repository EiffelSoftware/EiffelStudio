

class CMD_INH_HOLE 

inherit

	CMD_EDITOR_HOLE
		rename
			make as old_make
		redefine
			process_command
		end;
	WINDOWS;
	DRAG_SOURCE;
	CMD_STONE;
	REMOVABLE

creation

	make

feature {NONE}

	focus_string: STRING is
		do
			if data = Void then
				Result := focus_labels.parent_label
			else
				Result := data.label
			end;
		end;

	make (ed: CMD_EDITOR; a_parent: COMPOSITE) is
		do
			old_make (ed, a_parent);
			initialize_transport;
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.parent_pixmap
		end;

	full_symbol: PIXMAP is
		do
			Result := Pixmaps.parent_dot_pixmap
		end;

	source: WIDGET is
		do
			Result := Current
		end;

feature {NONE}

	data: CMD is
		local
			user_cmd: USER_CMD
		do
			user_cmd := command_editor.edited_command
			if user_cmd /= Void then
				Result := user_cmd.parent_type
			end
		end;

	process_command (dropped: CMD_STONE) is
		do
			command_editor.set_parent (dropped.data)
		end;

	remove_yourself is
		do
			command_editor.remove_parent
		end;

feature {CMD_EDITOR}

	update_symbol is
		do
			if data = Void then
				set_empty_symbol
			else
				set_full_symbol
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

end
