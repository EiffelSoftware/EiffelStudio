indexing
	description: "Objects that allow you to select a widget type."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TYPE_SELECTOR

inherit

	EV_TREE
		undefine
			is_in_default_state
		redefine
			initialize
		end
	
	GB_SUPPORTED_WIDGETS
		undefine
			default_create, copy, is_equal
		end
		
	GB_DEFAULT_STATE

create
	default_create

feature -- Initialization

	initialize is
			-- Initialize `Current'.
			-- Fill with supported Widgets.
		local
			tree_item1, tree_item2: EV_TREE_ITEM
		do
			Precursor {EV_TREE}
			create tree_item1.make_with_text ("Widgets")
			extend (tree_item1)
			create tree_item2.make_with_text ("Primitives")
			tree_item1.extend (tree_item2)
			add_tree_items (primitives, tree_item2)
			create tree_item2.make_with_text ("Containers")
			tree_item1.extend (tree_item2)
			add_tree_items (containers, tree_item2)
			recursive_do_all (agent strip_leading_ev (?))
		end

feature {GB_LAYOUT_NODE, GB_OBJECT} -- Basic operations

	update_drop_actions_for_all_children  (an_object: GB_OBJECT) is
			-- Generate correct drop_actions for every child in `Current' when
			-- `a_node' is the type to be transported. This sets up for a standard drop
			-- which inserts into `Current'.
		do
			recursive_do_all (agent set_up_drop_actions (an_object,  ?))
		end
		
	update_shift_drop_actions_for_all_children (an_object: GB_OBJECT) is
			-- Generate correct drop_actions for every child in `Current' when
			-- `a_node' is the type to be transported. This sets up for shift drop
			-- which inserts into parent of `Current', before `Current'.
		do
		end
		
		
	set_up_drop_actions (an_object: GB_OBJECT; an_item: EV_TREE_ITEM) is
			-- Generate correct drop actions for `an_item' when `a_node'
			-- is the type to be transported.
		local
			selector_item: GB_TYPE_SELECTOR_ITEM
		do
			selector_item ?= an_item
			if selector_item /= Void then
				selector_item.generate_drop_actions (an_object)
			end
		end		

feature {NONE} -- Implementation

	add_tree_items (list: ARRAY [STRING]; tree_item: EV_TREE_ITEM) is
			-- Add items corresponding to contents of `list' to `tree_item'.
		local
			counter: INTEGER
			new_item: GB_TYPE_SELECTOR_ITEM
		do
			from
				counter := 1
			until
				counter = list.count + 1
			loop
				create new_item.make_with_text (list @ counter)
				tree_item.extend (new_item)
				counter := counter + 1
			end
		end
		
	strip_leading_ev (tree_item: EV_TREE_ITEM) is
			-- If `tree_item' starts with "EV_", strip
			-- this.
		require
			tree_item_not_void: tree_item /= Void
		do
			if tree_item.text.substring (1, 3).is_equal ("EV_") then
				tree_item.set_text (tree_item.text.substring (4, tree_item.text.count))
			end
		end
		

invariant
	invariant_clause: -- Your invariant here

end -- class GB_WIDGET_SELECTOR
