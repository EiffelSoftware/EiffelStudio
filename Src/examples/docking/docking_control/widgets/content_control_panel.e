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

create
	make

feature {NONE} -- Initialization

	make (a_manager: SD_DOCKING_MANAGER; a_window: like window)
			-- Set `docking_manager' with `a_manager'.
		require
			a_manager_not_void: a_manager /= Void
		do
			docking_manager := a_manager
			window := a_window
			build_panels

			default_create

			setup_widgets
		end

feature {NONE} -- Building panels

	build_panels
			-- Build attribute setting panel
		do
			create general_panel.make (docking_manager, window)

			create attribute_panel.make (docking_manager, window)

			create transform_panel.make (docking_manager, window)

			create tool_bar_control_panel.make (docking_manager, window)
		end

	setup_widgets
			-- Extend widgets to correspond containers
		do
			extend (general_panel)
			item_tab (general_panel).set_text ("General")

			extend (attribute_panel)
			item_tab (attribute_panel).set_text ("Attributes")

			extend (transform_panel)
			item_tab (transform_panel).set_text ("Transform")

			extend (tool_bar_control_panel)
			item_tab (tool_bar_control_panel).set_text ("Tool Bars")
		end

feature -- Query

	general_panel: GENERAL_SETTING_PANEL

	attribute_panel: ATTRIBUTE_SETTING_PANEL

	transform_panel: TRANSFORM_PANEL

	tool_bar_control_panel: TOOL_BAR_CONTROL_PANEL

--	is_window_set: BOOLEAN
--			-- If `internal_window' has been set?
--		do
--			Result := attached internal_window
--		end

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

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager

	window: MAIN_WINDOW
			-- Related window of Current
--		require
--			set: is_window_set
--		local
--			l_result: like internal_window
--		do
--			l_result := internal_window
--			check l_result /= Void end -- Implied by precondition
--			Result := l_result
--		ensure
--			not_void: Result /= Void
--		end

feature -- Element change

	content_focused (a_content: SD_CONTENT)
			-- Content focused
		require
			a_content_not_void: a_content /= Void
		do
			attribute_panel.content_focused (a_content)
			transform_panel.content_focused (a_content)
		end

--feature {NONE} -- Implementaion

--	internal_window: detachable MAIN_WINDOW
--			-- Related window of Current

;note
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
