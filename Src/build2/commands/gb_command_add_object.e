indexing
	description: "Objects that represent a command for addition of an object."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_ADD_OBJECT

inherit
	
	GB_SHARED_OBJECT_HANDLER
	
	GB_COMMAND
	
	GB_SHARED_HISTORY
	
	GB_SHARED_OBJECT_EDITORS
	
	GB_WIDGET_UTILITIES
	
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
		do
			parent_id := parent.id
			child_id := child.id
			previous_parent_object := child.parent_object
			if previous_parent_object /= Void then
				previous_parent_id := previous_parent_object.id
			end
			insert_position := an_insert_position
			if previous_parent_object /= Void then
				previous_position_in_parent := previous_parent_object.layout_item.index_of (child.layout_item, 1)	
			end
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
			
				-- `previous_parent_id' will be greater than 0 when we are moving an object
				-- from within one abject to another. In this case, we unparent first.
			if previous_parent_id > 0 then
				a_previous_parent := child_object.parent_object
				child_object.unparent
				update_parent_object_editors (child_object, a_previous_parent, all_editors)
			end

			object_handler.add_object (parent_object, child_object, insert_position)

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
			-- `previous_parent_layout_item' is Void when we first execute, so
			-- we store our own local for passing to `update_object_editors_for_delete'.
			-- We must store it, as the unparenting which must occur first if we are to see any changes
			-- will change the parent.
		do
			child_object := Object_handler.deep_object_from_id (child_id)
			parent_object := Object_handler.deep_object_from_id (parent_id)

			a_previous_parent := child_object.parent_object
			child_object.unparent
			update_parent_object_editors (child_object, a_previous_parent, all_editors)

				-- If the object had a previous parent, we must put it back.
			if previous_parent_id > 0 then
				object_handler.add_object (object_handler.deep_object_from_id (previous_parent_id), child_object, previous_position_in_parent)
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
		-- Id of parent object into which chld is inserted.
		
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

end -- class GB_COMMAND_ADD_OBJECT
