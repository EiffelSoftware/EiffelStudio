indexing
	description: "Objects that collapse the layout tree."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COLLAPSE_LAYOUT_TREE_COMMAND

inherit

	EB_STANDARD_CMD
		redefine
			make, execute
		end

	GB_SHARED_OBJECT_HANDLER
	
	GB_SHARED_TOOLS
	
	GB_WIDGET_UTILITIES

create
	make

feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			Precursor {EB_STANDARD_CMD}
			set_menu_name ("Collapse layout tree")
			add_agent (agent execute)
			enable_sensitive
		end

feature -- Execution

	execute is
			-- Execute command.
		do
			collapse_tree_recursive (layout_constructor)
		end
		
end -- class GB_COLLAPSE_LAYOUT_TREE_COMMAND