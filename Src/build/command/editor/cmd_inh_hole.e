

class CMD_INH_HOLE 

inherit

	ICON_HOLE
		redefine
			stone
		end;
	PIXMAPS;
	WINDOWS;

creation

	make

feature 

	stone: CMD_STONE;

	make (ed: CMD_EDITOR) is
		do
			command_editor := ed;
			set_symbol (Command_pixmap);
			set_label ("Parent");
		end;

feature {NONE}

	command_editor: CMD_EDITOR;
	
	process_stone is
		do
			command_editor.set_parent (stone.original_stone)
		end;

end
