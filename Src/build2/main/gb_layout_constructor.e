indexing
	description: "Objects that allow the user to lay out their vision2 components."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_LAYOUT_CONSTRUCTOR

inherit
	EV_TREE
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
		
	GB_SHARED_OBJECT_HANDLER
		undefine
			default_create, copy, is_equal
		end
		
	GB_CONSTANTS

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
		
end -- class GB_LAYOUT_CONSTRUCTOR
