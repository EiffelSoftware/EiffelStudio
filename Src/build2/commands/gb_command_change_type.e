indexing
	description: "Objects that represent a command for type changing objects."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_CHANGE_TYPE
	
inherit
	
	GB_SHARED_OBJECT_HANDLER
	
	GB_COMMAND
	
	GB_SHARED_HISTORY
	
	GB_SHARED_TOOLS

create
	
	make
	
feature {NONE} -- Initialization

	make (an_object: GB_OBJECT; an_original_type, a_new_type: STRING) is
			-- Create `Current' and store necessary information
			-- required to `execute' and `undo'.
		do
			original_type := an_original_type
			new_type := a_new_type
			layout_item := an_object.layout_item
			old_object := an_object
		end
		

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		do
				-- We do not call `mark_as_deleted' here, as this would
				-- mark all the children as deleted also. Only the
				-- actual object should be marked as deleted.
			object_handler.objects.prune_all (layout_item.object)
			object_handler.deleted_objects.extend (layout_item.object)
			object_handler.replace_object_type (layout_item.object, new_type)
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			command_handler.update
		end
		
	undo is
			-- Undo `Current'.
			-- Must restore state to that before `execute'.
		do
			object_handler.replace_object (layout_item.object, old_object)
			command_handler.update
		end
		
feature -- Access 
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		do
			Result := original_type + " changed type to " + new_type
		end
		
feature {NONE} -- Implementation

	old_object: GB_OBJECT
		-- Original object that was repaced.
		-- We restore this when we undo.

	original_type: STRING
		-- String representation of original object type.

	new_type: STRING
		-- String representation of type changed to.
	
	layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		-- Layout item representing the object `Current' refers to.
		-- We cannot store the object, as changing the type
		-- creates a new object, therefore we have to do `layout_item.object'
		-- to retrieve the current object we are working with.

end -- class GB_COMMAND_CHANGE_TYPE
