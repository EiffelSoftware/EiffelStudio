note
	description: "Objects that contain all the singletons in Smart Docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SHARED

inherit
	REFACTORING_HELPER

feature -- Access

	icons: SD_ICONS_SINGLETON
			-- SD_ICONS_SINGLETON instance.
		local
			l_result: detachable like icons
		do
			l_result := internal_icons_cell.item
			if l_result = Void then
				create {SD_DEFAULT_ICONS} l_result.make
				internal_icons_cell.put (l_result)
			end
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	interface_names: SD_INTERFACE_NAMES
			-- All interface names
		local
			l_result: detachable like interface_names
		do
			l_result := internal_interface_names_cell.item
			if l_result = Void then
				create {SD_DEFAULT_INTERFACE_NAMES} l_result
				internal_interface_names_cell.put (l_result)
			end
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	feedback: SD_FEEDBACK_DRAWER
			-- SD_DRAW_FEEDBACK instance which is draw things on the desktop.
		once
			create Result.make
		ensure
			not_void: Result /= Void
		end

	hot_zone_factory: SD_HOT_ZONE_ABSTRACT_FACTORY
			-- Factory for different style hot zones.
		require
			set: is_hot_zone_factory_set
		local
			l_result: detachable like hot_zone_factory
		do
			l_result := hot_zone_factory_cell.item
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	widget_factory: SD_WIDGET_FACTORY
			-- SD_WIDGET_FACTORY instance.
		once
			create Result.make
		ensure
			not_void: Result /= Void
		end

	tool_bar_docker_mediator_cell: CELL [detachable SD_TOOL_BAR_DOCKER_MEDIATOR]
			-- Tool bar docker mediator when user dragging a SD_TOOL_BAR_ZONE.
		once
			create Result.put (Void)
		ensure
			not_void: Result /= Void
		end

	setter: SD_SYSTEM_SETTER
			-- System special handler
		once
			create {SD_SYSTEM_SETTER_IMP} Result
		end

	auto_hide_tab_slide_timer_interval: INTEGER
			-- Auto hide tab slide timer interval
			-- 0 means no animation.
		local
			l_system: SD_SYSTEM_SETTER
		do
			create {SD_SYSTEM_SETTER_IMP} l_system
			if not l_system.is_remote_desktop then
				Result := Auto_hide_tab_slide_timer_interval_cell.item
			else
				-- We disable auto hide animation in remote desktop
			end
		end

	tool_bar_font: EV_FONT
			-- Tool bar font
		require
			set: is_tool_bar_font_set
		local
			l_item: detachable like tool_bar_font
		do
			l_item := sizes.tool_bar_font_cell.item
			check l_item /= Void end -- Implied by precondition `is_tool_bar_font_set'
			Result := l_item
		ensure
			not_void: Result /= Void
		end

	notebook_tab_drawer: SD_NOTEBOOK_TAB_DRAWER_I
			-- Drawer for notebook tabs
		once
			create {SD_NOTEBOOK_TAB_DRAWER_IMP} Result.make
		end

	tool_bar_drawer: SD_TOOL_BAR_DRAWER
			-- Drawer for tool bars
		once
			create {SD_TOOL_BAR_DRAWER} Result.make
		end

	default_screen_x: INTEGER
			-- Default floating screen x/y position for the zone's float feature first time be called
		do
			Result := default_screen_x_cell.item
		end

	default_screen_y: INTEGER
			-- Default floating screen x/y position for the zone's float feature first time be called
		do
			Result := default_screen_y_cell.item
		end

	zone_navigation_accelerator_key: INTEGER
			-- Accelerator key setting for zone navigation dialog
			-- On Windows by default is Ctlr + Tab
		do
			Result := zone_navigation_accelerator_key_cell.item
		end

feature -- Right click menu items

	set_notebook_tab_area_menu_items_agent (a_agent: like notebook_tab_area_menu_items_agent)
			-- Set `notebook_tab_area_menu_items_agent' with `a_gent'
		do
			notebook_tab_area_menu_items_agent_cell.put (a_agent)
		ensure
			set: notebook_tab_area_menu_items_agent = a_agent
		end

	notebook_tab_area_menu_items_agent: detachable FUNCTION [ANY, TUPLE [SD_CONTENT], ARRAYED_LIST [EV_MENU_ITEM]]
			-- Menu items shown at notebook tab area
			-- Client programmers can customize the menu items here
			-- Same as `notebook_tab_area_menu_items' but has higer priority than `notebook_tab_area_menu_items'
		do
			Result := notebook_tab_area_menu_items_agent_cell.item
		end

	notebook_tab_area_menu_items: ARRAYED_LIST [EV_MENU_ITEM]
			-- Menu items shown at notebook tab area.
			-- Client programmers can customize the menu items here
		do
			Result := widget_factory.notebook_tab_area_menu_items
		ensure
			not_void: Result /= Void
		end

	set_title_bar_area_menu_items_agent (a_agent: like title_bar_area_menu_items_agent)
			-- Set `title_bar_area_menu_items_agent_cell' with `a_agent'
		do
			title_bar_area_menu_items_agent_cell.put (a_agent)
		ensure
			set: title_bar_area_menu_items_agent = a_agent
		end

	title_bar_area_menu_items_agent: detachable FUNCTION [ANY, TUPLE [SD_CONTENT], ARRAYED_LIST [EV_MENU_ITEM]]
			-- Menu items shown at {SD_CONTENT}'s title bar.
			-- Client programmers can customize the menu items here.	
			-- Same as `title_bar_area_menu_items' but has higer priority than `title_bar_area_menu_items
			-- Note: parameter SD_CONTENT maybe void if not found
		do
			Result := title_bar_area_menu_items_agent_cell.item
		end

	title_bar_area_menu_items: ARRAYED_LIST [EV_MENU_ITEM]
			-- Menu items shown at {SD_CONTENT}'s title bar.
			-- Client programmers can customize the menu items here.
		do
			Result := widget_factory.title_bar_area_menu_items
		ensure
			not_void: Result /= Void
		end

