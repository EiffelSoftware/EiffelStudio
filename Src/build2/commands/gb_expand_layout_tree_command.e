indexing
	description: "Objects that expand the layout tree."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EXPAND_LAYOUT_TREE_COMMAND

inherit

	EB_STANDARD_CMD
		redefine
			make, execute
		end

	GB_SHARED_OBJECT_HANDLER
	
	GB_SHARED_TOOLS

create
	make

feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			Precursor {EB_STANDARD_CMD}
			set_menu_name ("Expand layout tree")
			add_agent (agent execute)
			enable_sensitive
		end

feature -- Execution

	execute is
			-- Execute command.
		local
			root_object: GB_OBJECT
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			layout_item ?= layout_constructor.first
			check
				layout_item /= Void
			end
			root_object := layout_item.object
			object_handler.recursive_do_all (root_object, agent expand_layout_node)
		end
		
feature {NONE} -- Implementation

	expand_layout_node (an_object: GB_OBJECT) is
			-- Expand `an_object' if it has children.
		local
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			layout_item ?= an_object.layout_item
			check
				layout_item_not_void: layout_item /= Void
			end
			if layout_item.count > 0 then
				layout_item.expand
			end
		end

end -- class GB_EXPAND_LAYOUT_TREE_COMMAND
