indexing
	description: "Objects that represent a command for the deletion of a directory."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_DELETE_DIRECTORY
	
inherit
	
	GB_COMMAND
		export
			{NONE} all
		end
	
	GB_SHARED_HISTORY
		export
			{NONE} all
		end
		
	GB_FILE_UTILITIES
		export
			{NONE} all
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
		
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
	
create
	make
	
feature {NONE} -- Initialization

	make (a_directory: STRING) is
			-- Create `Current' with directory named `a_directory'.
		do
			directory_name := a_directory
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			temp_file_name: FILE_NAME
			directory: DIRECTORY
		do
			history.cut_off_at_current_position
				-- Now actually remove the directory from the disk.
			create temp_file_name.make_from_string (generated_path.string)
			temp_file_name.extend (directory_name)	
			create directory.make (temp_file_name)
			delete_directory (directory)
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			command_handler.update
		end
		
	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			temp_file_name: FILE_NAME
			directory: DIRECTORY
		do
			create temp_file_name.make_from_string (generated_path.string)
			temp_file_name.extend (directory_name)	
			create directory.make (temp_file_name)
			create_directory (directory)
			window_selector.add_named_directory (directory_name)
			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		do
			Result := "directory %"" + directory_name + "%" removed from project."
		end

feature {NONE} -- Implementation

	generated_path: FILE_NAME is
			-- `Result' is generated directory for current project.
		do
			create Result.make_from_string (system_status.current_project_settings.project_location)
		ensure
			result_not_void: Result /= Void
		end

	directory_name: STRING
		-- Name of directory that was deleted. Only the actual name,
		-- and not the full name, as all directories are relative to the project.

end -- class GB_COMMAND_DELETE_DIRECTORY
