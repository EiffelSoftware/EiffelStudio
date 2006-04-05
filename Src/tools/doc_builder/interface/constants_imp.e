indexing
	description: "Objects that provide access to constants loaded from files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANTS_IMP
	
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

	icon_paste_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_paste.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_refresh_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_refresh.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_code_format_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_code_format.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_html_file_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_html_file.ico")
			set_with_named_file (Result, a_file_name)
		end

	radio_button_width: INTEGER is 
			-- `Result' is INTEGER constant named radio_button_width.
		once
			Result := 20
		end

	icon_down_triangle_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_down_triangle.ico")
			set_with_named_file (Result, a_file_name)
		end

	left_scroll_arrow_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("left_scroll_arrow.png")
			set_with_named_file (Result, a_file_name)
		end

	icon_search_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_search.ico")
			set_with_named_file (Result, a_file_name)
		end

	empty_cell_width: INTEGER is 
			-- `Result' is INTEGER constant named empty_cell_width.
		once
			Result := 15
		end

	icon_link_check_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_link_check.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_png_file_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_png_file.ico")
			set_with_named_file (Result, a_file_name)
		end

	dialog_height: INTEGER is 
			-- `Result' is INTEGER constant named dialog_height.
		once
			Result := 500
		end

	button_width: INTEGER is 
			-- `Result' is INTEGER constant named button_width.
		once
			Result := 80
		end

	button_browse_text: STRING is
			-- `Result' is STRING constant named `button_browse_text'.
		once
			Result := "Browse..."
		end

	inner_border_width: INTEGER is 
			-- `Result' is INTEGER constant named inner_border_width.
		once
			Result := 5
		end

	dialog_short_height: INTEGER is 
			-- `Result' is INTEGER constant named dialog_short_height.
		once
			Result := 175
		end

	box_padding_width: INTEGER is 
			-- `Result' is INTEGER constant named box_padding_width.
		once
			Result := 5
		end

	icon_toc_exclude_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_toc_exclude.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_forth_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_forth_color.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_ie_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_ie.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_maximize_color_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_maximize_color.png")
			set_with_named_file (Result, a_file_name)
		end

	uparrow_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("uparrow.png")
			set_with_named_file (Result, a_file_name)
		end

	icon_validate_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_validate.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_link_check_ico_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_link_check_ico.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_unchecked_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_unchecked.png")
			set_with_named_file (Result, a_file_name)
		end

	icon_code_feature_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_code_feature.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_redo_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_redo.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_toc_folder_open_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_toc_folder_open.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_info_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_info.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_close_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_close_color.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_gif_file_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_gif_file.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_back_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_back_color.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_close_folder_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_close_folder.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_file_close_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_file_close.ico")
			set_with_named_file (Result, a_file_name)
		end

	button_cancel_text: STRING is
			-- `Result' is STRING constant named `button_cancel_text'.
		once
			Result := "Cancel"
		end

	button_next_text: STRING is
			-- `Result' is STRING constant named `button_next_text'.
		once
			Result := "Next"
		end

	unfiltered_text: STRING is
			-- `Result' is STRING constant named `unfiltered_text'.
		once
			Result := "Unfiltered"
		end

	icon_ie_icon_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_ie_icon.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_open_file_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_open_file.ico")
			set_with_named_file (Result, a_file_name)
		end

	dialog_medium_height: INTEGER is 
			-- `Result' is INTEGER constant named dialog_medium_height.
		once
			Result := 250
		end

	icon_minimize_color_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_minimize_color.png")
			set_with_named_file (Result, a_file_name)
		end

	icon_new_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_new.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_cut_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_cut_color.ico")
			set_with_named_file (Result, a_file_name)
		end

	button_open_text: STRING is
			-- `Result' is STRING constant named `button_open_text'.
		once
			Result := "Open"
		end

	icon_search_ico_1: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_search.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_properties_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_properties_color.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_new_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_new_color.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_copy_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_copy_color.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_undo_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_undo.ico")
			set_with_named_file (Result, a_file_name)
		end

	button_back_text: STRING is
			-- `Result' is STRING constant named `button_back_text'.
		once
			Result := "Back"
		end

	icon_format_text_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_format_text_color.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_new_editor_color_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_new_editor_color.ico")
			set_with_named_file (Result, a_file_name)
		end

	dialog_tall_height: INTEGER is 
			-- `Result' is INTEGER constant named dialog_tall_height.
		once
			Result := 580
		end

	icon_envision_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_envision.ico")
			set_with_named_file (Result, a_file_name)
		end

	pixmap_directory: STRING is
			-- `Result' is DIRECTORY constant named `pixmap_directory'.
		once
			Result := "D:\Src\tools\doc_builder\resources\icons"
		end

	icon_restore_color_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_restore_color.png")
			set_with_named_file (Result, a_file_name)
		end

	icon_code_cluster_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_code_cluster.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_widget_edit_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_widget_edit.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_merge_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_merge.ico")
			set_with_named_file (Result, a_file_name)
		end

	button_finish_text: STRING is
			-- `Result' is STRING constant named `button_finish_text'.
		once
			Result := "Finish"
		end

	icon_settings_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_settings.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_jpeg_file_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_jpeg_file.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_close_color_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_close_color.png")
			set_with_named_file (Result, a_file_name)
		end

	dialog_width: INTEGER is 
			-- `Result' is INTEGER constant named dialog_width.
		once
			Result := 400
		end

	downarrow_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("downarrow.png")
			set_with_named_file (Result, a_file_name)
		end

	button_add_text: STRING is
			-- `Result' is STRING constant named `button_add_text'.
		once
			Result := "Add"
		end

	button_ok_text: STRING is
			-- `Result' is STRING constant named `button_ok_text'.
		once
			Result := "OK"
		end

	icon_bitmap_file_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_bitmap_file.ico")
			set_with_named_file (Result, a_file_name)
		end

	box_border_width: INTEGER is 
			-- `Result' is INTEGER constant named box_border_width.
		once
			Result := 2
		end

	envision_filtered_text: STRING is
			-- `Result' is STRING constant named `envision_filtered_text'.
		once
			Result := "EiffelEnvision Filtered"
		end

	icon_save_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_save.ico")
			set_with_named_file (Result, a_file_name)
		end

	button_continue_text: STRING is
			-- `Result' is STRING constant named `button_continue_text'.
		once
			Result := "Continue"
		end

	icon_toc_file_node_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_toc_file_node.ico")
			set_with_named_file (Result, a_file_name)
		end

	button_find_text: STRING is
			-- `Result' is STRING constant named `button_find_text'.
		once
			Result := "Find"
		end

	icon_toc_folder_closed_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_toc_folder_closed.ico")
			set_with_named_file (Result, a_file_name)
		end

	button_apply_text: STRING is
			-- `Result' is STRING constant named `button_apply_text'.
		once
			Result := "Apply"
		end

	icon_code_class_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_code_class.ico")
			set_with_named_file (Result, a_file_name)
		end

	dialog_wide_width: INTEGER is 
			-- `Result' is INTEGER constant named dialog_wide_width.
		once
			Result := 600
		end

	studio_filtered_text: STRING is
			-- `Result' is STRING constant named `studio_filtered_text'.
		once
			Result := "EiffelStudio Filtered"
		end

	icon_checked_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_checked.png")
			set_with_named_file (Result, a_file_name)
		end

	header_close_cross_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("header_close_cross.png")
			set_with_named_file (Result, a_file_name)
		end

	button_save_text: STRING is
			-- `Result' is STRING constant named `button_save_text'.
		once
			Result := "Save..."
		end

	icon_sorter_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_sorter.ico")
			set_with_named_file (Result, a_file_name)
		end

	right_scroll_arrow_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("right_scroll_arrow.png")
			set_with_named_file (Result, a_file_name)
		end

	icon_new_doc_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_new_doc.ico")
			set_with_named_file (Result, a_file_name)
		end

	button_create_text: STRING is
			-- `Result' is STRING constant named `button_create_text'.
		once
			Result := "Create"
		end

	icon_studio_ico: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_studio.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_highlight_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmap_directory)
			a_file_name.set_file_name ("icon_highlight.png")
			set_with_named_file (Result, a_file_name)
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
			Result := (all_constants.item (a_name)).twin
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
			l_string := (all_constants.item (a_name)).twin
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
						all_constants.put (value, name)
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
				Result := content.twin
				content.keep_head (0)
			end
		ensure
			Result_not_void: Result /= Void
			no_characters_lost: old content.count = Result.count + content.count
		end

	set_with_named_file (a_pixmap: EV_PIXMAP; a_file_name: STRING) is
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class CONSTANTS_IMP