feature -- Status report

	allow_window_to_back: BOOLEAN
			-- Does allow SD_FLOATING_ZONE or SD_FLOATING_TOOL_BAR_ZONE to go to back of main window?
		do
			Result := allow_window_to_back_cell.item
		end

	show_all_feedback_indicator: BOOLEAN
			-- If show all indicators same time when use transparent rectangle style feedback?
		do
			Result := show_all_feedback_indicator_cell.item
		end

	show_all_tab_stub_text: BOOLEAN
			-- When more than one tab stubs stay together at side of main window, show inactive tab stub text?
		do
			Result := show_tab_stub_text_cell.item
		end

	zone_navigation_accelerator_ctrl: BOOLEAN
			-- Accelerator ctrl setting for zone navigation dialog.
			-- On Windows by default is Ctlr + Tab.
		do
			Result := zone_navigation_accelerator_ctrl_cell.item
		end

	zone_navigation_accelerator_alt: BOOLEAN
			-- Accelerator alt setting for zone navigation dialog.
			-- On Windows by default is Ctlr + Tab.
		do
			Result := zone_navigation_accelerator_alt_cell.item
		end

	zone_navigation_accelerator_shift: BOOLEAN
			-- Accelerator shift setting for zone navigation dialog.
			-- On Windows by default is Ctlr + Tab.
		do
			Result := zone_navigation_accelerator_shift_cell.item
		end

	icons_set: BOOLEAN
			-- Is `icons' has been set?
		do
			Result := internal_icons_cell.item /= Void
		end

	is_hot_zone_factory_set: BOOLEAN
			-- Is `hot_zone_factory' has been set?
		do
			Result := hot_zone_factory_cell.item /= Void
		end

	is_tool_bar_font_set: BOOLEAN
			-- Is tool bar singleton cell has been set?
		do
			Result := sizes.tool_bar_font_cell.item /= Void
		end

