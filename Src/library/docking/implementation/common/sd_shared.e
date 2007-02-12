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
		require
			icons_set: icons_set
		do
			Result := internal_icons_cell.item
		ensure
			not_void: Result /= Void
		end

	interface_names: SD_INTERFACE_NAMES is
			-- All interface names
		do
			Result := internal_interface_names_cell.item
			if Result = Void then
				create {SD_DEFAULT_INTERFACE_NAMES} Result
				internal_interface_names_cell.put (Result)
			end
		ensure
			not_void: Result /= Void
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

	widget_factory: SD_WIDGET_FACTORY is
			-- SD_WIDGET_FACTORY instance.
		once
			create Result.make
		ensure
			not_void: Result /= Void
		end

	tool_bar_docker_mediator_cell: CELL [SD_TOOL_BAR_DOCKER_MEDIATOR] is
			-- Tool bar docker mediator when user dragging a SD_TOOL_BAR_ZONE.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	auto_hide_tab_slide_timer_interval: INTEGER is
			-- Auto hide tab slide timer interval
			-- 0 means no animation.
		do
			Result := Auto_hide_tab_slide_timer_interval_cell.item
		end

	tool_bar_font: EV_FONT is
			-- Tool bar font
		local
			l_color: SD_SYSTEM_COLOR
		once
			create {SD_SYSTEM_COLOR_IMP} l_color.make
			Result := l_color.tool_bar_font
		end

	notebook_tab_drawer: SD_NOTEBOOK_TAB_DRAWER_I is
			-- Drawer for notebook tabs.
		once
			create {SD_NOTEBOOK_TAB_DRAWER_IMP} Result.make
		end

	tool_bar_drawer: SD_TOOL_BAR_DRAWER is
			-- Drawer for tool bars.
		once
			create {SD_TOOL_BAR_DRAWER} Result.make
		end

	default_screen_x: INTEGER is
			-- Default floating screen x/y position for the zone's float feature first time be called.
		do
			Result := default_screen_x_cell.item
		end

	default_screen_y: INTEGER is
			-- Default floating screen x/y position for the zone's float feature first time be called.
		do
			Result := default_screen_y_cell.item
		end

	zone_navigation_accelerator_key: INTEGER is
			-- Accelerator key setting for zone navigation dialog.
			-- On Windows by default is Ctlr + Tab.
		do
			Result := zone_navigation_accelerator_key_cell.item
		end

