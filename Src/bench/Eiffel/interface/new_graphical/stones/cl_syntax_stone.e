indexing
	description: 
		"Class syntax stone."
	date: "$Date$"
	revision: "$Revision $"

class
	CL_SYNTAX_STONE

inherit
	SYNTAX_STONE
		rename
			make as old_make
		undefine
			stone_cursor,
			x_stone_cursor,
			header,
			stone_signature,
			history_name,
			synchronized_stone
		redefine
			same_as,
			is_valid
		end
		
	CLASSC_STONE
		rename
			make as cl_make,
			file_name as class_file_name
		undefine
			help_text
		redefine
			same_as,
			is_valid
		select
			class_file_name
		end

creation
	make

feature {NONE} -- Initialization

	make (a_syntax_errori: SYNTAX_ERROR; c: CLASS_C) is
		do
			syntax_error_i := a_syntax_errori
			cl_make (c)
		end

feature -- Properties

	same_as (other: STONE): BOOLEAN is
			-- Is `Current' identical to `other'?
		do
			Result := Precursor {SYNTAX_STONE} (other) and then
				Precursor {CLASSC_STONE} (other)
		end
	
	is_valid: BOOLEAN is
			-- Is `Current' meaningful?
		do
			Result := Precursor {SYNTAX_STONE} and then
					Precursor {CLASSC_STONE}
		end
	
feature -- Access

--	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
--		do
--			Result := Cursors.cur_Class
--		end

--	x_stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
--		do
--			Result := Cursors.cur_X_class
--		end

end -- class CL_SYNTAX_STONE
