indexing

	description: 
		"Error object sent by the compiler to the workbench."
	date: "$Date$"
	revision: "$Revision $"

class ERROR_STONE

inherit

	EIFFEL_ENV
	FILED_STONE
		redefine
			help_text,
			is_storable
		end

creation

	make

feature {NONE} -- Initialization

	make (an_errori: ERROR) is
		do
			error_i := an_errori
		end
 
feature -- Properties

	error_i: ERROR

feature -- Access

	code: STRING is
			-- Code error
		do
			Result := error_i.code
		end

	header: STRING is 
		do 
			Result := code
			if Result = Void then
				create Result.make (0)
			end
		end

	is_storable: BOOLEAN is
			-- Error stone are not kept.
		do
			Result := False
		end

	help_text: STRING is
			-- Content of the file where the help is.
		do
			Result := origin_text
			if Result = Void or else Result.is_equal ("") then
				Result := clone (Interface_names.h_No_help_available)
			end
		end

	history_name: STRING is
		do
			Result := "Error " + header
		end

	file_name: FILE_NAME is
			-- File where the help is
		do
			create Result.make_from_string (help_path)
			Result.set_file_name (error_i.help_file_name)
		end

	stone_signature: STRING is do Result := code end

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

end -- class ERROR_STONE
