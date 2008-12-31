note
	description: "Objects that provide access to constants loaded from files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANTS_IMP
	
feature {NONE} -- Initialization

	initialize_constants
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

	strike_png: EV_PIXMAP
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("strike.png")
			set_with_named_file (Result, a_file_name)
		end

	justified_png: EV_PIXMAP
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("justified.png")
			set_with_named_file (Result, a_file_name)
		end

	italic_png: EV_PIXMAP
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("italic.png")
			set_with_named_file (Result, a_file_name)
		end

	caret_position_status_bar_width: INTEGER 
			-- `Result' is INTEGER constant named caret_position_status_bar_width.
		once
			Result := 100
		end

	italic_ico: EV_PIXMAP
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("italic.ico")
			set_with_named_file (Result, a_file_name)
		end

	left_alignment_png: EV_PIXMAP
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("left_alignment.png")
			set_with_named_file (Result, a_file_name)
		end

	tiny_padding: INTEGER 
			-- `Result' is INTEGER constant named tiny_padding.
		once
			Result := 2
		end

	bold_png: EV_PIXMAP
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("bold.png")
			set_with_named_file (Result, a_file_name)
		end

	underline_png: EV_PIXMAP
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("underline.png")
			set_with_named_file (Result, a_file_name)
		end

	window_height: INTEGER 
			-- `Result' is INTEGER constant named window_height.
		once
			Result := 320
		end

	small_padding: INTEGER 
			-- `Result' is INTEGER constant named small_padding.
		once
			Result := 4
		end

	window_width: INTEGER 
			-- `Result' is INTEGER constant named window_width.
		once
			Result := 640
		end

	right_alignment_png: EV_PIXMAP
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("right_alignment.png")
			set_with_named_file (Result, a_file_name)
		end

	font_size_combo_box_width: INTEGER 
			-- `Result' is INTEGER constant named font_size_combo_box_width.
		once
			Result := 50
		end

	justified_ico: EV_PIXMAP
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("justified.ico")
			set_with_named_file (Result, a_file_name)
		end

	center_alignment_png: EV_PIXMAP
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("center_alignment.png")
			set_with_named_file (Result, a_file_name)
		end

	font_selection_combo_box_width: INTEGER 
			-- `Result' is INTEGER constant named font_selection_combo_box_width.
		once
			Result := 150
		end

	rich_text_example_root: STRING
			-- `Result' is DIRECTORY constant named `rich_text_example_root'.
		once
			Result := "E:\projects\rich_text"
		end

	icon_save_color_png: EV_PIXMAP
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("icon_save_color.png")
			set_with_named_file (Result, a_file_name)
		end


feature -- Access

--| FIXME `constant_by_name' and `has_constant' `constants_initialized' are only required until the complete change to
--| constants is complete. They are required for the pixmaps at the moment.

	constants_initialized: BOOLEAN
			-- Have constants been initialized from file?
		do
			Result := initialized_cell.item
		end

	string_constant_by_name (a_name: STRING): STRING
			-- `Result' is STRING 
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		do
			Result := (all_constants.item (a_name)).twin
		ensure
			Result_not_void: Result /= Void
		end
		
	integer_constant_by_name (a_name: STRING): INTEGER
			-- `Result' is STRING 
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		local
			l_string: STRING
		do
			l_string := (all_constants.item (a_name)).twin
			check
				is_integer: l_string.is_integer
			end
			
			Result := l_string.to_integer
		end
		
	has_constant (a_name: STRING): BOOLEAN
			-- Does constant `a_name' exist?
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
		do
			Result := all_constants.item (a_name) /= Void
		end

feature {NONE} -- Implementation

	initialized_cell: CELL [BOOLEAN]
			-- A cell to hold whether the constants have been loaded.
		once
			create Result
		end
		
	all_constants: HASH_TABLE [STRING, STRING]
			-- All constants loaded from constants file.
		once
			create Result.make (4)
		end
		
	file_name: STRING = "constants.txt"
		-- File name from which constants must be loaded.
		
	String_constant: STRING = "STRING"
	
	Integer_constant: STRING = "INTEGER"
		
	parse_file_contents (content: STRING)
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
						all_constants.put (value, name)
					end
				end
			end
		end
		
	first_line (content: STRING): STRING
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
				Result := content.twin
				content.keep_head (0)
			end
		ensure
			Result_not_void: Result /= Void
			no_characters_lost: old content.count = Result.count + content.count
		end

	set_with_named_file (a_pixmap: EV_PIXMAP; a_file_name: STRING)
			-- Set image of `a_pixmap' from file, `a_file_name'.
			-- If `a_file_name' does not exist, do nothing.
		require
			a_pixmap_not_void: a_pixmap /= Void
			a_file_name /= Void
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name)
			if l_file.exists then
				a_pixmap.set_with_named_file (a_file_name)
			end
		end

invariant
	all_constants_not_void: all_constants /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CONSTANTS_IMP
