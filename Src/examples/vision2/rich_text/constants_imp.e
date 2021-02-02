note
	description: "[
			Objects that provide access to constants, possibly loaded from a files.
			Each constant is generated into two features: both a query and a storage
			feature. For example, for a STRING constant named `my_string', the following
			features are generated: my_string: STRING and my_string_cell: CELL [STRING].
			`my_string' simply returns the current item of `my_string_cell'. By separating
			the constant access in this way, it is possible to change the constant's value
			by either redefining `my_string' in descendent classes or simply performing
			my_string_cell.put ("new_string") as required.
			If you are loading the constants from a file and you wish to reload a different set
			of constants for your interface (e.g. for multi-language support), you may perform
			this in the following way:
			
			set_file_name ("my_constants_file.text")
			reload_constants_from_file
			
			and then for each generated widget, call `set_all_attributes_using_constants' to reset
			the newly loaded constants into the attribute settings of each widget that relies on constants.
			
			Note that if you wish your constants file to be loaded from a specific location,
			you may redefine `initialize_constants' to handle the loading of the file from
			an alternative location.
			
			Note that if you have selected to load constants from a file, and the file cannot
			be loaded, you will get a precondition violation when attempting to access one
			of the constants that should have been loaded. Therefore, you must ensure that either the
			file is accessible or you do not specify to load from a file.
		]"
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONSTANTS_IMP

feature {NONE} -- Initialization

	initialize_constants
			-- Load all constants from file.
		local
			file: PLAIN_TEXT_FILE
		do
			if not constants_initialized then
				create file.make_with_name (file_name)
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

	reload_constants_from_file
			-- Re-load all constants from file named `file_name'.
			-- When used in conjunction with `set_file_name', it enables
			-- you to load a fresh set of INTEGER and STRING constants
			-- from a constants file. If you then wish these to be applied
			-- to a current generated interface, call `set_all_attributes_using_constants'
			-- on that interface for the changed constants to be reflected in the attributes
			-- of your widgets.
		do
			initialized_cell.put (False)
			initialize_constants
		end

	caret_position_status_bar_width: INTEGER
			-- `Result' is INTEGER constant named `caret_position_status_bar_width'.
		do
			Result := caret_position_status_bar_width_cell.item
		end

	caret_position_status_bar_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `caret_position_status_bar_width'.
		once
			create Result.put (100)
		end

	tiny_padding: INTEGER
			-- `Result' is INTEGER constant named `tiny_padding'.
		do
			Result := tiny_padding_cell.item
		end

	tiny_padding_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `tiny_padding'.
		once
			create Result.put (2)
		end

	window_height: INTEGER
			-- `Result' is INTEGER constant named `window_height'.
		do
			Result := window_height_cell.item
		end

	window_height_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `window_height'.
		once
			create Result.put (320)
		end

	small_padding: INTEGER
			-- `Result' is INTEGER constant named `small_padding'.
		do
			Result := small_padding_cell.item
		end

	small_padding_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `small_padding'.
		once
			create Result.put (4)
		end

	window_width: INTEGER
			-- `Result' is INTEGER constant named `window_width'.
		do
			Result := window_width_cell.item
		end

	window_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `window_width'.
		once
			create Result.put (640)
		end

	font_size_combo_box_width: INTEGER
			-- `Result' is INTEGER constant named `font_size_combo_box_width'.
		do
			Result := font_size_combo_box_width_cell.item
		end

	font_size_combo_box_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `font_size_combo_box_width'.
		once
			create Result.put (50)
		end

	font_selection_combo_box_width: INTEGER
			-- `Result' is INTEGER constant named `font_selection_combo_box_width'.
		do
			Result := font_selection_combo_box_width_cell.item
		end

	font_selection_combo_box_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `font_selection_combo_box_width'.
		once
			create Result.put (150)
		end

	rich_text_example_root: STRING
			-- `Result' is DIRECTORY constant named `rich_text_example_root'.
		do
			Result := rich_text_example_root_cell.item
		end

	rich_text_example_root_cell: CELL [STRING]
			--`Result' is once access to a cell holding vale of `rich_text_example_root'.
		once
			create Result.put ("E:\projects\rich_text")
		end

	strike_png: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `strike_png'.
		do
			Result := strike_png_cell.item
		end

	strike_png_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `strike_png'.
		local
			a_file_name: PATH
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name := a_file_name.extended ("strike.png")
			set_with_named_path (Result.item, a_file_name)
		end

	justified_png: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `justified_png'.
		do
			Result := justified_png_cell.item
		end

	justified_png_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `justified_png'.
		local
			a_file_name: PATH
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name := a_file_name.extended ("justified.png")
			set_with_named_path (Result.item, a_file_name)
		end

	italic_png: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `italic_png'.
		do
			Result := italic_png_cell.item
		end

	italic_png_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `italic_png'.
		local
			a_file_name: PATH
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name := a_file_name.extended ("italic.png")
			set_with_named_path (Result.item, a_file_name)
		end

	italic_ico: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `italic_ico'.
		do
			Result := italic_ico_cell.item
		end

	italic_ico_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `italic_ico'.
		local
			a_file_name: PATH
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name := a_file_name.extended ("italic.ico")
			set_with_named_path (Result.item, a_file_name)
		end

	left_alignment_png: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `left_alignment_png'.
		do
			Result := left_alignment_png_cell.item
		end

	left_alignment_png_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `left_alignment_png'.
		local
			a_file_name: PATH
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name := a_file_name.extended ("left_alignment.png")
			set_with_named_path (Result.item, a_file_name)
		end

	bold_png: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `bold_png'.
		do
			Result := bold_png_cell.item
		end

	bold_png_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `bold_png'.
		local
			a_file_name: PATH
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name := a_file_name.extended ("bold.png")
			set_with_named_path (Result.item, a_file_name)
		end

	underline_png: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `underline_png'.
		do
			Result := underline_png_cell.item
		end

	underline_png_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `underline_png'.
		local
			a_file_name: PATH
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name := a_file_name.extended ("underline.png")
			set_with_named_path (Result.item, a_file_name)
		end

	right_alignment_png: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `right_alignment_png'.
		do
			Result := right_alignment_png_cell.item
		end

	right_alignment_png_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `right_alignment_png'.
		local
			a_file_name: PATH
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name := a_file_name.extended ("right_alignment.png")
			set_with_named_path (Result.item, a_file_name)
		end

	justified_ico: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `justified_ico'.
		do
			Result := justified_ico_cell.item
		end

	justified_ico_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `justified_ico'.
		local
			a_file_name: PATH
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name := a_file_name.extended ("justified.ico")
			set_with_named_path (Result.item, a_file_name)
		end

	icon_save_color_png: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_save_color_png'.
		do
			Result := icon_save_color_png_cell.item
		end

	icon_save_color_png_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_save_color_png'.
		local
			a_file_name: PATH
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name := a_file_name.extended ("icon_save_color.png")
			set_with_named_path (Result.item, a_file_name)
		end

	center_alignment_png: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `center_alignment_png'.
		do
			Result := center_alignment_png_cell.item
		end

	center_alignment_png_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `center_alignment_png'.
		local
			a_file_name: PATH
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name := a_file_name.extended ("center_alignment.png")
			set_with_named_path (Result.item, a_file_name)
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
			check attached all_constants.item (a_name) as l_string then
				Result := l_string.twin
			end
		ensure
			Result_not_void: Result /= Void
		end

	integer_constant_by_name (a_name: STRING): INTEGER
			-- `Result' is STRING
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		do
			check attached all_constants.item (a_name) as l_string then
				check
					is_integer: l_string.is_integer
				end
				Result := l_string.to_integer
			end
		end

	has_constant (a_name: STRING): BOOLEAN
			-- Does constant `a_name' exist?
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
		do
			all_constants.search (a_name)
			Result := all_constants.found
		end

