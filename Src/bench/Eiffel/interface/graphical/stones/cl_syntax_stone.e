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
			process
		end;
	INTERFACE_W

creation

	make

feature {NONE} -- Initialization

	make (a_syntax_errori: SYNTAX_ERROR; c: E_CLASS) is
		do
			syntax_error_i := a_syntax_errori;
			associated_class := c
		end;

feature -- Properties

	associated_class: E_CLASS;
		-- Associated class for error

feature -- Access

	stone_type: INTEGER is 
		do 
			Result := Class_type 
		end;

	stone_name: STRING is 
		do 
			Result := l_Class_stone
		end;

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with
			-- Current stone during transport.
		do
			Result := cur_Class
		end;

feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_class_syntax (Current)
		end;

end -- class CL_SYNTAX_STONE
