indexing
	description: "Objects that represent the state when SD_CONTENT in a SD_TAB_ZONE."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TAB_STATE

inherit
	SD_INNER_STATE
		redefine
			stick_window,
			change_zone_split_area,
			float_window,
			move_to_tab_zone,
			move_to_docking_zone,
			dock_at_top_level
		end
create 
	make,
	make_with_tab_zone

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_target_zone: SD_DOCKING_ZONE) is
			-- Creation method
		require
			a_content_not_void: a_content /= Void
			a_content_parent_void: a_content.user_widget.parent = Void
		local
			l_parent: EV_CONTAINER
			l_target_zone_tab_state: SD_TAB_STATE
			l_old_split_position: INTEGER
			l_old_parent_split: BOOLEAN
			l_split_parent: EV_SPLIT_AREA
		do
			create internal_shared
			if a_target_zone.is_parent_split then
				l_old_split_position := a_target_zone.parent_split_position
				l_old_parent_split := True
			end
			l_parent := a_target_zone.parent
			internal_shared.docking_manager.prune_zone (a_target_zone)
			internal_tab_zone := internal_shared.widget_factory.tab_zone (a_content, a_target_zone)
			internal_shared.docking_manager.add_zone (internal_tab_zone)
			internal_content := a_content
			
			l_parent.extend (internal_tab_zone)
			
			create l_target_zone_tab_state.make_with_tab_zone (a_target_zone.content, internal_tab_zone)
			a_target_zone.content.change_state (l_target_zone_tab_state)
			-- At the end, add `a_content', so `a_content' is selected on SD_TAB_ZONE.
			internal_tab_zone.extend (a_content)
			internal_shared.docking_manager.remove_empty_split_area
			if l_old_parent_split  then
				l_split_parent ?= internal_tab_zone.parent
				check l_split_parent /= Void end
				if l_split_parent.minimum_split_position <= l_old_split_position and l_split_parent.maximum_split_position >= l_old_split_position then
					l_split_parent.set_split_position (l_old_split_position)
				end

			end
		ensure
			a_content_set: a_content = internal_content
		end
	
	make_with_tab_zone (a_content: SD_CONTENT; a_target_zone: SD_TAB_ZONE) is
			-- 
		require
			a_content_not_void: a_content /= Void
			a_target_zone: a_target_zone /= Void
		do
			create internal_shared
			internal_content := a_content
			internal_tab_zone := a_target_zone
			if internal_content.user_widget.parent /= Void then
				internal_content.user_widget.parent.prune (internal_content.user_widget)
			end
			internal_tab_zone.extend (internal_content)
		end
		
feature 

	restore (a_content: SD_CONTENT; a_container: EV_CONTAINER) is
			-- 
		do
		end
		
	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- 

		do
			internal_shared.docking_manager.lock_update
			
			if drag_title_bar then
				dock_whole_at_top_level (a_multi_dock_area)
			else
				dock_tab_at_top_level (a_multi_dock_area)
			end

			internal_shared.docking_manager.remove_empty_split_area
			internal_shared.docking_manager.unlock_update	
		end
		
	record_state is
			-- 
		do
			
		end
	
	stick_window (a_direction: INTEGER) is
			-- 
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE

		do
			create l_auto_hide_state.make (internal_content, a_direction)
			l_auto_hide_state.dock_at_top_level (internal_shared.docking_manager.inner_container_main)
			
			change_state (l_auto_hide_state)
			
			internal_tab_zone.disable_handle_select_tab
			internal_tab_zone.prune (internal_content)
			internal_tab_zone.enable_handle_select_tab
			update_last_content_state
			
		end
	
	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			-- 
		local
			l_docking_state: SD_DOCKING_STATE
			l_docking_zone: SD_DOCKING_ZONE
		do
			internal_shared.docking_manager.lock_update
			if not internal_drag_title_bar then
				internal_tab_zone.disable_handle_select_tab
				internal_tab_zone.prune (internal_content)			
															-- FIXIT: should be the size base on a_direction
				create l_docking_state.make (internal_content, a_direction, internal_tab_zone.width)
				l_docking_state.change_zone_split_area (a_target_zone, a_direction)
				change_state (l_docking_state)
				
				update_last_content_state
				internal_tab_zone.enable_handle_select_tab				
			else
				l_docking_zone ?= a_target_zone
				if l_docking_zone /= Void then
					change_zone_split_area_to_docking_zone (l_docking_zone, a_direction)
				end
				
			end
			internal_shared.docking_manager.unlock_update
		end
	
	update_last_content_state is
			-- If there only on content left, then change it's state to SD_DOCKING_STATE
		local
			l_parent: EV_CONTAINER
			l_docking_state: SD_DOCKING_STATE
			l_split_position: INTEGER
			l_split_area: EV_SPLIT_AREA
			l_widget: EV_WIDGET
		do
			if internal_tab_zone.count = 1 then
				l_split_area ?= internal_tab_zone.parent
				if l_split_area /= Void then
					l_split_position := l_split_area.split_position
				end
				l_parent := internal_tab_zone.parent
				internal_shared.docking_manager.prune_zone (internal_tab_zone)
				create l_docking_state.make_for_tab_zone (internal_tab_zone.last_content, l_parent)
				internal_tab_zone.last_content.change_state (l_docking_state)
			
				if l_split_area /= Void then
					l_widget ?= l_docking_state.zone
					check l_widget /= Void end
					l_split_area ?= l_widget.parent
					check l_split_area /= Void end
					if l_split_area.minimum_split_position <= l_split_position and l_split_area.maximum_split_position >= l_split_position then
						l_split_area.set_split_position (l_split_position)
					end
				end
			end			
		end
	
	float_window (a_x, a_y: INTEGER) is
			--
		local
			l_float_state: SD_FLOATING_STATE
		do
			internal_shared.docking_manager.lock_update
			
			if not internal_drag_title_bar then
				internal_tab_zone.prune (internal_content)
				create l_float_state.make_with_position (internal_content, a_x, a_y)
				change_state (l_float_state)
				
				
				update_last_content_state
								
			end
			
			internal_shared.docking_manager.remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		end
	
	move_to_tab_zone (a_target_zone: SD_TAB_ZONE) is
			-- 
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_tab_state: SD_TAB_STATE
		do
			internal_shared.docking_manager.lock_update
			internal_tab_zone.disable_handle_select_tab
			if internal_drag_title_bar then
				internal_shared.docking_manager.prune_zone (internal_tab_zone)
				
				l_contents := internal_tab_zone.contents
				from 
					l_contents.start
				until
					l_contents.after
				loop
					if l_contents.item.user_widget.parent /= Void then
						l_contents.item.user_widget.parent.prune (l_contents.item.user_widget)
					end
					create l_tab_state.make_with_tab_zone (l_contents.item, a_target_zone)
