indexing
	description: "Objects that represent a renaming of an object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_NAME_CHANGE
	
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
	
	GB_GENERAL_UTILITIES
		export
			{NONE} all
		end
	
create
	make
	
feature {NONE} -- Initialization

	make (child: GB_OBJECT; a_new_name, an_old_name: STRING) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.
		do
			object_id := child.id
			new_name := a_new_name
			old_name := an_old_name
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			object: GB_OBJECT
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			object := Object_handler.deep_object_from_id (object_id)
			
			object.set_name (new_name)
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			object.layout_item.set_text (name_and_type_from_object (object))
			titled_window_object ?= object
			if titled_window_object /= Void then
				titled_window_object.window_selector_item.set_text (name_and_type_from_object(titled_window_object))
			end
			update_editors_by_calling_feature (object.object, Void, agent {GB_OBJECT_EDITOR}.update_name_field)
			update_all_editors_by_calling_feature (object.object, Void, agent {GB_OBJECT_EDITOR}.update_merged_containers)
			command_handler.update
		end
		
	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			object: GB_OBJECT
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			object := Object_handler.deep_object_from_id (object_id)
			object.set_name (old_name)
			object.layout_item.set_text (name_and_type_from_object (object))
			titled_window_object ?= object
			if titled_window_object /= Void then
				titled_window_object.window_selector_item.set_text (name_and_type_from_object(titled_window_object))
			end
			update_editors_by_calling_feature (object.object, Void, agent {GB_OBJECT_EDITOR}.update_name_field)
			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			object: GB_OBJECT
		do
			object := Object_handler.deep_object_from_id (object_id)
			if old_name.is_empty then
				Result := "Unnamed " + object.layout_item.object.short_type + " named as '" + new_name + "'"
			else
				if new_name.is_empty then
					Result := "'" + old_name + "' name removed."	
				else
					Result := "'"+ old_name + "' renamed to '" + new_name + "'"
				end
			end
		end

feature {NONE} -- Implementation

	object_id: INTEGER
		-- Id of object whose name is changed.
		
	new_name: STRING
		-- Name given to object.
		
	old_name: STRING
		-- Previous name of `object'.

end -- class GB_COMMAND_NAME_CHANGE
