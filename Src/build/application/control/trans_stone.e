

deferred class TRANS_STONE  

inherit

	STONE
		redefine
			original_stone
		
		end

feature 

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.transition_cursor
		end;

	original_stone: TRANS_STONE is
		deferred
		end;

end
