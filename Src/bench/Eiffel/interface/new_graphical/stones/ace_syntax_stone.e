indexing
	description: 
		"Ace syntax stone."
	date: "$Date$"
	revision: "$Revision $"

class
	ACE_SYNTAX_STONE

inherit
	SYNTAX_STONE

creation
	make

feature -- Access

--	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
--		do
--			Result := Cursors.cur_System
--		end

--	x_stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
--		do
--			Result := Cursors.cur_X_system
--		end

end -- class ACE_SYNTAX_STONE
