indexing
	description: "Window holding a unique tool"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_TOOL_WINDOW

inherit
	EV_WINDOW

	EB_TOOL_MANAGER

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

	tool_parent: EV_CONTAINER is
			-- parent of `tool'
		do
			Result := Current
		end

	associated_window: EV_WINDOW is
			-- window used as parent of `tool''s subwindows
		do
			Result := Current
		end

feature {EB_TOOL} -- Tool management

	-- the call with `t' is mandatory because these features
	-- may be called during `tool''s creation

	destroy_tool (t: like tool) is
			-- destroy associated tool
			-- implies Current destruction
			-- (window cannot exist without its tool)
		do
			t.destroy_imp
			destroy
		ensure then
			destroyed: destroyed
		end

	show_tool (t: like tool) is
			-- shows the tool.
			-- it implies showing Current
		do
			t.show_imp
			show
		ensure then
			shown: shown
		end

	raise_tool (t: like tool) is
			-- shows the tool in the foreground.
			-- it implies showing Current
		do
			t.show_imp
			show
			set_focus
		ensure then
			shown: shown
		end

	hide_tool (t: like tool) is
			-- hides `t'.
			-- it implies hiding Current
		do
			t.hide_imp
			hide
		ensure then
			hidden: not shown
		end

feature -- Tool status report

	tool_title: STRING is
		do
			Result := title
		end

	tool_icon_name: STRING is
		do
			Result := icon_name
		end

feature -- Tool status setting

	set_tool_title (t: like tool; s: STRING) is
		do
			set_title (s)
		end

	set_tool_icon_name (t: like tool; s: STRING) is
		do
			set_icon_name (s)
		end

feature {NONE} -- Implementation
	
	menu_bar: EV_STATIC_MENU_BAR
			-- Menu bar for the window

end -- class EB_TOOL_WINDOW