feature -- Status report

	allow_window_to_back: BOOLEAN is
			-- Does allow SD_FLOATING_ZONE or SD_FLOATING_TOOL_BAR_ZONE to go to back of main window?
		do
			Result := allow_window_to_back_cell.item
		end

	show_all_feedback_indicator: BOOLEAN is
			-- If show all indicators same time when use transparent rectangle style feedback?
		do
			Result := show_all_feedback_indicator_cell.item
		end

	zone_navigation_accelerator_ctrl: BOOLEAN is
			-- Accelerator ctrl setting for zone navigation dialog.
			-- On Windows by default is Ctlr + Tab.
		do
			Result := zone_navigation_accelerator_ctrl_cell.item
		end

	zone_navigation_accelerator_alt: BOOLEAN is
			-- Accelerator alt setting for zone navigation dialog.
			-- On Windows by default is Ctlr + Tab.
		do
			Result := zone_navigation_accelerator_alt_cell.item
		end

	zone_navigation_accelerator_shift: BOOLEAN is
			-- Accelerator shift setting for zone navigation dialog.
			-- On Windows by default is Ctlr + Tab.
		do
			Result := zone_navigation_accelerator_shift_cell.item
		end

	icons_set: BOOLEAN is
			-- Is `icons' setted?
		do
			Result := internal_icons_cell.item /= Void
		end

feature -- Status setting

	set_icons (a_icons: like icons) is
			-- Set the SD_ICONS_SINGLETON instance.
		require
			a_icons_not_void: a_icons /= Void
		do
			internal_icons_cell.put (a_icons)
		ensure
			set: internal_icons_cell.item = a_icons
		end

	set_interface_names (a_names: like interface_names) is
			-- Set `internal_interface_names' with `a_names'
		require
			not_void: a_names /= Void
		do
			internal_interface_names_cell.put (a_names)
		ensure
			set: internal_interface_names_cell.item = a_names
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

	set_show_all_feedback_indicator (a_bool: BOOLEAN) is
			-- Set `show_all_feedback_indicator'.
		do
			show_all_feedback_indicator_cell.put (a_bool)
		ensure
			set: show_all_feedback_indicator = a_bool
		end

	set_auto_hide_tab_slide_timer_interval (a_int: INTEGER) is
			-- Set `auto_hide_tab_slide_timer_interval' with `a_int'.
		do
			auto_hide_tab_slide_timer_interval_cell.put (a_int)
		ensure
			set: auto_hide_tab_slide_timer_interval = a_int
		end

	set_tool_bar_docker_mediator (a_mediator: SD_TOOL_BAR_DOCKER_MEDIATOR) is
			-- Set tool bar docker mediator singleton.
		do
			tool_bar_docker_mediator_cell.put (a_mediator)
		ensure
			set: tool_bar_docker_mediator_cell.item = a_mediator
		end

	set_default_screen_x (a_x: INTEGER) is
			-- Set `default_screen_x'
		require
			valid: default_screen_x >= 0
		do
			default_screen_x_cell.put (a_x)
		ensure
			set: default_screen_x = a_x
		end

	set_default_screen_y (a_y: INTEGER) is
			-- Set `default_screen_y'
		require
			valid: default_screen_y >= 0
		do
			default_screen_y_cell.put (a_y)
		ensure
			set: default_screen_y = a_y
		end

	set_zone_navigation_accelerator_key (a_key: INTEGER) is
			-- Set `zone_navigation_accelerator_key' with `a_key'.
		do
			zone_navigation_accelerator_key_cell.put (a_key)
		ensure
			set: zone_navigation_accelerator_key = a_key
		end

	set_zone_navigation_accelerator_ctrl (a_bool: BOOLEAN) is
			-- Set `zone_navigation_accelerator_ctrl' with `a_bool'.
		do
			zone_navigation_accelerator_ctrl_cell.put (a_bool)
		ensure
			set: zone_navigation_accelerator_ctrl = a_bool
		end

	set_zone_navigation_accelerator_alt (a_bool: BOOLEAN) is
			-- Set `zone_navigation_accelerator_alt' with `a_bool'.
		do
			zone_navigation_accelerator_alt_cell.put (a_bool)
		ensure
			set: zone_navigation_accelerator_alt = a_bool
		end

	set_zone_navigation_accelerator_shift (a_bool: BOOLEAN) is
			-- Set `zone_navigation_accelerator_shift' with `a_bool'.
		do
			zone_navigation_accelerator_shift_cell.put (a_bool)
		ensure
			set: zone_navigation_accelerator_shift = a_bool
		end

