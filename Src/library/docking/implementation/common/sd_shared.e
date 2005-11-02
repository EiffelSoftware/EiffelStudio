indexing
	description: "Objects that get all the singletons in the super docking system."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SHARED

feature -- Access

	icons: SD_ICONS_SINGLETON is
			-- Get the SD_ICONS_SINGLETON instance.
		once
			Result := internal_icons
		ensure
			result_not_void: Result /= Void
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
			a_icons_set: internal_icons = a_icons
		end
		
	feedback: SD_FEEDBACK_DRAWER is
			-- Get the SD_DRAW_FEEDBACK instance which is draw things on the desktop.
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end
		
	docking_manager: SD_DOCKING_MANAGER is
			-- Get the SD_DOCKING_MANAGER instance.
		once
			Result := internal_docking_manager
		ensure
			result_not_void: Result /= Void
		end
	
	set_docking_manager (a_manager: like internal_docking_manager) is
			-- Set the docking manager instance.
		require
			a_manager_not_void: a_manager /= Void
			docking_manager_not_set: not docking_manager_set
		local
			l_dummy: like internal_docking_manager
		do
			internal_docking_manager := a_manager
			-- Init the once function
			l_dummy := docking_manager
		ensure
			a_manager_set: a_manager = internal_docking_manager
		end
		
	hot_zone_factory: SD_HOT_ZONE_ABSTRACT_FACTORY is
			-- Factory for different style hot zones.
		do
			Result := hot_zone_factory_cell.item
		ensure
			result_not_void: Result /= Void
		end
	
	set_hot_zone_factory (a_factory: like hot_zone_factory) is
			-- 
		require
			a_factory_not_void: a_factory /= Void
		do
			hot_zone_factory_cell.put (a_factory)
		end
		
	hot_zone_factory_cell: CELL [SD_HOT_ZONE_ABSTRACT_FACTORY] is
			-- Singleton factory cell.
		once
			create Result
		end
	
	allow_window_to_back_cell: CELL [BOOLEAN] is
			-- 
		once
			create Result
		end
		
	widget_factory: SD_WIDGET_FACTORY is
			-- 
		once
			create Result.make
		end
	
	allow_window_to_back: BOOLEAN is
			-- 
		do
			Result := allow_window_to_back_cell.item
		end
		
feature -- Contract Support
	
	docking_manager_set: BOOLEAN is
			-- Is `internal_docking_manager' attached?
		do
			Result := internal_docking_manager /= Void
		end
	
	icons_set: BOOLEAN is
			-- Is `icons' attached?
		do
			Result := internal_icons /= Void
		end
		
	direction_valid (a_direction: INTEGER): BOOLEAN is
			-- If `a_direction' valid?
		do
			Result := a_direction = dock_top or a_direction = dock_bottom or a_direction = dock_left or a_direction = dock_right or a_direction = dock_in
		end
	
	type_valid (a_type: INTEGER): BOOLEAN is
			-- If `a_type' valid?
		do
			Result := a_type = type_editor or a_type = type_normal
		end
		
feature -- Constants
	Auto_hide_panel_width: INTEGER is 25
			-- The width of auto hide panel.
	Line_width: INTEGER is 5
			-- The width of feedback line.
		
	Resize_bar_width_height: INTEGER is 5
			-- Resize bar width or height which is used by SD_RESIZE_BAR.
		
	Dock_top: INTEGER is 1
	Dock_bottom: INTEGER is 2
	Dock_left: INTEGER is 3
	Dock_right: INTEGER is 4
	Dock_in: INTEGER is 5
--	dock_last_direction: INTEGER is 6

	Type_normal: INTEGER is 1
		-- Normal hot zones which normal zones have.
	Type_editor: INTEGER is 2
		-- Editor hot zones which editor zones have.
		
	Menu_size: INTEGER is 23
		-- Size of menu.
	
	Default_floating_window_width: INTEGER is 300
	
	Default_floating_window_height: INTEGER is 300
	
	Default_docking_height_rate: REAL is 0.25
			-- When change from floating to docking, height := main container height * `default_docking_height_rate'.
	Default_docking_width_rate: REAL is 0.2
			-- When change from floating to docking, width := main container width * `default_docking_width_rate'.
	
feature {NONE} -- Implementation
	
	internal_docking_manager: SD_DOCKING_MANAGER
			-- The docking manager.
	
	internal_icons: SD_ICONS_SINGLETON
			-- The icons.

end
