indexing
	description: "Objects that remember resotre information when floating."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FLOATING_STATE

inherit
	SD_STATE
		redefine
			change_zone_split_area,
			stick_window,
			move_to_docking_zone,
			move_to_tab_zone
		end
		
create
	make, make_with_position

feature {NONE} -- Initlization
	make (a_content: SD_CONTENT) is
			-- Creation method.
		require
			a_content_not_void: a_content /= Void
		do
			create internal_shared
			internal_content := a_content
			create internal_zone.make 
			internal_zone.set_size (internal_shared.default_floating_window_width, internal_shared.default_floating_window_height)
			internal_zone.set_title (internal_content.title)
--			l_window.close_request_actions.extend (agent handle_close_window)
			if internal_content.user_widget.parent /= Void then
				internal_content.user_widget.parent.prune (internal_content.user_widget)
			end
--			internal_zone.extend (internal_content.user_widget)
			internal_zone.show
			internal_zone.move_actions.extend (agent handle_move_window)
			
	--FIXIT: should add a new SD_MULTI_DOCK_AREA here.					
--			internal_shared.docking_manager.add_zone (internal_zone)
		end
	
	make_with_position (a_content: SD_CONTENT; a_x, a_y: INTEGER) is
			-- 
		do
			make (a_content)
			internal_zone.set_position (a_x, a_y)
		end
		
feature -- Perform Restore
	restore (a_content: SD_CONTENT; a_container: EV_CONTAINER) is
			-- 
		do
		end
		
	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- 
		local
--			l_old_widget: EV_WIDGET
			l_docking_state: SD_DOCKING_STATE
			l_width_height: INTEGER
		do
			internal_shared.docking_manager.lock_update
			-- FIXIT: shoudl prune the SD_MULTI_DOCK_AREA here.
--			internal_shared.docking_manager.prune_zone (internal_zone)
			internal_zone.destroy
			if 	internal_direction	= {SD_SHARED}.dock_left or internal_direction = {SD_SHARED}.dock_right then
				l_width_height := (a_multi_dock_area.width * internal_shared.default_docking_width_rate).ceiling
			else
				l_width_height := (a_multi_dock_area.height * internal_shared.default_docking_height_rate).ceiling
			end
			create l_docking_state.make (internal_content, internal_direction, l_width_height)
			l_docking_state.dock_at_top_level (a_multi_dock_area)
			change_state (l_docking_state)
			internal_shared.docking_manager.unlock_update
		end
	
	record_state is
			-- 
		do
			
		end
		
feature {NONE} -- Implementation
	
	internal_zone: SD_FLOATING_ZONE
	
	handle_close_window is
			-- Handle user clicked the close button on the floating window.
		do
			
		end
	
	handle_move_window (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle user drag the window.
		do
			
		end
	
	stick_window (a_direction: INTEGER) is
			-- 
		local
--			l_auto_hide_state: SD_AUTO_HIDE_STATE
		do
--			internal_shared.docking_manager.prune_zone (internal_zone)
--			
--			internal_zone.destroy
--			create l_auto_hide_state.make (internal_content, a_direction)
--			l_auto_hide_state.dock_at_top_level (internal_shared.docking_manager.inner_container_main)
--			change_state (l_auto_hide_state)
		end
		
	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			-- Change `Current' to a docking zone.
		local
			l_docking_zone: SD_DOCKING_ZONE
		do
			l_docking_zone ?= a_target_zone
			if l_docking_zone /= Void then
				move_to_docking_zone_imp (l_docking_zone, a_direction)
			end
		end
	
	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE) is
			-- 
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_shared.docking_manager.lock_update
			
--			internal_shared.docking_manager.prune_zone (internal_zone)
			internal_zone.destroy
			create l_tab_state.make (internal_content, a_target_zone)
--			l_tab_state.dock_at_top_level
			change_state (l_tab_state)		
			internal_shared.docking_manager.unlock_update	
		end
	
	move_to_tab_zone (a_target_zone: SD_TAB_ZONE) is
			-- 
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_shared.docking_manager.lock_update
			
			-- FIXIT: shoudl prune the SD_MULTI_DOCK_AREA here.
--			internal_shared.docking_manager.prune_zone (internal_zone)
			internal_zone.destroy
			create l_tab_state.make_with_tab_zone (internal_content, a_target_zone)
--			l_tab_state.dock_at_top_level
			change_state (l_tab_state)	
			internal_shared.docking_manager.unlock_update		
		end
		
feature {NONE} -- Implementation

	move_to_docking_zone_imp (a_target_zone: SD_DOCKING_ZONE; a_direction: INTEGER) is
			-- 
		local
			l_old_zone_width_height: INTEGER
			l_old_width, l_old_height: INTEGER
			l_docking_state: SD_DOCKING_STATE
		do
			-- First, remove current zone from old parent split area.
			l_old_width := internal_zone.width
			l_old_height := internal_zone.height
			-- FIXIT: shoudl prune the SD_MULTI_DOCK_AREA here.
--			internal_shared.docking_manager.prune_zone (internal_zone)

			if a_direction = {SD_SHARED}.dock_left or a_direction = {SD_SHARED}.dock_right then
				l_old_zone_width_height := l_old_width
			else
				l_old_zone_width_height := l_old_height
			end	
					
			create l_docking_state.make (internal_content, a_direction, l_old_zone_width_height)
			change_state (l_docking_state)
			l_docking_state.change_zone_split_area (a_target_zone, a_direction)
			
			internal_zone.destroy
		end
feature {SD_DOCKING_MANAGER}
--	xml_element (node: XM_ELEMENT) is
--		do
--		end
feature -- Properties
	zone: SD_ZONE is
			-- 
		do
--			Result := internal_zone
		end
		
end
