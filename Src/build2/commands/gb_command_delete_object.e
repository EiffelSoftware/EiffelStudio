indexing
	description: "Objects that represent a command for the deletion of an object."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_DELETE_OBJECT
	
inherit
	
	GB_ACCESSIBLE_OBJECT_HANDLER
	
	GB_COMMAND
	
	GB_ACCESSIBLE_HISTORY
	
	GB_ACCESSIBLE_OBJECT_EDITOR
	
	GB_ACCESSIBLE_COMMAND_HANDLER
	
	GB_WIDGET_UTILITIES
	
create
	
	make
	
feature {NONE} -- Initialization

	make (parent, child: GB_OBJECT; a_position: INTEGER) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.

		do
			child_layout_item := child.layout_item
			parent_layout_item := parent.layout_item
			position := a_position
		end
		

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			previous_parent_object: GB_OBJECT
		do
				-- Note that unparenting an object does not update parent representations
				-- in objects editors, so we must do it ourselves by calling
				-- `update_object_editors_for_delete'.
			previous_parent_object := child_layout_item.object.parent_object
			child_layout_item.object.unparent
			update_object_editors_for_delete (child_layout_item.object, previous_parent_object, all_editors)
				-- We now need to mark the deleted object and all children as
				-- deleted.
			object_handler.mark_as_deleted (child_layout_item.object)
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
				-- Calling `add_object' on the obejct handler, will automatically
				-- update any parent representations in the object editor.
			object_handler.add_object (parent_layout_item.object, child_layout_item.object, position)
				-- We now need to ensure that the object is no longer marked as
				-- deleted.
			object_handler.mark_existing (child_layout_item.object)
			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			child_name, parent_name: STRING
		do
			if not child_layout_item.object.name.is_empty then
				child_name := child_layout_item.object.name
			else
				child_name := child_layout_item.object.short_type
			end
			
			if not parent_layout_item.object.name.is_empty then
				parent_name := parent_layout_item.object.name
			else
				parent_name := parent_layout_item.object.short_type
			end
			Result := child_name + " removed from " + parent_name
		end
		
		
feature {NONE} -- Implementation
	
	child_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		-- Layout constructor representation of `child_object'.
		
	parent_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		-- Layout constructor representation of `previous_parent_object'.
		
	position: INTEGER
		-- Position of `child_layout_item' within `parent_layout_item' when `make'
		-- was called.
	
	update_object_editors_for_delete (deleted_object, parent_object: GB_OBJECT editors: ARRAYED_LIST [GB_OBJECT_EDITOR]) is
			-- For every item in `editors', update to reflect removal of `deleted_object' from `parent_object'.
		local
			editor: GB_OBJECT_EDITOR
			window_parent: EV_WINDOW
		do
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
					if editor = docked_object_editor then
						editor.make_empty
					else
						window_parent := parent_window (editor)
						check
							floating_editor_is_in_window: window_parent /= Void
						end
						editor.destroy
						window_parent.destroy
						--| FIXME should this be `editors' prune?
						--| if not, then we may not even need the argument anymore.
						floating_object_editors.prune (editor)
					end
				end
			
					-- If the parent of `an_object' is in the object editor then we must
					-- update it accordingly.
				if parent_object /= Void and then parent_object = editor.object then
					editor.update_current_object
				end	
				editors.forth
			end
		end

end -- class GB_COMMAND_DELETE_OBJECT
