indexing
	description: "Objects that contain all the singletons in the smart docking library."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SHARED

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
			-- Does allow SD_FLOATING_ZONE or SD_FLOATING_MENU_ZONE to go to back of main window?
		do
			Result := allow_window_to_back_cell.item
		end

	non_focused_color: EV_COLOR is
			-- Non focuse color. Used by SD_TITLE_BAR...
		local
			l_grid: EV_GRID
		once
			create l_grid
			Result := l_grid.non_focused_selection_color
			
		ensure
			not_void: Result /= Void
		end

	focused_color: EV_COLOR is
			-- Focused color. Used by SD_TITLE_BAR...
		local
			l_grid: EV_GRID
		once
			create l_grid
			Result := l_grid.focused_selection_color
		ensure
			not_void: Result /= Void
		end
	
--	border_color: EV_COLOR is
			-- Border color, used by SD_TAB_STUB, SD_NOTEBOOK_TAB...
--		local
			

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
			Result := a_type = type_editor or a_type = type_normal
		end

feature -- Constants

	Auto_hide_panel_lightness: REAL is 0.5
			-- Auto hide panel lightness value. Used by SD_AUTO_HIDE_PANEL.			

	Auto_hide_panel_size: INTEGER is 18
			-- Width of auto hide panel.

	Auto_hide_panel_gap_size: INTEGER is 4
			-- Auto hide panel's Gap size.

	Line_width: INTEGER is 5
			-- Width of feedback line.

	Resize_bar_width_height: INTEGER is 5
			-- Resize bar width or height which is used by SD_RESIZE_BAR.

	Type_normal: INTEGER is 1
			-- Normal hot zones which normal zones have.

	Type_editor: INTEGER is 2
			-- Editor hot zones which editor zones have.

	Title_bar_height: INTEGER is 18
			-- Size of zone's title bar.

	Menu_size: INTEGER is 23
			-- Size of menu.

	Default_floating_window_width: INTEGER is 300
			-- Default floating window width.

	Default_floating_window_height: INTEGER is 300
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

feature {NONE} -- Implementation

	internal_icons: SD_ICONS_SINGLETON
			-- Icons.

end
