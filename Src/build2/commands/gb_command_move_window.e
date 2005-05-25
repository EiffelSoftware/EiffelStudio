indexing
	description: "Objects that represent commands to move a window between directories."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_MOVE_WINDOW
	
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

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
create	
	make
	
feature {NONE} -- Initialization

	make (object: GB_OBJECT; a_new_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM) is
			-- Create `Current' with `window' to be moved from its current directory, to `new_directory'.
			-- If `a_new_directory' is Void, then move to root of project.
		require
			object_not_void: object /= Void
			is_top_level_object: object.is_top_level_object
		local
			dir: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			history.cut_off_at_current_position
			original_id := object.id
			dir ?= object.widget_selector_item.parent
			if dir /= Void then
				original_directory := dir.path
			end
			if a_new_directory /= Void then
				new_directory := a_new_directory.path
			end
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			object: GB_OBJECT
			original_directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			new_directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_was_top_level: object.is_top_level_object = True
			end

				-- Retrieve the directories via their names.
			if original_directory /= Void then
				original_directory_item := widget_selector.directory_object_from_name (original_directory)
			end
			if new_directory /= Void then
				new_directory_item := widget_selector.directory_object_from_name (new_directory)
			end
			
			object.widget_selector_item.unparent
			if new_directory_item /= Void then
				new_directory_item.add_alphabetically (object.widget_selector_item)
			else
				widget_selector.add_alphabetically (object.widget_selector_item)
			end
			
			widget_selector.update_class_files_location (object.widget_selector_item, original_directory_item, new_directory_item)
				-- Record `Current' in the history list.
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
			object: GB_OBJECT
			original_directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			new_directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_was_top_level: object.is_top_level_object = True
			end
			
				-- Retrieve the directories via their names.
			if original_directory /= Void then
				original_directory_item := widget_selector.directory_object_from_name (original_directory)
			end
			if new_directory /= Void then
				new_directory_item := widget_selector.directory_object_from_name (new_directory)
			end
			
			object.widget_selector_item.unparent
			if original_directory_item /= Void then
				original_directory_item.add_alphabetically (object.widget_selector_item)
			else
				widget_selector.add_alphabetically (object.widget_selector_item)
			end
			widget_selector.update_class_files_location (object.widget_selector_item, new_directory_item, original_directory_item)
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			object: GB_OBJECT
			current_text: STRING
		do
			object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_was_top_level: object.is_top_level_object = True
			end
			current_text := object.name
			if object.name.is_empty then
				current_text := "unnamed " + object.short_type
			end
			if original_directory = Void then
				Result := current_text + " moved into directory %"" + new_directory.last + "%""
			elseif new_directory = Void then
				Result := current_text + " moved from directory %"" + original_directory.last + "%" to the root"
			else
				Result := current_text + " moved from %"" + original_directory.last + "%" to directory %"" + new_directory.last + "%""
			end
		end
	
feature {NONE} -- Implementation

	original_id: INTEGER
		-- id of object that was deleted.
		
	original_directory: ARRAYED_LIST [STRING]
		-- String representing the original directory holding the window
		-- empty if root of project.
	
	new_directory: ARRAYED_LIST [STRING]
		-- String representing the directory into which the window was moved.
		-- `empty' if root of project.

end -- class GB_COMMAND_MOVE_WINDOW