--					l_tab_state.dock_at_top_level 
					l_contents.item.change_state (l_tab_state)
					l_contents.forth
				end
				l_tab_state.select_tab (internal_content)				
			else
				move_tab_to_tab_zone (a_target_zone)
			end

			internal_tab_zone.enable_handle_select_tab
			internal_shared.docking_manager.unlock_update
		end
		
	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE) is
			-- 

		do
			internal_shared.docking_manager.lock_update
			
			if internal_drag_title_bar then
				move_whole_to_docking_zone (a_target_zone)
			else				
				move_tab_to_docking_zone (a_target_zone)
			end

			internal_shared.docking_manager.unlock_update
		end
	

		
		
feature {SD_TAB_STATE}

	select_tab (a_content: SD_CONTENT) is
			-- Enable select one tab.
		require
			has_content: 
		do
			internal_tab_zone.select_item (a_content)
		end	
		
feature -- Properties
	zone: SD_TAB_ZONE is
			-- 
		do
			Result := internal_tab_zone
		end
		
	tab_zone: like internal_tab_zone is
			-- 
		do
			Result := internal_tab_zone
		end
	
	drag_title_bar: BOOLEAN is
			-- 
		do
			Result := internal_drag_title_bar
		end
	
	set_drag_title_bar (a_value: BOOLEAN) is
			-- 
		do
			internal_drag_title_bar := a_value
		end
		
