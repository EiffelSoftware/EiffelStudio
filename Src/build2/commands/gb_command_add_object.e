indexing
	description: "Objects that represent a command for addition of an object."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_ADD_OBJECT

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
	
create
	make
	
feature {NONE} -- Initialization

	make (parent, child: GB_OBJECT; an_insert_position: INTEGER) is
			-- Create `Current' with `child' to be inserted in `parent' at
			-- position `position'.
		require
			parent_not_void: parent /= Void
			child_not_void: child /= Void
			an_insert_position_valid: an_insert_position >= 1 and an_insert_position <= parent.layout_item.count + 1
		local
			previous_parent_object: GB_OBJECT
			real_child: GB_OBJECT
			parent_object: GB_PARENT_OBJECT
		do
			parent_object ?= parent
			check
				object_was_parent: parent_object /= Void
			end
			if child.object = Void then
					-- If picked straight from the type selector, we may have to build the objects.
				child.build_objects
			end
			
			if child.is_top_level_object and child.parent_object = Void then
					-- If we are dropping a top level object, we must copy the object rather
					-- than use it directly. Only in the case where the object is not already
					-- parented as if so, all representations are already created.
				real_child := child.new_top_level_representation
				child.instance_referers.extend (real_child.id, real_child.id)
				real_child.connect_instance_referers (child, real_child)
				real_child.set_associated_top_level_object (child)
			else
					-- If not a top level object, simply use the child as is.
				real_child := child
			end
			parent_id := parent.id
			child_id := real_child.id
			previous_parent_object := real_child.parent_object
			if previous_parent_object /= Void then
					-- If the object being picked was already parented, we must store all
					-- original parents for restoration during an `undo'.
				previous_position_in_parent := previous_parent_object.children.index_of (real_child, 1)
				previous_parent_id := previous_parent_object.id
				create previous_parents.make (5)
			end
			
				-- Create structures used for adding and removing the objects retrieved recursively.
			create parent_objects.make (20)
			create child_objects.make (20)
			
			if previous_parent_object = Void then
				if not parent_object.instance_referers.is_empty  then
						-- No need to do anything if the new parent has no referers.
						-- As there are referers, we must recursively add a copy of the new object to all instances.
					create_new_representations (parent_object, real_child)
				end
			else
				-- If the the object to be parented was already contained within an object, we must store all
				-- previous parents for the referers of the child so they may be restored during an undo.
				get_original_parents (parent_object)
				record_previous_parents (previous_parent_object)
			end

			history.cut_off_at_current_position
			insert_position := an_insert_position
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			a_previous_parent: GB_OBJECT
			child_object: GB_OBJECT
			parent_object: GB_OBJECT
		do
			child_object := Object_handler.deep_object_from_id (child_id)
			parent_object := Object_handler.deep_object_from_id (parent_id)
			
				-- `previous_parent_id' is greater than 0 when we are moving an object
				-- from within one abject to another. In this case, we unparent first.
			if previous_parent_id > 0 then
				a_previous_parent := child_object.parent_object
				a_previous_parent.remove_child (child_object)
				update_parent_object_editors (child_object, a_previous_parent, all_editors)
					-- Now remove all representations of the object from their parents.
				from
					child_objects.start
				until
					child_objects.off
				loop
					object_handler.deep_object_from_id (child_objects.item).parent_object.remove_child (object_handler.deep_object_from_id (child_objects.item))
					child_objects.forth
				end
			end
			
				-- Add `child_object' to it's new parent.
			object_handler.add_object (parent_object, child_object, insert_position)
				-- Add all representations of `child_object' to their new parents.
			add_object_representations

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
			child_object, parent_object, a_previous_parent: GB_OBJECT
			original_parent_object: GB_PARENT_OBJECT
		do
			child_object := Object_handler.deep_object_from_id (child_id)
			parent_object := Object_handler.deep_object_from_id (parent_id)
			
			a_previous_parent := child_object.parent_object
				-- Remove `child_object' from the parent.
			a_previous_parent.remove_child (child_object)
				-- Remove all representations of `child_object' from their parent representations
			remove_object_representations

			update_parent_object_editors (child_object, a_previous_parent, all_editors)

				-- If the object had a previous parent before the command was executed, we must put it back.
			if previous_parent_id > 0 then
				object_handler.add_object (object_handler.deep_object_from_id (previous_parent_id), child_object, previous_position_in_parent)
				from
					previous_parents.start
				until
					previous_parents.off
				loop
					original_parent_object ?= object_handler.deep_object_from_id (previous_parents.item)
					check
						object_was_parent_object: original_parent_object /= Void
					end
					original_parent_object.add_child_object (object_handler.deep_object_from_id (child_objects.i_th (previous_parents.index)), previous_position_in_parent)
					previous_parents.forth
				end
			end
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
			Result := child_name  + " added to " + parent_name
		end

feature {NONE} -- Implementation

	child_id: INTEGER
		-- Id of child object for addition.

	parent_id: INTEGER
		-- Id of parent object into which child is inserted.
		
	previous_parent_id: INTEGER
		-- Id of parent object which contained the child object
		-- previously. 0 if none.
	
	previous_position_in_parent: INTEGER
		-- If `previous_parent_id' /= 0 then this is
		-- the index of `child_object' within `previous_parent_object'.
	
	insert_position: INTEGER
		-- The position `execute' will insert `child_object'
		-- in `parent_object'.

	update_parent_object_editors (deleted_object, a_parent_object: GB_OBJECT; editors: ARRAYED_LIST [GB_OBJECT_EDITOR]) is
			-- For every item in `editors', update to reflect removal of `deleted_object'.
		local
			editor: GB_OBJECT_EDITOR
		do
			from
				editors.start
			until
				editors.off
			loop
				editor := editors.item		
					-- If the parent of `an_object' is in the object editor then we must
					-- update it accordingly.
				if a_parent_object /= Void and then a_parent_object = editor.object then
					editor.update_current_object
				end	
				editors.forth
			end
		end
	
	parent_objects, child_objects: ARRAYED_LIST [INTEGER]
		-- All parent and child objects encountered during `create_new_representations' represented by their id.
		-- We must store these in a list to preserve the association as if we iterate the hash tables
		-- together, the order of insertion is not preserved, and they are iterated based on their
		-- id's. One future possibility is to try using DS_HASH_TABLE which is supposed to preserve the iteration.
	
	previous_parents: ARRAYED_LIST [INTEGER]
		-- All previous parents if the object was originally parented within another object, represented by their id.
		
