indexing
	description: "Objects that represent commands to add directories to a project."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_ADD_DIRECTORY
	
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

		--| FIXME, constants are now no longer undoable.
		--| Hence the commented sections in this class.

	make (a_directory: STRING) is
			-- Create `Current' with directory named `a_directory'.
		do
			history.cut_off_at_current_position
			directory_name := a_directory
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			temp_file_name: FILE_NAME
			directory: DIRECTORY
			layout_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			create layout_item.make_with_name (directory_name)
			window_selector.extend (layout_item)
			
				-- Now actually remove the directory from the disk.
			create temp_file_name.make_from_string (generated_path.string)
			temp_file_name.extend (directory_name)	
			create directory.make (temp_file_name)
			if not directory.exists then
					-- Only create the directory if it is not already present on the disk.
				create_directory (directory)
			end
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
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			directory_item := window_selector.directory_object_from_name (directory_name)
			check
				directory_not_void: directory_item /= Void
			end
			window_selector.prune_all (directory_item)
			create temp_file_name.make_from_string (generated_path.string)
			temp_file_name.extend (directory_name)	
			create directory.make (temp_file_name)
			if directory.exists and directory.is_empty then
				delete_directory (directory)
			end	
			command_handler.update
		end
	
	textual_representation: STRING is
			-- Text representation of command exectuted.
		do
			Result := "directory %"" + directory_name + "%" added to project."
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

end -- class GB_COMMAND_ADD_DIRECTORY
