indexing
	description: "SD_INNER_STATE which is docking in SD_MULTI_DOCK_AREA."
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
			zone,
			change_title
		end

create
	make,
	make_for_tab_zone

feature {NONE}-- Initlization

	make (a_content: SD_CONTENT; a_direction: INTEGER; a_width_height: INTEGER) is
			-- Creation method.
		require
			a_content_not_void: a_content /= Void
		do
			create internal_shared
--			normal_max_able := True
			direction := a_direction
			internal_width_height := a_width_height
			internal_content := a_content
			create zone.make (a_content)
			internal_shared.docking_manager.add_zone (zone)
		ensure
			set: internal_content = a_content
			set: direction = a_direction
			set: internal_width_height = a_width_height
		end

	make_for_tab_zone (a_content: SD_CONTENT; a_container: EV_CONTAINER; a_direction: INTEGER) is
			-- Creation method for SD_TAB_STATE.
		require
			a_content_not_void: a_content /= Void
			a_container_not_void: a_container /= Void
			a_container_not_full: not a_container.full
		do
			make (a_content, a_direction, 0)
			a_container.extend (zone)
		ensure
			extended: a_container.has (zone)
		end

feature -- Redefine.

	restore (a_titles: ARRAYED_LIST [STRING]; a_container: EV_CONTAINER; a_direction: INTEGER) is
			-- Redefine.
		local
			l_content: SD_CONTENT
		do
			create internal_shared
			a_titles.start
			l_content := internal_shared.docking_manager.content_by_title (a_titles.item)
			make (l_content, {SD_DOCKING_MANAGER}.dock_left, 1)
			a_container.extend (zone)
			change_state (Current)
			direction := a_direction
		end

	record_state is
			-- Redefine.
		do

		end

	change_title (a_title: STRING; a_content: SD_CONTENT) is
			-- Redefine.
		do
			zone.set_title (a_title)
		ensure then
			set: zone.title = a_title
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Redefine.
		local
			l_old_stuff: EV_WIDGET
			l_old_spliter: EV_SPLIT_AREA
			l_new_container: EV_SPLIT_AREA
		do
			internal_shared.docking_manager.lock_update

			if zone.parent /= Void then
				zone.parent.prune (zone)
			end

			if a_multi_dock_area.full then
				l_old_stuff := a_multi_dock_area.item
				l_old_spliter ?= l_old_stuff
				if l_old_spliter /= Void then
					a_multi_dock_area.save_spliter_position (l_old_spliter)
				end
				a_multi_dock_area.prune (l_old_stuff)
			end

			if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
				create {EV_HORIZONTAL_SPLIT_AREA} l_new_container
			else
				create {EV_VERTICAL_SPLIT_AREA} l_new_container
			end

			a_multi_dock_area.extend (l_new_container)

			if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_top then
				l_new_container.set_first (zone)
				if l_old_stuff /= Void then
					l_new_container.set_second (l_old_stuff)
					if direction = {SD_DOCKING_MANAGER}.dock_left then
						l_new_container.set_split_position ((l_new_container.maximum_split_position * internal_shared.default_docking_width_rate).ceiling)
					else
						l_new_container.set_split_position ((l_new_container.maximum_split_position * internal_shared.default_docking_height_rate).ceiling)
					end
				end
			else
				l_new_container.set_second (zone)
				if l_old_stuff /= Void then
					l_new_container.set_first (l_old_stuff)
					if direction = {SD_DOCKING_MANAGER}.dock_right then
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
		ensure then
			is_dock_at_top: old a_multi_dock_area.full implies is_dock_at_top (a_multi_dock_area)
		end

	stick_window (a_direction: INTEGER) is
			-- Redefine.
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
			l_width_height: INTEGER
		do
			internal_shared.docking_manager.lock_update
			-- Change current content's zone to a SD_AUTO_HIDE_ZONE.
			internal_shared.docking_manager.prune_zone (zone)

			if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
				l_width_height := zone.width
			else
				l_width_height := zone.height
				if zone.height > (internal_shared.docking_manager.inner_container_main.height * 0.5).ceiling then
					l_width_height := (internal_shared.docking_manager.inner_container_main.height * 0.2).ceiling
				end
				debug ("larry")
					io.put_string ("%N SD_DOCKING_STATE stick window. l_width_height " + l_width_height.out)
				end
			end
				debug ("larry")
					io.put_string ("%N SD_DOCKING_STATE stick window. a_direction " + a_direction.out)
				end
			-- Change state.
			create l_auto_hide_state.make_with_size (internal_content, direction, l_width_height)
			change_state (l_auto_hide_state)
			internal_shared.docking_manager.inner_container_main.remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		ensure then
			state_changed: content.state /= Current
		end

	float_window (a_x, a_y: INTEGER) is
			-- Redefine.
		local
			l_floating_state: SD_FLOATING_STATE
			l_orignal_multi_dock_area: SD_MULTI_DOCK_AREA
		do
			internal_shared.docking_manager.lock_update
			l_orignal_multi_dock_area := internal_shared.docking_manager.inner_container (zone)

			create l_floating_state.make (a_x, a_y)
			dock_at_top_level (l_floating_state.inner_container)
			l_floating_state.update_title_bar
			l_orignal_multi_dock_area.update_title_bar
			internal_shared.docking_manager.remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		ensure then
			floated: old zone.parent /= zone.parent
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			-- Redefine.
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
			internal_shared.docking_manager.inner_container (a_target_zone).update_title_bar
			internal_shared.docking_manager.unlock_update
		ensure then
			parent_changed: old zone.parent /= zone.parent
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE) is
			-- Redefine.
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_shared.docking_manager.lock_update
			internal_shared.docking_manager.prune_zone (zone)
			create l_tab_state.make (internal_content, a_target_zone, direction)
			l_tab_state.set_direction (a_target_zone.state.direction)
			internal_shared.docking_manager.remove_empty_split_area
			change_state (l_tab_state)
			internal_shared.docking_manager.unlock_update
		ensure then
			state_changed: content.state /= Current
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE) is
			-- Redefine.
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_shared.docking_manager.lock_update
			internal_shared.docking_manager.prune_zone (zone)
			create l_tab_state.make_with_tab_zone (internal_content, a_target_zone, direction)
			change_state (l_tab_state)
			internal_shared.docking_manager.remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		ensure then
			state_changed: content.state /= Current
		end

	zone: SD_DOCKING_ZONE
			-- Redefine.

