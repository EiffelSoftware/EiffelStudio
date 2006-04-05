indexing
	description: "Objects that provide access to constants loaded from files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EC_CHECKER_CONSTANTS_IMP
	
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

	icon_check_compliance: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("check_compliance.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_settings: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("settings.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_project: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("project.ico")
			set_with_named_file (Result, a_file_name)
		end

	button_cancel: STRING is
			-- `Result' is STRING constant named `button_cancel'.
		once
			Result := "Cancel"
		end

	tooltip_cls_compliance: STRING is
			-- `Result' is STRING constant named `tooltip_cls_compliance'.
		once
			Result := "Should non-CLS-compliant entities be shown in the report?"
		end

	button_remove: STRING is
			-- `Result' is STRING constant named `button_remove'.
		once
			Result := "Remove"
		end

	label_check: STRING is
			-- `Result' is STRING constant named `label_check'.
		once
			Result := "Compliant"
		end

	tooltip_assembly_cannot_be_found: STRING is
			-- `Result' is STRING constant named `tooltip_assembly_cannot_be_found'.
		once
			Result := "The specified assembly cannot be found!"
		end

	label_assembly: STRING is
			-- `Result' is STRING constant named `label_assembly'.
		once
			Result := "Assembly:"
		end

	icon_caution: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("caution.ico")
			set_with_named_file (Result, a_file_name)
		end

	tooltip_help: STRING is
			-- `Result' is STRING constant named `tooltip_help'.
		once
			Result := "Recieve help on using the compliance checker tool."
		end

	icon_export: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("export.ico")
			set_with_named_file (Result, a_file_name)
		end

	icon_open: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("open.ico")
			set_with_named_file (Result, a_file_name)
		end

	box_border_width: INTEGER is 
			-- `Result' is INTEGER constant named box_border_width.
		once
			Result := 6
		end

	tooltip_open_assembly: STRING is
			-- `Result' is STRING constant named `tooltip_open_assembly'.
		once
			Result := "Browse for an assembly."
		end

	tab_output: STRING is
			-- `Result' is STRING constant named `tab_output'.
		once
			Result := "Compliance Checker "
		end

	icon_cross: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("cross.ico")
			set_with_named_file (Result, a_file_name)
		end

	label_caution: STRING is
			-- `Result' is STRING constant named `label_caution'.
		once
			Result := "Illegally compliant"
		end

	box_padding_width: INTEGER is 
			-- `Result' is INTEGER constant named box_padding_width.
		once
			Result := 4
		end

	icon_blank: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("blank.ico")
			set_with_named_file (Result, a_file_name)
		end

	main_window_title: STRING is
			-- `Result' is STRING constant named `main_window_title'.
		once
			Result := "Eiffel for .NET Compliance Checker"
		end

	tooltip_assembly: STRING is
			-- `Result' is STRING constant named `tooltip_assembly'.
		once
			Result := "Location of assembly to check for Eiffel-compliance."
		end

	file_dialog_open_project: STRING is
			-- `Result' is STRING constant named `file_dialog_open_project'.
		once
			Result := "Please select a project to open"
		end

	button_okay: STRING is
			-- `Result' is STRING constant named `button_okay'.
		once
			Result := "Ok"
		end

	label_non_compliant: STRING is
			-- `Result' is STRING constant named `label_non_compliant'.
		once
			Result := "Non-compliant assembly members"
		end

	pixmaps: STRING is
			-- `Result' is DIRECTORY constant named `pixmaps'.
		once
			Result := "E:\tools\compliance_checker\resources"
		end

	tab_project: STRING is
			-- `Result' is STRING constant named `tab_project'.
		once
			Result := "Project Settings "
		end

	frame_report_generation: STRING is
			-- `Result' is STRING constant named `frame_report_generation'.
		once
			Result := "Report generation"
		end

	icon_save: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("save.ico")
			set_with_named_file (Result, a_file_name)
		end

	tooltip_open: STRING is
			-- `Result' is STRING constant named `tooltip_open'.
		once
			Result := "Open an existing compliance checker project."
		end

	icon_help: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("help.ico")
			set_with_named_file (Result, a_file_name)
		end

	button_check: STRING is
			-- `Result' is STRING constant named `button_check'.
		once
			Result := "Check"
		end

	icon_new: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("new.ico")
			set_with_named_file (Result, a_file_name)
		end

	error_unable_to_save_project: STRING is
			-- `Result' is STRING constant named `error_unable_to_save_project'.
		once
			Result := "Error: Unable to save project."
		end

	label_cross: STRING is
			-- `Result' is STRING constant named `label_cross'.
		once
			Result := "Not compliant"
		end

	button_height: INTEGER is 
			-- `Result' is INTEGER constant named button_height.
		once
			Result := 23
		end

	label_copyright: STRING is
			-- `Result' is STRING constant named `label_copyright'.
		once
			Result := "(C)2005 Eiffel Software. All rights reserved."
		end

	label_progress: STRING is
			-- `Result' is STRING constant named `label_progress'.
		once
			Result := "Progress:"
		end

	tooltip_close: STRING is
			-- `Result' is STRING constant named `tooltip_close'.
		once
			Result := "Close application."
		end

	tooltip_progress: STRING is
			-- `Result' is STRING constant named `tooltip_progress'.
		once
			Result := "Checking conformance progress."
		end

	label_legend: STRING is
			-- `Result' is STRING constant named `label_legend'.
		once
			Result := "Legend..."
		end

	icon_check: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("check.ico")
			set_with_named_file (Result, a_file_name)
		end

	button_export: STRING is
			-- `Result' is STRING constant named `button_export'.
		once
			Result := "Export to File"
		end

	tooltip_save: STRING is
			-- `Result' is STRING constant named `tooltip_save'.
		once
			Result := "Save current compliance checker project."
		end

	icon_error: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		once
			create Result
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("error.ico")
			set_with_named_file (Result, a_file_name)
		end

	tooltip_show_all: STRING is
			-- `Result' is STRING constant named `tooltip_show_all'.
		once
			Result := "Should generated report show all checked types?"
		end

	check_cls_compliance: STRING is
			-- `Result' is STRING constant named `check_cls_compliance'.
		once
			Result := "Show non-CLS-compliant"
		end

	frame_reference_paths: STRING is
			-- `Result' is STRING constant named `frame_reference_paths'.
		once
			Result := "Reference paths"
		end

	tooltip_check: STRING is
			-- `Result' is STRING constant named `tooltip_check'.
		once
			Result := "Perform Eiffel-compliance assembly checks"
		end

	button_close: STRING is
			-- `Result' is STRING constant named `button_close'.
		once
			Result := "Close"
		end

	tooltip_new: STRING is
			-- `Result' is STRING constant named `tooltip_new'.
		once
			Result := "Create a new compliance checker project."
		end

	button_add: STRING is
			-- `Result' is STRING constant named `button_add'.
		once
			Result := "Add"
		end

	button_recheck: STRING is
			-- `Result' is STRING constant named `button_recheck'.
		once
			Result := "Recheck"
		end

	check_show_all: STRING is
			-- `Result' is STRING constant named `check_show_all'.
		once
			Result := "Show all"
		end

	error_unable_to_retried_project: STRING is
			-- `Result' is STRING constant named `error_unable_to_retried_project'.
		once
			Result := "Error: Unable to retrieve project."
		end

	file_dialog_save_project: STRING is
			-- `Result' is STRING constant named `file_dialog_save_project'.
		once
			Result := "Please choose the file name and location to save the project to"
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
end -- class EC_CHECKER_CONSTANTS_IMP
