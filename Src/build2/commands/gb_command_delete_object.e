indexing
	description: "Objects that represent a command for the deletion of an object."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_DELETE_OBJECT
	
inherit
	
	GB_SHARED_OBJECT_HANDLER
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
	
	INTERNAL
		export
			{NONE} all
		end
		
	GB_COMMAND_ADD_OBJECT
		rename
			make as old_make
		redefine
			execute, undo, textual_representation
		end
	
create	
	make
	
feature {NONE} -- Initialization

	make (an_object: GB_OBJECT) is
			-- Create `Current' with `an_object' to be deleted.
		do
			history.cut_off_at_current_position
			child_id := an_object.id
			parent_id := an_object.parent_object.id
			insert_position := an_object.parent_object.children.index_of (an_object, 1)
			create new_parent_child_objects.make (50)
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		do
			internal_execute (child_id, previous_parent_id, parent_id, previous_position_in_parent, insert_position)
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			command_handler.update
		end
		
	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		do
			internal_execute (child_id, parent_id, 0, insert_position, 0)
			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			child_name, parent_name: STRING
			child_object, parent_object: GB_OBJECT
		do
			child_object := Object_handler.deep_object_from_id (child_id)
			parent_object := Object_handler.deep_object_from_id (parent_id)

			if not child_object.name.is_empty then
				child_name := child_object.name
			else
				child_name := child_object.short_type
			end
			
			if not parent_object.name.is_empty then
				parent_name := parent_object.name
			else
				parent_name := parent_object.short_type
			end
			Result := child_name + " removed from " + parent_name
		end

end -- class GB_COMMAND_DELETE_OBJECT
