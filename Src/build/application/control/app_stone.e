
deferred class APP_STONE  

inherit

	STONE
		redefine
			original_stone
		
		end
	
feature 

    stone_cursor: SCREEN_CURSOR is
        do
            Result := Cursors.application_cursor
        end

	original_stone: APP_STONE is
		deferred
		end;

end 
