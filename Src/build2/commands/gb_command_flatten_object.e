indexing
	description: "Objects that represent a command for flattening of an object."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_FLATTEN_OBJECT

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
	
	GB_WIDGET_UTILITIES
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

	make (an_object: GB_OBJECT; deep_flatten: BOOLEAN) is
			-- Create `Current' with `child' to be inserted in `parent' at
			-- position `position'.
		require
			object_not_void: an_object /= Void
			object_is_top_level_instance: an_object.is_instance_of_top_level_object
		do
			object_id := an_object.id
			top_id := an_object.associated_top_level_object
			is_deep_flatten := deep_flatten
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			an_object: GB_OBJECT
			top_object: GB_OBJECT
		do
				-- Recreate structures each time we execute which ensures that
				-- they are reset if we call `execute' and `undo' multiple times.
			create original_reference_objects.make (4)
			create original_instance_objects.make (4)
			create new_instance_objects.make (4)

			an_object := object_handler.deep_object_from_id (object_id)
			top_object := object_handler.deep_object_from_id (top_id)
			check
				links_correct: top_object.instance_referers.has (an_object.id) and an_object.associated_top_level_object = top_object.id
			end

			an_object.unconnect_instance_referers (top_object, an_object)
			internal_shallow_flatten (an_object, top_object)

			check
				top_object_link_removed: not top_object.instance_referers.has (object_id)
			end
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			command_handler.update
			check_execute_while_debugging
		end
		
		
	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			new_object: GB_OBJECT
			top_object: GB_OBJECT
			an_object: GB_OBJECT
			new_objects, old_objects: ARRAYED_LIST [GB_OBJECT]
			original_reference_object, original_instance_object, new_instance_object: INTEGER
			parent_object: GB_PARENT_OBJECT
			old_pos: INTEGER
		do
			an_object := object_handler.deep_object_from_id (object_id)
			top_object := object_handler.deep_object_from_id (top_id)
			
				-- Create a new representation of `new_object'.
			new_object := top_object.new_top_level_representation

				-- Now ensure that the bewly created objects have the same id's as the
				-- originals and are contained within the global list of objects.
			create new_objects.make (50)
			create old_objects.make (50)
			object_handler.remove_object (new_object)
			new_object.set_id (an_object.id)
			new_object.all_children_recursive (new_objects)
			an_object.all_children_recursive (old_objects)
			object_handler.remove_object (an_object)
			object_handler.add_object_to_objects (new_object)
			from
				new_objects.start
				old_objects.start
			until
				new_objects.off
			loop
				object_handler.remove_object (new_objects.item)
				new_objects.item.set_id (old_objects.item.id)
				object_handler.remove_object (old_objects.item)
				object_handler.add_object_to_objects (new_objects.item)
				old_objects.forth
				new_objects.forth
			end

				-- Now replace the new representation of the object in the old parent.
			parent_object ?= an_object.parent_object
			old_pos := parent_object.children.index_of (an_object, 1)
			parent_object.remove_child (an_object)
			object_handler.add_object (parent_object, new_object, old_pos)

				-- Now iterate through all of the objects that were originally stored as having their
				-- instances referers updated and store the connections to the pre `execute' state'.
			from
				original_reference_objects.start
				original_instance_objects.start
				new_instance_objects.start
			until
				original_reference_objects.off
			loop
				original_reference_object := original_reference_objects.item
				original_instance_object := original_instance_objects.item
				new_instance_object := new_instance_objects.item

				top_object := object_handler.deep_object_from_id (original_reference_object)
				check
					reference_has_new: top_object.instance_referers.has (new_instance_object)
				end
				top_object.instance_referers.remove (new_instance_object)
				top_object.unconnect_instance_referers (top_object, object_handler.deep_object_from_id (new_instance_object))
			
				top_object.instance_referers.extend (original_instance_object, original_instance_object)
				an_object.connect_instance_referers (top_object, object_handler.deep_object_from_id (original_instance_object))
				
				original_reference_objects.forth
				original_instance_objects.forth
				new_instance_objects.forth
			end
			
				-- Now update the instance referers for the top level object that had been flattened.
			an_object := object_handler.deep_object_from_id (object_id)
			top_object := object_handler.deep_object_from_id (top_id)
			
			new_object.connect_instance_referers (top_object, new_object)
			top_object.instance_referers.put (new_object.id, new_object.id)
			new_object.set_associated_top_level_object (top_object)

			
			command_handler.update
			
			check_undo_while_debugging	
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			object_name: STRING
			an_object: GB_OBJECT
		do
			an_object := object_handler.deep_object_from_id (object_id)

			if not an_object.name.is_empty then
				object_name := an_object.name
			else
				object_name := name_and_type_from_object (an_object)
			end
			Result := object_name  + " flattened"
		end

