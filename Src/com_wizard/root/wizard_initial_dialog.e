indexing 
	description: "WIZARD_INITIAL_DIALOG class created by Resource Bench."

class 
	WIZARD_INITIAL_DIALOG

inherit
	WIZARD_DIALOG
		redefine
			setup_dialog,
			on_ok,
			notify
		end

	OPERATING_ENVIRONMENT
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
			make_by_id (a_parent, Wizard_initial_dialog_constant)
			create id_ok.make_by_id (Current, Idok)
			create definition_file_edit.make_by_id (Current, Definition_file_edit_constant)
			create generate_edit.make_by_id (Current, Generate_edit_constant)
			create id_cancel.make_by_id (Current, Idcancel)
			create browse_button.make_by_id (Current, Browse_button_constant)
			create browse2_button.make_by_id (Current, Browse2_button_constant)
			create help_button.make_by_id (Current, Help_button_constant)
			create id_back.make_by_id (Current, Idok2_constant)
		end

feature -- Behavior

	setup_dialog is
			-- Initialize dialog's controls.
		do
			if shared_wizard_environment.idl and shared_wizard_environment.idl_file_name /= Void then
				definition_file_edit.set_text (shared_wizard_environment.idl_file_name)
			elseif not shared_wizard_environment.idl and shared_wizard_environment.type_library_file_name /= Void then
				definition_file_edit.set_text (shared_wizard_environment.type_library_file_name)
			end
			if shared_wizard_environment.destination_folder /= Void then
				generate_edit.set_text (shared_wizard_environment.destination_folder)
			end
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- Process `control_id' control notification.
		do
			if control = browse_button then
				browse_for_definition_file
			elseif control = browse2_button then
				browse_for_destination_folder
			end
		end

	on_ok is
			-- Process Next button activation.
		local
			folder_name, file_name: STRING
			a_file: RAW_FILE
		do
			folder_name := generate_edit.text
			file_name := definition_file_edit.text
			if folder_name = Void or folder_name.empty then
				msg_box.error_message_box (Current, "Destination folder empty!", "Initialization Error")
			elseif file_name = Void or file_name.empty then
				msg_box.error_message_box (Current, "Definition file empty!", "Initialization Error")
			else
				if folder_name.item (folder_name.count) = Directory_separator then
					folder_name.head (folder_name.count -1)
				end
				create a_file.make (folder_name)
				if not a_file.exists then
					msg_box.error_message_box (Current, "Destination folder not valid!", "Wizard Error")
				else
					create a_file.make (file_name)
					if not a_file.exists then
						msg_box.error_message_box (Current, "Definition file not valid!", "Wizard Error")
					else
						shared_wizard_environment.set_destination_folder (folder_name)
						if file_name.substring_index (idl_file_extension, 1) =
								(file_name.count - idl_file_extension.count + 1) then
							shared_wizard_environment.set_idl (True)
							shared_wizard_environment.set_idl_file_name (file_name)
						else
							shared_wizard_environment.set_type_library_file_name (file_name)
						end
						Precursor {WIZARD_DIALOG}
					end
				end
			end
		end

feature -- Basic Operations

	browse_for_definition_file is
			-- Browse for definition file.
		do
			File_selection_dialog.activate (Current)
			if File_selection_dialog.selected then
				definition_file_edit.set_text (file_selection_dialog.file_name)
				shared_wizard_environment.set_project_name (file_selection_dialog.file_title)
			end
		end
	
	browse_for_destination_folder is
			-- Browse for destination folder.
		do
			folder_selection_dialog.activate (Current)
			if folder_selection_dialog.selected then
				generate_edit.set_text (folder_selection_dialog.folder_name)
			end
		end

feature -- Access

	definition_file_edit: WEL_SINGLE_LINE_EDIT
			-- Definition file location edit

	generate_edit: WEL_SINGLE_LINE_EDIT
			-- Generate folder location edit

	browse_button: WEL_PUSH_BUTTON
			-- Browse for definition file button

	browse2_button: WEL_PUSH_BUTTON
			-- Browse for destination folder button

	File_selection_dialog: WEL_OPEN_FILE_DIALOG is
			-- File selection dialog
		once
			create Result.make
			Result.set_filter (<<"IDL File (*.idl)", "Type Library (*.tlb)", "Dynamic Link Library (*.dll)", "Executable (*.exe)">>, <<"*.idl", "*.tlb", "*.dll", "*.exe">>)
		end
	
	Folder_selection_dialog: WEL_CHOOSE_FOLDER_DIALOG is
			-- Folder selection dialog
		once
			create Result.make
			Result.set_title ("Choose Destination Folder")
		end

feature {NONE} -- Implementation

	msg_box: WEL_MSG_BOX is
			-- Message box
		once
			create Result.make
		end

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
				generate_edit.set_text (shared_wizard_environment.destination_folder)
			end
		end

end -- class WIZARD_INITIAL_DIALOG

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
