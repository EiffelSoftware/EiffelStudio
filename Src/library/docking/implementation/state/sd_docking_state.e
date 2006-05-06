indexing
	description: "SD_INNER_STATE which is docking in SD_MULTI_DOCK_AREA."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_STATE

inherit
	SD_STATE
		redefine
			stick,
			float,
			change_zone_split_area,
			move_to_docking_zone,
			move_to_tab_zone,
			restore,
			zone,
			change_title,
			show,
			hide,
			record_state
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
			internal_docking_manager := a_content.docking_manager
			direction := a_direction
			width_height := a_width_height
			internal_content := a_content
			zone := internal_shared.widget_factory.docking_zone (a_content)
			internal_docking_manager.zones.add_zone (zone)
			last_floating_height := a_content.state.last_floating_height
			last_floating_width := a_content.state.last_floating_width
		ensure
			set: internal_content = a_content
			set: direction = a_direction
			set: width_height = a_width_height
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

feature {SD_TAB_STATE_ASSISTANT} -- Initlization

	set_widget_main_area (a_widget: EV_WIDGET; a_main_area: SD_MULTI_DOCK_AREA; a_parent: EV_CONTAINER; a_split_position: INTEGER) is
			-- Set widget and main area which used by normal window.
		require
			a_widget_not_void: a_widget /= Void
			a_main_area_not_void: a_main_area /= Void
			a_parent_not_void: a_parent /= Void
		do
			zone.set_max (True)
			zone.set_widget_main_area (a_widget, a_main_area, a_parent, a_split_position)
		end

feature -- Redefine.

	restore (a_titles: ARRAYED_LIST [STRING]; a_container: EV_CONTAINER; a_direction: INTEGER) is
			-- Redefine.
		local
			l_content: SD_CONTENT
		do
			create internal_shared
			a_titles.start
			l_content := internal_docking_manager.query.content_by_title_for_restore (a_titles.item)

			-- If we don't find SD_CONTENT, ignore it.
			if l_content /= Void then
				internal_content := l_content
				Precursor {SD_STATE} (a_titles, a_container, a_direction)
				make (l_content, {SD_DOCKING_MANAGER}.dock_left, 1)
				a_container.extend (zone)
				change_state (Current)
				direction := a_direction
			end
		end

	record_state is
			-- Redefine
		do
			if floating_zone /= Void then
				check valid_height: floating_zone.height > 0 end
				check valid_width: floating_zone.width > 0 end
				last_floating_height := floating_zone.height
				last_floating_width := floating_zone.width
			end
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
			l_retried: BOOLEAN
			l_called: BOOLEAN
		do
			if not l_retried then
				internal_docking_manager.command.lock_update (zone, False)
				record_state
				if zone.parent /= Void then
					zone.parent.prune (zone)
				end

				internal_docking_manager.command.lock_update (Void, True)
				l_called := True

				if a_multi_dock_area.full then
					l_old_stuff := a_multi_dock_area.item
					l_old_spliter ?= l_old_stuff
					if l_old_spliter /= Void then
						a_multi_dock_area.save_spliter_position (l_old_spliter)
					end
					a_multi_dock_area.prune (l_old_stuff)
				end

				if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
					create {SD_HORIZONTAL_SPLIT_AREA} l_new_container
				else
					create {SD_VERTICAL_SPLIT_AREA} l_new_container
				end

				a_multi_dock_area.extend (l_new_container)

				if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_top then
					l_new_container.set_first (zone)
					if l_old_stuff /= Void then
						l_new_container.set_second (l_old_stuff)
					end
				else
					l_new_container.set_second (zone)
					if l_old_stuff /= Void then
						l_new_container.set_first (l_old_stuff)
					end
				end
				if l_new_container.full then
					l_new_container.set_split_position (top_split_position (direction, l_new_container))
				end
				if l_old_spliter /= Void then
					a_multi_dock_area.restore_spliter_position (l_old_spliter)
				end
				internal_docking_manager.command.remove_empty_split_area
				internal_docking_manager.command.update_title_bar
				internal_docking_manager.command.unlock_update
				internal_docking_manager.command.unlock_update
			end
		ensure then
			is_dock_at_top: old a_multi_dock_area.full implies is_dock_at_top (a_multi_dock_area)
		rescue
			internal_docking_manager.command.unlock_update
			if l_called then
				internal_docking_manager.command.unlock_update
			end
			l_retried := True
			retry
		end

stick (a_direction: INTEGER) is
			-- Redefine.
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
			l_width_height: INTEGER
		do
			internal_docking_manager.command.lock_update (zone, False)
			Precursor {SD_STATE} (a_direction)
			-- Change current content's zone to a SD_AUTO_HIDE_ZONE.
			internal_docking_manager.zones.prune_zone (zone)

			-- Change state.
			create l_auto_hide_state.make_with_size (internal_content, direction, l_width_height)
			l_auto_hide_state.set_width_height (width_height_by_direction)
			change_state (l_auto_hide_state)
			internal_docking_manager.query.inner_container_main.remove_empty_split_area
			internal_docking_manager.command.unlock_update
		ensure then
			state_changed: content.state /= Current
		end

	float (a_x, a_y: INTEGER) is
			-- Redefine.
		local
			l_floating_state: SD_FLOATING_STATE
			l_orignal_multi_dock_area: SD_MULTI_DOCK_AREA
		do
			l_orignal_multi_dock_area := internal_docking_manager.query.inner_container (zone)
			if l_orignal_multi_dock_area.has (zone) and l_orignal_multi_dock_area.parent_floating_zone /= Void then
				l_orignal_multi_dock_area.parent_floating_zone.set_position (a_x, a_y)
			else
				internal_docking_manager.command.lock_update (zone, False)
				create l_floating_state.make (a_x, a_y, internal_docking_manager)
				l_floating_state.set_size (last_floating_width, last_floating_height)
				dock_at_top_level (l_floating_state.inner_container)
				l_floating_state.update_title_bar
				l_orignal_multi_dock_area.update_title_bar
				internal_docking_manager.command.remove_empty_split_area
				internal_docking_manager.command.unlock_update
			end
			internal_docking_manager.command.update_title_bar
		ensure then
