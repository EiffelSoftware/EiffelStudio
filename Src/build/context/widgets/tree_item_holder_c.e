indexing
	description: "Context that represents a tree item holder (EV_TREE_ITEM_CONTAINER)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TREE_ITEM_HOLDER_C

inherit
	CONTEXT
		undefine
			create_context,
			set_modified_flags,
			reset_modified_flags,
			is_able_to_be_grouped
		redefine
			gui_object
		end

	HOLDER_C
		redefine
			gui_object
		end

feature -- Implementation

	gui_object: EV_TREE_ITEM_HOLDER

end -- class TREE_ITEM_HOLDER_C

