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

	make (an_object: GB_OBJECT) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.
		require
			object_not_void: an_object /= Void
			object_is_top_level: an_object.is_top_level_object 
		local
			directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			History.cut_off_at_current_position
			directory_item ?= an_object.widget_selector_item.parent
			if directory_item /= Void then
					-- If held in a directory, store the directory name.
				parent_directory := directory_item.path
			end
			original_id := an_object.id
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			object: GB_OBJECT
		do
			object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_is_top_level_object: object.is_top_level_object
			end
			object.remove_client_representation_recursively
				-- If the root window is being deleted, select the next window.
			if Object_handler.root_window_object = object then
				widget_selector.mark_next_window_as_root (1)
			end
			object_handler.update_for_delete (original_id)
			object_handler.update_object_editors_for_delete (object, Void)
			object.layout_item.unparent
			object.widget_selector_item.unparent
			object_handler.mark_as_deleted (object)
			
				-- Store and delete all files associated with `object' if any.
				-- Files associated are only there if already generated.
			delete_files
			
				-- Record `Current' in the history list.
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			
			(create {GB_GLOBAL_STATUS}).mark_as_dirty
		end

	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			object: GB_OBJECT
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_is_top_level_object: object.is_top_level_object
			end
			object.add_client_representation_recursively
			object_handler.mark_existing (object)
			if parent_directory /= Void then
					-- Only try to retrieve the directory item if there was one.
				directory_item := widget_selector.directory_object_from_name (parent_directory)
			end
			if directory_item = Void then
				-- Now simply add as root.
				widget_selector.add_alphabetically (object.widget_selector_item)
			else
				-- Restore window into original directory.
				directory_item.add_alphabetically (object.widget_selector_item)
				directory_item.expand
			end
			
				-- If this is the only window contained, select it.
			if widget_selector.objects.count = 1 then
				object.widget_selector_item.enable_select
				titled_window_object ?= object
				if titled_window_object /= Void then
					widget_selector.change_root_window_to (titled_window_object)
				end
			end
				-- Restore all files associated with `window_object' if any.
			restore_files
			
			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			window_name: STRING
			object: GB_OBJECT
		do
			object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_is_top_level_object: object.is_top_level_object
			end
			if not object.name.is_empty then
				window_name := object.name
			else
				window_name := object.short_type
			end
			Result := window_name + " removed from the project"
		end
	
feature {NONE} -- Implementation

	parent_directory: ARRAYED_LIST [STRING]
		-- Orignal directory containing object referenced by `original_id' before deletion.

	original_id: INTEGER
		-- id of object that was deleted.

end -- class GB_COMMAND_DELETE_WINDOW_OBJECT
