
class ARG_HOLE 

inherit

	CMD_EDITOR_HOLE
		redefine
			stone, compatible
		end;

creation

	make

feature 

	stone: TYPE_STONE;

	compatible (s: TYPE_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.type_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.argument_label
		end;
	
feature {NONE}

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
	

	
