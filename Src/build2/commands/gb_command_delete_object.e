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
		do
			update_object_editors_for_delete (child_layout_item.object, all_editors)
			child_layout_item.object.unparent
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
			object_handler.add_object (parent_layout_item.object, child_layout_item.object, position)
			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		do
			Result := child_layout_item.object.short_type + " removed from " + parent_layout_item.object.short_type
		end
		
		
feature {NONE} -- Implementation
	
	child_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		-- Layout constructor representation of `child_object'.
		
	parent_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		-- Layout constructor representation of `previous_parent_object'.
		
	position: INTEGER
		-- Position of `child_layout_item' within `parent_layout_item' when `make'
		-- was called.
	
	update_object_editors_for_delete (deleted_object: GB_OBJECT editors: ARRAYED_LIST [GB_OBJECT_EDITOR]) is
			-- For every item in `editors', update to reflect removal of `deleted_object'.
		local
			editor: GB_OBJECT_EDITOR
			local_parent: GB_OBJECT
		do
			local_parent := deleted_object.parent_object
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
					--editor.make_empty
					if editor = docked_object_editor then
						editor.make_empty
					else
						editor.window_parent.destroy
						editor.destroy
						floating_object_editors.prune (editor)
					end
				end
			
					-- If the parent of `an_object' is in the object editor then we must
					-- update it accordingly.
				if local_parent /= Void and then local_parent = editor.object then
					editor.update_current_object
				end	
				editors.forth
			end
		end

end -- class GB_COMMAND_DELETE_OBJECT
