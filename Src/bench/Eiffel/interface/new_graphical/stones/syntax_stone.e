indexing
	description: 
		"Stone representing a syntax error."
	date: "$Date$"
	revision: "$Revision $"


class
	SYNTAX_STONE

--| FIXME XR: The point of ERROR_STONE's is to have an explanatory message.
--| Since syntax errors do not provide this, there is no point in inheriting from ERROR_STONE.
--inherit
--	ERROR_STONE
--		rename
--			make as make_simple_error
--		redefine
--			code, file_name, help_text
--		end
--

inherit
	FILED_STONE
		redefine
			help_text,
			is_storable
		end

creation
	make

feature {NONE} -- Initialization

	make (a_syntax_errori: SYNTAX_ERROR) is
 		do
			syntax_error_i := a_syntax_errori
		end

feature -- Properties
 
	syntax_error_i: SYNTAX_ERROR

feature -- Access

	file_name: FILE_NAME is
			-- The one from SYNTAX_ERROR: where it happened
		do
			create Result.make_from_string (syntax_error_i.file_name)
		end

	help_text: STRING is
		do
			Result := clone (Interface_names.h_No_help_available)
		end

	history_name: STRING is
		do
			Result := "Error " + header
		end

	stone_signature: STRING is
		do
			Result := code
		end

	header: STRING is 
		do 
			Result := code
			if Result = Void then
				create Result.make (0)
			end
		end

	start_position: INTEGER is do Result := syntax_error_i.start_position end
			-- Stating position of the token involved in the syntax error

	end_position: INTEGER is do Result := syntax_error_i.end_position end
			-- Ending position of the of the token involved in the syntax
			-- error

	code: STRING is "Syntax error"
			-- Error code

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Interro
		end

	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_interro
		end

	is_storable: BOOLEAN is
		do
			Result := False
		end

end -- class SYNTAX_STONE
