note
	description: "Assistant for SD_TAB_STATE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TAB_STATE_ASSISTANT

inherit
	SD_ACCESS

create
	make

feature {NONE} -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER)
			-- Creation method
		require
			not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
			create internal_shared
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature {SD_TAB_STATE} -- Initlization

	init (a_tab_state: SD_TAB_STATE)
			-- Initlization
		require
			not_void: a_tab_state /= Void
		do
			internal_state := a_tab_state
		ensure
			set: state = a_tab_state
		end

feature {SD_TAB_STATE}  -- Implementation functions

	float_internal (a_x, a_y: INTEGER)
			-- Float window
		local
			l_floating_state: SD_FLOATING_STATE
			l_docking_state: SD_DOCKING_STATE
			l_content: SD_CONTENT
			l_parent: detachable EV_CONTAINER
		do
			internal_docking_manager.command.lock_update (state.zone, False)
			create l_floating_state.make (a_x, a_y, internal_docking_manager, True)
			l_floating_state.set_size (state.last_floating_width, state.last_floating_height)

			if state.zone.is_drag_title_bar then
				state.dock_at_top_level (l_floating_state.inner_container)
				l_floating_state.update_title_bar
			else
				l_content := state.content
				l_parent := state.tab_zone.parent
				state.tab_zone.prune (l_content, False)
				internal_docking_manager.command.unlock_update
				create l_docking_state.make (l_content, {SD_ENUMERATION}.left,  internal_shared.title_bar_height)
				l_docking_state.dock_at_top_level (l_floating_state.inner_container)
				l_content.change_state (l_docking_state)
				internal_docking_manager.command.lock_update (state.zone, False)
				if l_parent /= Void then
					update_last_content_state (l_parent)
				end
			end
			internal_docking_manager.query.inner_container_main.recover_normal_for_only_one
			-- After floating, left minmized editor zone(s) in SD_MULTI_DOCK_AREA, then we
			-- have to resize
			internal_docking_manager.command.resize (True)

			internal_docking_manager.command.unlock_update
		end

	change_zone_split_area_to_docking_zone (a_target_zone: SD_ZONE; a_direction: INTEGER)
			-- Change zone split area to docking zone
			-- FIXIT: This routine copy from SD_DOCKING_STATE, only change internal_zone to tab_zone.
			-- May should merge functions
		require
			a_target_zone_not_void: a_target_zone /= Void
			direction_valid: (create {SD_ENUMERATION}).is_direction_valid (state.direction)
		local
			l_new_split_area: EV_SPLIT_AREA
			l_target_zone_parent: detachable EV_CONTAINER
			l_old_zone_parent_type: STRING_GENERAL
			l_target_zone_parent_split_position: INTEGER
			l_target_zone_parent_spliter: detachable EV_SPLIT_AREA
		do
			if attached {EV_WIDGET} a_target_zone as lt_widget then
				internal_docking_manager.command.lock_update (lt_widget, False)
			else
				check not_possible: False end
			end

			-- First, remove current internal_zone from old parent split area	
			if attached state.tab_zone.parent as l_parent then
				l_old_zone_parent_type := l_parent.generating_type
				l_parent.prune (state.tab_zone)
			end

			if attached {EV_WIDGET} a_target_zone as lt_widget_2 then
				l_target_zone_parent := lt_widget_2.parent
			else
				check not_possible: False end
			end

			if l_target_zone_parent /= Void then
				-- Remember target zone parent split position
				l_target_zone_parent_spliter ?= l_target_zone_parent
				if l_target_zone_parent_spliter /= Void then
					l_target_zone_parent_split_position := l_target_zone_parent_spliter.split_position
				end
				if attached {EV_WIDGET} a_target_zone as lt_widget_3 then
					l_target_zone_parent.prune (lt_widget_3)
				else
					check not_possible: False end
				end
			end
			check l_target_zone_parent /= Void and then not l_target_zone_parent.full end
			-- Then, insert current internal_zone to new split area base on  `a_direction'.
			if a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom then
				create {SD_VERTICAL_SPLIT_AREA} l_new_split_area
			else
				check a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right end -- Implied by only four direction
				create {SD_HORIZONTAL_SPLIT_AREA} l_new_split_area
			end
			if attached {EV_WIDGET} a_target_zone as lt_widget_4 then
				if a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.left then
					l_new_split_area.set_first (state.tab_zone)
					l_new_split_area.set_second (lt_widget_4)
				else
					l_new_split_area.set_first (lt_widget_4)
					l_new_split_area.set_second (state.tab_zone)
				end
			else
				check not_possible: False end
			end
			check l_target_zone_parent /= Void end -- Implied by previous assign codes in this feature
			l_target_zone_parent.extend (l_new_split_area)
			l_new_split_area.set_proportion (0.5)
			if l_target_zone_parent_spliter /= Void and then l_target_zone_parent_spliter.full then
				if l_target_zone_parent_spliter.maximum_split_position >= l_target_zone_parent_split_position and
					l_target_zone_parent_spliter.minimum_split_position <= l_target_zone_parent_split_position then
						l_target_zone_parent_spliter.set_split_position (l_target_zone_parent_split_position)
				end
			end
			internal_docking_manager.query.inner_container (state.tab_zone).remove_empty_split_area
			internal_docking_manager.command.unlock_update
		ensure
			changed: attached {EV_WIDGET} a_target_zone as lt_widget_5 implies attached lt_widget_5.parent as le_parent and then le_parent.has (state.tab_zone)
		end

	move_whole_to_docking_zone (a_target_zone: SD_DOCKING_ZONE)
			-- Move whole tab area to a docking zone
		require
			a_target_zone_not_void: a_target_zone /= Void
		local
			l_tab_state: detachable SD_TAB_STATE
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_is_split: BOOLEAN
			l_split_position: INTEGER
			l_orignal_direction: INTEGER
		do
			internal_docking_manager.zones.prune_zone (state.zone)
			l_orignal_direction := a_target_zone.state.direction
			if a_target_zone.is_parent_split then
				l_is_split := True
				l_split_position := a_target_zone.parent_split_position
			end
			l_contents := state.tab_zone.contents
			from
				l_contents.start
				first_move_to_docking_zone := True
			until
				l_contents.after
			loop
				if first_move_to_docking_zone then
					if attached l_contents.item.user_widget.parent as l_parent then
						l_parent.prune (l_contents.item.user_widget)
					end
					create l_tab_state.make (l_contents.item, a_target_zone, l_orignal_direction)
					first_move_to_docking_zone := False
				else
					check l_tab_state /= Void end -- Implied by set by first time loop
					if attached {SD_TAB_ZONE} l_tab_state.zone as l_tab_zone then
						create l_tab_state.make_with_tab_zone (l_contents.item, l_tab_zone, l_orignal_direction)
					else
						check False end -- Implied by tab state's zone muse be SD_TAB_ZONE
					end
				end
				check l_tab_state /= Void end -- Implied by previous if clause
				l_contents.item.change_state (l_tab_state)
				l_tab_state.set_direction (l_orignal_direction)
				l_contents.forth
			end
			check l_tab_state /= Void end -- Implied by previous loop
			l_tab_state.select_tab (state.content, True)

			if l_is_split then
				if attached {EV_SPLIT_AREA} l_tab_state.zone.parent as l_split then
					if l_split.full then
						if l_split.minimum_split_position > l_split_position then
							l_split_position := l_split.minimum_split_position
						elseif l_split.maximum_split_position < l_split_position then
							l_split_position := l_split.maximum_split_position
						end
						l_split.set_split_position (l_split_position)
					end
				else
					check False end -- Implied by `l_is_split'
				end
			end
		ensure