feature {NONE} -- Implementation

	initialized_cell: CELL [BOOLEAN]
			-- A cell to hold whether the constants have been loaded.
		once
			create Result.put (False)
		end

	all_constants: HASH_TABLE [STRING, STRING]
			-- All constants loaded from constants file.
		once
			create Result.make (4)
		end

	file_name: STRING
			-- File name from which constants must be loaded.
		do
			Result := file_name_cell.item
		end

	file_name_cell: CELL [STRING]
		once
			create Result.put ("constants.txt")
		end

	set_file_name (a_file_name: STRING)
			-- Assign `a_file_name' to `file_name'.
		do
			file_name_cell.put (a_file_name)
		end

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
						all_constants.force (value, name)
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

	set_with_named_path (a_pixmap: EV_PIXMAP; a_file_name: PATH)
			-- Set image of `a_pixmap' from file, `a_file_name'.
			-- If `a_file_name' does not exist, do nothing.
		require
			a_pixmap_not_void: a_pixmap /= Void
			a_file_name /= Void
		local
			l_file: RAW_FILE
		do
			create l_file.make_with_path (a_file_name)
			if l_file.exists then
				a_pixmap.set_with_named_path (a_file_name)
			end
		end

invariant
	all_constants_not_void: all_constants /= Void

end
