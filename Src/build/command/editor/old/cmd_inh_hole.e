

class CMD_INH_HOLE 

inherit

	ICON_HOLE
		redefine
			stone
		end;

	PIXMAPS
		export
			{NONE} all
		end;

	WINDOWS
		export
			{NONE} all
		end


creation

	make

feature {NONE}

	command_editor: CMD_EDITOR;
	
feature 

	stone: CMD_STONE;

	make (ed: CMD_EDITOR) is
		do
			command_editor := ed;
			set_symbol (Command_pixmap);
			set_label ("Parent");
		end;

	
feature {NONE}

	process_stone is
		do
			command_editor.set_parent (stone.original_stone)
		end;

end
