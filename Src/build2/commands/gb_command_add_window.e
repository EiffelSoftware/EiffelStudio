indexing
	description: "Objects that represent a command to add a window to a project."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_ADD_WINDOW
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

	make (window: GB_TITLED_WINDOW_OBJECT; a_new_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.
		require
			window_not_void: window /= Void
		local
			parent_item: EV_TREE_ITEM
		do
			History.cut_off_at_current_position
			if a_new_directory /= Void then
				parent_directory := a_new_directory.text
			end
			original_id := window.id
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			window_object: GB_TITLED_WINDOW_OBJECT
			full_file_name, file_location: FILE_NAME
			selector_item: GB_WINDOW_SELECTOR_ITEM
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			window_object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_was_window: window_object /= Void
			end
			create selector_item.make_with_object (window_object)
			if parent_directory = Void then
				window_selector.extend (window_object.window_selector_item)
			else
				directory_item := window_selector.directory_object_from_name (parent_directory)
				directory_item.extend (window_object.window_selector_item)
			end
				-- If this is the only window contained, select it.
			if window_selector.objects.count = 1 then
				window_object.window_selector_item.enable_select
				window_selector.change_root_window_to (window_object)
			end
				-- Now mark object as non deleted, only if it is deleted.
				-- Handles case, where you repeatedly undo/redo.
			if object_handler.deleted_objects.has (window_object) then
				object_handler.mark_existing (window_object)
			end	
			
				-- Restore all files associated with `window_object' if any.
			restore_files
				
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
			window_object: GB_TITLED_WINDOW_OBJECT
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			file_name: FILE_NAME
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
			
			System_status.enable_project_modified
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
			Result := window_name + " added to the project"
		end
	
feature {NONE} -- Implementation

	parent_directory: STRING
		-- Orignal directory that object referenced by `original_id' was added to.

	original_id: INTEGER
		-- id of object that was deleted.
		
end -- class GB_COMMAND_ADD_WINDOW
