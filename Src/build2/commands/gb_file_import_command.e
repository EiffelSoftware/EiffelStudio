indexing
	description: "Objects that represent an import command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FILE_IMPORT_COMMAND

inherit
	GB_STANDARD_CMD
		redefine
			execute, executable
		end

	GB_CONSTANTS
		export
			{NONE} all
		end

	GB_FILE_CONSTANTS
		export
			{NONE} all
		end

	GB_RECENT_PROJECTS
		export
			{NONE} all
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		do
			components := a_components
			make
			set_tooltip ("Import Project...")
			set_name ("Import project...")
			set_menu_name ("Import Project...")
			disable_sensitive
			add_agent (agent execute)
		end

feature -- Access

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
				-- Only can execute if there is a project open.
			Result := components.system_status.project_open
		end

feature -- Basic operations

		project_settings: GB_PROJECT_SETTINGS
			-- Last project settings loaded by `execute' or
			-- `execute_with_name'.

		execute is
				-- Execute `Current'.
			local
				dialog: EV_FILE_OPEN_DIALOG
				opened: BOOLEAN
				file_handler: GB_SIMPLE_XML_FILE_HANDLER
				test_file: RAW_FILE
				error_dialog: EV_ERROR_DIALOG
				dialog_constants: EV_DIALOG_CONSTANTS
				file_name: FILE_NAME
			do
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
								create file_name.make_from_string (project_settings.project_location)
								file_name.extend ("system_interface.xml")
								create test_file.make (file_name)
								if test_file.exists then
									components.xml_handler.import (file_name)
									add_project_to_recent_projects
									components.commands.update
										-- Compress all used ids.
									id_compressor.compress_all_id
								end
							end
						end
					end
				end
				if test_file /= Void and then not test_file.exists then
					create error_dialog.make_with_text ("The system interface file '" + system_interface_filename + "' (referenced by the specified .BPR file) is missing.%NIf the file has been moved, please restore the file and try again.%NIf you no longer have a copy of the file, please start a new project.")
					create dialog_constants
						-- Hide unwanted buttons from the dialog
					error_dialog.button (dialog_constants.ev_retry).hide;
					(error_dialog.button (dialog_constants.ev_ignore)).hide
					error_dialog.show_modal_to_window (components.tools.main_window)
				end
			end

	system_interface_filename: FILE_NAME is
			-- File to be generated.
		do
			create Result.make_from_string (components.system_status.current_project_settings.project_location)
			Result.extend ("system_interface.xml")
		end

feature {NONE} -- Implementation

	valid_file_name (file_name: STRING): BOOLEAN is
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

	id_compressor: GB_ID_COMPRESSOR is
			-- Once instance of GB_ID_COMPRESSOR
			-- for compressing saved Ids.
		once
			create Result.make_with_components (components)
		end

end -- class GB_FILE_OPEN_COMMAND

