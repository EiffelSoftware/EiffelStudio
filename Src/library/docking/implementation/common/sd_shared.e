indexing
	description: "Objects that contain all the singletons in the smart docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SHARED

inherit
	REFACTORING_HELPER

feature -- Access

	icons: SD_ICONS_SINGLETON is
			-- SD_ICONS_SINGLETON instance.
		once
			Result := internal_icons
		ensure
			not_void: Result /= Void
		end

	set_icons (a_icons: like internal_icons) is
			-- Get the SD_ICONS_SINGLETON instance.
		require
			the_icons_void: not icons_set
		local
			l_dummy: like internal_icons
		do
			internal_icons := a_icons
			-- Set the once function
			l_dummy := icons
		ensure
			set: internal_icons = a_icons
		end

	feedback: SD_FEEDBACK_DRAWER is
			-- SD_DRAW_FEEDBACK instance which is draw things on the desktop.
		once
			create Result.make
		ensure
			not_void: Result /= Void
		end

	hot_zone_factory: SD_HOT_ZONE_ABSTRACT_FACTORY is
			-- Factory for different style hot zones.
		do
			Result := hot_zone_factory_cell.item
		ensure
			not_void: Result /= Void
		end

	set_hot_zone_factory (a_factory: like hot_zone_factory) is
			-- Set `hot_zone_factory'.
		require
			a_factory_not_void: a_factory /= Void
		do
			hot_zone_factory_cell.put (a_factory)
		ensure
			set: hot_zone_factory = a_factory
		end

	hot_zone_factory_cell: CELL [SD_HOT_ZONE_ABSTRACT_FACTORY] is
			-- Hot zone factory cell.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	allow_window_to_back_cell: CELL [BOOLEAN] is
			-- Cell hold `allow_window_to_back'.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	widget_factory: SD_WIDGET_FACTORY is
			-- SD_WIDGET_FACTORY instance.
		once
			create Result.make
		ensure
			not_void: Result /= Void
		end

	allow_window_to_back: BOOLEAN is
			-- Does allow SD_FLOATING_ZONE or SD_FLOATING_TOOL_BAR_ZONE to go to back of main window?
		do
			Result := allow_window_to_back_cell.item
		end

	tool_bar_docker_mediator_cell: CELL [SD_TOOL_BAR_DOCKER_MEDIATOR] is
			-- Tool bar docker mediator when user dragging a SD_TOOL_BAR_ZONE.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	set_tool_bar_docker_mediator (a_mediator: SD_TOOL_BAR_DOCKER_MEDIATOR) is
			-- Set tool bar docker mediator singleton.
		do
			tool_bar_docker_mediator_cell.put (a_mediator)
		ensure
			set: tool_bar_docker_mediator_cell.item = a_mediator
		end

	show_all_feedback_indicator: BOOLEAN is
			-- If show all indicators same time when use transparent rectangle style feedback?
		do
			Result := show_all_feedback_indicator_cell.item
		end

	set_show_all_feedback_indicator (a_bool: BOOLEAN) is
			-- Set `show_all_feedback_indicator'.
		do
			show_all_feedback_indicator_cell.put (a_bool)
		ensure
			set: show_all_feedback_indicator = a_bool
		end

feature  -- Colors

	non_focused_color: EV_COLOR is
			-- Non focuse color. Used by SD_TITLE_BAR...
		local
			l_system_color: SD_SYSTEM_COLOR
		once
			create {SD_SYSTEM_COLOR_IMP} l_system_color.make
			Result := l_system_color.non_focused_selection_color
		ensure
			not_void: Result /= Void
		end

	non_focused_title_color: EV_COLOR is
			-- Non focused color of window title bar.
		local
			l_system_color: SD_SYSTEM_COLOR
		do
			create {SD_SYSTEM_COLOR_IMP} l_system_color.make
			Result := l_system_color.non_focused_selection_title_color
		ensure
			not_void: Result /= Void
		end

	non_focused_title_text_color: EV_COLOR is
			--
		local
			l_system_color: SD_SYSTEM_COLOR
		do
			create {SD_SYSTEM_COLOR_IMP} l_system_color.make
			Result := l_system_color.non_focused_title_text_color
		end

	non_focused_color_lightness: EV_COLOR is
			-- Lighter `non_focused_color'.
		local
			l_helper: SD_COLOR_HELPER
			l_cell: EV_CELL
		once
			create l_helper
			create l_cell
			Result := l_helper.build_color_with_lightness (l_cell.background_color, Auto_hide_panel_lightness)
		end

	focused_color: EV_COLOR is
			-- Focused color. Used by SD_TITLE_BAR...
		local
			l_system_color: SD_SYSTEM_COLOR
		do
			create {SD_SYSTEM_COLOR_IMP} l_system_color.make
			Result := l_system_color.focused_selection_color
		ensure
			not_void: Result /= Void
		end

	focused_title_text_color: EV_COLOR is
			-- Focused title bar text color. Used bt SD_TITLE_BAR.
		local
			l_system_color: SD_SYSTEM_COLOR
		do
			create {SD_SYSTEM_COLOR_IMP} l_system_color.make
			Result := l_system_color.focused_title_text_color
		ensure
			not_void: Result /= Void
		end

	border_color: EV_COLOR is
			-- Border color, used by SD_TAB_STUB, SD_NOTEBOOK_TAB...
		local
			l_sys_color: SD_SYSTEM_COLOR
		once
			create {SD_SYSTEM_COLOR_IMP} l_sys_color.make
			Result := l_sys_color.active_border_color
		ensure
			not_void: Result /= Void
		end

	tab_text_color: EV_COLOR is
			-- Text color
		local
			l_sys_color: SD_SYSTEM_COLOR
		once
			to_implement ("if theme changed .... We should change color. theme_change actions in EV_APPLICATION")
			create {SD_SYSTEM_COLOR_IMP} l_sys_color.make
			Result := l_sys_color.button_text_color
		end

	tool_tip_color: EV_COLOR is
			-- Tooltip color which is used by SD_NOTEBOOK_HIDE_DIALOG.
		local
			l_text_box: EV_TEXT_FIELD
		once
			create l_text_box
			Result :=  l_text_box.background_color
		end

	tool_bar_title_bar_color: EV_COLOR is
			-- Tool bar tilte bar color when tool bar floating.
		once
			create Result
			Result.set_rgb (132 / 255, 130 / 255, 132 / 255)
		ensure
			not_void: Result /= Void
		end

	feedback_indicator_region_window_discard_color: EV_COLOR is
			-- Feedback indicator window region discard color.
		once
			create Result.make_with_rgb (1, 1, 1)
		end

