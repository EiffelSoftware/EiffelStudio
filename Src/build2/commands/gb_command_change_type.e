indexing
	description: "Objects that represent a command for type changing objects."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_CHANGE_TYPE
	
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
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
		
	GB_LAYOUT_CONSTRUCTOR_STATE_HANDLER

create
	make
	
feature {NONE} -- Initialization

	make (an_object: GB_OBJECT; an_original_type, a_new_type: STRING) is
			-- Create `Current' and store necessary information
			-- required to `execute' and `undo'.
		do
			history.cut_off_at_current_position
			original_type := an_original_type
			new_type := a_new_type
			original_id := an_object.id
		end
		

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			original_object, new_object: GB_OBJECT
		do
			store_layout_constructor
			original_object := Object_handler.deep_object_from_id (original_id)
			
				-- Call delete on object.
			original_object.delete
			
				-- We do not call `mark_as_deleted' here, as this would
				-- mark all the children as deleted also. Only the
				-- actual object should be marked as deleted.
			object_handler.objects.prune_all (original_object)
			object_handler.deleted_objects.extend (original_object)
			
				-- `new_id' is 0, the first time that we execute this command. In this case, we
				-- build a new object to replace the current one. Subsequent calls to `execute' will
				-- no longer build new objects, but will use the previously created object, referenced
				-- by `new_id'.
			if new_id = 0 then
				new_object := object_handler.build_object_from_string_and_assign_id (new_type)
				new_id := new_object.id
			else
				new_object := object_handler.deep_object_from_id (new_id)
			end
			
			if not original_object.expanded_in_box then
				new_object.disable_expanded_in_box
			end
			object_handler.replace_object (original_object, new_object)
			
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			new_object.set_name (original_object.name)
			restore_layout_constructor
			command_handler.update
		end
		
	undo is
			-- Undo `Current'.
			-- Must restore state to that before `execute'.
		local
			original_object, current_object: GB_OBJECT
		do
			store_layout_constructor
			original_object := Object_handler.deep_object_from_id (original_id)
			current_object := Object_handler.deep_object_from_id (new_id)

			object_handler.replace_object (current_object, original_object)
			current_object.set_name (original_object.name)
			current_object.layout_item.update_pixmap
			restore_layout_constructor
			command_handler.update
		end
		
feature -- Access 
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		do
			Result := original_type + " changed type to " + new_type
		end
		
feature {NONE} -- Implementation

	original_id: INTEGER
		-- Id of object whose type was changed.
		
	new_id: INTEGER
		-- Id of new object created to replace the original object. This
		-- will be 0, until `execute' has been called. This then allows us
		-- use the same object as the history is traversed multiple times.

	original_type: STRING
		-- String representation of original object type.

	new_type: STRING
		-- String representation of type changed to.

end -- class GB_COMMAND_CHANGE_TYPE