--			moved: old a_target_zone.parent.has (tab_zone)
		end

	move_tab_to_zone (a_target_zone: SD_ZONE; a_index: INTEGER)
			-- Move one tab from a tab zone to a docking zone
		require
			a_target_zone_not_void: a_target_zone /= Void
		local
			l_tab_state: detachable SD_TAB_STATE
			l_orignal_direction: INTEGER
		do
			l_orignal_direction := a_target_zone.state.direction
			if attached state.tab_zone.parent as l_parent then
				state.tab_zone.prune (state.content, False)
				if attached state.content.user_widget.parent as l_parent_2 then
					l_parent_2.prune (state.content.user_widget)
				end

				if attached {SD_DOCKING_ZONE} a_target_zone as l_docking_zone then
					create l_tab_state.make (state.content, l_docking_zone, l_orignal_direction)
				elseif attached {SD_TAB_ZONE} a_target_zone as l_tab_zone then
					create l_tab_state.make_with_tab_zone (state.content, l_tab_zone, l_orignal_direction)
					l_tab_zone.set_content_position (state.content, a_index)
				else
					check False end -- Implied by only docking zone or tab zone
				end

				check l_tab_state /= Void end -- Implied by previous if clause
				l_tab_state.set_direction (l_orignal_direction)
				state.change_state (l_tab_state)

				-- FIXME: Maybe we are opening layout config, so the parent is Void?
