indexing 
	description: "WIZARD_INITIAL_DIALOG class created by Resource Bench."

class 
	WIZARD_INITIAL_DIALOG

inherit
	WEL_MODAL_DIALOG
		redefine
			on_ok,
			notify,
			setup_dialog
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	APPLICATION_IDS	
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Create the dialog.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			make_by_id (a_parent, Wizard_initial_dialog_constant)
			create in_process_check.make_by_id (Current, In_process_check_constant)
			create local_check.make_by_id (Current, Local_check_constant)
			create remote_check.make_by_id (Current, Remote_check_constant)
			create id_ok.make_by_id (Current, Idok)
			create definition_file_edit.make_by_id (Current, Definition_file_edit_constant)
			create generate_edit.make_by_id (Current, Generate_edit_constant)
			create idl_static.make_by_id (Current, Idl_static_constant)
			create generate_static.make_by_id (Current, Generate_static_constant)
			create id_cancel.make_by_id (Current, Idcancel)
			create browse_button.make_by_id (Current, Browse_button_constant)
			create browse2_button.make_by_id (Current, Browse2_button_constant)
			create help_button.make_by_id (Current, Help_button_constant)
			create server_check.make_by_id (Current, Server_check_constant)
			create client_check.make_by_id (Current, Client_check_constant)
		end

feature -- Behavior

	on_ok is
			-- Process Next button activation.
		local
			folder_name, file_name: STRING
			a_file: RAW_FILE
		do
			shared_wizard_environment.set_client (client_check.checked)
			shared_wizard_environment.set_server (server_check.checked)
			shared_wizard_environment.set_in_process_server (in_process_check.checked)
			shared_wizard_environment.set_local_server (local_check.checked)
			shared_wizard_environment.set_remote_server (remote_check.checked)
			folder_name := generate_edit.text
			file_name := definition_file_edit.text
			if folder_name = Void or folder_name.empty then
				msg_box.error_message_box (Current, "Destination folder empty!", "Initialization Error")
			elseif file_name = Void or file_name.empty then
				msg_box.error_message_box (Current, "Definition file empty!", "Initialization Error")
			else
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
						Precursor
					end
				end
			end
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- Process `control_id' control notification.
		do
			if control = browse_button then
				browse_for_definition_file
			elseif control = browse2_button then
				browse_for_destination_folder
			elseif control = help_button then
		--		Help_dialog.activate
			end
		end

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
			if shared_wizard_environment.client then
				client_check.set_checked
			end
			if shared_wizard_environment.server then
				server_check.set_checked
			end
			if shared_wizard_environment.in_process_server then
				in_process_check.set_checked
			end
			if shared_wizard_environment.local_server then
				local_check.set_checked
			end
			if shared_wizard_environment.remote_server then
				remote_check.set_checked
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

	launch_next_dialog is
			-- Launch code generation.
		local
			a_file: RAW_FILE
		do
		end

feature -- GUI Elements

	in_process_check: WEL_CHECK_BOX
			-- In Process check box

	local_check: WEL_CHECK_BOX
			-- Local check box

	remote_check: WEL_CHECK_BOX
			-- Remote check box

	id_ok: WEL_PUSH_BUTTON
			-- OK button

	definition_file_edit: WEL_SINGLE_LINE_EDIT
			-- Definition file location edit

	generate_edit: WEL_SINGLE_LINE_EDIT
			-- Generate folder location edit

	idl_static: WEL_STATIC
			-- Definition file location edit title

	generate_static: WEL_STATIC
			-- Generate folder location edit title

	id_cancel: WEL_PUSH_BUTTON
			-- Cancel button

	browse_button: WEL_PUSH_BUTTON
			-- Browse for definition file button

	browse2_button: WEL_PUSH_BUTTON
			-- Browse for destination folder button

	help_button: WEL_PUSH_BUTTON
			-- Help button

	server_check: WEL_CHECK_BOX
			-- Generate server code check box
	
	client_check: WEL_CHECK_BOX
			-- Generate client code check box

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
