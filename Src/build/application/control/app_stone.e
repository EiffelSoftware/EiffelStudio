
deferred class APP_STONE  

inherit

	STONE
		redefine
			data
		
		end
	
feature 

    process (hole: HOLE) is
            -- Process Current stone dropped in hole `hole'.
        do
        end;

    stone_cursor: SCREEN_CURSOR is
        do
            Result := Cursors.application_cursor
        end

	data: APP_STONE is
		deferred
		end;

end 
