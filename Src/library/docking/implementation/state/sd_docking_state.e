indexing
	description: "Objects that it is the restore object when docking in the main window."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_STATE
	
inherit
	SD_INNER_STATE
		redefine
			stick_window,
			float_window,
			change_zone_split_area,
			move_to_docking_zone,
			move_to_tab_zone,
			restore,
			close_window
		end

create
	make,
	make_for_tab_zone
	
feature {NONE}-- Initlization

	-- FIXIT: one creation method should call another creation method.
	make (a_content: SD_CONTENT; a_direction: INTEGER; a_width_height: INTEGER) is
			-- 
		require
			a_content_not_void: a_content /= Void
		do
			create internal_shared
			internal_direction := a_direction
			internal_width_height := a_width_height
			internal_content := a_content
			create internal_zone.make (a_content)
			internal_shared.docking_manager.add_zone (internal_zone)
		end
		
	make_for_tab_zone (a_content: SD_CONTENT; a_container: EV_CONTAINER) is
			-- 
		require
			a_content_not_void: a_content /= Void
			a_container_not_full: not a_container.full
		do
			create internal_shared
			internal_content := a_content
			create internal_zone.make (a_content)
			a_container.extend (internal_zone)
			internal_shared.docking_manager.add_zone (internal_zone)
		end
		
feature -- Perform Restore
	
	restore (a_content: SD_CONTENT; a_container: EV_CONTAINER) is
			-- 
		do
			make (a_content, 1, 1)
			a_container.extend (internal_zone)
			change_state (Current)
		end
		
	record_state is
			-- 
		do
			
		end
		
	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Perform a restore.
		local
			l_old_stuff: EV_WIDGET
			l_old_spliter: EV_SPLIT_AREA
			l_new_container: EV_SPLIT_AREA
		do
			internal_shared.docking_manager.lock_update
			
			if internal_zone.parent /= Void then
				internal_zone.parent.prune (internal_zone)
			end
			
			if a_multi_dock_area.full then
				l_old_stuff := a_multi_dock_area.item	
				l_old_spliter ?= l_old_stuff
				if l_old_spliter /= Void then
					a_multi_dock_area.save_spliter_position (l_old_spliter)	
				end
				a_multi_dock_area.prune (l_old_stuff)
			end
							
			if internal_direction = {SD_SHARED}.dock_left or internal_direction = {SD_SHARED}.dock_right then
				create {EV_HORIZONTAL_SPLIT_AREA} l_new_container
			else
				create {EV_VERTICAL_SPLIT_AREA} l_new_container
			end
			
			a_multi_dock_area.extend (l_new_container)
	
			if internal_direction = {SD_SHARED}.dock_left or internal_direction = {SD_SHARED}.dock_top then
				l_new_container.set_first (internal_zone)
				if l_old_stuff /= Void then
					l_new_container.set_second (l_old_stuff)
--					if l_new_container.maximum_split_position >= internal_width_height and l_new_container.minimum_split_position <= internal_width_height then
--						l_new_container.set_split_position (internal_width_height)
--					end	
					if internal_direction = {SD_SHARED}.dock_left then
						l_new_container.set_split_position ((l_new_container.maximum_split_position * internal_shared.default_docking_width_rate).ceiling)
					else	
						l_new_container.set_split_position ((l_new_container.maximum_split_position * internal_shared.default_docking_height_rate).ceiling)
					end
					
				end
			else
				l_new_container.set_second (internal_zone)						
				if l_old_stuff /= Void then
					l_new_container.set_first (l_old_stuff)	
					
--					if l_new_container.maximum_split_position >= internal_width_height and l_new_container.minimum_split_position <= internal_width_height then
--						l_new_container.set_split_position (l_new_container.maximum_split_position - internal_width_height)
--					end
					if internal_direction = {SD_SHARED}.dock_right then
						l_new_container.set_split_position ((l_new_container.maximum_split_position * (1 - internal_shared.default_docking_width_rate)).ceiling)
					else
						l_new_container.set_split_position ((l_new_container.maximum_split_position * (1 - internal_shared.default_docking_height_rate)).ceiling)
					end
				end

			end
							
			if l_old_spliter /= Void then
				a_multi_dock_area.restore_spliter_position (l_old_spliter)	
			end
			internal_shared.docking_manager.remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		end
	
	stick_window (a_direction: INTEGER) is
			-- 
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
			l_width_height: INTEGER
		do
			internal_shared.docking_manager.lock_update
			-- Change current content's internal_zone to a SD_AUTO_HIDE_ZONE.
			internal_shared.docking_manager.prune_zone (internal_zone)
			
			if a_direction = {SD_SHARED}.dock_left or a_direction = {SD_SHARED}.dock_right then
				l_width_height := internal_zone.width
			else
				l_width_height := (internal_shared.docking_manager.inner_container_main.height * 0.2).ceiling
			end
			
			-- Change state.
			create l_auto_hide_state.make_with_size (internal_content, internal_direction, l_width_height)
