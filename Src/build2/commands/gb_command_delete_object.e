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

	make (parent, child: GB_OBJECT; a_position: INTEGER) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.
		do
			original_id := child.id
			parent_id := parent.id
			position := a_position
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
			update_for_delete
				-- Note that unparenting an object does not update parent representations
				-- in objects editors, so we must do it ourselves by calling
				-- `update_object_editors_for_delete'.
			previous_parent_object := child_object.parent_object

			child_object.unparent
			update_object_editors_for_delete (child_object, previous_parent_object)
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
	
	update_object_editors_for_delete (deleted_object, parent_object: GB_OBJECT) is
			-- For every item in `editors', update to reflect removal of `deleted_object' from `parent_object'.
		local
			editor: GB_OBJECT_EDITOR
			window_parent: EV_WINDOW
			editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
		do
			editors := all_editors
			from
				editors.start
			until
				editors.off
			loop
				editor := editors.item
					-- Update the editor if `Current' or a child of `Current'
					-- is contained.
				if object_handler.object_contained_in_object (deleted_object, editor.object) or
					deleted_object = editor.object then
						-- If we are the doced object editor, then just empty it.
						-- If not, we destroy the editor and the containing window.
					if editor = docked_object_editor then
						editor.make_empty
					else
						window_parent := parent_window (editor)
						check
							floating_editor_is_in_window: window_parent /= Void
						end
						editor.destroy
						window_parent.destroy
						floating_object_editors.prune (editor)
					end
				end

					-- We only update any editors that reference containers.
					-- Note that we could check to see which attributes of which objects
					-- really were affected, thus minimizing, rebuilding. Not done
					-- and probably not necessary.
				
				if not editor.is_destroyed and then editor.object /= Void and then
					type_conforms_to (dynamic_type_from_string (editor.object.type), dynamic_type_from_string (Ev_container_string)) then
					editor.update_current_object
				end	
				editors.forth
			end
		end
		
	update_for_delete is
				-- Perfrom any necessary processing on `Current'
				-- and all children contained within for a deletion
				-- event.
			local
				all_objects: ARRAYED_LIST [GB_OBJECT]
				counter: INTEGER
			do
				create all_objects.make (10)
				object_handler.deep_object_from_id (original_id).all_children_recursive (all_objects)
				all_objects.extend (object_handler.deep_object_from_id (original_id))
				from
					counter := 1
				until
					counter > all_objects.count
				loop
					(all_objects @ counter).delete
					counter := counter + 1
				end
			end

end -- class GB_COMMAND_DELETE_OBJECT