feature -- Status setting

	set_icons (a_icons: like icons)
			-- Set the SD_ICONS_SINGLETON instance
			-- Client programmers don't have to call this feature since SD_DEFAULT_ICONS will be used by default.
		require
			a_icons_not_void: a_icons /= Void
		do
			internal_icons_cell.put (a_icons)
		ensure
			set: internal_icons_cell.item = a_icons
		end

	set_interface_names (a_names: like interface_names)
			-- Set `internal_interface_names' with `a_names'
		require
			not_void: a_names /= Void
		do
			internal_interface_names_cell.put (a_names)
		ensure
			set: internal_interface_names_cell.item = a_names
		end

	set_hot_zone_factory (a_factory: like hot_zone_factory)
			-- Set `hot_zone_factory'
		require
			a_factory_not_void: a_factory /= Void
		do
			hot_zone_factory_cell.put (a_factory)
		ensure
			set: hot_zone_factory = a_factory
		end

	set_show_all_feedback_indicator (a_bool: BOOLEAN)
			-- Set `show_all_feedback_indicator'
		do
			show_all_feedback_indicator_cell.put (a_bool)
			is_set_show_all_feedback_indicator_called.put (True)
		ensure
			set: show_all_feedback_indicator = a_bool
		end

	set_allow_window_to_back (a_bool: BOOLEAN)
			-- Set `allow_window_to_back' with `a_bool'
		do
			allow_window_to_back_cell.put (a_bool)
		ensure
			set: allow_window_to_back = a_bool
		end

	set_auto_hide_tab_slide_timer_interval (a_int: INTEGER)
			-- Set `auto_hide_tab_slide_timer_interval' with `a_int'.
		do
			auto_hide_tab_slide_timer_interval_cell.put (a_int)
		ensure
			set: auto_hide_tab_slide_timer_interval_cell.item = a_int
		end

	set_show_tab_stub_text (a_bool: BOOLEAN)
			-- Set `show_tab_stub_text_cell' with `a_bool'
		do
			show_tab_stub_text_cell.put (a_bool)
			is_set_show_all_feedback_indicator_called.put (True)
		ensure
			set: show_all_tab_stub_text =  a_bool
		end

	set_default_screen_x (a_x: INTEGER)
			-- Set `default_screen_x'
		require
			valid: default_screen_x >= 0
		do
			default_screen_x_cell.put (a_x)
		ensure
			set: default_screen_x = a_x
		end

	set_default_screen_y (a_y: INTEGER)
			-- Set `default_screen_y'
		require
			valid: default_screen_y >= 0
		do
			default_screen_y_cell.put (a_y)
		ensure
			set: default_screen_y = a_y
		end

	set_zone_navigation_accelerator_key (a_key: INTEGER)
			-- Set `zone_navigation_accelerator_key' with `a_key'.
		do
			zone_navigation_accelerator_key_cell.put (a_key)
		ensure
			set: zone_navigation_accelerator_key = a_key
		end

	set_zone_navigation_accelerator_ctrl (a_bool: BOOLEAN)
			-- Set `zone_navigation_accelerator_ctrl' with `a_bool'.
		do
			zone_navigation_accelerator_ctrl_cell.put (a_bool)
		ensure
			set: zone_navigation_accelerator_ctrl = a_bool
		end

	set_zone_navigation_accelerator_alt (a_bool: BOOLEAN)
			-- Set `zone_navigation_accelerator_alt' with `a_bool'.
		do
			zone_navigation_accelerator_alt_cell.put (a_bool)
		ensure
			set: zone_navigation_accelerator_alt = a_bool
		end

	set_zone_navigation_accelerator_shift (a_bool: BOOLEAN)
			-- Set `zone_navigation_accelerator_shift' with `a_bool'.
		do
			zone_navigation_accelerator_shift_cell.put (a_bool)
		ensure
			set: zone_navigation_accelerator_shift = a_bool
		end