--			l_auto_hide_state.dock_at_top_level
			change_state (l_auto_hide_state)
			internal_shared.docking_manager.inner_container_main.remove_empty_split_area
			
			internal_shared.docking_manager.unlock_update
		end
	
	float_window (a_x, a_y: INTEGER) is
			-- Make current window floating.
		local
			l_floating_zone: SD_FLOATING_ZONE
			l_floating_state: SD_FLOATING_STATE
		do
			internal_shared.docking_manager.lock_update
		
			internal_shared.docking_manager.prune_zone (internal_zone)

			create l_floating_state.make_with_position (internal_content, a_x, a_y)

			change_state (l_floating_state)
			
			internal_shared.docking_manager.remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			-- 
		local
			l_docking_zone: SD_DOCKING_ZONE
			a_tab_zone: SD_TAB_ZONE
		do
			internal_shared.docking_manager.lock_update
			l_docking_zone ?= a_target_zone
			if l_docking_zone /= Void then
				change_zone_split_area_to_docking_zone (l_docking_zone, a_direction)
			end
			a_tab_zone ?= a_target_zone
			if a_tab_zone /= Void then
				change_zone_split_area_to_tab_zone (a_tab_zone, a_direction)
			end
			internal_shared.docking_manager.unlock_update
		end
		
	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE) is
			-- 
		local
			l_tab_state: SD_TAB_STATE
			l_split_area: EV_SPLIT_AREA
			l_split_position: INTEGER
			l_widget: EV_WIDGET
		do
			internal_shared.docking_manager.lock_update
			
--			l_split_area ?= internal_zone.parent
--			if l_split_area /= Void then
--				l_split_position := l_split_area.split_position
--			end
			
			prune_a_content_from_split_area
			create l_tab_state.make (internal_content, a_target_zone)
			
			internal_shared.docking_manager.remove_empty_split_area
			
--			if l_split_area /= Void then
--				l_widget ?= l_tab_state.zone
--				check l_widget /= Void end
--				l_split_area ?= l_widget.parent
--				check l_split_area /= Void end
--				l_split_area.set_split_position (l_split_position)
--			end
			change_state (l_tab_state)
			
			internal_shared.docking_manager.unlock_update
		end
	
	move_to_tab_zone (a_target_zone: SD_TAB_ZONE) is
			-- Move `internal_content' to `a_target_zone'.
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_shared.docking_manager.lock_update
			prune_a_content_from_split_area
			create l_tab_state.make_with_tab_zone (internal_content, a_target_zone)
			change_state (l_tab_state)
			internal_shared.docking_manager.remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		end
		
