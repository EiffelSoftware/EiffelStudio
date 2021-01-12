note
	description: "Objects that represent the open command."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FILE_OPEN_COMMAND

inherit
	GB_STANDARD_CMD
		redefine
			execute, executable
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

	GB_CONSTANTS
		export
			{NONE} all
		end

	GB_FILE_CONSTANTS
		export
			{NONE} all
		end

	GB_GENERAL_UTILITIES
		export
			{NONE} all
		end

	GB_RECENT_PROJECTS
		export
			{NONE} all
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS)
			-- Create `Current' and assign `a_components' to `components'.
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
		do
			components := a_components
			make
			set_tooltip ("Open Project...")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_open_file)
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

	executable: BOOLEAN
			-- May `execute' be called on `Current'?
		do
				-- Only can execute if there is no project open.
			Result := not (components.system_status.project_open)
		end

feature -- Basic operations

		project_settings: GB_PROJECT_SETTINGS
			-- Last project settings loaded by `execute' or
			-- `execute_with_name'.

		execute_with_name (file_name: STRING)
				-- execute `Current' to load file `file_name'. This is used when
				-- starting build by double clicking on a .bpr file.
			require
				file_name_not_void: file_name /= Void
			local
				file_handler: GB_SIMPLE_XML_FILE_HANDLER
				test_file: RAW_FILE
				error_dialog: EV_ERROR_DIALOG
				dialog_constants: EV_DIALOG_CONSTANTS
				discardable_error_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
				id_compressor: GB_ID_COMPRESSOR
			do
				create project_settings.make_with_components (components)
				create file_handler.make_with_components (components)
				project_settings.load (file_name, file_handler)
				if file_handler.last_load_successful then
					if not project_settings.load_cancelled then
							-- Do nothing if we cancelled the loading.
						if project_settings.main_window_class_name = Void then
								-- If the main window class name is Void, then it means that
								-- the settings were not loaded (As they were not compatible),
								-- so we fill in the location, and use the default_values.
							create project_settings.make_with_default_values (components)
								-- Set the location to the current file location.
							project_settings.set_project_location (directory_of_file (file_name))
						end
						components.system_status.set_current_project (project_settings)
						if not directory_of_file (file_name).same_string (project_settings.project_location) then
							create discardable_error_dialog.make_initialized (1, preferences.dialog_data.show_project_location_changed_warning,
								"The location of the .bpr file has changed from " + project_settings.project_location + " to " + directory_of_file (file_name) + ".%N%NPlease ensure that the file `system_interface.xml' has also been relocated to this new directory%NEiffelBuild will now attempt to load `system_interface.xml'.",
								"Do not show again and always check for `system_interface.xml' in the current directory",
								preferences.preferences)
							discardable_error_dialog.set_icon_pixmap (Icon_build_window @ 1)
							discardable_error_dialog.set_ok_action (agent update_location (directory_of_file (file_name)))
							discardable_error_dialog.show_modal_to_window (components.tools.main_window)
						end

						if not location_update_cancelled then
							create test_file.make_with_path (system_interface_filename)
							if test_file.exists then
								components.events.open_project_start_actions.call (Void)
								components.xml_handler.load
								components.commands.update
									-- Compress all used ids.
								create id_compressor.make_with_components (components)
								id_compressor.compress_all_id
							end
							update_client_information
						end
					end
				end
				if test_file /= Void and then not test_file.exists and not location_update_cancelled then
					create error_dialog.make_with_text ("The system interface file '" + system_interface_filename.utf_8_name + "' (referenced by the specified .BPR file) is missing.%NIf the file has been moved, please restore the file and try again.%NIf you no longer have a copy of the file, please start a new project.")
					create dialog_constants
						-- Hide unwanted buttons from the dialog
					error_dialog.button (dialog_constants.ev_retry).hide;
					(error_dialog.button (dialog_constants.ev_ignore)).hide
					error_dialog.show_modal_to_window (components.tools.main_window)
					components.system_status.close_current_project
				end
				if components.system_status.project_open then
					add_project_to_recent_projects
					components.events.open_project_finish_actions.call (Void)
				end
			end


		execute
				-- Execute `Current'.
			local
				dialog: EV_FILE_OPEN_DIALOG
				opened: BOOLEAN
				file_handler: GB_SIMPLE_XML_FILE_HANDLER
				test_file: RAW_FILE
				error_dialog: EV_ERROR_DIALOG
				discardable_error_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
				dialog_constants: EV_DIALOG_CONSTANTS
				id_compressor: GB_ID_COMPRESSOR
			do
					-- Reset this value.
				location_update_cancelled := False
				create dialog
				dialog.filters.extend ([project_file_filter, "Files of type (" + project_file_filter + ")"])
				create file_handler.make_with_components (components)
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
					dialog.show_modal_to_window (components.tools.main_window)
						-- The dialog has now been opened once.
					opened := True
						-- If the ok button was clicked and the file name exists,
						-- then we attempt to open it.
					if not dialog.file_name.is_empty and valid_file_name (dialog.file_name) then
						create project_settings.make_with_components (components)
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
									create project_settings.make_with_default_values (components)
									project_settings.set_project_location (dialog.file_path)
								end
								components.system_status.set_current_project (project_settings)
									-- We must now check to see if the build project is in a different location
									-- to the location referenced in the file. If it is, we need to update the
									-- location, so we can find `system_interface.xml' correctly in the new location.
								if not dialog.file_path.same_string_general (project_settings.project_location) then
									create discardable_error_dialog.make_initialized (1, preferences.dialog_data.show_project_location_changed_warning,
										"The location of the .bpr file has changed from " + project_settings.project_location + " to " + dialog.file_path + ".%N%NPlease ensure that the file `system_interface.xml' has also been relocated to this new directory%NEiffelBuild will now attempt to load `system_interface.xml'.",
										"Do not show again and always check for `system_interface.xml' in the current directory",
										preferences.preferences)
									discardable_error_dialog.set_icon_pixmap (Icon_build_window @ 1)
									discardable_error_dialog.set_ok_action (agent update_location (dialog.file_path))
									discardable_error_dialog.show_modal_to_window (components.tools.main_window)
								end

								if not location_update_cancelled then
										-- Do not load the project, as the used selected "abort" from
										-- the previous dialog.
									create test_file.make_with_path (system_interface_filename)
									if test_file.exists then
										components.events.open_project_start_actions.call (Void)
										components.xml_handler.load
										add_project_to_recent_projects
										components.commands.update
											-- Compress all used ids.
										create id_compressor.make_with_components (components)
										id_compressor.compress_all_id
										update_client_information
										components.events.open_project_finish_actions.call (Void)
									end
								end
							end
						end
					end
				end
				if test_file /= Void and then not test_file.exists and not location_update_cancelled then
					create error_dialog.make_with_text ("The system interface file '" + system_interface_filename.utf_8_name + "' (referenced by the specified .BPR file) is missing.%NIf the file has been moved, please restore the file and try again.%NIf you no longer have a copy of the file, please start a new project.")
					create dialog_constants
						-- Hide unwanted buttons from the dialog
					error_dialog.button (dialog_constants.ev_retry).hide;
					(error_dialog.button (dialog_constants.ev_ignore)).hide
					error_dialog.show_modal_to_window (components.tools.main_window)
					components.system_status.close_current_project
				end
			end

	system_interface_filename: PATH
			-- File to be generated.
		do
			create Result.make_from_string (components.system_status.current_project_settings.project_location)
			Result := Result.extended ("system_interface.xml")
		end

