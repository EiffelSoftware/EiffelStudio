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
				has_recursively
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
		export {NONE} all
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
		local
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			Precursor {EV_TREE}
			create layout_item.make_root
			extend (layout_item)
			-- Cannot strengthen post condition, so use
			-- a check
			-- We only currently support one window, so there should only
			-- be one item which represents that window.
			check
				count_is_one: count = 1
			end
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
		
		
		
end -- class GB_LAYOUT_CONSTRUCTOR