--				if l_parent /= Void then
				update_last_content_state (l_parent)
--				end
			else
				check False end -- Implied by tab zone existing in main window
			end
		ensure
--			has: a_target_zone.has (content)
--			moved: a_target_zone.parent.has (internal_content.state.zone)
		end

	dock_whole_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA)
			-- Dock whole zone at top of  `a_multi_dock_area'
		require
			a_multi_dock_area_not_void: a_multi_dock_area /= Void
		local
			l_old_stuff: detachable EV_WIDGET
			l_new_container: EV_SPLIT_AREA
		do
			if attached state.tab_zone.parent as l_parent then
				l_parent.prune (state.tab_zone)
			else
				check False end -- Implied by tab zone displaying in main window
			end

			if a_multi_dock_area.full then

				l_old_stuff := a_multi_dock_area.item
				a_multi_dock_area.save_spliter_position (l_old_stuff, generating_type)
				a_multi_dock_area.prune (l_old_stuff)
			end

			if state.direction = {SD_ENUMERATION}.left or state.direction = {SD_ENUMERATION}.right then
				create {SD_HORIZONTAL_SPLIT_AREA} l_new_container
			else
				create {SD_VERTICAL_SPLIT_AREA} l_new_container
			end

			if state.direction = {SD_ENUMERATION}.left or state.direction = {SD_ENUMERATION}.top then
				l_new_container.set_first (state.tab_zone)
				if l_old_stuff /= Void then
					l_new_container.set_second (l_old_stuff)
				end
			else
				l_new_container.set_second (state.tab_zone)
				if l_old_stuff /= Void then
					l_new_container.set_first (l_old_stuff)
				end
			end
			a_multi_dock_area.extend (l_new_container)
			state.docking_manager.command.resize (False)
			if l_new_container.full then
				l_new_container.set_split_position (state.top_split_position (state.direction, l_new_container))
			end
			if l_old_stuff /= Void then
				a_multi_dock_area.restore_spliter_position (l_old_stuff, generating_type)
			end
		ensure
			docked: is_top_has_zone (a_multi_dock_area)
		end

	dock_tab_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA)
			-- Dock selected tab at top of `a_multi_dock_area'
		require
			a_multi_dock_area_not_void: a_multi_dock_area /= Void
		local
			l_docking_state: SD_DOCKING_STATE
			l_parent: detachable EV_CONTAINER
		do
--			tab_zone.disable_on_select_tab
			l_parent := state.tab_zone.parent
			state.tab_zone.prune (state.content, False)
			create l_docking_state.make (state.content, state.direction, state.width_height)
			l_docking_state.dock_at_top_level (a_multi_dock_area)
			state.change_state (l_docking_state)

			if l_parent /= Void then
				update_last_content_state (l_parent)
			end