feature {SD_DOCKING_MANAGER}

	add_docking_manager (a_manager: SD_DOCKING_MANAGER) is
			-- Set `internal_docking_manager'.
		require
			a_manager_not_void: a_manager /= Void
		do
			docking_manager_list.extend (a_manager)
		ensure
			added: docking_manager_list.has (a_manager)
		end

	docking_manager_list: ARRAYED_LIST [SD_DOCKING_MANAGER] is
			-- All docking managers.
		once
			create Result.make (1)
		ensure
			not_void: Result /= Void
		end

feature -- Contract Support

	icons_set: BOOLEAN is
			-- Is `icons' setted?
		do
			Result := internal_icons /= Void
		end

	type_valid (a_type: INTEGER): BOOLEAN is
			-- If `a_type' valid?
		do
			Result := a_type = type_editor or a_type = type_tool
		end

feature -- Constants

	Border_width: INTEGER is 1
			-- Border widht, used by SD_TITLE_BARs, SD_TAB_STUBs, SD_NOTEBOOK_TABs....

	Auto_hide_panel_lightness: REAL is 0.5
			-- Auto hide panel lightness value. Used by SD_AUTO_HIDE_PANEL.			

	Auto_hide_panel_size: INTEGER is 20
			-- Width of auto hide panel.

	Auto_hide_panel_gap_size: INTEGER is 4
			-- Auto hide panel's Gap size.

	Line_width: INTEGER is 2
			-- Width of feedback line.

	Resize_bar_width_height: INTEGER is 5
			-- Resize bar width or height which is used by SD_RESIZE_BAR.

	Title_bar_height: INTEGER is 16
			-- Size of zone's title bar.

	Zone_minmum_width: INTEGER is
			-- Minmum width of a zone.
		once
			Result := Title_bar_height * 5
		end

	Zone_minmum_height: INTEGER is
			-- Minmum height of a zone.
		once
			Result := Title_bar_height + 1
		end

	Tool_bar_size: INTEGER is 24
			-- Size of tool bar. When horizontal the size is height. When vertical the size is width.

	Tool_bar_hidden_item_dialog_max_width: INTEGER is 400
			-- Tool bar hidden item dialog maximum allowed width.

	Tool_bar_border_width: INTEGER is
			--
		do
			Result := 10
		end

	Default_floating_window_width: INTEGER is 470
			-- Default floating window width.

	Default_floating_window_height: INTEGER is 280
			-- Default floating window height.

	Default_docking_height_rate: REAL is 0.25
			-- When change from floating to docking, height := main container height * `default_docking_height_rate'.

	Default_docking_width_rate: REAL is 0.2
			-- When change from floating to docking, width := main container width * `default_docking_width_rate'.

	Auto_hide_delay: INTEGER is 2000
			-- When SD_AUTO_HIDE_ZONE show but no focused, time to hide SD_AUTO_HIDE_ZONE.

	Focuse_border_width: INTEGER is 1
			-- Border width of a zone. This is width show focus color surround a zone.

	Highlight_tail_width: INTEGER is 30
			-- Tilte highlight area width which shown color chang gradually.

	Hide_tab_indicator_size: INTEGER is 20
			-- Hide tab indicator size. Hide tabs are tabs in SD_NOTEBOOK_TAB_AREA.

	Drawing_area_icons_start_x: INTEGER is 0
			-- When drawing area draw a icon, start x position.

	Drawing_area_icons_start_y: INTEGER is 2
			-- When drawing area draw a icon, start y position.

	Padding_width: INTEGER is 6
			-- Padding width used by whold system.

	Feedback_tab_width: INTEGER is 60
			-- When user dragging, the width of feedback rectangle for tab.

	Floating_title_bar_height: INTEGER is 13
			-- Height of SD_FLOATING_TOOL_BAR_ZONE's title bar.

feature -- Zone type constants

	Type_tool: INTEGER is 1
			-- Normal hot zones which normal zones have.

	Type_editor: INTEGER is 2
			-- Editor hot zones which editor zones have.

feature {NONE} -- Implementation

	internal_icons: SD_ICONS_SINGLETON;
			-- Icons.

	show_all_feedback_indicator_cell: CELL [BOOLEAN] is
			-- Singleton cell for show_all_feedback_indicator.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

indexing
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
