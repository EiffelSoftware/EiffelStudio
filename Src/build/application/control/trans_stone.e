

deferred class TRANS_STONE  

inherit

	CURSORS
		rename
			transition_cursor as stone_cursor
		export
			{NONE} all
		end;
	STONE
		redefine
			original_stone
		
		end

feature 

	original_stone: TRANS_STONE is
		deferred
		end;

end