feature  -- Colors

	non_focused_color: EV_COLOR is
			-- Non focuse color. Used by SD_TITLE_BAR...
		do
			Result := color.non_focused_color
		ensure
			not_void: Result /= Void
		end

	non_focused_title_color: EV_COLOR is
			-- Non focused color of window title bar.
		do
			Result := color.non_focused_title_color
		ensure
			not_void: Result /= Void
		end

	non_focused_title_text_color: EV_COLOR is
			-- Non focused title text color
		do
			Result := color.non_focused_title_text_color
		ensure
			not_void: Result /= Void
		end

	non_focused_color_lightness: EV_COLOR is
			-- Lighter `non_focused_color'.
		do
			Result := color.non_focused_color_lightness
		end

	focused_color: EV_COLOR is
			-- Focused color. Used by SD_TITLE_BAR...
		do
			Result := color.focused_color
		ensure
			not_void: Result /= Void
		end

	focused_title_text_color: EV_COLOR is
			-- Focused title bar text color. Used bt SD_TITLE_BAR.
		do
			Result := color.focused_title_text_color
		ensure
			not_void: Result /= Void
		end

	border_color: EV_COLOR is
			-- Border color, used by SD_TAB_STUB, SD_NOTEBOOK_TAB...
		do
			Result := color.border_color
		ensure
			not_void: Result /= Void
		end

	tab_text_color: EV_COLOR is
			-- Text color
		do
			Result := color.tab_text_color
		ensure
			not_void: Result /= Void
		end

	tool_tip_color: EV_COLOR is
			-- Tooltip color which is used by SD_NOTEBOOK_HIDE_DIALOG.
		do
			Result := color.tool_tip_color
		ensure
			not_void: Result /= Void
		end

	tool_bar_title_bar_color: EV_COLOR is
			-- Tool bar tilte bar color when tool bar floating.
		do
			Result := color.tool_bar_title_bar_color
		ensure
			not_void: Result /= Void
		end

	feedback_indicator_region_window_discard_color: EV_COLOR is
			-- Feedback indicator window region discard color.
		do
			Result := color.feedback_indicator_region_window_discard_color
		ensure
			not_void: Result /= Void
		end

	default_background_color: EV_COLOR is
			-- Default background color.
			-- Changed when theme changed
		do
			Result := color.default_background_color
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

	Line_width: INTEGER is 4
			-- Width of feedback line.

	Resize_bar_width_height: INTEGER is 5
			-- Resize bar width or height which is used by SD_RESIZE_BAR.

	title_bar_height: INTEGER is
			-- Size of zone's title bar.
		local
			l_platform: PLATFORM
		once
			create l_platform
			if l_platform.is_windows then
				Result := 18
			else
				-- For Linux is a little bit bigger.
				Result := 23
			end
		end

	Notebook_tab_height: INTEGER is 18
			-- Notebook tab height.

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

	Highlight_before_width: INTEGER is 4
			-- Title highlight area width before drawn title texts.

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

	Floating_title_bar_height: INTEGER is 15
			-- Height of SD_FLOATING_TOOL_BAR_ZONE's title bar.

	Notebook_minimum_width: INTEGER is 77
			-- Minimumu width for SD_NOTEBOOK, it's useful when a zone is minimized.	

	Zone_navigation_column_count: INTEGER is 8
			-- How many items per column in zone navigation dialog which is normally activated by Ctrl + Tab.

	Auto_hide_tab_stub_show_delay: INTEGER is 1000
			-- Auto hide tab stub delay time in milliseconds.

feature {SD_DOCKING_MANAGER} -- Implementation

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

feature {NONE} -- Implementation

	color: SD_COLORS is
			-- Colors query class.
		once
			create Result.make
		end

	internal_icons_cell: CELL [SD_ICONS_SINGLETON]
			-- Singleton cell for icons.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	internal_interface_names_cell: CELL [SD_INTERFACE_NAMES]
			-- Singleton cell for interface names.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	Show_all_feedback_indicator_cell: CELL [BOOLEAN] is
			-- Singleton cell for show_all_feedback_indicator.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	Auto_hide_tab_slide_timer_interval_cell: CELL [INTEGER] is
			-- Singleton cell for `Auto_hide_tab_slide_timer_interval'.
		once
			create Result
		ensure
			not_void: Result /= Void
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

	default_screen_x_cell: CELL [INTEGER] is
			-- Singleton cell for `default_screen_x'
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	default_screen_y_cell: CELL [INTEGER] is
			-- Singleton cell for `default_screen_y'
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	zone_navigation_accelerator_key_cell: CELL [INTEGER] is
			-- Singleton cell for `zone_navigation_accelerator_key'
		once
			create Result.put ({EV_KEY_CONSTANTS}.key_tab)
		end

	zone_navigation_accelerator_ctrl_cell: CELL [BOOLEAN] is
			-- Singleton cell for `zone_navigation_accelerator_ctrl'
		do
			create Result.put (True)
		end

	zone_navigation_accelerator_alt_cell: CELL [BOOLEAN] is
			-- Singleton cell for `zone_navigation_accelerator_alt'
		do
			create Result.put (False)
		end

	zone_navigation_accelerator_shift_cell: CELL [BOOLEAN] is
			-- Singleton cell for `zone_navigation_accelerator_shift'
		do
			create Result.put (False)
		end

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
