indexing
	description: "Objects that represent the open command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FILE_OPEN_COMMAND
	
inherit
	EB_STANDARD_CMD
		redefine
			make, execute, executable
		end
	
	GB_SHARED_XML_HANDLER
	
	GB_SHARED_COMMAND_HANDLER
	
	GB_SHARED_TOOLS
	
	GB_WIDGET_UTILITIES
	
	GB_CONSTANTS
	
	GB_SHARED_SYSTEM_STATUS
	
	GB_GENERAL_UTILITIES

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("Open Project...")
			set_name ("Open project...")
			set_menu_name ("Open Project...")
			enable_sensitive
			add_agent (agent execute)

					-- Now add an accelerator for `Current'.
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_o)
			create acc.make_with_key_combination (key, True, False, False)
			set_accelerator (acc)
		end
		
feature -- Access

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
				-- Only can execute if there is no project open.
			Result := not (system_status.project_open)
		end

feature -- Basic operations

		project_settings: GB_PROJECT_SETTINGS
			-- Last project settings loaded by `execute' or
			-- `execute_with_name'.

		execute_with_name (file_name: STRING) is
				-- execute `Current' to load file `file_name'. This is used when
				-- starting build by double clicking on a .bpr file.
			local
				file_handler: GB_SIMPLE_XML_FILE_HANDLER
				test_file: RAW_FILE
				error_dialog: EV_ERROR_DIALOG
				dialog_constants: EV_DIALOG_CONSTANTS
			do
				create project_settings
				create file_handler
				project_settings.load (file_name, file_handler)
				if file_handler.last_load_successful then
					if not project_settings.load_cancelled then
							-- Do nothing if we cancelled the loading.
						if project_settings.main_window_class_name = Void then
								-- If the main window class name is Void, then it means that
								-- the settings were not loaded (As they were not compatible),
								-- so we fill in the location, and use the default_values.
							create project_settings.make_stand_alone_with_default_values
								-- Set the location to the current file location.
							project_settings.set_project_location (directory_of_file (file_name))
						end
						system_status.set_current_project (project_settings)
						if not directory_of_file (file_name).is_equal (project_settings.project_location) then								
							create error_dialog.make_with_text ("The location of the .bpr file has changed from " + project_settings.project_location + " to " + directory_of_file (file_name) + ".%NPlease ensure that the file `system_interface.xml' has also been relocated to this new directory.%NBuild will now update the reference to `system_interface.xml' and attempt to load the file.")
							create dialog_constants
								-- Hide unwanted buttons from the dialog
							error_dialog.button (dialog_constants.ev_retry).set_text ("Continue")
							error_dialog.button (dialog_constants.ev_retry).select_actions.extend (agent update_location (directory_of_file (file_name)))
							error_dialog.button (dialog_constants.ev_ignore).hide
							error_dialog.button (dialog_constants.ev_abort).select_actions.extend (agent cancel_update_location)
							error_dialog.show_modal_to_window (main_window)
						end
						
						if not location_update_cancelled then
							create test_file.make (filename)
							if test_file.exists then
								xml_handler.load
								if not system_status.current_project_settings.is_envision_project then
									main_window.show_tools	
								end
								command_handler.update
									-- Compress all used ids.
								id_compressor.compress_all_id
							end
						end
					end
				end
				if test_file /= Void and then not test_file.exists and not location_update_cancelled then
					create error_dialog.make_with_text ("The system interface file '" + filename + "' (referenced by the specified .BPR file) is missing.%NIf the file has been moved, please restore the file and try again.%NIf you no longer have a copy of the file, please start a new project.")
					create dialog_constants
						-- Hide unwanted buttons from the dialog
					error_dialog.button (dialog_constants.ev_retry).hide;
					(error_dialog.button (dialog_constants.ev_ignore)).hide
					error_dialog.show_modal_to_window (main_window)
					system_status.close_current_project
					if project_settings.is_envision_project then
						Environment.application.destroy
					end
				end
			end
			
	
		execute is
				-- Execute `Current'.
			local
				dialog: EV_FILE_OPEN_DIALOG
				opened: BOOLEAN
				file_handler: GB_SIMPLE_XML_FILE_HANDLER
				test_file: RAW_FILE
				error_dialog: EV_ERROR_DIALOG
				dialog_constants: EV_DIALOG_CONSTANTS
				temp_file_name, retrieved_file_name: FILE_NAME
			do
					-- Reset this value.
				location_update_cancelled := False
				create dialog
				dialog.set_filter (project_file_filter)
				create file_handler
					-- We do not allow the dialog to close until a valid
					-- file name has been entered or the user clicks the
					-- cancel button.
					-- As the file name is empty before the dialog is shown,
					-- we use `opened' to ensure that it opens the first
					-- time.
				from
				until
					opened and then
					((valid_file_name (dialog.file_name) and file_handler.last_load_successful and not project_settings.load_cancelled) or dialog.file_name.is_empty)
				loop
						-- Display the dialog.
					dialog.show_modal_to_window (main_window)
						-- The dialog has now been opened once.
					opened := True
						-- If the ok button was clicked and the file name exists,
						-- then we attempt to open it.
					if not dialog.file_name.is_empty and valid_file_name (dialog.file_name) then
						create project_settings
						project_settings.load (dialog.file_name, file_handler)
						if file_handler.last_load_successful and not project_settings.load_cancelled then
							-- Check that the filename is valid.
							-- i.e. that the system_interface file exists.
							if not project_settings.load_cancelled then
									-- Do nothing if we cancelled the loading.
								if project_settings.main_window_class_name = Void then
										-- If the main window class name is Void, then it means that
										-- the settings were not loaded (As they were not compatible),
										-- so we fill in the location, and use the default_values.
									create project_settings.make_stand_alone_with_default_values
									project_settings.set_project_location (dialog.file_path)
								end
								system_status.set_current_project (project_settings)
									-- We must now check to see if the build project is in a different location
									-- to the location referenced in the file. If it is, we need to update the
									-- location, so we can find `system_interface.xml' correctly in the new location.
								if not dialog.file_path.is_equal (project_settings.project_location) then								
									create error_dialog.make_with_text ("The location of the .bpr file has changed from " + project_settings.project_location + " to " + dialog.file_path + ".%NPlease ensure that the file `system_interface.xml' has also been relocated to this new directory.%NBuild will now update the reference to `system_interface.xml' and attempt to load the file.")
									create dialog_constants
										-- Hide unwanted buttons from the dialog
									error_dialog.button (dialog_constants.ev_retry).set_text ("Continue")
									error_dialog.button (dialog_constants.ev_retry).select_actions.extend (agent update_location (dialog.file_path))
									error_dialog.button (dialog_constants.ev_ignore).hide
									error_dialog.button (dialog_constants.ev_abort).select_actions.extend (agent cancel_update_location)
									error_dialog.show_modal_to_window (main_window)
								end
								
								if not location_update_cancelled then
										-- Do not load the project, as the used selected "abort" from
										-- the previous dialog.
									create test_file.make (filename)
									if test_file.exists then
										xml_handler.load
										main_window.show_tools
										command_handler.update
											-- Compress all used ids.
										id_compressor.compress_all_id
									end
								end
							end
						end	
					end
				end
				if test_file /= Void and then not test_file.exists and not location_update_cancelled then
					create error_dialog.make_with_text ("The system interface file '" + filename + "' (referenced by the specified .BPR file) is missing.%NIf the file has been moved, please restore the file and try again.%NIf you no longer have a copy of the file, please start a new project.")
					create dialog_constants
						-- Hide unwanted buttons from the dialog
					error_dialog.button (dialog_constants.ev_retry).hide;
					(error_dialog.button (dialog_constants.ev_ignore)).hide
					error_dialog.show_modal_to_window (main_window)
					system_status.close_current_project
				end
			end

