indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_DISPLAY_PARAMETERS_DOTNET

inherit

	EB_OBJECT_DISPLAY_PARAMETERS

create {SHARED_DEBUG}
	make, make_from_debug_value, make_from_stack_element

feature -- Transformation

	object_full_output: STRING is
			-- Full ouput representation for related object
		do
		end

feature {EB_SET_SLICE_SIZE_CMD} -- Refreshing

	refresh is
			-- Reload attributes (useful if `Current' represents a special object)
		do
		end

feature {NONE} -- Facade

	fill_onces_with_list (parent: EV_TREE_NODE_LIST; a_once_list: LIST [E_FEATURE]; dv: ABSTRACT_DEBUG_VALUE) is
			-- Fill `parent' with the once functions `a_once_list'.
		do
		end

	load_attributes_under (parent: EV_TREE_NODE_LIST) is
			-- Fill in `parent' with the associated attributes object.
		do
		end

end -- class EB_OBJECT_DISPLAY_PARAMETERS_DOTNET
