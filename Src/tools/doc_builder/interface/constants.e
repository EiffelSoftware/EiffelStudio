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

	icon_studio_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_studio.ico")
			Result.set_with_named_file (a_file_name)
		end

	icon_format_text_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_format_text_color.ico")
			Result.set_with_named_file (a_file_name)
		end

	button_continue_text: STRING is
			-- `Result' is STRING constant named `button_continue_text'.
		once
			Result := "Continue"
		end

	button_cancel_text: STRING is
			-- `Result' is STRING constant named `button_cancel_text'.
		once
			Result := "Cancel"
		end

	icon_cut_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_cut_color.ico")
			Result.set_with_named_file (a_file_name)
		end

	radio_button_width: INTEGER is 
			-- `Result' is INTEGER constant named radio_button_width.
		once
			Result := 20
		end

	inner_border_width: INTEGER is 
			-- `Result' is INTEGER constant named inner_border_width.
		once
			Result := 5
		end

	button_add_text: STRING is
			-- `Result' is STRING constant named `button_add_text'.
		once
			Result := "Add"
		end

	button_width: INTEGER is 
			-- `Result' is INTEGER constant named button_width.
		once
			Result := 80
		end

	button_apply_text: STRING is
			-- `Result' is STRING constant named `button_apply_text'.
		once
			Result := "Apply"
		end

	button_back_text: STRING is
			-- `Result' is STRING constant named `button_back_text'.
		once
			Result := "Back"
		end

	pixmap_directory: STRING is
			-- `Result' is DIRECTORY constant named `pixmap_directory'.
		once
			Result := "D:\My Documents\Documentation Project\systems\DocBuilder\resources\icons"
		end

	button_save_text: STRING is
			-- `Result' is STRING constant named `button_save_text'.
		once
			Result := "Save..."
		end

	dialog_medium_height: INTEGER is 
			-- `Result' is INTEGER constant named dialog_medium_height.
		once
			Result := 250
		end

	dialog_tall_height: INTEGER is 
			-- `Result' is INTEGER constant named dialog_tall_height.
		once
			Result := 580
		end

	dialog_width: INTEGER is 
			-- `Result' is INTEGER constant named dialog_width.
		once
			Result := 400
		end

	button_finish_text: STRING is
			-- `Result' is STRING constant named `button_finish_text'.
		once
			Result := "Finish"
		end

	dialog_short_height: INTEGER is 
			-- `Result' is INTEGER constant named dialog_short_height.
		once
			Result := 175
		end

	icon_ie_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_ie.ico")
			Result.set_with_named_file (a_file_name)
		end

	icon_info_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_info.ico")
			Result.set_with_named_file (a_file_name)
		end

	icon_validate_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_validate.ico")
			Result.set_with_named_file (a_file_name)
		end

	button_next_text: STRING is
			-- `Result' is STRING constant named `button_next_text'.
		once
			Result := "Next"
		end

	button_ok_text: STRING is
			-- `Result' is STRING constant named `button_ok_text'.
		once
			Result := "OK"
		end

	dialog_height: INTEGER is 
			-- `Result' is INTEGER constant named dialog_height.
		once
			Result := 500
		end

	icon_save_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_save.ico")
			Result.set_with_named_file (a_file_name)
		end

	button_find_text: STRING is
			-- `Result' is STRING constant named `button_find_text'.
		once
			Result := "Find"
		end

	padding_width: INTEGER is 
			-- `Result' is INTEGER constant named padding_width.
		once
			Result := 5
		end

	icon_paste_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_paste.ico")
			Result.set_with_named_file (a_file_name)
		end

	button_create_text: STRING is
			-- `Result' is STRING constant named `button_create_text'.
		once
			Result := "Create"
		end

	border_width: INTEGER is 
			-- `Result' is INTEGER constant named border_width.
		once
			Result := 2
		end

	icon_properties_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_properties_color.ico")
			Result.set_with_named_file (a_file_name)
		end

	icon_open_file_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_open_file.ico")
			Result.set_with_named_file (a_file_name)
		end

	icon_close_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_close_color.ico")
			Result.set_with_named_file (a_file_name)
		end

	icon_search_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_search.ico")
			Result.set_with_named_file (a_file_name)
		end

	icon_envision_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_envision.ico")
			Result.set_with_named_file (a_file_name)
		end

	empty_cell_width: INTEGER is 
			-- `Result' is INTEGER constant named empty_cell_width.
		once
			Result := 15
		end

	icon_new_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_new_color.ico")
			Result.set_with_named_file (a_file_name)
		end

	icon_new_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_new.ico")
			Result.set_with_named_file (a_file_name)
		end

	button_browse_text: STRING is
			-- `Result' is STRING constant named `button_browse_text'.
		once
			Result := "Browse..."
		end

	icon_copy_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_copy_color.ico")
			Result.set_with_named_file (a_file_name)
		end

	icon_close_folder_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.extend ("icon_close_folder.ico")
			Result.set_with_named_file (a_file_name)
		end

	button_open_text: STRING is
			-- `Result' is STRING constant named `button_open_text'.
		once
			Result := "Open"
		end


feature -- Access

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
