

class CMD_INH_HOLE 

inherit

	CMD_EDITOR_HOLE
		rename
			make as old_make
		redefine
			stone, compatible
		end;
	WINDOWS;
	CMD_STONE
		redefine
			transportable
		end;
	REMOVABLE

creation

	make

feature 

	stone: CMD_STONE;

	focus_string: STRING is
		do
			if original_stone = Void then
				Result := focus_labels.parent_label
			else
				Result := label
			end;
		end;

	label: STRING is
		do
			Result := original_stone.label
		end;

	compatible (s: CMD_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
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

	source: WIDGET is
		do
			Result := Current
		end;

feature {NONE}

	original_stone: CMD is
		local
			user_cmd: USER_CMD
		do
			user_cmd := command_editor.edited_command
			if user_cmd /= Void then
				Result := user_cmd.parent_type
			end
		end;

	transportable: BOOLEAN is
		do
			Result := original_stone /= Void;
		end;

	identifier: INTEGER is
		do 
			Result := original_stone.identifier
		end;

	eiffel_type: STRING is
		do
			Result := original_stone.eiffel_type
		end;

	arguments: EB_LINKED_LIST [ARG] is
		do
			Result := original_stone.arguments
		end;

	labels: EB_LINKED_LIST [CMD_LABEL] is
		do
			Result := original_stone.labels
		end;

	eiffel_text: STRING is
		do
			Result := original_stone.eiffel_text
		end;
	
	process_stone is
		do
			command_editor.set_parent (stone.original_stone)
		end;

	remove_yourself is
		do
			command_editor.remove_parent
		end;

	
end
