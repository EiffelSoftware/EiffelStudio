indexing

	description: 
		"Class syntax stone.";
	date: "$Date$";
	revision: "$Revision $"

class CL_SYNTAX_STONE

inherit

	SYNTAX_STONE
		rename
			make as old_make
		redefine
			stone_type, stone_name, stone_cursor,
			process, x_stone_cursor
		end

creation

	make

feature {NONE} -- Initialization

	make (a_syntax_errori: SYNTAX_ERROR; c: CLASS_C) is
		do
			syntax_error_i := a_syntax_errori;
			associated_class := c
		end;

feature -- Properties

	associated_class: CLASS_C;
		-- Associated class for error

feature -- Access

	stone_type: INTEGER is 
		do 
			Result := Class_type 
		end;

	stone_name: STRING is 
		do 
			Result := Interface_names.s_Class_stone
		end;

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Class
		end;

	x_stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_class
		end;

feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_class_syntax (Current)
		end;

end -- class CL_SYNTAX_STONE
