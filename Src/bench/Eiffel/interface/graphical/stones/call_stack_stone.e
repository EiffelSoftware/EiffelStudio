indexing

	description: 
		"Stone representating a breakable point.";
	date: "$Date$";
	revision: "$Revision $"

class CALL_STACK_STONE 

inherit

	STONE

creation

	make
	
feature {NONE} -- Initialization

	make (level_num: INTEGER) is
			-- Initialize `level_number' to `level_num'.
		require
			level_num: level_num > 0
		do
			level_number := level_num
		end
 
feature -- Access

	level_number: INTEGER;
			-- Level number of call stack

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Setstop
		end;

	x_stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_setstop
		end;

	stone_type: INTEGER is 
		do 
			Result := Call_stack_type 
		end;
 
	stone_name: STRING is 
		do 
			Result := stone_signature
		end;

	stone_signature: STRING is "";
 
	click_list: ARRAY [CLICK_STONE] is do end;

	origin_text: STRING is 
		do
			Result := stone_signature
		end

	icon_name: STRING is
		do
			Result := stone_signature
		end;
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
		end

feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_call_stack (Current)
		end;

end -- class BREAKABLE_STONE
