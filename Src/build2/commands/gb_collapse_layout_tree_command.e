indexing
	description: "Objects that collapse the layout tree."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COLLAPSE_LAYOUT_TREE_COMMAND

inherit

	GB_STANDARD_CMD
		redefine
			execute
		end

	GB_WIDGET_UTILITIES

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		do
			components := a_components
			make
			set_menu_name ("Collapse layout tree")
			add_agent (agent execute)
			enable_sensitive
		end

feature -- Execution

	execute is
			-- Execute command.
		do
			collapse_tree_recursive (components.tools.layout_constructor)
		end

end -- class GB_COLLAPSE_LAYOUT_TREE_COMMAND
