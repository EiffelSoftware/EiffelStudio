indexing
	description: "Objects that represent windows in a GB_WINDOW_SELECTOR"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WINDOW_SELECTOR_ITEM
	
inherit
	GB_WINDOW_SELECTOR_COMMON_ITEM
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
		
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end

create
	make_with_object
	
feature {NONE} -- Initialization

	make_with_object (an_object: GB_OBJECT) is
			-- Create `Current' and associate with `an_object'.
		require
			object_not_void: an_object /= Void
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			common_make
			object := an_object

				-- Ensure that `Current' graphically reflects `an_object'.
			update_to_reflect_name_change
			
				-- Assign the appropriate pixmap.
			create pixmaps
			tree_item.set_pixmap (pixmaps.pixmap_by_name (an_object.type.as_lower))
			
				-- Set a pebble for transport
			tree_item.set_pebble_function (agent retrieve_pebble)
				
				-- Make `Current' available from `an_object'.
			an_object.set_window_selector_item (Current)
			tree_item.select_actions.extend (agent window_selector.selected_window_changed (Current))
			tree_item.drop_actions.extend (agent object.add_new_object)
			tree_item.drop_actions.set_veto_pebble_function (agent object.can_add_child)
		ensure
			object_set: object = an_object
		end
		
feature -- Access

	object: GB_OBJECT
			-- Object referenced by `Current'
			-- Note that it is safe to keep a reference to `object' here and not an id reference
			-- as used elsewhere by a system, as `Current' is part of an object and therefore the
			-- object is responsible for ensuring that the references are correct.
			
feature -- Status setting

	update_to_reflect_name_change is
			-- Update `Current' to reflect a name change of `object'.
		do
			name := object.name
			tree_item.set_text (name_and_type_from_object (object))
		end
	
feature --{NONE} -- Implementation

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
		
feature {GB_OBJECT} -- Implementation

	set_object (an_object: GB_OBJECT) is
			-- Assign `an_object' to `object'
		require
			an_object_not_void: an_object /= Void
		do
			object := an_object
		ensure
			object_set: object = an_object
		end

invariant
	object_not_void: object /= Void

end -- class GB_WINDOW_SELECTOR_ITEM
