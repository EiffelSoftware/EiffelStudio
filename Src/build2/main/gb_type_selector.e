indexing
	description: "Objects that allow you to select a widget type."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TYPE_SELECTOR

inherit

	EV_TREE
		export
			{ANY} parent
			{NONE} all
		undefine
			is_in_default_state
		redefine
			initialize
		end
	
	GB_SUPPORTED_WIDGETS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_DEFAULT_STATE
	
create
	default_create

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
			-- Fill with supported Widgets.
		local
			tree_item1, tree_item2, tree_item3, tree_item4: EV_TREE_ITEM
			shared_pixmaps: GB_SHARED_PIXMAPS
		do
			Precursor {EV_TREE}
			create shared_pixmaps
			create tree_item1.make_with_text ("Widgets")
			tree_item1.set_pixmap (shared_pixmaps.pixmap_by_name ("widgets"))
			extend (tree_item1)
			create tree_item3.make_with_text ("Containers")
			tree_item3.set_pixmap (shared_pixmaps.pixmap_by_name ("containers"))
			tree_item1.extend (tree_item3)
			add_tree_items (containers, tree_item3)
			create tree_item2.make_with_text ("Primitives")
			tree_item2.set_pixmap (shared_pixmaps.pixmap_by_name ("primitives"))
			tree_item1.extend (tree_item2)
			add_tree_items (primitives, tree_item2)
			create tree_item4.make_with_text ("Items")
			tree_item4.set_pixmap (shared_pixmaps.pixmap_by_name ("items"))
			extend (tree_item4)
			add_tree_items (items, tree_item4)
				-- Expand the types when the project is started.
			tree_item2.expand
			tree_item3.expand
			tree_item1.expand
			tree_item4.expand
			recursive_do_all (agent strip_leading_ev (?))
		end
		
feature -- Basic operation

	ensure_top_item_visible is
			-- Ensure that the topmost displayed item
			-- in `Current' is visible.
		require
			is_displayed: is_displayed
		do
			ensure_item_visible (i_th (1))
		end
		

feature {GB_LAYOUT_NODE, GB_OBJECT, GB_TYPE_SELECTOR_ITEM, GB_EV_BOX} -- Basic operations

	update_drop_actions_for_all_children  (an_object: GB_OBJECT) is
			-- Generate correct drop_actions for every child in `Current' when
			-- `a_node' is the type to be transported. This sets up for a standard drop
			-- which inserts into `Current'.
		do
			recursive_do_all (agent set_up_drop_actions (an_object,  ?))
		end

	set_up_drop_actions (an_object: GB_OBJECT; an_item: EV_TREE_ITEM) is
			-- Generate correct drop actions for `an_item' when `a_node'
			-- is the type to be transported.
			-- If `an_object' object is void, then we must have picked from
			-- a GB_TYPE_SELECTOR_ITEM, so in this case we simply wipe
			-- out the drop actions on `selector_item' as you cannot
			-- drop a type on a type.
			-- If `an_object' is Void, then we wipe out the drop actions.
		local
			selector_item: GB_TYPE_SELECTOR_ITEM
		do
			selector_item ?= an_item
				-- We check that the selector item is not void, as not
				-- all items in the selector tree are of type
				-- GB_SELECTOR_ITEM. For example, "widgets" is just a basic
				-- tree item, as you can do nothing with it.
				-- The check for object.parent not Void, ensures that we do nothing
				-- if a window has been picked.
			if selector_item /= Void then
				if an_object /= Void and then an_object.object /= Void and then an_object.parent_object /= Void then
					selector_item.generate_drop_actions (an_object)	
				else
					selector_item.drop_actions.wipe_out
				end
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

end -- class GB_WIDGET_SELECTOR
