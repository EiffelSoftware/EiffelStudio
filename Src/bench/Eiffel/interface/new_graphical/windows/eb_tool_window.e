indexing
	description: "Window holding a unique tool"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_TOOL_WINDOW

inherit
	EV_WINDOW

	EB_TOOL_MANAGER

	EB_SHARED_INTERFACE_TOOLS

	INTERFACE_NAMES

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

feature -- Resize

	set_tool_size (t: like tool; new_width, new_height: INTEGER) is
		do
			set_size (new_width, new_height)
		end

	set_tool_width (t: like tool; new_width: INTEGER) is
		do
			set_width (new_width)
		end

	set_tool_height (t: like tool; new_height: INTEGER) is
		do
			set_height (new_height)
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

	build_windows_menu (a_menu: EV_MENU_ITEM_HOLDER) is
			-- Builds the standart windows items in `a_menu'
		local
			i: EV_MENU_ITEM
			create_class_cmd: EB_CREATE_CLASS_CMD
			create_feature_cmd: EB_CREATE_FEATURE_CMD
			create_object_cmd: EB_CREATE_OBJECT_CMD
			show_preferences: EB_SHOW_PREFERENCE_TOOL
			raise_project_tool: EB_RAISE_TOOL_CMD
		do
			create create_class_cmd.make (project_tool)
			create i.make_with_text (a_menu, m_New_class)
			i.add_select_command (create_class_cmd, Void)

			create create_feature_cmd.make (project_tool)
			create i.make_with_text (a_menu, m_New_routine)
			i.add_select_command (create_feature_cmd, Void)

			create create_object_cmd.make (project_tool)
			create i.make_with_text (a_menu, m_New_object)
			i.add_select_command (create_object_cmd, Void)

			create show_preferences.make
			create i.make_with_text (a_menu, m_Preferences)
			i.add_select_command (show_preferences, Void)

			create raise_project_tool.make (project_tool)
			create i.make_with_text (a_menu, m_Raise_project)
			i.add_select_command (raise_project_tool, Void)
		end	

end -- class EB_TOOL_WINDOW
