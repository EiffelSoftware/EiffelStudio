
deferred class APP_STONE  

inherit

	CURSORS
		rename
			application_cursor as stone_cursor
		export
			{NONE} all
		end;
	STONE
		redefine
			original_stone
		
		end
	
feature 

	original_stone: APP_STONE is
		deferred
		end;

end 
