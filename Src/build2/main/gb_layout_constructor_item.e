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

	GB_SHARED_TOOLS
		undefine
			default_create, copy, is_equal
		end
		
	GB_SHARED_OBJECT_HANDLER
		undefine
			copy, default_create, is_equal
		end
		
	GB_SHARED_OBJECT_EDITORS
		
	GB_CONSTANTS
	
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
			set_text (object.short_type)
			update_pixmap
		ensure
			object_assigned: object = an_object
			text_assigned: text.is_equal (object.type.substring (4, object.type.count))
		end
		
	make_root is
			-- Create `Current' as a root object.
		local
			an_object: GB_TITLED_WINDOW_OBJECT
			shared_pixmaps: GB_SHARED_PIXMAPS
		do
			default_create
			create shared_pixmaps
			create an_object.make_with_type_and_object (ev_titled_window_string, display_window)
			set_text ("TITLED_WINDOW")
			set_pixmap (shared_pixmaps.pixmap_by_name ("ev_titled_window"))
			object_handler.add_root_object (an_object)
			an_object.set_layout_item (Current)
			builder_window.set_object (an_object)
		end
		
	initialize is
			-- Initialize `Current'.
			-- Assign `Current' to `pebble'.
		do
			Precursor {EV_TREE_ITEM}
				-- Set the pebble function for
				-- tansport.
			set_pebble_function (agent retrieve_pebble)
			select_actions.extend (agent update_docked_object_editor)
		end
		
feature {GB_RADIO_GROUP_LINK} -- Access

	is_animated: BOOLEAN
		-- Is `Current' presently being animated?

feature {GB_RADIO_GROUP_LINK}-- Status setting

	enable_animation is
			-- Assign `True' to `is_animated'.
		do
			is_animated := True
		end
		
	disable_animation is
			-- Assign `False' to `is_animated'.
		do
			is_animated := False
		end

feature {GB_OBJECT} -- Implementation
		
	set_object (an_object: GB_OBJECT) is
			-- Assign `an_object' to `object'
		do
			object := an_object
		end
		
feature {GB_COMMAND_CHANGE_TYPE} -- Implementation

	update_pixmap is
			-- Set pixmap of `Current' to match type
			-- of `object'
		require
			object_not_void: Object /= Void
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			create pixmaps
			set_pixmap (pixmaps.pixmap_by_name (object.type.as_lower))
		end

feature {NONE} -- Implementation

	retrieve_pebble: ANY is
			-- Retrieve pebble for transport.
			-- A convenient was of setting up the drop
			-- actions for GB_OBJECT.
		do			
			--| FIXME This is currently identical to version in 
			--| GB_OBJECT
				-- If the ctrl key is pressed, then we must
				-- start a new object editor for `Current', instead
				-- of beginning the pick and drop.
			if application.ctrl_pressed then
				new_object_editor (object)
			else
				type_selector.update_drop_actions_for_all_children (object)
				Result := object
			end
		end
		
	update_docked_object_editor is
			-- update `docked_object_editor' to reflect `Current'
		do
			docked_object_editor.set_object (object)
		end
		
end -- class GB_LAYOUT_CONSTRUCTOR_ITEM
