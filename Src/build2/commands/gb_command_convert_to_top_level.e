indexing
	description: "[
		Objects that represent a command for the conversion of an existing object to a top level object
		that now represents the original object which becomes a locked representation of the new top level object.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_CONVERT_TO_TOP_LEVEL

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
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
create
	make
	
feature {NONE} -- Initialization

	make (child: GB_OBJECT; new_name: STRING) is
			-- Create `Current' with `child' to be inserted in `parent' at
			-- position `position'.
		require
			child_not_void: child /= Void
			new_name_not_void: new_name /= Void
			child_is_not_representation: not child.is_instance_of_top_level_object
		local
		do
			name := new_name
			child_id := child.id
			history.cut_off_at_current_position
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			all_children_old, all_children_new: ARRAYED_LIST [GB_OBJECT]
			window_selector_item: GB_WINDOW_SELECTOR_ITEM
			display_win: GB_DISPLAY_WINDOW
			builder_win: GB_BUILDER_WINDOW
		do
			child_object := Object_handler.deep_object_from_id (child_id)

			new_object := Object_handler.deep_object_from_id (child_id).new_top_level_representation
			new_object_id := new_object.id
			
			create window_selector_item.make_with_object (new_object)
			create display_win
			insert_into_window (new_object.object, display_win)
			create builder_win
			insert_into_window (new_object.display_object, builder_win)

			create all_children_old.make (50)
			child_object.all_children_recursive (all_children_old)
			create all_children_new.make (50)
			new_object.all_children_recursive (all_children_new)
			check
				children_count_identical: all_children_new.count = all_children_old.count
			end

			child_object.set_associated_top_level_object (new_object)
			child_object.represent_as_locked_instance
			new_object.represent_as_non_locked_instance
			new_object.instance_referers.extend (child_object.id, child_object.id)
			from
				all_children_old.start
				all_children_new.start
			until
				all_children_old.off
			loop
				if all_children_old.item.is_instance_of_top_level_object then
					all_children_new.item.set_associated_top_level_object (object_handler.deep_object_from_id (all_children_old.item.associated_top_level_object))
					all_children_new.item.represent_as_locked_instance
				end
				all_children_old.forth
				all_children_new.forth
			end
			from
				all_children_new.start
				all_children_old.start
			until
				all_children_new.off
			loop
				check
					no_instance_referers: all_children_new.item.instance_referers.is_empty
				end
				all_children_new.item.instance_referers.extend (all_children_old.item.id, all_children_old.item.id)
				all_children_new.forth
				all_children_old.forth
			end

			new_object.set_name (name)
			window_selector.add_alphabetically (new_object.window_selector_item)
			
			rebuild_associated_editors (child_object.object)

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
			all_children_old, all_children_new: ARRAYED_LIST [GB_OBJECT]
		do
			child_object := Object_handler.deep_object_from_id (child_id)
			new_object := Object_handler.deep_object_from_id (new_object_id)
			
			
			create all_children_old.make (50)
			child_object.all_children_recursive (all_children_old)
			create all_children_new.make (50)
			new_object.all_children_recursive (all_children_new)
			check
				children_count_identical: all_children_new.count = all_children_old.count
			end

				-- It is possible that the child object has been flattened before `undo' was called.
				-- If so, there is no instance referring to undo. A subsequent `redo' will once
				-- again ensure that the two objects are linked. Should we overried `redo' if the object
				-- was flattened and not connect the referers, just add the new object?
			if child_object.is_instance_of_top_level_object then

				child_object.remove_associated_top_level_object
				child_object.represent_as_non_locked_instance
				new_object.instance_referers.remove (child_object.id)
				from
					all_children_old.start
					all_children_new.start
				until
					all_children_old.off
				loop
					if all_children_old.item.is_instance_of_top_level_object then
						all_children_new.item.remove_associated_top_level_object
						all_children_new.item.represent_as_non_locked_instance
					end
					all_children_old.forth
					all_children_new.forth
				end
				from
					all_children_new.start
					all_children_old.start
				until
					all_children_new.off
				loop
					check
						has_instance_referers: not all_children_new.item.instance_referers.is_empty
					end
					all_children_new.item.instance_referers.remove (all_children_old.item.id)
					all_children_new.forth
					all_children_old.forth
				end
			end
				
					-- Remove the window selector item from the window selector.
				new_object.window_selector_item.unparent
				
					-- Note that we do not mark `new_object' as deleted as it is no longer used after this.
					-- If we undo and re-do we must create the new object representation each time. This is
					-- due to the fact that if we undo the execution of `Current', modify a property of one
					-- of the widgets in the original widget structure and then re-do the command, the two
					-- object instances are out of synch with the new property. This is because while modifying
					-- the property while undone, there is no correct `instance_referes' reference. We cannot simply
					-- keep the refering links as it is performed in the wrong direction from the new to the original,
					-- and the links from every object within the structure are not bi-directional. So for the moment,
					-- we simply rebuild the new top level object each time which keeps the properties in synch. This
					-- has the disadvantage of being slow and creating new objects each time.
					
					-- Ensure that we no longer reference `new_object' in the object list.
					-- But note the comment above which explains why it is not added to `deleted_objects'.
				object_handler.objects.remove (new_object.id)
				from
					all_children_new.start
				until
					all_children_new.off
				loop
					object_handler.objects.remove (all_children_new.item.id)
					all_children_new.forth
				end
				
					-- Now must actually delete the object and its representations.
					--| FIXME
					
			rebuild_associated_editors (child_object.object)

			command_handler.update
		ensure then
			not_contained_in_objects: old child_object.is_instance_of_top_level_object implies not object_handler.objects.has (new_object.id)
				-- Also must perform recursively for all children, but not easy to write 
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			child_name: STRING
		do
			child_object := Object_handler.deep_object_from_id (child_id)
			if not child_object.name.is_empty then
				child_name := child_object.name
			else
				child_name := child_object.short_type
			end
			Result := child_name  + " converted to widget representation named " + name
		end

feature {NONE} -- Implementation

	new_object, child_object: GB_OBJECT
		-- Current representations of `new_object_id' and `child_id'. These may change
		-- each time we execute or undo.

	child_id: INTEGER
		-- Id of child object for addition.

	new_object_id: INTEGER
		-- Id of representation of object with id `child_id' that is created.
		
	original_directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		-- Original directory item in which obejct represented by `new_object_id' was parented.
		
	name: STRING
		-- Name used for the new object that is created.

end -- class GB_COMMAND_CONVERT_TO_TOP_LEVEL
