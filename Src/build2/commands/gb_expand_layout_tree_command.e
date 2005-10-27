indexing
	description: "Objects that expand the layout tree."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EXPAND_LAYOUT_TREE_COMMAND

inherit

	GB_STANDARD_CMD
		redefine
			execute
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		do
			components := a_components
			make
				-- Retrieve top level window of `layout_constructor'.
			set_menu_name ("Expand layout tree")
			add_agent (agent execute)
			enable_sensitive
		end

feature -- Access

	tool_bar_button: EV_TOOL_BAR_BUTTON is
			-- `Result' is a tool bar button that when selected, expands `layout_constructor'.
		do
			create Result
			Result.select_actions.extend (agent execute)
			Result.set_tooltip ("Expand all")
			Result.set_pixmap ((create {GB_SHARED_PIXMAPS}).pixmap_by_name ("icon_expand_all_small_color"))
		ensure
			result_not_void: Result /= Void
		end


feature -- Execution

	execute is
			-- Execute command.
		local
			top_window: EV_WINDOW
		do
			top_window := parent_window (components.tools.layout_constructor)
			top_window.lock_update
			expand_tree_recursive (components.tools.layout_constructor)
			top_window.unlock_update
		end

end -- class GB_EXPAND_LAYOUT_TREE_COMMAND
