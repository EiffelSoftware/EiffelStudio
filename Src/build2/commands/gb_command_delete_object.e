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
			position := an_object.parent_object.children.index_of (an_object, 1)
			create child_objects.make (5)
			create previous_parents.make (5)
			record_previous_parents (an_object.parent_object)
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			previous_parent_object: GB_OBJECT
			current_child, child_object: GB_OBJECT
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
			
			previous_parent_object.remove_child (child_object)
			from
				previous_parents.start
				child_objects.start
			until
				previous_parents.off
			loop
				current_child := object_handler.deep_object_from_id (child_objects.item)
				object_handler.deep_object_from_id (previous_parents.item).remove_child (current_child)
				object_handler.mark_as_deleted (current_child)
				previous_parents.forth
				child_objects.forth
			end
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
			from
				previous_parents.start
				child_objects.start
			until
				previous_parents.off
			loop
				object_handler.mark_existing (object_handler.deep_object_from_id (child_objects.item))
				object_handler.add_object (object_handler.deep_object_from_id (previous_parents.item), object_handler.deep_object_from_id (child_objects.item), position)
				previous_parents.forth
				child_objects.forth
			end
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
		
	previous_parents: ARRAYED_LIST [INTEGER]
		-- All previous parents if the object was originally parented within another object.
		
	child_objects: ARRAYED_LIST [INTEGER]
	
feature {NONE} -- Iteration implementation

	record_previous_parents (parent_object: GB_OBJECT) is
			-- Record all instance referers of `parent' recursively in `previous_parents' and also for
			-- each child object at `previous_position_in_parent', store in `child_objects'.
		require
			parent_object_not_void: parent_object /= Void
		local
			temp_parent: GB_PARENT_OBJECT
			child: GB_OBJECT
		do
			from
				parent_object.instance_referers.start
			until
				parent_object.instance_referers.off
			loop
				temp_parent ?= object_handler.deep_object_from_id (parent_object.instance_referers.item_for_iteration)
				check
					temp_parent_not_void: temp_parent /= Void
				end
				
					-- *** IMPORTANT ***
					-- Not all previous parents are recorded, only those that are not already deleted.
					-- This is because all `instance_referers' are kept even when objects are deleted
					-- as if we change the property of a widget, we must update all representations, even
					-- those in the history, in case we perform an undo.
					-- If we do not perform this check, EiffelBuild would crash when you performed the following :
					-- Delete a top level object instance from somewhere in an interface
					-- Remove a widget from the actual top level window that had just been removed.
					-- As performing the second step attempted to go through all references recursively, those that are
					-- deleted must not be recursed.
					-- *** IMPORTANT ***
				if not object_handler.deleted_objects.has (temp_parent.id) then
						-- We retrieve the child via `orig_index'.
					child := temp_parent.children.i_th (position)

					previous_parents.extend (temp_parent.id)
					child_objects.extend (child.id)
					record_previous_parents (object_handler.deep_object_from_id (parent_object.instance_referers.item_for_iteration))
				end
				parent_object.instance_referers.forth
			end
		ensure
			lists_consistent: child_objects.count = previous_parents.count
		end

end -- class GB_COMMAND_DELETE_OBJECT