--			floated: old zone.parent /= zone.parent
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			-- Redefine.
		local
			l_called: BOOLEAN
			l_retried: BOOLEAN
		do
			if not l_retried then
				internal_docking_manager.command.lock_update (zone, False)
				record_state
				if zone.parent /= Void then
					zone.parent.prune (zone)
				end

				internal_docking_manager.command.lock_update (a_target_zone, False)
				l_called := True

				change_zone_split_area_to_zone (a_target_zone, a_direction)
				internal_docking_manager.command.update_title_bar
				internal_docking_manager.command.unlock_update
				internal_docking_manager.command.unlock_update
			end
		ensure then
			parent_changed: old zone.parent /= zone.parent
		rescue
			internal_docking_manager.command.unlock_update
			if l_called then
				internal_docking_manager.command.unlock_update
			end
			l_retried := True
			retry
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_first: BOOLEAN) is
			-- Redefine.
		do
			move_to_zone_internal (a_target_zone, a_first)
		ensure then
			state_changed: content.state /= Current
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE; a_index: INTEGER) is
			-- Redefine.
		do
			if a_index = 1 then
				move_to_zone_internal (a_target_zone, True)
			else
				move_to_zone_internal (a_target_zone, False)
			end

			if a_index > 0 and a_index <= a_target_zone.contents.count then
				a_target_zone.set_content_position (content, a_index)
			end
		ensure then
			state_changed: content.state /= Current
		end

	show is
			-- Redefine.
		local
			l_multi_dock_area: SD_MULTI_DOCK_AREA
		do
			zone.show
			l_multi_dock_area := internal_docking_manager.query.inner_container (zone)
			if l_multi_dock_area /= Void and then not internal_docking_manager.query.is_main_inner_container (l_multi_dock_area) then
				l_multi_dock_area.parent_floating_zone.show
				l_multi_dock_area.update_title_bar
			end
		end

	hide is
			-- Redefine.
		local
			l_multi_dock_area: SD_MULTI_DOCK_AREA
		do
			zone.hide
			l_multi_dock_area := internal_docking_manager.query.inner_container (zone)
			if l_multi_dock_area /= Void and then not internal_docking_manager.query.is_main_inner_container (l_multi_dock_area) then
				l_multi_dock_area.update_title_bar
			end
			docking_manager.command.resize (False)
		end

	zone: SD_DOCKING_ZONE
			-- Redefine.

feature {NONE} -- Implementation

	move_to_zone_internal (a_target_zone: SD_ZONE; a_first: BOOLEAN) is
			-- Move to a zone.
		local
			l_tab_state: SD_TAB_STATE
			l_orignal_direction: INTEGER
			l_docking_zone: SD_DOCKING_ZONE
			l_tab_zone: SD_TAB_ZONE
		do
			internal_docking_manager.command.lock_update (zone, False)
			internal_docking_manager.zones.prune_zone (zone)
			l_orignal_direction := a_target_zone.state.direction

			l_docking_zone ?= a_target_zone
			l_tab_zone ?= a_target_zone
			internal_docking_manager.command.lock_update (a_target_zone, False)
			if l_docking_zone /= Void then
				create l_tab_state.make (internal_content, l_docking_zone, l_orignal_direction)
			else
				check only_allow_two_type_zone: l_tab_zone /= Void end
				create l_tab_state.make_with_tab_zone (internal_content, l_tab_zone, l_orignal_direction)
			end
			if a_first then
				l_tab_state.zone.set_content_position (internal_content, 1)
			end
			internal_docking_manager.command.unlock_update
			l_tab_state.set_direction (l_orignal_direction)
			internal_docking_manager.command.remove_empty_split_area
			change_state (l_tab_state)
			internal_docking_manager.command.unlock_update
			internal_docking_manager.command.update_title_bar
		end

	change_zone_split_area_to_zone (a_target_zone: SD_ZONE; a_direction: INTEGER) is
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
				create {SD_VERTICAL_SPLIT_AREA} l_new_split_area
			elseif a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
				create {SD_HORIZONTAL_SPLIT_AREA} l_new_split_area
			end
			if a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_left then
				l_new_split_area.set_first (zone)
				l_new_split_area.set_second (a_target_zone)
			else
				l_new_split_area.set_first (a_target_zone)
				l_new_split_area.set_second (zone)
			end
			l_target_zone_parent.extend (l_new_split_area)

			if l_target_zone_parent_spliter /= Void and then l_target_zone_parent_spliter.full and
				 l_target_zone_parent_spliter.minimum_split_position <= l_target_zone_parent_split_position and
				 	l_target_zone_parent_spliter.maximum_split_position >= l_target_zone_parent_split_position then
				l_target_zone_parent_spliter.set_split_position (l_target_zone_parent_split_position)
			end
			-- If we don't resize here and content is in top level,
			-- content's widget will be minimum size.
			internal_docking_manager.command.resize (False)

			l_new_split_area.set_proportion (0.5)
			set_direction (a_target_zone.state.direction)
			internal_docking_manager.command.remove_empty_split_area
		ensure
			changed:
		end

invariant

	internal_zone_not_void: zone /= Void

indexing
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
