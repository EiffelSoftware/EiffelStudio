indexing 
	description: "WIZARD_EIFFEL_PROJECT_FILE_DIALOG class created by Resource Bench."

class 
	WIZARD_EIFFEL_PROJECT_FILE_DIALOG

inherit
	WIZARD_DIALOG
		redefine
			setup_dialog,
			notify,
			on_ok
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
			make_by_id (a_parent, Wizard_eiffel_project_file_dialog_constant)
			create id_ok.make_by_id (Current, Idok)
			create id_cancel.make_by_id (Current, Idcancel)
			create project_file_edit.make_by_id (Current, Project_file_edit_constant)
			create ace_file_name_edit.make_by_id (Current, Ace_file_edit_constant)
			create cluster_edit.make_by_id (Current, Cluster_Edit_constant)
			create class_name_edit.make_by_id (Current, Eiffel_class_edit_constant)
			create ace_file_browse_button.make_by_id (Current, Ace_file_browse_button_constant)
			create project_file_browse_button.make_by_id (Current, Project_file_browse_button_constant)
			create help_button.make_by_id (Current, Help_button_constant)
			help_topic_id := 734
			create id_back.make_by_id (Current, Id_back_constant)
			create msg_box.make
		end

feature -- Behavior

	setup_dialog is
			-- Initialize dialog's controls.
		do
			Precursor {WIZARD_DIALOG}
			setup_text_fields
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- Process `control_id' control notification.
		do
			if control = project_file_browse_button then
				browse_for_project_file
			elseif control = ace_file_browse_button then
				browse_for_ace_file
			end
		end

	on_ok is
			-- Process Next button activation.
		local
			project_file_name, eiffel_class_name, ace_file_name, cluster_name: STRING
			a_file: RAW_FILE
		do
			project_file_name := project_file_edit.text
			eiffel_class_name := class_name_edit.text
			eiffel_class_name.left_adjust
			eiffel_class_name.right_adjust
			ace_file_name := ace_file_name_edit.text
			cluster_name := cluster_edit.text

			project_file_name.to_lower
			if project_file_name = Void or else project_file_name.empty then
				msg_box.error_message_box (Current, Empty_project_file, Initialization_error)
			elseif eiffel_class_name = Void or else eiffel_class_name.empty then
				msg_box.error_message_box (Current, Empty_class_name, Initialization_error)
			elseif ace_file_name = Void or else ace_file_name.empty then
				msg_box.error_message_box (Current, Empty_ace_file, Initialization_error)
			elseif cluster_name = Void or else cluster_name.empty then
				msg_box.error_message_box (Current, Empty_cluster_name, Initialization_error)
			else
				shared_wizard_environment.set_project_name (project_name)
				shared_wizard_environment.set_ace_file_name (ace_file_name)
				shared_wizard_environment.set_class_cluster_name (cluster_name)

				create a_file.make (project_file_name)
				if not a_file.exists then
					msg_box.warning_message_box (Current, Invalid_project_file, Wizard_error)
				else
					shared_wizard_environment.set_eiffel_project_name (project_file_name)

					shared_wizard_environment.set_eiffel_class_name (eiffel_class_name)
					Precursor {WIZARD_DIALOG}
				end
			end
		end

feature -- Access

	class_name_edit: WEl_SINGLE_LINE_EDIT
			-- Class name edit

	ace_file_name_edit: WEL_SINGLE_LINE_EDIT
			-- Ace file name edit

	project_file_edit: WEL_SINGLE_LINE_EDIT
			-- Project file location edit

	cluster_edit: WEL_SINGLE_LINE_EDIT
			-- Destination folder location edit

	ace_file_browse_button: WEL_PUSH_BUTTON
			-- Browse for Ace file button

	project_file_browse_button: WEL_PUSH_BUTTON
			-- Browse for project file button

feature -- Basic Operations

	browse_for_ace_file is
			-- Browse for Ace file
		do
			ace_file_selection_dialog.set_initial_directory (browse_directory)
			ace_file_selection_dialog.activate (Current)
			if ace_file_selection_dialog.selected then
				ace_file_name_edit.set_text (ace_file_selection_dialog.file_name)
			end
			safe_browse_directory_from_dialog (ace_file_selection_dialog)
		end

	browse_for_project_file is
			-- Browse for Eiffel file.
		do
			File_selection_dialog.set_initial_directory (browse_directory)
			File_selection_dialog.activate (Current)
			if File_selection_dialog.selected then
				project_file_edit.set_text (file_selection_dialog.file_name)
			end
			safe_browse_directory_from_dialog (file_selection_dialog)
		end
	
	File_selection_dialog: WEL_OPEN_FILE_DIALOG is
			-- File selection dialog
		once
			create Result.make
			Result.set_filter (File_filters_descriptions, File_filters)
		end
	
	ace_file_selection_dialog: WEL_OPEN_FILE_DIALOG is
			-- Ace file selection dialog
		once
			create Result.make
			Result.set_filter (Ace_file_filter_descriptions, Ace_file_filters)
		end

feature {NONE} -- Implementation

	msg_box: WEL_MSG_BOX
			-- Message box.

	Initialization_error: STRING is "Initialization Error"
			-- Initialization error message.

	Wizard_error: STRING is "Wizard error"
			-- Wizard error message.

	Invalid_destination_folder: STRING is "Invalid destination folder%NPlease enter a valid destination folder"
			-- Invalid destination folder message.

	Invalid_project_file: STRING is "Invalid project file%NPlease enter a valid definition file"
			-- Invalid destination folder message.

	Empty_destination_folder: STRING is "Empty destination folder%NPlease enter a valid destination folder"
			-- Invalid destination folder message

	Empty_project_file: STRING is "Empty project file%NPlease enter a valid project file"
			-- Invalid destination folder message.

	Empty_ace_file: STRING is "Empty Ace file%NPlease enter a valid Ace file"
			-- Invalid destination folder message.

	Empty_class_name: STRING is "Empty class name%NPlease enter a valid class name"
			-- Invalid class name message.

	Empty_cluster_name: STRING is "Empty cluster name%NPlease enter a valid cluster name"
			-- Invalid cluster name message.

	File_filters_descriptions: ARRAY [STRING] is
			-- Open file dialog file filters descriptions.
		once
			Result := <<"Eiffel Project (*.epr)">>
		end
	
	File_filters: ARRAY [STRING] is
			-- Open file dialog file filters.
		once
			Result := <<"*.epr">>
		end

	Ace_file_filter_descriptions: ARRAY[STRING] is
			-- Ace file dialog file filter descriptions.
		once
			Result := <<"Ace file (*.ace)", "All files">>
		end

	Ace_file_filters: ARRAY[STRING] is
			-- Ace file filters.
		once
			Result := <<"*.ace","*.*">>
		end

	Folder_selection_dialog_title: STRING is "Choose Destination Folder"
			-- Folder selection dialog title.

	idl_file_extension: STRING is ".idl"
			-- IDL file extension

	setup_text_fields is
			-- Initialize edits according to `shared_wizard_environment'.
		do
			if shared_wizard_environment.eiffel_project_name /= Void then
				project_file_edit.set_text (shared_wizard_environment.eiffel_project_name)
			end

			if shared_wizard_environment.eiffel_class_name /= Void then
				class_name_edit.set_text (shared_wizard_environment.eiffel_class_name)
			end

			if shared_wizard_environment.ace_file_name /= Void then
				ace_file_name_edit.set_text (shared_wizard_environment.ace_file_name)
			end

			if shared_wizard_environment.class_cluster_name /= Void then
				cluster_edit.set_text (shared_wizard_environment.class_cluster_name)
			end
		end

	project_name: STRING is
			-- Project name.
		local
			separator_index: INTEGER
		do
			Result := project_file_edit.text
			separator_index := Result.last_index_of (Directory_separator, Result.count)
			Result.tail (Result.count - separator_index)
		end

end -- class WIZARD_EIFFEL_PROJECT_FILE_DIALOG

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