feature {NONE} -- Implementation

	change_zone_split_area_to_tab_zone (a_target_zone: SD_TAB_ZONE; a_direction: INTEGER) is
			-- Change zone split area to tab zone.
		require
			a_target_zone_not_void: a_target_zone /= Void
		local
			l_new_split_area: EV_SPLIT_AREA
			l_target_parent_spliter_position: INTEGER
			l_target_parent_split: EV_SPLIT_AREA
			l_target_zone_parent: EV_CONTAINER
		do
			internal_shared.docking_manager.lock_update
			-- First, remove current zone from old parent split area.
			if zone.parent /= Void then
				zone.parent.prune (zone)
			end
			 l_target_zone_parent := a_target_zone.parent
			 l_target_parent_split ?= a_target_zone.parent

			 if l_target_parent_split /= Void then
			 	l_target_parent_spliter_position := l_target_parent_split.split_position
			 end
			a_target_zone.parent.prune (a_target_zone)

			-- Then, insert current zone to new split area base on  `a_direction'.
			if a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom then
				create {EV_VERTICAL_SPLIT_AREA} l_new_split_area
			elseif a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
				create {EV_HORIZONTAL_SPLIT_AREA} l_new_split_area
			end
			if zone.parent/= Void then
				zone.parent.prune (zone)
			end
			if a_target_zone.parent /= Void then
				a_target_zone.parent.prune (a_target_zone)
			end
			if a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_left then
				l_new_split_area.set_first (zone)
				l_new_split_area.set_second (a_target_zone)
			else
				l_new_split_area.set_first (a_target_zone)
				l_new_split_area.set_second (zone)
			end
			l_target_zone_parent.extend (l_new_split_area)
			 if l_target_parent_split /= Void and l_target_parent_split.full then
			 	if l_target_parent_spliter_position >= l_target_parent_split.minimum_split_position and
			 		l_target_parent_spliter_position <= l_target_parent_split.maximum_split_position then
			 		l_target_parent_split.set_split_position (l_target_parent_spliter_position)
			 	end
			 end
			l_new_split_area.set_proportion (0.5)

			internal_shared.docking_manager.inner_container (zone).remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		ensure
			changed:
		end

	change_zone_split_area_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_direction: INTEGER) is
			-- Change zone parent split area to docking zone.
		require
			a_target_zone_not_void: a_target_zone /= Void
		local
			l_new_split_area: EV_SPLIT_AREA
			l_target_zone_parent: EV_CONTAINER
			l_target_zone_parent_split_position: INTEGER
			l_target_zone_parent_spliter: EV_SPLIT_AREA
		do
			-- First, remove current zone from old parent split area.	
			if zone.parent /= Void then
				zone.parent.prune (zone)
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
			-- Then, insert current zone to new split area base on  `a_direction'.
			if a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom then
				create {EV_VERTICAL_SPLIT_AREA} l_new_split_area
			elseif a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
				create {EV_HORIZONTAL_SPLIT_AREA} l_new_split_area
			end
			if a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_left then
				l_new_split_area.set_first (zone)
				l_new_split_area.set_second (a_target_zone)
			else
				l_new_split_area.set_first (a_target_zone)
				l_new_split_area.set_second (zone)
			end
			l_target_zone_parent.extend (l_new_split_area)

			if l_target_zone_parent_spliter /= Void and then l_target_zone_parent_spliter.full then
				l_target_zone_parent_spliter.set_split_position (l_target_zone_parent_split_position)
			end
			l_new_split_area.set_proportion (0.5)
			internal_shared.docking_manager.remove_empty_split_area
		ensure
			changed:
		end

	internal_width_height: INTEGER
			-- Width of zone if dock_left or dock_right.
			-- Height of zone if dock_top or dock_bottom.

invariant

	internal_zone_not_void: zone /= Void

end