feature {NONE} -- Iteration implementation
		
	get_original_parents (parent_object: GB_PARENT_OBJECT) is
			-- Get all representations of `parent_object' recursively and add to `parent_objects'.
		require
			parent_object_not_void: parent_object /= Void
		local
			iterated_parent_object: GB_PARENT_OBJECT
		do
			from
				parent_object.instance_referers.start
			until
				parent_object.instance_referers.off
			loop
				iterated_parent_object ?= object_handler.deep_object_from_id (parent_object.instance_referers.item_for_iteration)
				parent_objects.extend (iterated_parent_object.id)
				get_original_parents (iterated_parent_object)
				parent_object.instance_referers.forth
			end
		end
		
	record_previous_parents (parent_object: GB_OBJECT) is
			-- Record all instance referers of `parent' recursively in `previous_parents' and also for
			-- each child object at `previous_position_in_parent', store in `child_objects'.
		require
			parent_object_not_void: parent_object /= Void
		local
			temp_parent: GB_PARENT_OBJECT
			list: ARRAYED_LIST [INTEGER]
		do
			list := parent_object.instance_referers.linear_representation
			from
				list.start
			until
				list.off
			loop
				temp_parent ?= object_handler.deep_object_from_id (list.item)
				check
					parent_found: temp_parent /= Void
				end
				if not object_handler.deleted_objects.has (temp_parent.id) then
					previous_parents.extend (temp_parent.id)
						-- We retrieve the child via `orig_index'.
					child_objects.extend (temp_parent.children.i_th (previous_position_in_parent).id)
					record_previous_parents (temp_parent)
				end
				list.forth
			end
		ensure
			lists_consistent: child_objects.count = previous_parents.count
		end
		
	add_object_representations is
				-- For every child within `child_objects', insert into the corresponding parent object
				-- within `parent_objects' at position `insert_posision'.
			require
				lists_consistent: parent_objects.count = child_objects.count
			local
				temp_parent_object: GB_PARENT_OBJECT
			do
				from
					parent_objects.start
				until
					parent_objects.off
				loop
					temp_parent_object ?= object_handler.deep_object_from_id (parent_objects.item)
					check
						was_parent_object: temp_parent_object /= Void
					end
					temp_parent_object.add_child_object (object_handler.deep_object_from_id (child_objects.i_th (parent_objects.index)), insert_position)
					parent_objects.forth
				end
			end
			
	remove_object_representations is
				-- For every parent object within `parent_objects', remove child at position `insert_posision'.
			require
				lists_consistent: parent_objects.count = child_objects.count
			local
				temp_parent_object: GB_PARENT_OBJECT
			do
				from
					parent_objects.start
				until
					parent_objects.off
				loop
					temp_parent_object ?= object_handler.deep_object_from_id (parent_objects.item)
					check
						was_parent_object: temp_parent_object /= Void
					end
					temp_parent_object.remove_child (object_handler.deep_object_from_id (child_objects.i_th (parent_objects.index)))
					parent_objects.forth
				end
			end
			
	create_new_representations (parent_object: GB_PARENT_OBJECT; child_object: GB_OBJECT) is
			-- Recursivley create new representations of the object to be added with id `child_id'
			-- for each `parent_object' and link new representations to `child_object'.
		require
			parent_object_not_void: parent_object /= Void
			child_object_not_void: child_object /= Void
		local
			new_object: GB_OBJECT
			iterated_parent_object: GB_PARENT_OBJECT
			actual_child: GB_OBJECT
		do
				-- Always retrieve the original child that must be copied.
			actual_child := Object_handler.deep_object_from_id (child_id)
			from
				parent_object.instance_referers.start
			until
				parent_object.instance_referers.off
			loop
				new_object := actual_child.new_top_level_representation
				
					-- Now connect instance referers for `actual_child'.
				child_object.instance_referers.extend (new_object.id, new_object.id)
				new_object.connect_instance_referers (child_object, new_object)
				
				iterated_parent_object ?= object_handler.deep_object_from_id (parent_object.instance_referers.item_for_iteration)

				if not object_handler.deleted_objects.has (iterated_parent_object.id) then
						-- Store both the parent and child in the flat representations.
					parent_objects.extend (iterated_parent_object.id)
					child_objects.extend (new_object.id)
				end
				
					-- Perform this recursively.
				create_new_representations (iterated_parent_object, new_object)
				parent_object.instance_referers.forth
			end
		ensure
			flattened_lists_equal: parent_objects.count = child_objects.count
			referers_equal: child_object.instance_referers.count = parent_object.instance_referers.count
		end

end -- class GB_COMMAND_ADD_OBJECT
