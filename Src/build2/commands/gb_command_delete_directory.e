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

	make (a_directory, parent_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM) is
			-- Create `Current' with directory named `a_directory'.
		require
			a_directory_not_void: a_directory /= Void
			void_parent_implies_widget_selector: parent_directory = Void implies a_directory.parent = widget_selector
			non_void_parent_correct: parent_directory /= Void implies a_directory.parent /= widget_selector
		do
			History.cut_off_at_current_position
			directory_name := a_directory.path
			if parent_directory /= Void then
				parent_directory_name := parent_directory.path
			end
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			temp_file_name: FILE_NAME
			directory: DIRECTORY
			directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
				-- Now actually remove the directory from the disk.
			create temp_file_name.make_from_string (generated_path.string)
			from
				directory_name.start
			until
				directory_name.off
			loop
				temp_file_name.extend (directory_name.item)
				directory_name.forth
			end
			create directory.make (temp_file_name)
			if directory.exists and directory.is_empty then
					-- Only remove the directory if it is present on the disk.
					-- If a project has not been generated, then there may be no directory yet.
				delete_directory (directory)
			end
				-- Now remove the representation from the directory selector.
			directory_item := widget_selector.directory_object_from_name (directory_name)
			check
				directory_item_found: directory_item /= Void
			end
			directory_item.unparent
			
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
				-- Only restore the directory to the disk if it was actually
				-- removed previously.
			create temp_file_name.make_from_string (generated_path.string)
			from
				directory_name.start
			until
				directory_name.off
			loop
				temp_file_name.extend (directory_name.item)
				directory_name.forth
			end
			create directory.make (temp_file_name)
			if not directory.exists then
				create_directory (directory)	
			end
			widget_selector.silent_add_named_directory (directory_name)
			command_handler.update
		end
	
	textual_representation: STRING is
			-- Text representation of command exectuted.
		do
			Result := "directory %"" + directory_name.last + "%" removed from project."
		end

feature {NONE} -- Implementation

	generated_path: FILE_NAME is
			-- `Result' is generated directory for current project.
		do
			create Result.make_from_string (system_status.current_project_settings.project_location)
		ensure
			result_not_void: Result /= Void
		end
		
	parent_directory_name: ARRAYED_LIST [STRING]
		-- Name of parent directory in which `directory_name' is contained.

	directory_name: ARRAYED_LIST [STRING]
		-- Name of directory that was deleted.

end -- class GB_COMMAND_DELETE_DIRECTORY
