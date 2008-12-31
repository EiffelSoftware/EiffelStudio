note
	description: "Control panel which hold sub widgets to control the target docking content."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONTENT_CONTROL_PANEL

inherit
	EV_NOTEBOOK

	DOCKING_MANAGER_HODLER
		undefine
			default_create, copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: SD_DOCKING_MANAGER; a_window: like window)
			-- Set `docking_manager' with `a_manager'.
		require
			a_manager_not_void: a_manager /= Void
		do
			default_create
			docking_manager := a_manager
			window := a_window
			build_panels
		end

feature {NONE} -- Building panels

	build_panels
			-- Build attribute setting panel.
		do
			create general_panel.make (docking_manager, window)
			extend (general_panel)
			item_tab (general_panel).set_text ("General")

			create attribute_panel.make (docking_manager, window)
			extend (attribute_panel)
			item_tab (attribute_panel).set_text ("Attributes")

			create transform_panel.make (docking_manager, window)
			extend (transform_panel)
			item_tab (transform_panel).set_text ("Transform")

			create tool_bar_control_panel.make (docking_manager, window)
			extend (tool_bar_control_panel)
			item_tab (tool_bar_control_panel).set_text ("Tool Bars")
		end

feature -- Access

	general_panel: GENERAL_SETTING_PANEL

	attribute_panel: ATTRIBUTE_SETTING_PANEL

	transform_panel: TRANSFORM_PANEL

	tool_bar_control_panel: TOOL_BAR_CONTROL_PANEL

feature -- Creation

	build_docking_tool_content
			-- Build docking tool.
		do
			general_panel.build_docking_tool_content
		end

	build_docking_editor_content
			-- Build docking editor
		do
			general_panel.build_docking_editor_content
		end

feature -- Element change

	content_focused (a_content: SD_CONTENT)
			-- Content focused
		require
			a_content_not_void: a_content /= Void
		do
			attribute_panel.content_focused (a_content)
			transform_panel.content_focused (a_content)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
