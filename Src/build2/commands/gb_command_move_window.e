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

	make (window: GB_TITLED_WINDOW_OBJECT; a_new_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM) is
			-- Create `Current' with `window' to be moved from its current directory, to `new_directory'.
			-- If `a_new_directory' is Void, then move to root of project.
		require
			window_not_void: window /= Void
		local
			parent_item: EV_TREE_ITEM
			dir: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			history.cut_off_at_current_position
			original_id := window.id
			dir ?= window.window_selector_item.parent
			original_directory := dir
			new_directory := a_new_directory
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			window_object: GB_TITLED_WINDOW_OBJECT
		do
			window_object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_was_window: window_object /= Void
			end
			unparent_tree_node (window_object.window_selector_item)
			if new_directory /= Void then
				new_directory.extend (window_object.window_selector_item)
			else
				Window_selector.extend (window_object.window_selector_item)
			end
			window_selector.update_class_files_location (window_object.window_selector_item, original_directory, new_directory)
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
			window_object: GB_TITLED_WINDOW_OBJECT
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			file_name: FILE_NAME
		do
			window_object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_was_window: window_object /= Void
			end
			unparent_tree_node (window_object.window_selector_item)
			if original_directory /= Void then
				original_directory.extend (window_object.window_selector_item)
			else
				Window_selector.extend (window_object.window_selector_item)
			end
			window_selector.update_class_files_location (window_object.window_selector_item, new_directory, original_directory)
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			window_name: STRING
			window_object: GB_TITLED_WINDOW_OBJECT
			current_text: STRING
		do
			window_object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_was_window: window_object /= Void
			end
			current_text := window_object.name
			if window_object.name.is_empty then
				current_text := "unnamed " + window_object.short_type
			end
			if original_directory = Void then
				Result := current_text + " moved into directory %"" + new_directory.text + "%""
			elseif new_directory = Void then
				Result := current_text + " moved from directory %"" + original_directory.text + "%" to the root"
			else
				Result := current_text + " moved from %"" + original_directory.text + "%" to directory %"" + new_directory.text + "%""
			end
		end
	
feature {NONE} -- Implementation

	original_id: INTEGER
		-- id of object that was deleted.
		
	original_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
	
	new_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM

end -- class GB_COMMAND_MOVE_WINDOW
