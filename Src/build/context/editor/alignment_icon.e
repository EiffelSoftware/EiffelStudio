
class ALIGNMENT_ICON 

inherit

	CON_ICON_STONE;
	HOLE
		rename
			target as source
		redefine
			stone, compatible
		end;
	REMOVABLE

creation

	make

	
feature {NONE}

	associated_box: ALIGNMENT_BOX;

	stone: like Current;

	compatible (s: like Current): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	
feature 

	make (ab: ALIGNMENT_BOX) is
		do
			associated_box := ab;
			register
		end;

	
feature {NONE}

	process_stone is
		do
			associated_box.insert_after (original_stone, stone.original_stone)
		end;

	remove_yourself is
		do
			associated_box.remove_icon (Current)
		end;
	
end
