indexing
	description: "Objects that expand the layout tree."
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
		export
			{NONE} all
		end
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			Precursor {EB_STANDARD_CMD}
				-- Retrieve top level window of `layout_constructor'.
			set_menu_name ("Expand layout tree")
			add_agent (agent execute)
			enable_sensitive
		end
		
feature -- Access

	tool_bar_button: EV_TOOL_BAR_BUTTON is
			--
		local
			pixamps: GB_SHARED_PIXMAPS
			top_window: EV_TITLED_WINDOW
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
			top_window := parent_window (layout_constructor)
			top_window.lock_update
			expand_tree_recursive (layout_constructor)
			top_window.unlock_update
		end

end -- class GB_EXPAND_LAYOUT_TREE_COMMAND
