indexing
	description: "Objects that allow modification of attributes. For%
		% insertion into a GB_OBJECT_EDITOR."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_EDITOR_ITEM

inherit
	EV_VERTICAL_BOX
	
feature -- Access

	update_for_child_addition: BOOLEAN
		-- must `Current be updated when a child
		-- has been added?
		
	type_represented: STRING
		-- Type of object represented and
		-- modifyable by `Current'.
		-- i.e. EV_SENSITIVE, EV_BUTTON etc.
		
	creating_class: GB_EV_ANY
		-- `Result' is class that created `Current'.
		
feature -- Status Setting

	enable_update_for_child_addition is
			-- Assign `True' to `update_for_child_addition'.
		do
			update_for_child_addition := True
		end
		
	set_type_represented (a_type: STRING) is
			-- Assign `a_type' to `type'.
		require
			type_not_void: a_type /= Void
		do
			type_represented := a_type
		ensure
			type_represented.is_equal (a_type)
		end
		
	set_creating_class (a_class: GB_EV_ANY) is
			--
		do
			creating_class := a_class
		end
		

end -- class GB_OBJECT_EDITOR_ITEM