feature {NONE} -- Implementation

	update_location (new_location: STRING)
			-- Assign `new_location' to `project_location' in the
			-- system settings, and save the current settings.
		require
			new_location_not_void: new_location /= Void
		do
			components.system_status.current_project_settings.set_project_location (new_location)
			components.system_status.current_project_settings.save
		end

	cancel_update_location
			-- Assign `True' to `location_update_cancelled', so that
			-- we know a user selected cancel, from the location update
			-- dialog.
		do
			location_update_cancelled := True
			components.system_status.close_current_project
		end

	location_update_cancelled: BOOLEAN
		-- Has the response to the out of synch project location in the .bpr file
		-- to abort the loading process?

	valid_file_name (file_name: STRING): BOOLEAN
			-- Is `file_name' the name of an existing file?
		require
			file_name_not_void: file_name /= Void
		local
			file: RAW_FILE
		do
			if not file_name.is_empty then
				create file.make (file_name)
				Result := file.exists and not file.is_directory
			end
		end

	update_client_information
			-- Update all top level objects to be generated as clients if the loaded file
			-- had the client generation option set. This is provided for backwards compatibility.
		do
			if project_settings.loaded_project_had_client_information then
				components.tools.widget_selector.objects.do_all (agent project_settings.set_object_as_client)
			end
		end

note
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


end -- class GB_FILE_OPEN_COMMAND
