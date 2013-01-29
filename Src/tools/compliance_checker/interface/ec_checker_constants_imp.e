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
	EC_CHECKER_CONSTANTS_IMP

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

	button_cancel: STRING_32
			-- `Result' is STRING_32 constant named `button_cancel'.
		do
			Result := button_cancel_cell.item
		end

	button_cancel_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `button_cancel'.
		once
			create Result.put ("Cancel")
		end

	tooltip_cls_compliance: STRING_32
			-- `Result' is STRING_32 constant named `tooltip_cls_compliance'.
		do
			Result := tooltip_cls_compliance_cell.item
		end

	tooltip_cls_compliance_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tooltip_cls_compliance'.
		once
			create Result.put ("Should non-CLS-compliant entities be shown in the report?")
		end

	button_remove: STRING_32
			-- `Result' is STRING_32 constant named `button_remove'.
		do
			Result := button_remove_cell.item
		end

	button_remove_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `button_remove'.
		once
			create Result.put ("Remove")
		end

	label_check: STRING_32
			-- `Result' is STRING_32 constant named `label_check'.
		do
			Result := label_check_cell.item
		end

	label_check_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `label_check'.
		once
			create Result.put ("Compliant")
		end

	tooltip_assembly_cannot_be_found: STRING_32
			-- `Result' is STRING_32 constant named `tooltip_assembly_cannot_be_found'.
		do
			Result := tooltip_assembly_cannot_be_found_cell.item
		end

	tooltip_assembly_cannot_be_found_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tooltip_assembly_cannot_be_found'.
		once
			create Result.put ("The specified assembly cannot be found!")
		end

	label_assembly: STRING_32
			-- `Result' is STRING_32 constant named `label_assembly'.
		do
			Result := label_assembly_cell.item
		end

	label_assembly_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `label_assembly'.
		once
			create Result.put ("Assembly:")
		end

	tooltip_help: STRING_32
			-- `Result' is STRING_32 constant named `tooltip_help'.
		do
			Result := tooltip_help_cell.item
		end

	tooltip_help_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tooltip_help'.
		once
			create Result.put ("receive help on using the compliance checker tool.")
		end

	box_border_width: INTEGER
			-- `Result' is INTEGER constant named `box_border_width'.
		do
			Result := box_border_width_cell.item
		end

	box_border_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `box_border_width'.
		once
			create Result.put (6)
		end

	tooltip_open_assembly: STRING_32
			-- `Result' is STRING_32 constant named `tooltip_open_assembly'.
		do
			Result := tooltip_open_assembly_cell.item
		end

	tooltip_open_assembly_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tooltip_open_assembly'.
		once
			create Result.put ("Browse for an assembly.")
		end

	tab_output: STRING_32
			-- `Result' is STRING_32 constant named `tab_output'.
		do
			Result := tab_output_cell.item
		end

	tab_output_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tab_output'.
		once
			create Result.put ("Compliance Checker ")
		end

	label_caution: STRING_32
			-- `Result' is STRING_32 constant named `label_caution'.
		do
			Result := label_caution_cell.item
		end

	label_caution_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `label_caution'.
		once
			create Result.put ("Illegally compliant")
		end

	box_padding_width: INTEGER
			-- `Result' is INTEGER constant named `box_padding_width'.
		do
			Result := box_padding_width_cell.item
		end

	box_padding_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `box_padding_width'.
		once
			create Result.put (4)
		end

	main_window_title: STRING_32
			-- `Result' is STRING_32 constant named `main_window_title'.
		do
			Result := main_window_title_cell.item
		end

	main_window_title_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `main_window_title'.
		once
			create Result.put ("Eiffel for .NET Compliance Checker")
		end

	tooltip_assembly: STRING_32
			-- `Result' is STRING_32 constant named `tooltip_assembly'.
		do
			Result := tooltip_assembly_cell.item
		end

	tooltip_assembly_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tooltip_assembly'.
		once
			create Result.put ("Location of assembly to check for Eiffel-compliance.")
		end

	file_dialog_open_project: STRING_32
			-- `Result' is STRING_32 constant named `file_dialog_open_project'.
		do
			Result := file_dialog_open_project_cell.item
		end

	file_dialog_open_project_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `file_dialog_open_project'.
		once
			create Result.put ("Please select a project to open")
		end

	button_okay: STRING_32
			-- `Result' is STRING_32 constant named `button_okay'.
		do
			Result := button_okay_cell.item
		end

	button_okay_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `button_okay'.
		once
			create Result.put ("Ok")
		end

	label_non_compliant: STRING_32
			-- `Result' is STRING_32 constant named `label_non_compliant'.
		do
			Result := label_non_compliant_cell.item
		end

	label_non_compliant_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `label_non_compliant'.
		once
			create Result.put ("Non-compliant assembly members")
		end

	pixmaps: STRING
			-- `Result' is DIRECTORY constant named `pixmaps'.
		do
			Result := pixmaps_cell.item
		end

	pixmaps_cell: CELL [STRING]
			--`Result' is once access to a cell holding vale of `pixmaps'.
		once
			create Result.put (".\resources")
		end

	tab_project: STRING_32
			-- `Result' is STRING_32 constant named `tab_project'.
		do
			Result := tab_project_cell.item
		end

	tab_project_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tab_project'.
		once
			create Result.put ("Project Settings ")
		end

	frame_report_generation: STRING_32
			-- `Result' is STRING_32 constant named `frame_report_generation'.
		do
			Result := frame_report_generation_cell.item
		end

	frame_report_generation_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `frame_report_generation'.
		once
			create Result.put ("Report generation")
		end

	tooltip_open: STRING_32
			-- `Result' is STRING_32 constant named `tooltip_open'.
		do
			Result := tooltip_open_cell.item
		end

	tooltip_open_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tooltip_open'.
		once
			create Result.put ("Open an existing compliance checker project.")
		end

	button_check: STRING_32
			-- `Result' is STRING_32 constant named `button_check'.
		do
			Result := button_check_cell.item
		end

	button_check_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `button_check'.
		once
			create Result.put ("Check")
		end

	error_unable_to_save_project: STRING_32
			-- `Result' is STRING_32 constant named `error_unable_to_save_project'.
		do
			Result := error_unable_to_save_project_cell.item
		end

	error_unable_to_save_project_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `error_unable_to_save_project'.
		once
			create Result.put ("Error: Unable to save project.")
		end

	label_cross: STRING_32
			-- `Result' is STRING_32 constant named `label_cross'.
		do
			Result := label_cross_cell.item
		end

	label_cross_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `label_cross'.
		once
			create Result.put ("Not compliant")
		end

	button_height: INTEGER
			-- `Result' is INTEGER constant named `button_height'.
		do
			Result := button_height_cell.item
		end

	button_height_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `button_height'.
		once
			create Result.put (23)
		end

	label_copyright: STRING_32
			-- `Result' is STRING_32 constant named `label_copyright'.
		do
			Result := label_copyright_cell.item
		end

	label_copyright_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `label_copyright'.
		once
			create Result.put ("(C)2005 Eiffel Software. All rights reserved.")
		end

	label_progress: STRING_32
			-- `Result' is STRING_32 constant named `label_progress'.
		do
			Result := label_progress_cell.item
		end

	label_progress_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `label_progress'.
		once
			create Result.put ("Progress:")
		end

	tooltip_close: STRING_32
			-- `Result' is STRING_32 constant named `tooltip_close'.
		do
			Result := tooltip_close_cell.item
		end

	tooltip_close_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tooltip_close'.
		once
			create Result.put ("Close application.")
		end

	tooltip_progress: STRING_32
			-- `Result' is STRING_32 constant named `tooltip_progress'.
		do
			Result := tooltip_progress_cell.item
		end

	tooltip_progress_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tooltip_progress'.
		once
			create Result.put ("Checking conformance progress.")
		end

	label_legend: STRING_32
			-- `Result' is STRING_32 constant named `label_legend'.
		do
			Result := label_legend_cell.item
		end

	label_legend_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `label_legend'.
		once
			create Result.put ("Legend...")
		end

	button_export: STRING_32
			-- `Result' is STRING_32 constant named `button_export'.
		do
			Result := button_export_cell.item
		end

	button_export_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `button_export'.
		once
			create Result.put ("Export to File")
		end

	tooltip_save: STRING_32
			-- `Result' is STRING_32 constant named `tooltip_save'.
		do
			Result := tooltip_save_cell.item
		end

	tooltip_save_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tooltip_save'.
		once
			create Result.put ("Save current compliance checker project.")
		end

	tooltip_show_all: STRING_32
			-- `Result' is STRING_32 constant named `tooltip_show_all'.
		do
			Result := tooltip_show_all_cell.item
		end

	tooltip_show_all_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tooltip_show_all'.
		once
			create Result.put ("Should generated report show all checked types?")
		end

	check_cls_compliance: STRING_32
			-- `Result' is STRING_32 constant named `check_cls_compliance'.
		do
			Result := check_cls_compliance_cell.item
		end

	check_cls_compliance_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `check_cls_compliance'.
		once
			create Result.put ("Show non-CLS-compliant")
		end

	frame_reference_paths: STRING_32
			-- `Result' is STRING_32 constant named `frame_reference_paths'.
		do
			Result := frame_reference_paths_cell.item
		end

	frame_reference_paths_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `frame_reference_paths'.
		once
			create Result.put ("Reference paths")
		end

	tooltip_check: STRING_32
			-- `Result' is STRING_32 constant named `tooltip_check'.
		do
			Result := tooltip_check_cell.item
		end

	tooltip_check_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tooltip_check'.
		once
			create Result.put ("Perform Eiffel-compliance assembly checks")
		end

	button_close: STRING_32
			-- `Result' is STRING_32 constant named `button_close'.
		do
			Result := button_close_cell.item
		end

	button_close_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `button_close'.
		once
			create Result.put ("Close")
		end

	tooltip_new: STRING_32
			-- `Result' is STRING_32 constant named `tooltip_new'.
		do
			Result := tooltip_new_cell.item
		end

	tooltip_new_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `tooltip_new'.
		once
			create Result.put ("Create a new compliance checker project.")
		end

	button_add: STRING_32
			-- `Result' is STRING_32 constant named `button_add'.
		do
			Result := button_add_cell.item
		end

	button_add_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `button_add'.
		once
			create Result.put ("Add")
		end

	button_recheck: STRING_32
			-- `Result' is STRING_32 constant named `button_recheck'.
		do
			Result := button_recheck_cell.item
		end

	button_recheck_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `button_recheck'.
		once
			create Result.put ("Recheck")
		end

	check_show_all: STRING_32
			-- `Result' is STRING_32 constant named `check_show_all'.
		do
			Result := check_show_all_cell.item
		end

	check_show_all_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `check_show_all'.
		once
			create Result.put ("Show all")
		end

	error_unable_to_retried_project: STRING_32
			-- `Result' is STRING_32 constant named `error_unable_to_retried_project'.
		do
			Result := error_unable_to_retried_project_cell.item
		end

	error_unable_to_retried_project_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `error_unable_to_retried_project'.
		once
			create Result.put ("Error: Unable to retrieve project.")
		end

	file_dialog_save_project: STRING_32
			-- `Result' is STRING_32 constant named `file_dialog_save_project'.
		do
			Result := file_dialog_save_project_cell.item
		end

	file_dialog_save_project_cell: CELL [STRING_32]
			--`Result' is once access to a cell holding vale of `file_dialog_save_project'.
		once
			create Result.put ("Please choose the file name and location to save the project to")
		end

	icon_check_compliance: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_check_compliance'.
		do
			Result := icon_check_compliance_cell.item
		end

	icon_check_compliance_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_check_compliance'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("check_compliance.ico")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_settings: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_settings'.
		do
			Result := icon_settings_cell.item
		end

	icon_settings_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_settings'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("settings.ico")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_project: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_project'.
		do
			Result := icon_project_cell.item
		end

	icon_project_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_project'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("project.ico")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_caution: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_caution'.
		do
			Result := icon_caution_cell.item
		end

	icon_caution_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_caution'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("caution.ico")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_export: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_export'.
		do
			Result := icon_export_cell.item
		end

	icon_export_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_export'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("export.ico")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_open: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_open'.
		do
			Result := icon_open_cell.item
		end

	icon_open_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_open'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("open.ico")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_cross: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_cross'.
		do
			Result := icon_cross_cell.item
		end

	icon_cross_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_cross'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("cross.ico")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_blank: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_blank'.
		do
			Result := icon_blank_cell.item
		end

	icon_blank_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_blank'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("blank.ico")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_save: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_save'.
		do
			Result := icon_save_cell.item
		end

	icon_save_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_save'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("save.ico")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_help: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_help'.
		do
			Result := icon_help_cell.item
		end

	icon_help_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_help'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("help.ico")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_new: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_new'.
		do
			Result := icon_new_cell.item
		end

	icon_new_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_new'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("new.ico")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_check: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_check'.
		do
			Result := icon_check_cell.item
		end

	icon_check_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_check'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("check.ico")
			set_with_named_file (Result.item, a_file_name)
		end

	icon_error: EV_PIXMAP
			-- `Result' is EV_PIXMAP constant named `icon_error'.
		do
			Result := icon_error_cell.item
		end

	icon_error_cell: CELL [EV_PIXMAP]
			--`Result' is once access to a cell holding vale of `icon_error'.
		local
			a_file_name: FILE_NAME
		once
			create Result.put (create {EV_PIXMAP})
			create a_file_name.make_from_string (pixmaps)
			a_file_name.set_file_name ("error.ico")
			set_with_named_file (Result.item, a_file_name)
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

end