feature  -- Colors

	non_focused_color: EV_COLOR
			-- Non focuse color. Used by SD_TITLE_BAR...
		do
			Result := color.non_focused_color
		ensure
			not_void: Result /= Void
		end

	non_focused_title_color: EV_COLOR
			-- Non focused color of window title bar.
		do
			Result := color.non_focused_title_color
		ensure
			not_void: Result /= Void
		end

	non_focused_title_text_color: EV_COLOR
			-- Non focused title text color
		do
			Result := color.non_focused_title_text_color
		ensure
			not_void: Result /= Void
		end

	non_focused_color_lightness: EV_COLOR
			-- Lighter `non_focused_color'.
		do
			Result := color.non_focused_color_lightness
		end

	focused_color: EV_COLOR
			-- Focused color. Used by SD_TITLE_BAR...
		do
			Result := color.focused_color
		ensure
			not_void: Result /= Void
		end

	focused_title_text_color: EV_COLOR
			-- Focused title bar text color. Used bt SD_TITLE_BAR.
		do
			Result := color.focused_title_text_color
		ensure
			not_void: Result /= Void
		end

	border_color: EV_COLOR
			-- Border color, used by SD_TAB_STUB, SD_NOTEBOOK_TAB...
		do
			Result := color.border_color
		ensure
			not_void: Result /= Void
		end

	tab_text_color: EV_COLOR
			-- Text color
		do
			Result := color.tab_text_color
		ensure
			not_void: Result /= Void
		end

	tool_tip_color: EV_COLOR
			-- Tooltip color which is used by SD_NOTEBOOK_HIDE_DIALOG.
		do
			Result := color.tool_tip_color
		ensure
			not_void: Result /= Void
		end

	tool_bar_title_bar_color: EV_COLOR
			-- Tool bar tilte bar color when tool bar floating.
		do
			Result := color.tool_bar_title_bar_color
		ensure
			not_void: Result /= Void
		end

	feedback_indicator_region_window_discard_color: EV_COLOR
			-- Feedback indicator window region discard color.
		do
			Result := color.feedback_indicator_region_window_discard_color
		ensure
			not_void: Result /= Void
		end

	default_background_color: EV_COLOR
			-- Default background color.
			-- Changed when theme changed
		do
			Result := color.default_background_color
		end

feature -- Constants

	Border_width: INTEGER = 1
			-- Border widht, used by SD_TITLE_BARs, SD_TAB_STUBs, SD_NOTEBOOK_TABs....

	Auto_hide_panel_lightness: REAL = 0.5
			-- Auto hide panel lightness value. Used by SD_AUTO_HIDE_PANEL.			

	Auto_hide_panel_size: INTEGER
			-- Width of auto hide panel.
		do
			Result := sizes.auto_hide_panel_size_cell.item
		end

	Auto_hide_panel_gap_size: INTEGER = 4
			-- Auto hide panel's Gap size.

	Line_width: INTEGER = 4
			-- Width of feedback line.

	Resize_bar_width_height: INTEGER = 5
			-- Resize bar width or height which is used by SD_RESIZE_BAR.

	title_bar_height: INTEGER
			-- Size of zone's title bar.
		do
			Result := sizes.title_bar_height_cell.item
		end

	Notebook_tab_height: INTEGER
			-- Notebook tab height.
		do
			Result := sizes.notebook_tab_height_cell.item
		end

	Notebook_tab_maximum_size: INTEGER
			-- Maximum size of a notebook tab.
			-- If the title on the tab would exceed this size, it is cropped.
		do
			Result := sizes.notebook_tab_maximum_size_cell.item
		end

	tab_zone_upper_minimum_height: INTEGER
			-- SD_TAB_ZONE_UPPER and SD_DOCKING_ZONE_UPPER's minimum height.
		do
			Result := notebook_tab_height + 5
		end

	zone_minimum_width: INTEGER
			-- Minimum width of a zone.
		do
			Result := sizes.zone_minimum_width_cell.item
		end

	zone_minimum_height: INTEGER
			-- Minimum height of a zone.
		do
			Result := sizes.zone_minimum_height_cell.item
		end

	Tool_bar_size: INTEGER
			-- Size of tool bar. When horizontal the size is height. When vertical the size is width.
			-- Note: SD_WIDGET_TOOL_BAR's size may bigger than this size when font size is very small.
			-- For example, on Linux Desktop when using font Scans 8.
		do
			Result := sizes.tool_bar_size_cell.item
		end

	Tool_bar_border_width: INTEGER
			-- Tool bar border width
		do
			Result := sizes.tool_bar_border_width_cell.item
		end

	Tool_bar_hidden_item_dialog_max_width: INTEGER = 400
			-- Tool bar hidden item dialog maximum allowed width.

	Tool_bar_customize_dialog_default_width: INTEGER = 560
			-- Tool bar customize dialog default width.

	Tool_bar_customize_dialog_default_height: INTEGER = 360
			-- Tool bar customize dialog default height.

	Default_floating_window_width: INTEGER = 470
			-- Default floating window width.

	Default_floating_window_height: INTEGER = 280
			-- Default floating window height.

	Default_docking_height_rate: REAL = 0.25
			-- When change from floating to docking, height := main container height * `default_docking_height_rate'.

	Default_docking_width_rate: REAL = 0.2
			-- When change from floating to docking, width := main container width * `default_docking_width_rate'.

	Auto_hide_delay: INTEGER = 2000
			-- When SD_AUTO_HIDE_ZONE show but no focused, time to hide SD_AUTO_HIDE_ZONE.

	Focuse_border_width: INTEGER = 1
			-- Border width of a zone. This is width show focus color surround a zone.

	Highlight_before_width: INTEGER = 4
			-- Title highlight area width before drawn title texts.

	Highlight_tail_width: INTEGER = 30
			-- Tilte highlight area width which shown color chang gradually.

	Hide_tab_indicator_size: INTEGER = 20
			-- Hide tab indicator size. Hide tabs are tabs in SD_NOTEBOOK_TAB_AREA.

	title_bar_text_start_x: INTEGER = 0
			-- When title bar drawing text, start x position.

	title_bar_text_start_y: INTEGER
			-- When title bar drawing text, start y position.
		do
			Result := sizes.title_bar_text_start_y_cell.item
		end

	Padding_width: INTEGER = 4
			-- Padding width used by whole system.

	Feedback_tab_width: INTEGER = 60
			-- When user dragging, the width of feedback rectangle for tab.

	Notebook_minimum_width: INTEGER = 77
			-- Minimumu width for SD_NOTEBOOK, it's useful when a zone is minimized.	

	Zone_navigation_column_count: INTEGER = 8
			-- How many items per column in zone navigation dialog which is normally activated by Ctrl + Tab.

	Auto_hide_tab_stub_show_delay: INTEGER = 1000
			-- Auto hide tab stub delay time in milliseconds.

	Editor_place_holder_content_name: STRING_32
			-- Content name for `place_holder_content' in SD_DOCKING_MANAGER_ZONES.
		once
			Result := "docking manager editor place holder"
		ensure
			Result_not_void: Result /= Void
		end

