indexing
	description: "Window holding a tool"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_TOOL_WINDOW

inherit
	EV_WINDOW
		redefine
			implementation
		end

	EB_TOOL_CONTAINER
		undefine
			show, widget_make, parent, parent_needed
		redefine
			tool, implementation
		end


feature -- Initialization

	initialize_main_menu is
			-- Create and initialize `menu_bar'.
		deferred
		end

feature -- Access

	tool: EB_TOOL is
			-- tool under management
		deferred
		end

feature -- Tool management

	destroy_tool is
			-- destroy associated tool
			-- implies Current destruction
			-- (window cannot exist without its tool)
		do
			tool.destroy_imp
			destroy
		ensure then
			destroyed: destroyed
		end

	show_tool is
			-- shows the tool.
			-- it implies showing Current
		do
			tool.show_imp
			show
		ensure then
			shown: shown
		end

	raise_tool is
			-- shows the tool in the foreground.
			-- it implies showing Current
		do
			tool.show_imp
			show
			set_focus
		ensure then
			shown: shown
		end

	hide_tool is
			-- hides the tool.
			-- it implies hiding Current
		do
			tool.hide_imp
			hide
		ensure then
			hidden: not shown
		end

feature {NONE} -- Implementation
	
	menu_bar: EV_STATIC_MENU_BAR
			-- Menu bar for the window

	implementation: EV_WINDOW_I

end -- class EB_TOOL_WINDOW
