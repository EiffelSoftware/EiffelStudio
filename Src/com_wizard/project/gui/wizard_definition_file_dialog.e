indexing 
	description: "WIZARD_DEFINITION_FILE_DIALOG class created by Resource Bench."

class 
	WIZARD_DEFINITION_FILE_DIALOG

inherit
	WIZARD_DIALOG
		redefine
			setup_dialog,
			notify,
			on_ok
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		rename
			free as env_free
		export
			{NONE} all
		end

	WIZARD_BROWSE_DIRECTORY
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Create the dialog.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			make_by_id (a_parent, Wizard_definition_file_dialog_constant)
			create id_ok.make_by_id (Current, Idok)
			create definition_file_edit.make_by_id (Current, Definition_file_edit_constant)
			create destination_folder_edit.make_by_id (Current, Destination_folder_edit_constant)
			create id_cancel.make_by_id (Current, Idcancel)
			create definition_file_browse_button.make_by_id (Current, Definition_file_browse_button_constant)
			create destination_folder_browse_button.make_by_id (Current, Destination_folder_browse_button_constant)
			create help_button.make_by_id (Current, Help_button_constant)
			help_topic_id := 733
			create id_back.make_by_id (Current, Id_back_constant)
			create msg_box.make
		end

feature -- Behavior

	setup_dialog is
			-- Initialize dialog's controls.
		do
			Precursor {WIZARD_DIALOG}
			if shared_wizard_environment.idl and shared_wizard_environment.idl_file_name /= Void then
				definition_file_edit.set_text (shared_wizard_environment.idl_file_name)
			elseif not shared_wizard_environment.idl and shared_wizard_environment.type_library_file_name /= Void then
				definition_file_edit.set_text (shared_wizard_environment.type_library_file_name)
			end
			if shared_wizard_environment.destination_folder /= Void then
				destination_folder_edit.set_text (shared_wizard_environment.destination_folder)
			end
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- Process `control_id' control notification.
		do
			if control = definition_file_browse_button then
				browse_for_definition_file
			elseif control = destination_folder_browse_button then
				browse_for_destination_folder
			end
		end

	on_ok is
			-- Process Next button activation.
		local
			folder_name, file_name: STRING
			a_file: RAW_FILE
		do
			folder_name := destination_folder_edit.text
			file_name := definition_file_edit.text
			file_name.to_lower
			if folder_name = Void or folder_name.is_empty then
				msg_box.error_message_box (Current, Empty_destination_folder, Initialization_error)
			elseif file_name = Void or file_name.is_empty then
				msg_box.error_message_box (Current, Empty_definition_file, Initialization_error)
			else
				shared_wizard_environment.set_project_name (project_name)

				if folder_name.item (folder_name.count) = Directory_separator then
					folder_name.head (folder_name.count -1)
				end
				create a_file.make (folder_name)
				if not a_file.exists then
					msg_box.warning_message_box (Current, Invalid_destination_folder, Wizard_error)
				else
					create a_file.make (file_name)
					if not a_file.exists then
						msg_box.warning_message_box (Current, Invalid_definition_file, Wizard_error)
					else
						shared_wizard_environment.set_destination_folder (folder_name)
						if file_name.substring_index (idl_file_extension, 1) =
								(file_name.count - idl_file_extension.count + 1) then
							shared_wizard_environment.set_idl (True)
							shared_wizard_environment.set_idl_file_name (file_name)
						else
							shared_wizard_environment.set_idl (False)
							shared_wizard_environment.set_type_library_file_name (file_name)
						end
						Precursor {WIZARD_DIALOG}
					end
				end
			end
		end

feature -- Access

	definition_file_edit: WEL_SINGLE_LINE_EDIT
			-- Definition file location edit

	destination_folder_edit: WEL_SINGLE_LINE_EDIT
			-- Destination folder location edit

	definition_file_browse_button: WEL_PUSH_BUTTON
			-- Browse for definition file button

	destination_folder_browse_button: WEL_PUSH_BUTTON
			-- Browse for destination folder button

feature -- Basic Operations

	browse_for_definition_file is
			-- Browse for definition file.
		do
			File_selection_dialog.set_initial_directory (browse_directory)
			File_selection_dialog.activate (Current)
			if File_selection_dialog.selected then
				definition_file_edit.set_text (file_selection_dialog.file_name)
			end
			safe_browse_directory_from_dialog (File_selection_dialog)
		end
	
	browse_for_destination_folder is
			-- Browse for destination folder.
		do
			folder_selection_dialog.activate (Current)
			if folder_selection_dialog.selected then
				destination_folder_edit.set_text (folder_selection_dialog.folder_name)
			end
		end

	File_selection_dialog: WEL_OPEN_FILE_DIALOG is
			-- File selection dialog
		once
			create Result.make
			Result.set_filter (File_filters_descriptions, File_filters)
		end
	
	Folder_selection_dialog: WEL_CHOOSE_FOLDER_DIALOG is
			-- Folder selection dialog
		once
			create Result.make
			Result.set_title (Folder_selection_dialog_title)
		end

feature {NONE} -- Implementation

	msg_box: WEL_MSG_BOX
			-- Message box

	Initialization_error: STRING is "Initialization Error"
			-- Initialization error message

	Wizard_error: STRING is "Wizard error"
			-- Wizard error message

	Invalid_destination_folder: STRING is "Invalid destination folder%NPlease enter a valid destination folder"
			-- Invalid destination folder message

	Invalid_definition_file: STRING is "Invalid definition file%NPlease enter a valid definition file"
			-- Invalid destination folder message

	Empty_destination_folder: STRING is "is_empty destination folder%NPlease enter a valid destination folder"
			-- Invalid destination folder message

	Empty_definition_file: STRING is "is_empty definition file%NPlease enter a valid definition file"
			-- Invalid destination folder message

	File_filters_descriptions: ARRAY [STRING] is
			-- Open file dialog file filters descriptions
		once
			Result := <<"IDL File (*.idl)", "Type Library (*.tlb)", "ActiveX Control (*.ocx)", "Object Library (*.olb)", "Dynamic Link Library (*.dll)", "Executable (*.exe)", "All (*.*)">>
		end
	
	File_filters: ARRAY [STRING] is
			-- Open file dialog file filters
		once
			Result := <<"*.idl", "*.tlb", "*.ocx", "*.olb", "*.dll", "*.exe", "*.*">>
		end

	Folder_selection_dialog_title: STRING is "Choose Destination Folder"
			-- Folder selection dialog title

	idl_file_extension: STRING is ".idl"
			-- IDL file extension

	setup_text_fields is
			-- Initialize edits according to `shared_wizard_environment'.
		do
			if shared_wizard_environment.idl and shared_wizard_environment.idl_file_name /= Void then
				definition_file_edit.set_text (shared_wizard_environment.idl_file_name)
			elseif not shared_wizard_environment.idl and shared_wizard_environment.type_library_file_name /= Void then
				definition_file_edit.set_text (shared_wizard_environment.type_library_file_name)
			end
			if shared_wizard_environment.destination_folder /= Void then
				destination_folder_edit.set_text (shared_wizard_environment.destination_folder)
			end
		end

	project_name: STRING is
			-- Project name
		local
			separator_index: INTEGER
		do
			Result := definition_file_edit.text
			separator_index := Result.last_index_of (Directory_separator, Result.count)
			Result.tail (Result.count - separator_index)
		end

end -- class WIZARD_DEFINITION_FILE_DIALOG

--|-------------------------------------------------------------------
--| This class was automatically generated by Resource Bench
--| Copyright (C) 1996-1997, Interactive Software Engineering, Inc.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------
