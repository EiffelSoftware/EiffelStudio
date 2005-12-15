indexing
	description: "Docking manager commands."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_COMMAND

create
	make

feature {NONE}  -- Initlization
	
	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- Commands

	resize is
			-- Resize fixed area.
		local
			l_widget: EV_WIDGET
		do
			l_widget := internal_docking_manager.internal_viewport
			internal_docking_manager.agents.on_resize (l_widget.x_position, l_widget.y_position, l_widget.width, l_widget.height)
		end

	lock_update is
			-- Lock window update.
		do
			if (create {EV_ENVIRONMENT}).application.locked_window = Void then
				internal_docking_manager.main_window.lock_update
			end
			lock_call_time := lock_call_time + 1
		end

	unlock_update is
			-- Unlock window update.
		do
			remove_empty_split_area
			update_title_bar
			lock_call_time := lock_call_time - 1
			if lock_call_time = 0 then
				internal_docking_manager.main_window.unlock_update
			end
		end

	add_inner_container (a_area: SD_MULTI_DOCK_AREA) is
			-- Add `a_area'.
		require
			a_area_not_void: a_area /= Void
		do
			internal_docking_manager.inner_containers.extend (a_area)
		end

	prune_inner_container (a_area: SD_MULTI_DOCK_AREA) is
			-- Prune `a_area'.
		require
			a_area_not_void: a_area /= Void
			a_area_not_first_one: not is_main_inner_container (a_area)
		do
			internal_docking_manager.inner_containers.start
			internal_docking_manager.inner_containers.prune (a_area)
		end

	remove_empty_split_area  is
			-- Remove empty split area in SD_MULTI_DOCK_AREA.
		local
			l_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
		do
			from
				l_containers := internal_docking_manager.inner_containers
				l_containers.start
			until
				l_containers.after
			loop
				if l_containers.item /= Void then
					l_containers.item.remove_empty_split_area
				end
				l_containers.forth
			end
		end

	remove_auto_hide_zones is
			-- Remove all auto hide zones in `zones'.
		local
			l_auto_hide_zone: SD_AUTO_HIDE_ZONE
			l_zones_snapshot: ARRAYED_LIST [SD_ZONE]
		do
			l_zones_snapshot := internal_docking_manager.zones.zones.twin
			from
				l_zones_snapshot.start
			until
				l_zones_snapshot.after
			loop
				l_auto_hide_zone ?= l_zones_snapshot.item
				if l_auto_hide_zone /= Void then
					internal_docking_manager.zones.zones.prune (l_auto_hide_zone)
					l_auto_hide_zone.content.state.record_state
					internal_docking_manager.fixed_area.prune (l_auto_hide_zone)
				end
				l_zones_snapshot.forth
			end
		ensure
			no_auto_hide_zone_left: internal_docking_manager.fixed_area.count = 1
		end

	recover_normal_state is
			-- Recover all zone's state to normal state.
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
		do
			from
				l_zones := internal_docking_manager.zones.zones
				l_zones.start
			until
				l_zones.after
			loop
				l_zones.item.recover_to_normal_state
				l_zones.forth
			end
		end

	update_title_bar is
			-- Update all title bar.
		local
			l_inner_container_snapshot: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
		do
			l_inner_container_snapshot := internal_docking_manager.inner_containers.twin
			from
				l_inner_container_snapshot.start
			until
				l_inner_container_snapshot.after
			loop
				if l_inner_container_snapshot.item /= Void then
					l_inner_container_snapshot.item.update_title_bar
				end
					l_inner_container_snapshot.forth
			end
		end		

feature -- Contract Support
	
	is_main_inner_container (a_container: SD_MULTI_DOCK_AREA): BOOLEAN is
			-- If `a_container' is main contianer?
		do
			Result := internal_docking_manager.query.is_main_inner_container (a_container)
		end
		
feature {NONE}  -- Implementation
	
	lock_call_time: INTEGER
			-- Used for remember how many times client call `lock_update'.
			
	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

invariant
	
	internal_docking_manager_not_void: internal_docking_manager /= Void

end
