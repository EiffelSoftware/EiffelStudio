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
		export
			{NONE} all
		end

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
			create new_ids.make (4)
			create original_ids.make (4)
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			original_object: GB_OBJECT
		do
			store_layout_constructor
			original_object := object_handler.deep_object_from_id (original_id)
				-- Reset `new_ids' for iteration within `internal_execute' in the case where we are executing 2 or more times.
			new_ids.start
			
			internal_execute (original_object, Void)
			executed_once := True
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			
			restore_layout_constructor
			command_handler.update
		end
		
	internal_execute (original_object: GB_OBJECT; instance_object: GB_OBJECT) is
			-- Change type of `original_object' to `new_type', recursively changing all instances.
			-- If `instance_object' is not Void, then insert the newly created object into `instance_referers'
			-- of `instance_object'. This ensures that the instance structure of the new objects is identical to
			-- that of the original.
		require
			original_object_not_void: original_object /= Void
		local
			new_object: GB_OBJECT
		do
				-- Call delete on object.
			original_object.delete
			
				-- We do not call `mark_as_deleted' here, as this would
				-- mark all the children as deleted also. Only the
				-- actual object should be marked as deleted.
			object_handler.objects.remove (original_object.id)
			object_handler.deleted_objects.extend (original_object, original_object.id)
			
			if not executed_once then
					-- The first time `Current' is executed, we build a new object.
				new_object := object_handler.build_object_from_string_and_assign_id (new_type)
				new_ids.extend (new_object.id)
				original_ids.extend (original_object.id)
				if instance_object /= Void then
					instance_object.instance_referers.extend (new_object.id, new_object.id)
				end
			else
					-- Additional executions use the objects created the first time.
				new_object := object_handler.deleted_objects.item (new_ids.item)
				object_handler.deleted_objects.remove (new_object.id)
				object_handler.objects.extend (new_object, new_object.id)
				new_ids.forth
			end
			
			
			if not original_object.expanded_in_box then
					-- Update expanded status for objects parented in boxes.
				new_object.disable_expanded_in_box
			end
			object_handler.replace_object (original_object, new_object)
			new_object.set_name (original_object.name)
				
				-- Now recurse through all instance referers.
			from
				original_object.instance_referers.start
			until
				original_object.instance_referers.off
			loop
				internal_execute (object_handler.deep_object_from_id (original_object.instance_referers.item_for_iteration), new_object)
				original_object.instance_referers.forth
			end
		end
		
		
	undo is
			-- Undo `Current'.
			-- Must restore state to that before `execute'.
		local
			original_object, new_object: GB_OBJECT
		do
			store_layout_constructor
			
			from
				original_ids.start
			until
				original_ids.off
			loop
				original_object := Object_handler.deep_object_from_id (original_ids.item)
				new_object := Object_handler.deep_object_from_id (new_ids.i_th (original_ids.index))
				object_handler.deleted_objects.remove (original_object.id)
				object_handler.objects.extend (original_object, original_object.id)
				
				object_handler.objects.remove (new_object.id)
				object_handler.deleted_objects.extend (new_object, new_object.id)

				object_handler.replace_object (new_object, original_object)
				new_object.set_name (original_object.name)
				new_object.layout_item.update_pixmap
				
				original_ids.forth
			end
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
	
	new_ids: ARRAYED_LIST [INTEGER]
		-- Ids of all objects that were created as part of the type change operation.
	
	original_ids: ARRAYED_LIST [INTEGER]
		-- Ids of all objects that were replaced as part of the type change operation.

	original_type: STRING
		-- String representation of original object type.

	new_type: STRING
		-- String representation of type changed to.
		
	executed_once: BOOLEAN
	
invariant
	new_ids_not_void: new_ids /= Void
	original_ids_not_void: original_ids /= Void
	original_type_not_void: original_type /= Void

end -- class GB_COMMAND_CHANGE_TYPE
