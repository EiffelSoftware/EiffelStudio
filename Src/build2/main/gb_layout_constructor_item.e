indexing
	description: "Objects that represent an item in a GB_LAYOUT_STRUCTURE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_LAYOUT_CONSTRUCTOR_ITEM

inherit
	EV_TREE_ITEM
		undefine
			is_in_default_state
		redefine
			initialize
		select
			implementation
		end
		
	GB_LAYOUT_NODE
		rename
			implementation as old_imp
		end

	GB_ACCESSIBLE
		undefine
			default_create, copy, is_equal
		end
		
	GB_ACCESSIBLE_OBJECT_HANDLER
		export
			{NONE} copy
			{ANY} is_equal
		undefine
			default_create, copy, is_equal
		end
		
	GB_ACCESSIBLE_OBJECT_EDITOR
		undefine
			default_create, copy, is_equal
		end
		
	GB_CONSTANTS
		undefine
			default_create, copy, is_equal
		end
		
	GB_PICK_AND_DROP_SHIFT_MODIFIER
		undefine
			default_create, copy, is_equal
		end

create
	{GB_OBJECT_HANDLER, GB_OBJECT} make

create
	make_root

feature {NONE} -- Initialization

	make (an_object: GB_OBJECT) is
			-- Create `Current' and assign `an_object' to `object'.
		require
			an_object_not_void: an_object /= Void
		do
			default_create
			set_object (an_object)
			set_text (object.type.substring (4, object.type.count))
		ensure
			object_assigned: object = an_object
			text_assigned: text.is_equal (object.type.substring (4, object.type.count))
		end

	make_root is
			-- Create `Current' as a root object.
		local
			an_object: GB_CELL_OBJECT
		do
			default_create
			create an_object.make_with_type_and_object (ev_titled_window_string, display_window)
			set_text ("TITLED_WINDOW")
			object_handler.add_root_object (an_object)
			an_object.set_layout_item (Current)
		end
		
	initialize is
			-- Initialize `Current'.
			-- Assign `Current' to `pebble'.
		do
			Precursor {EV_TREE_ITEM}
				-- Set the pebble function for
				-- tansport.
			set_pebble_function (agent retrieve_pebble)
			pick_actions.force_extend (agent set_up_drop_actions_for_all_objects)
			pick_actions.force_extend (agent create_shift_timer)
			pick_ended_actions.force_extend (agent destroy_shift_timer)
			select_actions.extend (agent update_docked_object_editor)
		end

feature {GB_OBJECT} -- Implementation
		
	set_object (an_object: GB_OBJECT) is
			-- Assign `an_object' to `object'
		do
			object := an_object
		end

feature {NONE} -- Implementation

	retrieve_pebble: ANY is
			-- Retrieve pebble for transport.
			-- A convenient was of setting up the drop
			-- actions for GB_OBJECT.
		local
			environment: EV_ENVIRONMENT
		do
			
			--| FIXME This is currently identical to version in 
			--| GB_OBJECT
			create environment
				-- If the ctrl key is pressed, then we must
				-- start a new object editor for `Current', instead
				-- of beginning the pick and drop.
			if environment.application.ctrl_pressed then
				new_object_editor (object)
			else
				type_selector.update_drop_actions_for_all_children (object)
				Result := object
			end
		end
		
	set_up_drop_actions_for_all_objects is
			-- Check state of shift key, and set up drop actions
			-- to accept `pebble' ready for the transport.
		local
			environment: EV_ENVIRONMENT
			constructor: GB_LAYOUT_CONSTRUCTOR	
		do
			create environment
			constructor ?= parent_tree
			check
				constructor_not_void: constructor /= Void
			end
			if environment.application.shift_pressed then
				object_handler.for_all_objects_build_shift_drop_actions_for_new_object
			else
				object_handler.for_all_objects_build_drop_actions_for_new_object
			end
		end
		
	update_docked_object_editor is
			-- update `docked_object_editor' to reflect `Current'
		do
			docked_object_editor.set_object (object)
		end
		
end -- class GB_LAYOUT_CONSTRUCTOR_ITEM
