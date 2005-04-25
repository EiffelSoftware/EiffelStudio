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

	object_type_and_value: STRING is
			-- Full ouput representation for related object
		do
		end

feature {NONE} -- Facade

	fill_onces_with_list (parent: EV_TREE_NODE_LIST; a_once_list: LIST [E_FEATURE]; dv: ABSTRACT_DEBUG_VALUE) is
			-- Fill `parent' with the once functions `a_once_list'.
		do
		end

	refreshed_sorted_children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- Sorted children used by refresh
			-- set `is_sorted_children_about_special' attribute
		do
		end

	sorted_attributes: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		do
		end

end -- class EB_OBJECT_DISPLAY_PARAMETERS_DOTNET
