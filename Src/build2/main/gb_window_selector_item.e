indexing
	description: "Objects that represent windows in a GB_WINDOW_SELECTOR"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WINDOW_SELECTOR_ITEM
	
inherit
	EV_TREE_ITEM
	
	GB_SHARED_OBJECT_EDITORS
		undefine
			copy, default_create, is_equal
		end
		
	GB_SHARED_TOOLS
		undefine
			copy, default_create, is_equal
		end

create
	make_with_object
	
feature {NONE} -- Initialization

	make_with_object (an_object: GB_TITLED_WINDOW_OBJECT) is
			-- Create `Current' and associate with `an_object'.
		require
			object_not_void: an_object /= Void
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			default_create
			if an_object.output_name.is_empty then
				set_text (an_object.short_type)
			else
				set_text (an_object.output_name)
			end
			object := an_object
			
				-- Assign the appropriate pixmap.
			create pixmaps
			set_pixmap (pixmaps.pixmap_by_name (object.type.as_lower))
			
				-- Set a pebble for transport
			set_pebble_function (agent retrieve_pebble)
				
				-- Make `Current' available from `an_object'.
			an_object.set_window_selector_item (Current)
			select_actions.extend (agent window_selector.selected_window_changed (Current))
		ensure
			object_set: object = an_object
		end
		
feature -- Access

	object: GB_TITLED_WINDOW_OBJECT
		-- Object referenced by `Current'.
		
feature {GB_COMMAND_DELETE_WINDOW_OBJECT, GB_COMMAND_ADD_WINDOW} -- Implementation

	unparent is
			-- Remove `Current' from its parent.
		local
			parent_item: EV_TREE_NODE_LIST
			original_index: INTEGER
		do
			parent_item ?= parent
			if parent_item /= Void then
				check
					parent_item_not_void: parent_item /= Void
					item_contained_in_parent: parent_item.has (Current)
				end
				original_index := parent_item.index
				window_selector.update_for_removal (Current)
				parent_item.prune (Current)
				parent_item.go_i_th (original_index.min (parent_item.count))
			end
		ensure
			parent_void: parent = Void
		end
		
feature {NONE} -- Implementation

	retrieve_pebble: ANY is
			-- Retrieve pebble for transport.
			-- A convenient was of setting up the drop
			-- actions for GB_OBJECT.
		do			
				-- If the ctrl key is pressed, then we must
				-- start a new object editor for `Current', instead
				-- of beginning the pick and drop.
			if application.ctrl_pressed then
				new_object_editor (object)
			else
				Result := object
			end
		end

end -- class GB_WINDOW_SELECTOR_ITEM
