indexing
	description: "Objects that allow the user to lay out their vision2 components."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_LAYOUT_CONSTRUCTOR

inherit
	EV_TREE
		export
			{NONE} all
			{ANY} first, parent, is_destroyed, is_displayed,
				has_recursively, selected_item, is_empty
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
		export
			{NONE} all
		end
		
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end

create
	default_create

feature -- Initialization

	initialize is
			-- Initialize `Current' and add a root
			-- item to represent a window.
		do
			Precursor {EV_TREE}
				-- Does nothing right now, but as it was previously
				-- necessary to redefine this feature, we leave it
				-- for the time being.
		end
		
feature -- Basic operation

	ensure_object_visible (an_object: GB_OBJECT) is
			-- Ensure that `an_object' is contained in `Current'.
		require
			not_destroyed: not is_destroyed
			is_displayed: is_displayed
			object_contained: has_recursively (an_object.layout_item)
		do
			ensure_item_visible (an_object.layout_item)	
		end
		
feature -- Access

	expand_all_button: EV_TOOL_BAR_BUTTON is
			-- `Result' is a tool bar button that
			-- calls `add_new_directory'.
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			create Result
			Result.select_actions.extend (agent expand_tree_recursive (Current))
				-- Assign the appropriate pixmap.
			create pixmaps
			Result.set_pixmap (pixmaps.pixmap_by_name ("icon_expand_all_small_color"))
		ensure
			result_not_void: Result /= Void
		end
	
feature {GB_OBJECT_HANDLER} -- Implementation

	add_root_item (layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM) is
			-- Add `layout_item' as a root item of `Current'.
		do
			extend (layout_item)
		ensure
			has_layout_item: has (layout_item)
		end
		
feature {GB_WINDOW_SELECTOR} -- Implementation

	set_root_window (a_window: GB_TITLED_WINDOW_OBJECT) is
			-- Ensure that `a_window' is displayed in `Current'.
		do
			wipe_out
			add_root_item (a_window.layout_item)
		ensure
			has_one_item: count = 1
		end

end -- class GB_LAYOUT_CONSTRUCTOR
