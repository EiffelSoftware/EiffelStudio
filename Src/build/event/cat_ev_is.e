
class CAT_EV_IS 

inherit

	EV_ICON_STONE
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

creation

	make
	
feature {NONE}

	stone: like Current;
	
feature 

	remove_yourself is
		local
			r: REMOVABLE
		do
			io.putstring ("in cat ev is%N");
			r ?= original_stone;
			if r /= Void then
			io.putstring ("removing trans%N");
				r.remove_yourself
			end
		end;

	page: EVENT_PAGE;

	make (p: like page) is
		do
			page := p;
			register
		end; -- Create

	update_name is
		do
			if original_stone /= Void then
				set_label (original_stone.label)
			end
		end;
	
feature {NONE}

	process_stone is
		do
			page.insert_after (original_stone, stone.original_stone)
		end;

end
