indexing
	description: "Objects that represent a layout node."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_LAYOUT_NODE

inherit
	
	EV_TREE_NODE_LIST
		undefine
			is_in_default_state,
			initialize
		end
			
	GB_DEFAULT_STATE
	
	GB_ACCESSIBLE
		undefine
			default_create, copy, is_equal
		end

feature -- Access

	object: GB_OBJECT
		-- The GB_OBJECT represented by `Current'.

end -- class GB_LAYOUT
