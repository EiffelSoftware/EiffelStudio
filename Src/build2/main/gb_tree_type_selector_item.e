indexing
	description: "Tree item representations of type selector items"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TREE_TYPE_SELECTOR_ITEM
	
inherit
	GB_TYPE_SELECTOR_ITEM
		redefine
			item
		end
		
create
	make_with_text
	
feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Create `Current', assign `a_text' to `text'
			-- and "EV_" + `a_text' to `type'.
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			create item.make_with_text (a_text)
			item.set_data (Current)
			type := "EV_" + a_text
				-- We must now add the correct pixmap.
			create pixmaps
			item.set_pixmap (pixmaps.pixmap_by_name (type.as_lower))
			item.set_pebble_function (agent generate_transportable)
		end

feature -- Access

	item: EV_TREE_ITEM
		-- Graphical representation of `Current' used in the type selector.

feature {NONE} -- Implementation

	process_number_key is
			-- Begin processing by `digit_checker', so that
			-- it can be determined if a digit key is held down.
		local
			tree: EV_TREE
			tree_node: EV_TREE_NODE_LIST
		do
			from
				tree_node := item
			until
				tree /= Void
			loop
				tree_node ?= tree_node.parent
				tree ?= tree_node
			end
			digit_checker.begin_processing (tree)
		end

end -- class GB_TREE_TYPE_SELECTOR_ITEM
