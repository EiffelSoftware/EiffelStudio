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
		
	GB_SHARED_PREFERENCES
		export
			{NONE} all
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end
		
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
	
create
	make
	
feature {NONE} -- Initialization

	make (directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM; a_directory: STRING) is
			-- Create `Current' with directory named `a_directory'.
		require
			a_directory_not_void: a_directory /= Void
		do
			history.cut_off_at_current_position
			directory_name := a_directory
			if directory_item /= Void then
					-- `directory_item' may be `Void' if we are parenting at the root level
					-- in the window selector.
				parent_directory_path := directory_item.path
			else
				create parent_directory_path.make (0)
			end
		end

feature -- Basic Operation

	create_new_directory is
			-- Actually create directory
		local
			temp_file_name: FILE_NAME
			directory: DIRECTORY
			directory_exists_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			create temp_file_name.make_from_string (generated_path.string)
			from
				parent_directory_path.start
			until
				parent_directory_path.off
			loop
				temp_file_name.extend (parent_directory_path.item)
				create directory.make (temp_file_name)
				if not directory.exists then
						-- As the current nested directory path in the window selector
						-- may not actually exist on disk, we must re-create it.
					create_directory (directory)
				end
				parent_directory_path.forth
			end
			temp_file_name.extend (directory_name)
			create directory.make (temp_file_name)
			if not directory.exists then
					-- Only create the directory if it is not already present on the disk.
				create_directory (directory)
				directory_added_succesfully := True
			else
				if not warnings_supressed then
					create directory_exists_dialog.make_initialized (2, show_adding_existing_directory_warning,
									"The directory already exists on the disk. Do you wish to include it in the project?", "Always include, and do not show this warning again.")
					directory_exists_dialog.set_ok_action (agent set_directory_added_succesfully)
					directory_exists_dialog.show_modal_to_window (main_window)
				else
					directory_added_succesfully := True
				end
			end
		end
		
	set_directory_added_succesfully is
			-- Assign `True' to `directory_added_succesfully'
		do
			directory_added_succesfully := True
		end

	directory_added_succesfully: BOOLEAN
		-- Was last call to `create_directory' successful?

	execute is
			-- Execute `Current'.
		require else
			directory_added_succesfully: directory_added_succesfully
		local
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			window_node: EV_TREE_NODE_LIST
			tree_item: EV_TREE_ITEM
		do
			if executed_once then
					-- As we are re-doing an undo, we must create directory again.
					-- See comment of `executed_once'.
				create_new_directory
			end
			create directory_item.make_with_name (directory_name)
			if parent_directory_path.is_empty then
				add_to_tree_node_alphabetically (window_selector, directory_item)
			else
				window_node ?= tree_item_matching_path (window_selector, parent_directory_path)
				check
					window_node_not_void: window_node /= Void
				end
				add_to_tree_node_alphabetically (window_node, directory_item)
					-- Ensure `directory_item' is now visible.
				tree_item ?= window_node
				check
					node_was_item: tree_item /= Void
				end
				tree_item.expand
			end
			
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			command_handler.update
			executed_once := True
		end
		
	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			temp_file_name: FILE_NAME
			directory: DIRECTORY
			directory_item,	parent_directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			directory_path: ARRAYED_LIST [STRING]
		do
			directory_path := parent_directory_path.twin
			directory_path.extend (directory_name)
			directory_item := window_selector.directory_object_from_name (directory_path)
			check
				directory_item_not_void: directory_item /= Void				
			end
			if not parent_directory_path.is_empty then
				parent_directory_item := window_selector.directory_object_from_name (parent_directory_path)
				check
					parent_directory_not_void: parent_directory_item /= Void
					parent_has_directory: directory_item.parent = parent_directory_item
				end
				parent_directory_item.prune_all (directory_item)
			else
				check
					contained_in_window_selector: directory_item.parent = window_selector
				end
				window_selector.prune_all (directory_item)
			end
			
			create temp_file_name.make_from_string (generated_path.string)
			from
				directory_path.start
			until
				directory_path.off
			loop
				temp_file_name.extend (directory_path.item)
				directory_path.forth
			end
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
		
	supress_warnings is
			-- Ensure no warning is displayed when adding a directory
			-- that already exists.
		do
			warnings_supressed := True
		end

feature {NONE} -- Implementation

	executed_once: BOOLEAN
		-- Has `execute' already been called once? If so, we must call `create_new_directory'
		-- within `execute'. The first time that we call `execute' we do not perform it directly
		-- as the caller can do this to enable chacking for invalid directory names.

	generated_path: FILE_NAME is
			-- `Result' is generated directory for current project.
		do
			create Result.make_from_string (system_status.current_project_settings.project_location)
		ensure
			result_not_void: Result /= Void
		end

	directory_name: STRING
		-- Name of directory that was added. Only the actual name,
		-- and not the full name, as all directories are relative to the project.
		
	parent_directory_path: ARRAYED_LIST [STRING]
		-- Full path to parent_directory.
		
	warnings_supressed: BOOLEAN
		-- Are warnings being supressed?
		
invariant
	parent_directory_path_not_void: parent_directory_path /= Void
	directory_name_not_void: directory_name /= Void and not directory_name.is_empty

end -- class GB_COMMAND_ADD_DIRECTORY
