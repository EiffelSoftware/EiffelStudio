
class ALIGNMENT_ICON 

inherit

	CON_ICON_STONE;
	HOLE
		rename
			target as source
		redefine
			process_context
		end;
	REMOVABLE

creation

	make

	
feature {NONE}

	associated_box: ALIGNMENT_BOX;

feature 

	make (ab: ALIGNMENT_BOX) is
		do
			associated_box := ab;
			register
		end;

	
feature {NONE}

	process_context (dropped: CONTEXT_STONE) is
		do
			associated_box.insert_after (data, 
							dropped.data)
		end;

	remove_yourself is
		do
			associated_box.remove_icon (Current)
		end;
	
end
