indexing
	description: "Objects that represent a command for addition of an object."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_ADD_OBJECT
	
	--| FIXME This is messy, we should pass the layout items
	-- directly when creating `Current'. At the moment, we have to handle
	-- the first execution and then subsequent executions differently
	-- which becomes messy. See in `execute' as we handle this here. Julian.
	
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
		do
			parent_object := parent
			child_object := child
			previous_parent_object := child.parent_object
			insert_position := an_insert_position
			if previous_parent_object /= Void then
				previous_position_in_parent := previous_parent_object.layout_item.index_of (child.layout_item, 1)	
			end
		ensure
			parent_object = parent
			child_object = child
			previous_parent_object = child.parent_object
			insert_position = an_insert_position
		end
		

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			a_previous_parent: GB_OBJECT
		do
			if not executed then
				if previous_parent_object /= Void then
					a_previous_parent := child_object.parent_object
					child_object.unparent
					update_parent_object_editors (child_object, a_previous_parent, all_editors)
				end
				object_handler.add_object (parent_object, child_object, insert_position)
			else
				if previous_parent_layout_item /= Void then
					a_previous_parent := child_layout_item.object.parent_object
					child_layout_item.object.unparent
					update_parent_object_editors (child_layout_item.object, a_previous_parent, all_editors)
				end
				object_handler.add_object (parent_layout_item.object, child_layout_item.object, insert_position)
			end
			if not executed then
				child_layout_item := child_object.layout_item
				parent_layout_item := parent_object.layout_item
				if previous_parent_object /= Void then
					previous_parent_layout_item := previous_parent_object.layout_item
				end
					-- As execute has already been called, we assign `Void'
					-- to these attributes, as we must now use the layout versions instead.
				child_object := Void
				parent_object := Void
				previous_parent_object := Void
			end
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
				-- Assign `True' to `executed' so next time `execute' is called,
				-- we can use the correct objects to perform the settings.
			executed := True
			command_handler.update
		end
		
	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			a_previous_parent: GB_OBJECT
			-- `previous_parent_layout_item' is Void when we first execute, so
			-- we store our own local for passing to `update_object_editors_for_delete'.
			-- We must store it, as the unparenting which must occur first if we are to see any changes
			-- will change the parent.
		do
			a_previous_parent := child_layout_item.object.parent_object
			child_layout_item.object.unparent
			update_parent_object_editors (child_layout_item.object, a_previous_parent, all_editors)

				-- If the object had a previous parent, we must put it back.
			if previous_parent_layout_item /= Void then
				object_handler.add_object (previous_parent_layout_item.object, child_layout_item.object, previous_position_in_parent)
			end
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
			Result := child_name  + " added to " + parent_name
		end
		
		
feature {NONE} -- Implementation

	parent_object: GB_OBJECT
		-- New parent of `child_object'.
		
	child_object: GB_OBJECT
		-- Object to be added to `parent_object'.
	
	previous_parent_object: GB_OBJECT
		-- The parent of `child_object' before `execute'
		-- May be void if none.
	
	parent_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		-- Layout constructor representation of `parent_object'.
		
	child_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		-- Layout constructor representation of `child_object'.
		
	previous_parent_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		-- Layout constructor representation of `previous_parent_object'.
	
	previous_position_in_parent: INTEGER
		-- If `child_object' object was parented before `execute' then this is
		-- the index of `child_object' within `previous_parent_object'.
	
	insert_position: INTEGER
		-- The position `execute' will insert `child_object'
		-- in `parent_object'.
	
	executed: BOOLEAN
		-- Has execute already been called on `Current'?
		-- This is needed as type changes cause problems. i.e. they
		-- create new objects and our references no longer make any sense.
		-- Therefore, we use the layout constructor items defined above
		-- every time we call execute after the first time, as they will give
		-- us a reference to the real objects. The layout constructor items
		-- should not be changed when a type is changed.
		
		
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
