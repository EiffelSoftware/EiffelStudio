indexing
	description: "Objects that represent a renaming of an object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_NAME_CHANGE
	
inherit
	
	GB_ACCESSIBLE_OBJECT_HANDLER
	
	GB_COMMAND
	
	GB_ACCESSIBLE_HISTORY
	
	GB_ACCESSIBLE_OBJECT_EDITOR
	
	GB_ACCESSIBLE_COMMAND_HANDLER
	
create
	
	make
	
feature {NONE} -- Initialization

	make (child: GB_OBJECT; a_new_name, an_old_name: STRING) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.

		do
			child_layout_item := child.layout_item
			new_name := a_new_name
			old_name := an_old_name
		end
		

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			object: GB_OBJECT
		do
			object := child_layout_item.object
			object.set_name (new_name)
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			if object.name.is_empty then
				child_layout_item.set_text (object.type.substring (4, object.type.count))
			else
				child_layout_item.set_text (object.name + ": " + object.type.substring (4, object.type.count))			
			end
			update_editors_for_name_change (object.object, Void)
			command_handler.update
		end
		
	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			object: GB_OBJECT
		do
			object := child_layout_item.object
			object.set_name (old_name)
			if object.name.is_empty then
				child_layout_item.set_text (object.type.substring (4, object.type.count))
			else
				child_layout_item.set_text (object.name + ": " + object.type.substring (4, object.type.count))			
			end
			update_editors_for_name_change (object.object, Void)
			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		do
			if old_name.is_empty then
				Result := "Unnamed " + child_layout_item.object.short_type + " named as '" + new_name + "'"
			else
				Result := "'"+ old_name + "' renamed to '" + new_name + "'"
			end
		end
		
		
feature {NONE} -- Implementation
	
	child_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		-- Layout constructor representation of `child_object'.
		
	new_name: STRING
		-- Name given to object.
		
	old_name: STRING
		-- Previous name of `object'.

end -- class GB_COMMAND_NAME_CHANGE
