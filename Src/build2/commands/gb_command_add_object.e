indexing
	description: "Objects that represent a command for addition of an object."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_ADD_OBJECT
	
inherit
	
	GB_ACCESSIBLE_OBJECT_HANDLER
	
	GB_COMMAND
	
	GB_ACCESSIBLE_HISTORY
	
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
		do
			if not executed then
				if previous_parent_object /= Void then
					child_object.unparent
				end
				object_handler.add_object (parent_object, child_object, insert_position)
			else
				if previous_parent_layout_item /= Void then
					child_layout_item.object.unparent
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
		do
			child_layout_item.object.unparent
			if previous_parent_layout_item /= Void then
				object_handler.add_object (previous_parent_layout_item.object, child_layout_item.object, previous_position_in_parent)
			end
			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		do
			Result := child_layout_item.object.short_type + " added to " + parent_layout_item.object.short_type
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

end -- class GB_COMMAND_ADD_OBJECT
