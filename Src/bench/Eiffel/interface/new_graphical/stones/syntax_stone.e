indexing
	description: "Stone representing a syntax issue."
	date: "$Date$"
	revision: "$Revision$"

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

create
	make

feature {NONE} -- Initialization

	make (a_syntax_message: like syntax_message) is
			-- Create instance of SYNTAX_STONE with `a_syntax_message'.
		require
			a_syntax_message_not_void: a_syntax_message /= Void
 		do
			syntax_message := a_syntax_message
		ensure
			syntax_message_set: syntax_message = a_syntax_message
		end

feature -- Properties
 
	syntax_message: SYNTAX_MESSAGE
			-- Associated message about syntax issue.

feature -- Access

	file_name: FILE_NAME is
			-- The one from SYNTAX_ERROR: where it happened
		do
			create Result.make_from_string (syntax_message.file_name)
		ensure then
			file_name_not_void: Result /= Void
		end

	help_text: STRING is
		do
			Result := Interface_names.h_No_help_available.twin
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

	line: INTEGER is
			-- Line of the token involved in the syntax error
		do
			Result := syntax_message.line
		end

	code: STRING is "Syntax error"
			-- Error code

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_interro
		end

	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_x_interro
		end

	is_storable: BOOLEAN is
		do
			Result := False
		end

end -- class SYNTAX_STONE