feature {NONE} -- Implementation

	object_id: INTEGER
		-- id of object for flatten.
		
	top_id: INTEGER
		-- id of top object which the object was an instance.
		
	is_deep_flatten: BOOLEAN
		-- Does `Current' represent a deep flatten command?
		
	internal_shallow_flatten (current_object, associated_object: GB_OBJECT) is
			-- Recursively flatten all instance representations of `Current' object to `associated_object' if the
			-- current structure is not a representation of another top level object. If it is, reconnect
			-- all instance referers in the `current_object' structure to those in the `associated_object' structure.
		require
			current_object_not_void: current_object /= Void
			associated_object_not_void: associated_object /= Void
			current_object.children.count = associated_object.children.count
		local
			current_object_children, associated_object_children: ARRAYED_LIST [GB_OBJECT]
			current_item, current_associated_item, top_object: GB_OBJECT
			associated_cursor, current_cursor: CURSOR
		do
			if current_object.associated_top_level_object /= 0 then
				current_object.remove_associated_top_level_object
				current_object.connect_display_object_events
				current_object.represent_as_non_locked_instance
				current_object.update_representations_for_name_or_type_change
			end
			associated_object.instance_referers.remove (current_object.id)
			
			current_object_children := current_object.children
			current_cursor := current_object_children.cursor
			associated_object_children := associated_object.children
			associated_cursor := associated_object_children.cursor
			from
				current_object_children.start
				associated_object_children.start
			until
				current_object_children.off
			loop
				current_item := current_object_children.item
				current_associated_item := associated_object_children.item			
				if current_associated_item.associated_top_level_object > 0 then
						-- If the current associated object has a reference to a top level object then we must
						-- set the current object as an association to this top level object directly.

					original_reference_objects.extend (current_associated_item.associated_top_level_object)
					original_instance_objects.extend (current_associated_item.id)
					new_instance_objects.extend (current_item.id)
					
					top_object := object_handler.deep_object_from_id (current_associated_item.associated_top_level_object)
					top_object.instance_referers.remove (current_associated_item.id)
					top_object.instance_referers.extend (current_item.id, current_item.id)
					current_item.set_associated_top_level_object (object_handler.deep_object_from_id (top_object.id))
					current_object.connect_instance_referers (object_handler.deep_object_from_id (top_object.id), current_item)
					
						-- Ensure that the representations are updated to reflect the fact that they are locked.
					current_item.represent_as_locked_instance
					current_item.update_representations_for_name_or_type_change
				else
					internal_shallow_flatten (current_item, current_associated_item)
				end
				
				associated_object_children.forth
				current_object_children.forth
			end
			associated_object_children.go_to (associated_cursor)
			current_object_children.go_to (current_cursor)
		ensure
			current_object_is_not_top_level_instance: not current_object.is_instance_of_top_level_object
			current_object_children_index_not_changed: old current_object.children.index = current_object.children.index
			associated_object_children_index_not_changed: old associated_object.children.index = associated_object.children.index
		end

	original_reference_objects: ARRAYED_LIST [INTEGER]
	original_instance_objects: ARRAYED_LIST [INTEGER]
	new_instance_objects: ARRAYED_LIST [INTEGER]
	
feature {NONE} -- Contract Support	

	all_objects_before: HASH_TABLE [GB_OBJECT, INTEGER]
	all_objects_after: HASH_TABLE [GB_OBJECT, INTEGER]
	all_referers_before: HASH_TABLE [HASH_TABLE [INTEGER, INTEGER], INTEGER]
	all_referers_after: HASH_TABLE [HASH_TABLE [INTEGER, INTEGER], INTEGER]
	
	check_execute_while_debugging is
			-- Perform checking for debuggin where calling `execute' and `undo' must leave the system in the same state.
		local
			bool: BOOLEAN
		do
			if system_status.is_in_debug_mode then
				-- Handle checking that an `undo', `redo' step leaves the system in its original state.
				-- This cannot be written as a postcondition as it must be guaranteed across two features
				create all_objects_before.make (1000)
				all_objects_before := object_handler.objects.twin
				create all_referers_before.make (100)
				from
					all_objects_before.start
				until
					all_objects_before.off
				loop
					all_referers_before.extend (all_objects_before.item_for_iteration.instance_referers.twin, all_objects_before.item_for_iteration.id)
					bool := all_objects_before.item_for_iteration.is_full
					all_objects_before.forth
				end
			end
		end
	
	check_undo_while_debugging is
			-- Check that a call to `execute' immediately followed by a call to `undo' leaves the system
			-- in the same state as it was in originally. At the moment, only the existing objects and
			-- their instance referers are checked.
		local
			bool: BOOLEAN
			keys: ARRAY [INTEGER]
			counter: INTEGER
			old_instance_referers, new_instance_referers: HASH_TABLE [INTEGER, INTEGER]
		do
			if system_status.is_in_debug_mode then
				create all_objects_after.make (1000)
				all_objects_after := object_handler.objects.twin
				create all_referers_after.make (100)
				keys := all_objects_after.current_keys.twin
				from
					counter := keys.lower
				until
					counter > keys.upper
				loop
					all_referers_after.extend (all_objects_after.item (counter).instance_referers.twin, all_objects_after.item (counter).id)
						-- Force invariants to be checked for every object in existance.
					bool := all_objects_after.item (counter).is_full
					counter := counter + 1
				end
				check
					counts_equal: all_objects_before.count = all_objects_after.count
				end				
				keys := all_objects_before.current_keys.twin
				from
					counter := keys.lower
				until
					counter > keys.upper
				loop
					check
						same_ids_in_objects: all_objects_before.item (keys.item (counter)).id = all_objects_after.item (keys.item (counter)).id
					end
					old_instance_referers := all_objects_before.item (keys.item (counter)).instance_referers
					new_instance_referers := all_objects_after.item (keys.item (counter)).instance_referers
					check
						referers_count_equal: old_instance_referers.count = new_instance_referers.count
					end
					from
						old_instance_referers.start
					until
						old_instance_referers.off
					loop
						check
							items_identical: new_instance_referers.item (old_instance_referers.item_for_iteration) /= Void
						end
						old_instance_referers.forth
					end
					counter := counter + 1
				end
			end
		end
		
end -- class GB_COMMAND_ADD_OBJECT

