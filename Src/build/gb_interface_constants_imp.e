indexing
	description: "[
	Objects that provide access to constants, possibly loaded from a files.
	Each constant is generated into two features: both a query and a storage
	feature. For example, for a STRING constant named `my_string', the following
	features are generated: my_string: STRING and my_string_cell: CELL [STRING].
	`my_string' simply returns the current item of `my_string_cell'. By seperating
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
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_INTERFACE_CONSTANTS_IMP
	
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

	reload_constants_from_file is
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

	small_padding: INTEGER is
			-- `Result' is INTEGER constant named `small_padding'.
		do
			Result := small_padding_cell.item
		end

	small_padding_cell: CELL [INTEGER] is
			--`Result' is once access to a cell holding vale of `small_padding'.
		once
			create Result.put (4)
		end

	lightbulb_png: EV_PIXMAP is
			-- `Result' is EV_PIXMAP constant named `lightbulb_png'.
		do
			Result := lightbulb_png_cell.item
		end

	lightbulb_png_cell: CELL [EV_PIXMAP] is
			--`Result' is once access to a cell holding vale of `lightbulb_png'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmap_location)
			a_file_name.set_file_name ("lightbulb.png")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_component_viewer_color_png: EV_PIXMAP is
			-- `Result' is EV_PIXMAP constant named `icon_component_viewer_color_png'.
		do
			Result := icon_component_viewer_color_png_cell.item
		end

	icon_component_viewer_color_png_cell: CELL [EV_PIXMAP] is
			--`Result' is once access to a cell holding vale of `icon_component_viewer_color_png'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmap_location)
			a_file_name.set_file_name ("icon_component_viewer_color.png")
			set_with_named_file (Result.item, a_file_name)
		end

	system_window_title: STRING is
			-- `Result' is STRING constant named `system_window_title'.
		do
			Result := system_window_title_cell.item
		end

	system_window_title_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `system_window_title'.
		once
			create Result.put ("Project Configuration")
		end

	modify_pixmap_dialog_title: STRING is
			-- `Result' is STRING constant named `modify_pixmap_dialog_title'.
		do
			Result := modify_pixmap_dialog_title_cell.item
		end

	modify_pixmap_dialog_title_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `modify_pixmap_dialog_title'.
		once
			create Result.put ("Modify Pixmap")
		end

	remove_button_text: STRING is
			-- `Result' is STRING constant named `remove_button_text'.
		do
			Result := remove_button_text_cell.item
		end

	remove_button_text_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `remove_button_text'.
		once
			create Result.put ("Remove")
		end

	import_project_title: STRING is
			-- `Result' is STRING constant named `import_project_title'.
		do
			Result := import_project_title_cell.item
		end

	import_project_title_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `import_project_title'.
		once
			create Result.put ("Import Completion Status")
		end

	new_button_add_text: STRING is
			-- `Result' is STRING constant named `new_button_add_text'.
		do
			Result := new_button_add_text_cell.item
		end

	new_button_add_text_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `new_button_add_text'.
		once
			create Result.put ("Add")
		end

	pixmap_location: STRING is
			-- `Result' is DIRECTORY constant named `pixmap_location'.
		do
			Result := pixmap_location_cell.item
		end

	pixmap_location_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `pixmap_location'.
		once
			create Result.put ("D:\Eiffel54\build\bitmaps\png")
		end

	medium_padding: INTEGER is
			-- `Result' is INTEGER constant named `medium_padding'.
		do
			Result := medium_padding_cell.item
		end

	medium_padding_cell: CELL [INTEGER] is
			--`Result' is once access to a cell holding vale of `medium_padding'.
		once
			create Result.put (8)
		end

	next_tip_text: STRING is
			-- `Result' is STRING constant named `next_tip_text'.
		do
			Result := next_tip_text_cell.item
		end

	next_tip_text_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `next_tip_text'.
		once
			create Result.put ("Next tip")
		end

	ok_button_text: STRING is
			-- `Result' is STRING constant named `ok_button_text'.
		do
			Result := ok_button_text_cell.item
		end

	ok_button_text_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `ok_button_text'.
		once
			create Result.put ("OK")
		end

	icon_component_display_view_color_png: EV_PIXMAP is
			-- `Result' is EV_PIXMAP constant named `icon_component_display_view_color_png'.
		do
			Result := icon_component_display_view_color_png_cell.item
		end

	icon_component_display_view_color_png_cell: CELL [EV_PIXMAP] is
			--`Result' is once access to a cell holding vale of `icon_component_display_view_color_png'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmap_location)
			a_file_name.set_file_name ("icon_component_display_view_color.png")
			set_with_named_file (Result.item, a_file_name)
		end

	constants_dialog_title: STRING is
			-- `Result' is STRING constant named `constants_dialog_title'.
		do
			Result := constants_dialog_title_cell.item
		end

	constants_dialog_title_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `constants_dialog_title'.
		once
			create Result.put ("Constants")
		end

	no_directory_dialog: STRING is
			-- `Result' is STRING constant named `no_directory_dialog'.
		do
			Result := no_directory_dialog_cell.item
		end

	no_directory_dialog_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `no_directory_dialog'.
		once
			create Result.put ("No Matching DIRECTORY Constant")
		end

	icon_build_window_color_png: EV_PIXMAP is
			-- `Result' is EV_PIXMAP constant named `icon_build_window_color_png'.
		do
			Result := icon_build_window_color_png_cell.item
		end

	icon_build_window_color_png_cell: CELL [EV_PIXMAP] is
			--`Result' is once access to a cell holding vale of `icon_build_window_color_png'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmap_location)
			a_file_name.set_file_name ("icon_build_window_color.png")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_component_build_view_color_png: EV_PIXMAP is
			-- `Result' is EV_PIXMAP constant named `icon_component_build_view_color_png'.
		do
			Result := icon_component_build_view_color_png_cell.item
		end

	icon_component_build_view_color_png_cell: CELL [EV_PIXMAP] is
			--`Result' is once access to a cell holding vale of `icon_component_build_view_color_png'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmap_location)
			a_file_name.set_file_name ("icon_component_build_view_color.png")
			set_with_named_file (Result.item, a_file_name)
		end

	tip_of_day_dialog_title: STRING is
			-- `Result' is STRING constant named `tip_of_day_dialog_title'.
		do
			Result := tip_of_day_dialog_title_cell.item
		end

	tip_of_day_dialog_title_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `tip_of_day_dialog_title'.
		once
			create Result.put ("Tip of the Day")
		end

	cancel_button_text: STRING is
			-- `Result' is STRING constant named `cancel_button_text'.
		do
			Result := cancel_button_text_cell.item
		end

	cancel_button_text_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `cancel_button_text'.
		once
			create Result.put ("Cancel")
		end

	negative: INTEGER is
			-- `Result' is INTEGER constant named `negative'.
		do
			Result := negative_cell.item
		end

	negative_cell: CELL [INTEGER] is
			--`Result' is once access to a cell holding vale of `negative'.
		once
			create Result.put (-100)
		end

	default_button_width: INTEGER is
			-- `Result' is INTEGER constant named `default_button_width'.
		do
			Result := default_button_width_cell.item
		end

	default_button_width_cell: CELL [INTEGER] is
			--`Result' is once access to a cell holding vale of `default_button_width'.
		once
			create Result.put (80)
		end

	modify_button_text: STRING is
			-- `Result' is STRING constant named `modify_button_text'.
		do
			Result := modify_button_text_cell.item
		end

	modify_button_text_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `modify_button_text'.
		once
			create Result.put ("Modify")
		end

	close_text: STRING is
			-- `Result' is STRING constant named `close_text'.
		do
			Result := close_text_cell.item
		end

	close_text_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `close_text'.
		once
			create Result.put ("Close")
		end

	large_spacing_width: INTEGER is
			-- `Result' is INTEGER constant named `large_spacing_width'.
		do
			Result := large_spacing_width_cell.item
		end

	large_spacing_width_cell: CELL [INTEGER] is
			--`Result' is once access to a cell holding vale of `large_spacing_width'.
		once
			create Result.put (12)
		end

	new_button_text: STRING is
			-- `Result' is STRING constant named `new_button_text'.
		do
			Result := new_button_text_cell.item
		end

	new_button_text_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `new_button_text'.
		once
			create Result.put ("New...")
		end

	pixmap_settings_dialog_title: STRING is
			-- `Result' is STRING constant named `pixmap_settings_dialog_title'.
		do
			Result := pixmap_settings_dialog_title_cell.item
		end

	pixmap_settings_dialog_title_cell: CELL [STRING] is
			--`Result' is once access to a cell holding vale of `pixmap_settings_dialog_title'.
		once
			create Result.put ("Pixmap Selection")
		end

	large_padding: INTEGER is
			-- `Result' is INTEGER constant named `large_padding'.
		do
			Result := large_padding_cell.item
		end

	large_padding_cell: CELL [INTEGER] is
			--`Result' is once access to a cell holding vale of `large_padding'.
		once
			create Result.put (12)
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
		
	file_name: STRING is
			-- File name from which constants must be loaded.
		do
			Result := file_name_cell.item
		end
		
	file_name_cell: CELL [STRING] is
		once
			create Result
			Result.put ("constants.txt")
		end
		
	set_file_name (a_file_name: STRING) is
			-- Assign `a_file_name' to `file_name'.
		do
			file_name_cell.put (a_file_name)
		end
		
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
						all_constants.force (value, name)
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


end -- class GB_INTERFACE_CONSTANTS_IMP
