indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	CMD_INH_HOLE

inherit

	CMD_EDITOR_HOLE
		rename
			make as old_make
		redefine
			process_command
		end;
	
	DRAG_SOURCE;
	CMD_STONE;
	REMOVABLE

creation

	make

feature {NONE}

	create_focus_label is
		do
			if data = Void then
				set_focus_string (Focus_labels.parent_label)
			else
				set_focus_string (data.label)
			end
		end

	make (ed: like command_editor; a_parent: COMPOSITE) is
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

feature {CMD_EDITOR, COMMAND_EDITOR}

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

end -- class CMD_INH_HOLE
