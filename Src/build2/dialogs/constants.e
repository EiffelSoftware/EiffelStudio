indexing
	description: "Objects that provide access to constants loaded from files."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANTS
	
feature {NONE} -- Initialization

	initialize_constants is
			-- Load all constants from file.
		local
			file: PLAIN_TEXT_FILE
		do
			if not constants_initialized then
				create file.make (file_name)
				if file.exists then
					file.open_read
					file.readstream (file.count)
					file.close
					parse_file_contents (file.laststring)
				end
				initialized_cell.put (True)
			end
		ensure
			initialized: constants_initialized
		end

feature -- Access

	no_directory_dialog: STRING is
			-- `Result' is STRING constant named `no_directory_dialog'.
		once
			Result := "No Matching DIRECTORY Constant"
		end

	large_padding: INTEGER is 
			-- `Result' is INTEGER constant named large_padding.
		once
			Result := 12
		end

	modify_pixmap_dialog_title: STRING is
			-- `Result' is STRING constant named `modify_pixmap_dialog_title'.
		once
			Result := "Modify Pixmap"
		end

	close_text: STRING is
			-- `Result' is STRING constant named `close_text'.
		once
			Result := "Close"
		end

	constants_dialog_title: STRING is
			-- `Result' is STRING constant named `constants_dialog_title'.
		once
			Result := "Constants"
		end

	default_button_width: INTEGER is 
			-- `Result' is INTEGER constant named default_button_width.
		once
			Result := 80
		end

	next_tip_text: STRING is
			-- `Result' is STRING constant named `next_tip_text'.
		once
			Result := "Next tip"
		end

	system_window_title: STRING is
			-- `Result' is STRING constant named `system_window_title'.
		once
			Result := "Project Configuration"
		end

	modify_button_text: STRING is
			-- `Result' is STRING constant named `modify_button_text'.
		once
			Result := "Modify"
		end

	lightbulb_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (png_location)
			a_file_name.extend ("lightbulb.png")
			Result.set_with_named_file (a_file_name)
		end

	new_button_add_text: STRING is
			-- `Result' is STRING constant named `new_button_add_text'.
		once
			Result := "Add"
		end

	tip_of_day_dialog_title: STRING is
			-- `Result' is STRING constant named `tip_of_day_dialog_title'.
		once
			Result := "Tip of the Day"
		end

	new_button_text: STRING is
			-- `Result' is STRING constant named `new_button_text'.
		once
			Result := "New..."
		end

	small_padding: INTEGER is 
			-- `Result' is INTEGER constant named small_padding.
		once
			Result := 4
		end

	pixmap_settings_dialog_title: STRING is
			-- `Result' is STRING constant named `pixmap_settings_dialog_title'.
		once
			Result := "Pixmap Selection"
		end

	negative: INTEGER is 
			-- `Result' is INTEGER constant named negative.
		once
			Result := -100
		end

	ok_button_text: STRING is
			-- `Result' is STRING constant named `ok_button_text'.
		once
			Result := "OK"
		end

	large_spacing_width: INTEGER is 
			-- `Result' is INTEGER constant named large_spacing_width.
		once
			Result := 12
		end

	remove_button_text: STRING is
			-- `Result' is STRING constant named `remove_button_text'.
		once
			Result := "Remove"
		end

	cancel_button_text: STRING is
			-- `Result' is STRING constant named `cancel_button_text'.
		once
			Result := "Cancel"
		end

	medium_padding: INTEGER is 
			-- `Result' is INTEGER constant named medium_padding.
		once
			Result := 8
		end

	png_location: STRING is
			-- `Result' is DIRECTORY constant named `png_location'.
		once
			Result := "D:\Eiffel54\build\bitmaps\png"
		end


feature -- Access

--| FIXME `constant_by_name' and `has_constant' `constants_initialized' are only required until the complete change to
--| constants is complete. They are required for the pixmaps at the moment.

	constants_initialized: BOOLEAN is
			-- Have constants been initialized from file?
		do
			Result := initialized_cell.item
		end

	string_constant_by_name (a_name: STRING): STRING is
			-- `Result' is STRING 
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		do
			Result := clone (all_constants.item (a_name))
		ensure
			Result_not_void: Result /= Void
		end
		
	integer_constant_by_name (a_name: STRING): INTEGER is
			-- `Result' is STRING 
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		local
			l_string: STRING
		do
			l_string := clone (all_constants.item (a_name))
			check
				is_integer: l_string.is_integer
			end
			
			Result := l_string.to_integer
		end
		
	has_constant (a_name: STRING): BOOLEAN is
			-- Does constant `a_name' exist?
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
		do
			Result := all_constants.item (a_name) /= Void
		end

feature {NONE} -- Implementation

	initialized_cell: CELL [BOOLEAN] is
			-- A cell to hold whether the constants have been loaded.
		once
			create Result
		end
		
	all_constants: HASH_TABLE [STRING, STRING] is
			-- All constants loaded from constants file.
		once
			create Result.make (4)
		end
		
	file_name: STRING is "constants.txt"
		-- File name from which constants must be loaded.
		
	String_constant: STRING is "STRING"
	
	Integer_constant: STRING is "INTEGER"
		
	parse_file_contents (content: STRING) is
			-- Parse contents of `content' into `all_constants'.
		local
			line_contents: STRING
			is_string: BOOLEAN
			is_integer: BOOLEAN
			start_quote1, end_quote1, start_quote2, end_quote2: INTEGER
			name, value: STRING
		do
			from
			until
				content.is_equal ("")
			loop
				line_contents := first_line (content)
				if line_contents.count /= 1 then
					is_string := line_contents.substring_index (String_constant, 1) /= 0
					is_integer := line_contents.substring_index (Integer_constant, 1) /= 0
					if is_string or is_integer then
						start_quote1 := line_contents.index_of ('"', 1)
						end_quote1 := line_contents.index_of ('"', start_quote1 + 1)
						start_quote2 := line_contents.index_of ('"', end_quote1 + 1)
						end_quote2 := line_contents.index_of ('"', start_quote2 + 1)
						name := line_contents.substring (start_quote1 + 1, end_quote1 - 1)
						value := line_contents.substring (start_quote2 + 1, end_quote2 - 1)
						all_constants.extend (value, name)
					end
				end
			end
		end
		
	first_line (content: STRING): STRING is
			-- `Result' is first line of `Content',
			-- which will be stripped from `content'.
		require
			content_not_void: content /= Void
			content_not_empty: not content.is_empty
		local
			new_line_index: INTEGER		
		do
			new_line_index := content.index_of ('%N', 1)
			if new_line_index /= 0 then
				Result := content.substring (1, new_line_index)
				content.keep_tail (content.count - new_line_index)
			else
				Result := clone (content)
				content.keep_head (0)
			end
		ensure
			Result_not_void: Result /= Void
			no_characters_lost: old content.count = Result.count + content.count
		end

invariant
	all_constants_not_void: all_constants /= Void

end -- class CONSTANTS