feature {NONE}  -- Implementation

	first_move_to_docking_zone: BOOLEAN
			-- When move `Current' to a docking zone, first time is different.


	internal_tab_zone: SD_TAB_ZONE
	
	internal_drag_title_bar: BOOLEAN
			-- If user dragging title bar? Otherwise user drag a tab.


	change_zone_split_area_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_direction: INTEGER) is
			-- This routine copy from SD_DOCKING_STATE, only change internal_zone to internal_tab_zone.
		local
			l_new_split_area: EV_SPLIT_AREA
			l_target_zone_parent: EV_CONTAINER
			l_old_zone_parent_type: STRING
			l_target_zone_parent_split_position: INTEGER
			l_target_zone_parent_spliter: EV_SPLIT_AREA
		do
			-- First, remove current internal_zone from old parent split area.	
			if  internal_tab_zone.parent /= Void then
				l_old_zone_parent_type := internal_tab_zone.parent.generating_type		
				internal_tab_zone.parent.prune (internal_tab_zone)
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
				l_new_split_area.set_first (internal_tab_zone)
				l_new_split_area.set_second (a_target_zone)
			else				
				l_new_split_area.set_first (a_target_zone)
				l_new_split_area.set_second (internal_tab_zone)		
			end
					
			l_target_zone_parent.extend (l_new_split_area)
			
				l_new_split_area.set_proportion (0.5)

			if l_target_zone_parent_spliter /= Void and then l_target_zone_parent_spliter.full then
				l_target_zone_parent_spliter.set_split_position (l_target_zone_parent_split_position)
			end			

			internal_shared.docking_manager.inner_container (internal_tab_zone).remove_empty_split_area
		end	
	
	move_whole_to_docking_zone (a_target_zone: SD_DOCKING_ZONE) is
			-- Move whole tab area to a docking zone.
		local
			l_tab_state: SD_TAB_STATE
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_tab_zone: SD_TAB_ZONE	
			l_is_split: BOOLEAN
			l_split_position: INTEGER
			l_split: EV_SPLIT_AREA
		do
		
			internal_shared.docking_manager.prune_zone (zone)
			if a_target_zone.is_parent_split then
				l_is_split := True
				l_split_position := a_target_zone.parent_split_position
			end
			l_contents := internal_tab_zone.contents
			from 
				l_contents.start
				first_move_to_docking_zone := True
			until
				l_contents.after
			loop
				if first_move_to_docking_zone then
					if l_contents.item.user_widget.parent /= Void then
						l_contents.item.user_widget.parent.prune (l_contents.item.user_widget)
					end
					create l_tab_state.make (l_contents.item, a_target_zone)
					l_contents.item.change_state (l_tab_state)					
					first_move_to_docking_zone := False
				else
					l_tab_zone ?= l_tab_state.zone
					create l_tab_state.make_with_tab_zone (l_contents.item, l_tab_zone)
				end
				l_contents.forth
			end	
			l_tab_state.select_tab (internal_content)			
			
			if l_is_split then
				l_split ?= l_tab_state.zone.parent
				check l_split /= Void end
				l_split.set_split_position (l_split_position)
			end
		end
		
	move_tab_to_docking_zone (a_target_zone: SD_DOCKING_ZONE) is
			-- Move one tab from a tab zone to a docking zone.
--		require
--			a_target_zone_widget_parent_void: a_target_zone.content.user_widget.parent = Void
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_tab_zone.disable_handle_select_tab
			internal_tab_zone.prune (internal_content)
			if internal_content.user_widget.parent /= Void then
				internal_content.user_widget.parent.prune (internal_content.user_widget)	
			end
			create l_tab_state.make (internal_content, a_target_zone)
			change_state (l_tab_state)
			update_last_content_state
			internal_tab_zone.enable_handle_select_tab
		end
	
	move_tab_to_tab_zone (a_target_zone: SD_TAB_ZONE) is
			-- 
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_tab_zone.disable_handle_select_tab
			internal_tab_zone.prune (internal_content)
			create l_tab_state.make_with_tab_zone (internal_content, a_target_zone)
			change_state (l_tab_state)
			update_last_content_state
			internal_tab_zone.enable_handle_select_tab
		end
		
	dock_whole_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- 
		local
			l_old_stuff: EV_WIDGET
			l_old_spliter: EV_SPLIT_AREA
			l_new_container: EV_SPLIT_AREA
		do
			internal_tab_zone.parent.prune (internal_tab_zone)
			if a_multi_dock_area.full then
				l_old_stuff := a_multi_dock_area.item	
--				l_old_spliter ?= l_old_stuff
--				if l_old_spliter /= Void then
--					internal_shared.docking_manager.inner_container.save_spliter_position (l_old_spliter)	
--				end
				a_multi_dock_area.prune (l_old_stuff)
			end
							
			if internal_direction = {SD_SHARED}.dock_left or internal_direction = {SD_SHARED}.dock_right then
				create {EV_HORIZONTAL_SPLIT_AREA} l_new_container
			else
				create {EV_VERTICAL_SPLIT_AREA} l_new_container
			end
			
			if internal_direction = {SD_SHARED}.dock_left or internal_direction = {SD_SHARED}.dock_top then
				l_new_container.set_first ( internal_tab_zone)
				if l_old_stuff /= Void then
					l_new_container.set_second (l_old_stuff)
--					l_new_container.set_split_position (internal_width_height)
				end
			else
				l_new_container.set_second (internal_tab_zone)						
				if l_old_stuff /= Void then
					l_new_container.set_first (l_old_stuff)	
					if internal_direction = {SD_SHARED}.dock_right then
						-- maximum_split_position NOT work at the time.
--						l_new_container.set_split_position (l_new_container.maximum_split_position - internal_width_height)
--						l_new_container.set_split_position (internal_shared.docking_manager.inner_container.width - internal_width_height)
					else
--						l_new_container.set_split_position (internal_shared.docking_manager.inner_container.height - internal_width_height)
					end

				end

			end
							
			a_multi_dock_area.extend (l_new_container)
--			if l_old_spliter /= Void then
--				internal_shared.docking_manager.inner_container.restore_spliter_position (l_old_spliter)	
--			end						
		end
		
	dock_tab_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- 
		local
			l_width_height: INTEGER
			l_docking_state: SD_DOCKING_STATE
		do	
			internal_tab_zone.disable_handle_select_tab
			
			if internal_direction = {SD_SHARED}.dock_left or internal_direction = {SD_SHARED}.dock_right then
				l_width_height := (a_multi_dock_area.width * 0.2).ceiling
			else
				l_width_height := (a_multi_dock_area.height * 0.2).ceiling
			end
			
			internal_tab_zone.contents.prune (internal_content)
			create l_docking_state.make (internal_content, internal_direction, l_width_height)
			l_docking_state.dock_at_top_level (a_multi_dock_area)
			change_state (l_docking_state)
			
			update_last_content_state
			
			internal_tab_zone.enable_handle_select_tab
		end
		
end
