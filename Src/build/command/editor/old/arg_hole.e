
class ARG_HOLE 

inherit

	ICON_HOLE
		export
			{ANY} all
		redefine
			stone
		end;

	PIXMAPS
		export
			{NONE} all
		end;

	LABELS
		export
			{NONE} all
		end


creation

	make

	
feature 

	stone: TYPE_STONE;

	make (ed: CMD_EDITOR) is
		do
			command_editor := ed;
			set_symbol (Type_pixmap);
			set_label ("Arguments");
		end;

	
feature {NONE}

	command_editor: CMD_EDITOR;

	process_stone is
		local
			c: GROUP_C;
			t: CONTEXT_GROUP_TYPE
		do
			c ?= stone.original_stone;
			t ?= stone.original_stone;
			if (c = Void) and (t = Void) then
				command_editor.add_argument (stone)
			end;
		end;

end
	

	
