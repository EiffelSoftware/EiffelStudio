
class ALIGNMENT_ICON 

inherit

	CON_ICON_STONE
		undefine
			init_toolkit
		redefine
			make
		end;

	HOLE
		rename
			target as source
		export
			{NONE} all
		redefine
			stone
		end;

	REMOVABLE
		export
			{NONE} all
		end

creation

	make

	
feature {NONE}

	associated_box: ALIGNMENT_BOX;

	stone: like Current;

	
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