feature {NONE} -- Implementation
	
	update_location (new_location: STRING) is
			-- Assign `new_location' to `project_location' in the
			-- system settings, and save the current settings.
		do
			system_status.current_project_settings.set_project_location (new_location)
			system_status.current_project_settings.save
		end
		
	cancel_update_location is
			-- Assign `True' to `location_update_cancelled', so that
			-- we know a user selected cancel, from the lcoation update
			-- dialog.
		do
			location_update_cancelled := True
			system_status.close_current_project
				-- If we are in wizard mode, and they have clicked cancel, to
				-- the update of the .bpr project location, then we end Build
				-- as there is nothing to do.
			if project_settings.is_envision_project then
				Environment.application.destroy
			end
		end
	
	location_update_cancelled: BOOLEAN
		-- Has the response to the out of synch project location in the .bpr file
		-- to abort the loading process?

	valid_file_name (file_name: STRING): BOOLEAN is
			-- Is `file_name' the name of an existing file?
		require
			file_name_not_void: file_name /= Void
		local
			file: RAW_FILE
		do
			if not file_name.is_empty then
				create file.make (file_name)
				Result := file.exists
			end
		end
		
	id_compressor: GB_ID_COMPRESSOR is
			-- Once instance of GB_ID_COMPRESSOR
			-- for compressing saved Ids.
		once
			create Result
		end

end -- class GB_FILE_OPEN_COMMAND
