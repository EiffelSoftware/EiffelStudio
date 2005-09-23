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
			initialize,
			destroy
		select
			implementation
		end
		
	GB_LAYOUT_NODE
		rename
			implementation as old_imp
		export
			{NONE} all
			{ANY} object
		redefine
			destroy
		end

	GB_SHARED_TOOLS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		undefine
			copy, default_create, is_equal
		end
		
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		undefine
			copy, default_create, is_equal
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		undefine
			copy, default_create, is_equal
		end

create
	{GB_OBJECT_HANDLER, GB_OBJECT} make

feature {GB_TITLED_WINDOW_OBJECT} -- Initialization

	make (an_object: GB_OBJECT) is
			-- Create `Current' and assign `an_object' to `object'.
		require
			an_object_not_void: an_object /= Void
		do
			default_create
			set_object (an_object)
			set_pebble_function (agent object.retrieve_pebble)
			set_text (object.short_type)
			expand_actions.extend (agent register_expand)
			collapse_actions.extend (agent register_collapse)
			update_pixmap
		ensure
			object_assigned: object = an_object
			text_assigned: text.is_equal (object.type.substring (4, object.type.count))
		end
		
	initialize is
			-- Initialize `Current'.
			-- Assign `Current' to `pebble'.
		do
			Precursor {EV_TREE_ITEM}
				-- Set the pebble function for
				-- tansport.
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
		ensure
			object_set: object = an_object
		end
		
	destroy is
			-- Destroy `Current'.
		do
			object := Void
			Precursor {EV_TREE_ITEM}
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
		
feature {GB_COMMAND_DELETE_WINDOW_OBJECT, GB_OBJECT, GB_COMMAND_ADD_WINDOW} -- Implementation

	unparent is
			-- Remove `Current' from its `parent' if any.
		local
			parent_item: EV_TREE_NODE_LIST
		do
				-- Remove `layout_item' from its parent.
			parent_item ?= parent
			if parent_item /= Void then
				check
						-- No longer perform this check, as window object layout items
						-- will have no parent unless they are currently being edited.
					--parent_item_not_void: parent_item /= Void
					--item_contained_in_parent: parent_item.has (layout_item)
				end
				parent_item.prune (Current)			
			end
		ensure
			not_parented: parent = Void
		end

feature {NONE} -- Implementation

	register_expand is
			-- Flag `object' as expanded.
		do
			object.register_expand
		end
		
	register_collapse is
			-- Flag `obejct' as collapsed.
		do
			object.register_collapse
		end
		
	update_docked_object_editor is
			-- update `docked_object_editor' to reflect `Current'
		do
			if system_status.project_open then
					-- If there is no project open, then there is
					-- nothing to update. The reason that we must protect,
					-- is that when rebuilding new projects, it seems that
					-- selection change events from the layout tree items
					-- are somewhat unusual. There will be no side
					-- effect from performing this protection. Julian.				
				force_name_change_completion_on_all_editors
				docked_object_editor.set_object (object)
			end
		end
		
end -- class GB_LAYOUT_CONSTRUCTOR_ITEM