--			tab_zone.enable_on_select_tab
		ensure
			docked:
		end

	update_last_content_state (a_parent: EV_CONTAINER)
			-- If there only on content left, change it's state to SD_DOCKING_STATE
		require
			not_void: a_parent /= Void
		local
			l_docking_state: SD_DOCKING_STATE
			l_split_position: INTEGER
			l_split_area: detachable EV_SPLIT_AREA
			l_widget: detachable EV_WIDGET
			l_second_parent: detachable EV_CONTAINER
			l_last_content: SD_CONTENT
			l_main_area: detachable SD_MULTI_DOCK_AREA
			l_main_area_widget: detachable EV_WIDGET
			l_internal_parent: detachable EV_CONTAINER
		do
			-- `a_parent' may be void if calling by `close' from SD_TAB_STATE on Linux
			if a_parent /= Void and then state.tab_zone.count = 1 then
				l_last_content := state.tab_zone.last_content

				-- When Eiffel Studio is exiting (everything is recycling), we are not sure if `l_last_content''s docking manager attached, we have to check
				if l_last_content.is_docking_manager_attached then
					l_split_area ?= state.tab_zone.parent
					if l_split_area /= Void then
						l_split_position := l_split_area.split_position
					end
					l_second_parent := state.tab_zone.parent
					internal_docking_manager.zones.prune_zone (state.tab_zone)
					if a_parent.full then
						-- If a tab want to dock at it's own tab area, then a_parent is full, we use l_second_parent (old tab_zone parent) instead
						check l_second_parent /= Void end -- Implied by tab zone existing in main window
						create l_docking_state.make_for_tab_zone (l_last_content, l_second_parent, state.direction)
					else
						create l_docking_state.make_for_tab_zone (l_last_content, a_parent, state.direction)
					end

					if state.zone.is_maximized then
						l_main_area := state.zone.main_area
						check l_main_area /= Void end -- Implied by `is_maximized'
						l_main_area_widget := state.zone.main_area_widget
						check l_main_area_widget /= Void end -- Implied by `is_maximized'
						l_internal_parent := state.zone.internal_parent
						check l_internal_parent /= Void end -- Implied by `state.zone.is_maximized'
						l_docking_state.set_widget_main_area (l_main_area_widget, l_main_area, l_internal_parent, state.zone.internal_parent_split_position)
					end

					state.tab_zone.last_content.change_state (l_docking_state)

					if l_split_area /= Void then
						l_widget ?= l_docking_state.zone
						check l_widget /= Void end
						l_split_area ?= l_widget.parent
						check l_split_area /= Void end
						if
							l_split_area.full and then
							(l_split_area.minimum_split_position <= l_split_position and l_split_area.maximum_split_position >= l_split_position)
						then
							l_split_area.set_split_position (l_split_position)
						end
					end
					state.zone.destroy
					internal_docking_manager.command.resize (False)
					internal_docking_manager.command.update_title_bar
				end
			end
		ensure
			updated: state.tab_zone.count = 1 implies state.tab_zone.last_content.state /= state
		end

feature -- Query

	state: SD_TAB_STATE
			-- Tab state which current help
		require
			set: is_state_set
		local
			l_result: detachable like state
		do
			l_result := internal_state
			check l_result /= Void end
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	is_state_set: BOOLEAN
			-- If `internal_state' attached?
		do
			Result := internal_state /= Void
		end

	is_top_has_zone (a_multi_dock_area: SD_MULTI_DOCK_AREA): BOOLEAN
			-- If `a_multi_dock_area' has `tab_zone'?
		do
			if attached {EV_SPLIT_AREA} a_multi_dock_area.item as l_split_area then
				Result := l_split_area.has (state.tab_zone)
			end
		end

feature {NONE} -- Implementation

	internal_shared: SD_SHARED
			-- All singletons

	first_move_to_docking_zone: BOOLEAN
			-- When moving to a docking zone, first time is different

	internal_state: detachable SD_TAB_STATE
			-- Tab state which current help

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager

invariant
	not_void: internal_shared /= Void
	not_void: internal_docking_manager /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
