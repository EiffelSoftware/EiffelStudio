indexing
	description: "Objects that represent a command for the deletion of a window object."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_DELETE_WINDOW_OBJECT
	
inherit
	
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end
	
	GB_COMMAND
		export
			{NONE} all
		end
	
	GB_SHARED_HISTORY
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end
	
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
	
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
		
	GB_FILE_UTILITIES
		export
			{NONE} all
		end
	
	INTERNAL
		export
			{NONE} all
		end
		
	GB_FILE_REMOVE_RESTORE
		export
			{NONE} all
		end
	
create	
	make
	
feature {NONE} -- Initialization

	make (window: GB_TITLED_WINDOW_OBJECT) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.
		require
			window_not_void: window /= Void
		local
			parent_item: EV_TREE_ITEM
		do
			History.cut_off_at_current_position
			parent_item ?= window.window_selector_item.parent
			if parent_item /= Void then
					-- If held in a directory, store the directory name.
				parent_directory := parent_item.text
			end
			original_id := window.id
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			full_file_name, file_location: FILE_NAME
			window_object: GB_TITLED_WINDOW_OBJECT
		do
			window_object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_was_window: window_object /= Void
			end
				-- If the root window is being deleted, select the next window.
			if Object_handler.root_window_object = window_object then
				Window_selector.mark_next_window_as_root (1)
			end
			object_handler.update_for_delete (original_id)
			object_handler.update_object_editors_for_delete (window_object, Void)
			window_object.layout_item.unparent
			window_object.window_selector_item.unparent
			object_handler.mark_as_deleted (window_object)
			
				-- Store and delete all files associated with `window_object' if any.
				-- Files associated are only there if already generated.
			delete_files
			
				-- Record `Current' in the history list.
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			System_status.enable_project_modified
			command_handler.update
		end

	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			file_name: FILE_NAME
			window_object: GB_TITLED_WINDOW_OBJECT
		do
			window_object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_was_window: window_object /= Void
			end
			object_handler.mark_existing (window_object)
			if parent_directory /= Void then
					-- Only try to retrieve the directory item if there was one.
				directory_item := window_selector.directory_object_from_name (parent_directory)
			end
			if directory_item = Void then
				-- Now simply add as root.
				Window_selector.extend (window_object.window_selector_item)
			else
				-- Restore window into original directory.
				directory_item.extend (window_object.window_selector_item)
				directory_item.expand
			end
			
				-- Restore all files associated with `window_object' if any.
			restore_files
			
			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			window_name: STRING
			window_object: GB_TITLED_WINDOW_OBJECT
		do
			window_object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_was_window: window_object /= Void
			end
			if not window_object.name.is_empty then
				window_name := window_object.name
			else
				window_name := window_object.short_type
			end
			Result := window_name + " removed from the project"
		end
	
feature {NONE} -- Implementation

	parent_directory: STRING
		-- Orignal directory containing object referenced by `original_id' before deletion.

	original_id: INTEGER
		-- id of object that was deleted.

end -- class GB_COMMAND_DELETE_WINDOW_OBJECT
