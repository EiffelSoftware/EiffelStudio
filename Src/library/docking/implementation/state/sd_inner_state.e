indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_INNER_STATE

inherit
	SD_STATE
		redefine
			min_max_window
		end
		
feature {NONE} -- Implementation

	min_max_window is
			-- 
		local
			l_main_area: SD_MULTI_DOCK_AREA
			l_split_area: EV_SPLIT_AREA
			l_zone_widget: EV_WIDGET
		do
			internal_shared.docking_manager.lock_update
			
			l_main_area := internal_shared.docking_manager.inner_container (zone)
			l_zone_widget ?= zone
			check l_zone_widget /= Void end			
			
			if not maximized then
				internal_main_area_widget := l_main_area.item

				internal_parent := l_zone_widget.parent
				l_split_area ?= internal_parent
				if l_split_area /= Void then
					internal_parent_split_position := l_split_area.split_position
				end
				internal_parent.prune (l_zone_widget)
				l_main_area.wipe_out
				
				l_main_area.extend (l_zone_widget)				
			else
				l_main_area.wipe_out
				internal_parent.extend (l_zone_widget)
				l_main_area.extend (internal_main_area_widget)
				
				l_split_area ?= internal_parent
				if l_split_area /= Void then
					l_split_area.set_split_position (internal_parent_split_position)
				end
				internal_main_area_widget := Void
				internal_parent := Void
			end

			maximized := not maximized
			
			internal_shared.docking_manager.unlock_update
		end
	--
	maximized: BOOLEAN
	internal_parent_split_position: INTEGER
	internal_main_area_widget: EV_WIDGET
	internal_parent: EV_CONTAINER	
	--

end