feature {SD_DOCKING_MANAGER, SD_TOOL_BAR_DRAGGING_AGENTS, SD_TOOL_BAR_DOCKER_MEDIATOR, SD_SIZES,
		SD_GENERIC_TOOL_BAR, SD_TOOL_BAR_ZONE, SD_TITLE_BAR, SD_NOTEBOOK, SD_AUTO_HIDE_PANEL, SD_WIDGET_FACTORY,
		SD_TITLE_BAR_TITLE, SD_NOTEBOOK_TAB} -- Implementation

	set_tool_bar_docker_mediator (a_mediator: detachable SD_TOOL_BAR_DOCKER_MEDIATOR)
			-- Set tool bar docker mediator singleton.
		do
			tool_bar_docker_mediator_cell.put (a_mediator)
		ensure
			set: tool_bar_docker_mediator_cell.item = a_mediator
		end

	add_docking_manager (a_manager: SD_DOCKING_MANAGER)
			-- Set `internal_docking_manager'.
		require
			a_manager_not_void: a_manager /= Void
		do
			docking_manager_list.extend (a_manager)
		ensure
			added: docking_manager_list.has (a_manager)
		end

	docking_manager_list: ARRAYED_LIST [SD_DOCKING_MANAGER]
			-- All docking managers
		once
			create Result.make (1)
		ensure
			not_void: Result /= Void
		end

	is_set_show_all_feedback_indicator_called: CELL [BOOLEAN]
			-- If `set_show_all_feedback_indicator' has been called?
		once
			create Result.put (False)
		ensure
			not_void: Result /= Void
		end

	is_set_show_tab_stub_text_called: CELL [BOOLEAN]
			-- If `set_show_tab_stub_text' has been called?
		once
			create Result.put (False)
		ensure
			not_void: Result /= Void
		end

	widgets: SD_WIDGETS_LISTS
			-- Widget lists.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	drag_offset: INTEGER = 3
			-- How many pixels user's pointer moved before calling drag actions

feature {NONE} -- Implementation

	color: SD_COLORS
			-- Colors query class.
		once
			create Result.make
		end

	sizes: SD_SIZES
			-- Sizes query class.
		once
			create Result.make
		end

	internal_icons_cell: CELL [detachable SD_ICONS_SINGLETON]
			-- Singleton cell for icons.
		once
			create Result.put (Void)
		ensure
			not_void: Result /= Void
		end

	internal_interface_names_cell: CELL [detachable SD_INTERFACE_NAMES]
			-- Singleton cell for interface names.
		once
			create Result.put (Void)
		ensure
			not_void: Result /= Void
		end

	Show_all_feedback_indicator_cell: CELL [BOOLEAN]
			-- Singleton cell for show_all_feedback_indicator.
		once
			create Result.put (False)
		ensure
			not_void: Result /= Void
		end

	Auto_hide_tab_slide_timer_interval_cell: CELL [INTEGER]
			-- Singleton cell for `Auto_hide_tab_slide_timer_interval'.
		once
			create Result.put (0)
		ensure
			not_void: Result /= Void
		end

	hot_zone_factory_cell: CELL [detachable SD_HOT_ZONE_ABSTRACT_FACTORY]
			-- Hot zone factory cell.
		once
			create Result.put (Void)
		ensure
			not_void: Result /= Void
		end

	allow_window_to_back_cell: CELL [BOOLEAN]
			-- Cell hold `allow_window_to_back'.
		once
			create Result.put (False)
		ensure
			not_void: Result /= Void
		end

	show_tab_stub_text_cell: CELL [BOOLEAN]
			-- Cell hold `show_tab_stub_text'.
		once
			create Result.put (False)
		ensure
			not_void: Result /= Void
		end

	default_screen_x_cell: CELL [INTEGER]
			-- Singleton cell for `default_screen_x'
		once
			create Result.put (0)
		ensure
			not_void: Result /= Void
		end

	default_screen_y_cell: CELL [INTEGER]
			-- Singleton cell for `default_screen_y'
		once
			create Result.put (0)
		ensure
			not_void: Result /= Void
		end

	zone_navigation_accelerator_key_cell: CELL [INTEGER]
			-- Singleton cell for `zone_navigation_accelerator_key'
		once
			create Result.put ({EV_KEY_CONSTANTS}.key_tab)
		end

	zone_navigation_accelerator_ctrl_cell: CELL [BOOLEAN]
			-- Singleton cell for `zone_navigation_accelerator_ctrl'
		once
			create Result.put (True)
		end

	zone_navigation_accelerator_alt_cell: CELL [BOOLEAN]
			-- Singleton cell for `zone_navigation_accelerator_alt'
		once
			create Result.put (False)
		end

	zone_navigation_accelerator_shift_cell: CELL [BOOLEAN]
			-- Singleton cell for `zone_navigation_accelerator_shift'
		once
			create Result.put (False)
		end

	title_bar_area_menu_items_agent_cell: CELL [detachable FUNCTION [ANY, TUPLE [SD_CONTENT], ARRAYED_LIST [EV_MENU_ITEM]]]
			-- Singleton cell for `title_bar_area_menu_items_agent'
		once
			create Result.put (Void)
		end

	notebook_tab_area_menu_items_agent_cell: CELL [detachable FUNCTION [ANY, TUPLE [SD_CONTENT], ARRAYED_LIST [EV_MENU_ITEM]]]
			-- Singleton cell for `notebook_tab_area_menu_items_agent'
		once
			create Result.put (Void)
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