feature {NONE} -- Implementation

	close_window is
			-- 
		do
			internal_shared.docking_manager.lock_update
			internal_shared.docking_manager.prune_zone (internal_zone)
			internal_shared.docking_manager.remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		end
	
	prune_a_content_from_split_area is
			-- 
		do
			internal_shared.docking_manager.prune_zone (internal_zone)
		end
		
	change_zone_split_area_to_tab_zone (a_target_zone: SD_TAB_ZONE; a_direction: INTEGER) is
			-- 
		local
			l_new_split_area: EV_SPLIT_AREA
			l_old_spliter_position: INTEGER
			l_old_parent_split: EV_SPLIT_AREA
			l_target_zone_parent: EV_CONTAINER
		do
			-- First, remove current internal_zone from old parent split area.
			if internal_zone.parent /= Void then
				internal_zone.parent.prune (internal_zone)
			end
			 l_target_zone_parent := a_target_zone.parent
			 l_old_parent_split ?= a_target_zone.parent
			 check l_old_parent_split /= Void end
			l_old_spliter_position := l_old_parent_split.split_position
			a_target_zone.parent.prune (a_target_zone)
			
			-- Then, insert current internal_zone to new split area base on  `a_direction'.
			if a_direction = {SD_SHARED}.dock_top or a_direction = {SD_SHARED}.dock_bottom then
				create {EV_VERTICAL_SPLIT_AREA} l_new_split_area
			elseif a_direction = {SD_SHARED}.dock_left or a_direction = {SD_SHARED}.dock_right then
				create {EV_HORIZONTAL_SPLIT_AREA} l_new_split_area
			end
			
			if internal_zone.parent/= Void then
				internal_zone.parent.prune (internal_zone)
			end
			
			if a_target_zone.parent /= Void then
				a_target_zone.parent.prune (a_target_zone)
			end
--			check a_target_zone.parent.extendible end
			if a_direction = {SD_SHARED}.dock_top or a_direction = {SD_SHARED}.dock_left then
				l_new_split_area.set_first (internal_zone)
				l_new_split_area.set_second (a_target_zone)
			else				
				l_new_split_area.set_first (a_target_zone)
				l_new_split_area.set_second (internal_zone)					
			end
				
			l_target_zone_parent.extend (l_new_split_area)
			
			-- Maybe the parent split area not full when there is only two user widgets in `inner_container'
			-- And so at this time, there is only one widget in parent's area.
			if a_target_zone.parent.full then
				l_old_parent_split.set_proportion (0.5)
			end
			
			l_new_split_area.set_proportion (0.5)
			
			internal_shared.docking_manager.inner_container (internal_zone).remove_empty_split_area
		end
		
feature -- Properties

	internal_width_height: INTEGER
			-- Width of internal_zone if dock_left or dock_right.
			-- Height of internal_zone if dock_top or dock_bottom.
	zone: SD_ZONE is
			-- 
		do
			Result := internal_zone
		end

feature {NONE} -- Move to new split area implementation.

	change_zone_split_area_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_direction: INTEGER) is
			-- 
		local
			l_new_split_area: EV_SPLIT_AREA
			l_target_zone_parent: EV_CONTAINER
--			l_old_zone_parent_type: STRING
			l_target_zone_parent_split_position: INTEGER
			l_target_zone_parent_spliter: EV_SPLIT_AREA
--			l_multi_dock_area: SD_MULTI_DOCK_AREA
		do
--			l_multi_dock_area := internal_shared.docking_manager.inner_container(internal_zone)
			-- First, remove current internal_zone from old parent split area.	
			if internal_zone.parent /= Void then
--				l_old_zone_parent_type := internal_zone.parent.generating_type		
				internal_zone.parent.prune (internal_zone)
			end
			
			l_target_zone_parent := a_target_zone.parent
			if a_target_zone.parent /= Void then
				
				-- Remember target zone parent split position.
				l_target_zone_parent_spliter ?= a_target_zone.parent
				if l_target_zone_parent_spliter /= Void then
					l_target_zone_parent_split_position := l_target_zone_parent_spliter.split_position
				end
				a_target_zone.parent.prune (a_target_zone)
			end
			
			check not l_target_zone_parent.full end
			
			-- Then, insert current internal_zone to new split area base on  `a_direction'.
			if a_direction = {SD_SHARED}.dock_top or a_direction = {SD_SHARED}.dock_bottom then
				create {EV_VERTICAL_SPLIT_AREA} l_new_split_area
			elseif a_direction = {SD_SHARED}.dock_left or a_direction = {SD_SHARED}.dock_right then
				create {EV_HORIZONTAL_SPLIT_AREA} l_new_split_area
			end
			
			if a_direction = {SD_SHARED}.dock_top or a_direction = {SD_SHARED}.dock_left then
				l_new_split_area.set_first (internal_zone)
				l_new_split_area.set_second (a_target_zone)
			else				
				l_new_split_area.set_first (a_target_zone)
				l_new_split_area.set_second (internal_zone)		
			end
					
			l_target_zone_parent.extend (l_new_split_area)
			
			if l_target_zone_parent_spliter /= Void and then l_target_zone_parent_spliter.full then
				l_target_zone_parent_spliter.set_split_position (l_target_zone_parent_split_position)
			end			
			l_new_split_area.set_proportion (0.5)
			internal_shared.docking_manager.remove_empty_split_area
		end	
		
feature {NONE} -- States information
	
	internal_zone: SD_DOCKING_ZONE
			-- The internal_zone current is in.

end
