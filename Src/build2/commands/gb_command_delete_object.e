indexing
	description: "Objects that represent a command for the deletion of an object."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_DELETE_OBJECT
	
inherit
	
	GB_SHARED_OBJECT_HANDLER
	
	GB_COMMAND
	
	GB_SHARED_HISTORY
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_EDITORS
	
	GB_SHARED_COMMAND_HANDLER
	
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
	
	INTERNAL
		export
			{NONE} all
		end
	
create	
	make
	
feature {NONE} -- Initialization

	make (an_object: GB_OBJECT) is
			-- Create `Current' with `an_object' to be deleted.
		require
			an_object_not_void: an_object /= Void
		do
			history.cut_off_at_current_position
			original_id := an_object.id
			parent_id := an_object.parent_object.id
			position := an_object.parent_object.layout_item.index_of (an_object.layout_item, 1)
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			previous_parent_object: GB_OBJECT
			child_object: GB_OBJECT
		do
			child_object := Object_handler.deep_object_from_id (original_id)
			
				-- Call `update_for_delete' which does any processing
				-- necessary before objects are deleted.
				-- i.e. unmerge radio button groups.
			object_handler.update_for_delete (original_id)
				-- Note that unparenting an object does not update parent representations
				-- in objects editors, so we must do it ourselves by calling
				-- `update_object_editors_for_delete'.
			previous_parent_object := child_object.parent_object

			child_object.unparent
			object_handler.update_object_editors_for_delete (child_object, previous_parent_object)
				-- We now need to mark the deleted object and all children as
				-- deleted.
			object_handler.mark_as_deleted (child_object)
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
			child_object, parent_object: GB_OBJECT
		do
			child_object := Object_handler.deep_object_from_id (original_id)
			parent_object := Object_handler.deep_object_from_id (parent_id)
				-- We now need to ensure that the object is no longer marked as
				-- deleted.
			object_handler.mark_existing (child_object)
				-- Calling `add_object' on the obejct handler, will automatically
				-- update any parent representations in the object editor.
			object_handler.add_object (parent_object, child_object, position)
			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			child_name, parent_name: STRING
			child_object, parent_object: GB_OBJECT
		do
			child_object := Object_handler.deep_object_from_id (original_id)
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
	
feature {NONE} -- Implementation

	original_id: INTEGER
		-- id of object that was deleted.
		
	parent_id: INTEGER
		-- id of parent from which object was deleted.
		
	position: INTEGER
		-- Position of `child_layout_item' within `parent_layout_item' when `make'
		-- was called.

end -- class GB_COMMAND_DELETE_OBJECT
