indexing
	description: "Assistant for SD_TAB_STATE."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TAB_STATE_ASSISTANT

create
	make

feature {NONE} -- Initlization
	make (a_tab_state: SD_TAB_STATE; a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			not_void: a_tab_state /= Void
			not_void: a_docking_manager /= Void
		do
			state := a_tab_state
			internal_docking_manager := a_docking_manager
		ensure
			set: state = a_tab_state
			set: internal_docking_manager = a_docking_manager
		end

feature {SD_TAB_STATE}  -- Implementation functions.

	float_internal (a_x, a_y: INTEGER) is
			-- Float window.
		local
			l_floating_state: SD_FLOATING_STATE
			l_docking_state: SD_DOCKING_STATE
			l_content: SD_CONTENT
		do
			internal_docking_manager.command.lock_update (state.zone, False)
			create l_floating_state.make (a_x, a_y, internal_docking_manager)
			l_floating_state.set_size (state.last_floating_width, state.last_floating_height)

			if state.zone.is_drag_title_bar then
				state.dock_at_top_level (l_floating_state.inner_container)
				l_floating_state.update_title_bar
			else
				l_content := state.content
				state.tab_zone.prune (l_content, False)
				internal_docking_manager.command.unlock_update
				create l_docking_state.make (l_content, {SD_DOCKING_MANAGER}.dock_left, {SD_SHARED}.title_bar_height)
				l_docking_state.dock_at_top_level (l_floating_state.inner_container)
				l_content.change_state (l_docking_state)
				internal_docking_manager.command.lock_update (state.zone, False)
				update_last_content_state
			end
			internal_docking_manager.command.unlock_update
		end

	change_zone_split_area_to_docking_zone (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			-- Change zone split area to docking zone.
			-- FIXIT: This routine copy from SD_DOCKING_STATE, only change internal_zone to tab_zone.
			-- May should merge functions.
		require
			a_target_zone_not_void: a_target_zone /= Void
			direction_valid: state.direction = {SD_DOCKING_MANAGER}.dock_top or state.direction = {SD_DOCKING_MANAGER}.dock_bottom
				or state.direction = {SD_DOCKING_MANAGER}.dock_left or state.direction = {SD_DOCKING_MANAGER}.dock_right
		local
			l_new_split_area: EV_SPLIT_AREA
			l_target_zone_parent: EV_CONTAINER
			l_old_zone_parent_type: STRING
			l_target_zone_parent_split_position: INTEGER
			l_target_zone_parent_spliter: EV_SPLIT_AREA
		do
			internal_docking_manager.command.lock_update (a_target_zone, False)
			-- First, remove current internal_zone from old parent split area.	
			if  state.tab_zone.parent /= Void then
				l_old_zone_parent_type := state.tab_zone.parent.generating_type
				state.tab_zone.parent.prune (state.tab_zone)
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
			if a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom then
				create {SD_VERTICAL_SPLIT_AREA} l_new_split_area
			elseif a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
				create {SD_HORIZONTAL_SPLIT_AREA} l_new_split_area
			end
			if a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_left then
				l_new_split_area.set_first (state.tab_zone)
				l_new_split_area.set_second (a_target_zone)
			else
				l_new_split_area.set_first (a_target_zone)
				l_new_split_area.set_second (state.tab_zone)
			end
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
			changed: a_target_zone.parent.has (state.tab_zone)
		end

	move_whole_to_docking_zone (a_target_zone: SD_DOCKING_ZONE) is
			-- Move whole tab area to a docking zone.
		require
			a_target_zone_not_void: a_target_zone /= Void
		local
			l_tab_state: SD_TAB_STATE
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_tab_zone: SD_TAB_ZONE
			l_is_split: BOOLEAN
			l_split_position: INTEGER
			l_split: EV_SPLIT_AREA
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
					if l_contents.item.user_widget.parent /= Void then
						l_contents.item.user_widget.parent.prune (l_contents.item.user_widget)
					end
					create l_tab_state.make (l_contents.item, a_target_zone, l_orignal_direction)
					l_contents.item.change_state (l_tab_state)
					first_move_to_docking_zone := False
				else
					l_tab_zone ?= l_tab_state.zone
					create l_tab_state.make_with_tab_zone (l_contents.item, l_tab_zone, l_orignal_direction)
				end
				l_tab_state.set_direction (l_orignal_direction)
				l_contents.forth
			end
			l_tab_state.select_tab (state.internal_content, True)

			if l_is_split then
				l_split ?= l_tab_state.zone.parent
				check l_split /= Void end
				if l_split.full then
					if l_split.minimum_split_position > l_split_position then
						l_split_position := l_split.minimum_split_position
					elseif l_split.maximum_split_position < l_split_position then
						l_split_position := l_split.maximum_split_position
					end
					l_split.set_split_position (l_split_position)
				end
			end
		ensure
--			moved: old a_target_zone.parent.has (tab_zone)
		end

	move_tab_to_zone (a_target_zone: SD_ZONE; a_index: INTEGER) is
			-- Move one tab from a tab zone to a docking zone.
		require
			a_target_zone_not_void: a_target_zone /= Void
			valid: a_index > 0
		local
			l_tab_state: SD_TAB_STATE
			l_orignal_direction: INTEGER
			l_docking_zone: SD_DOCKING_ZONE
			l_tab_zone: SD_TAB_ZONE
		do
			l_orignal_direction := a_target_zone.state.direction
			state.tab_zone.prune (state.internal_content, False)
			if state.internal_content.user_widget.parent /= Void then
				state.internal_content.user_widget.parent.prune (state.internal_content.user_widget)
			end
			l_docking_zone ?= a_target_zone
			l_tab_zone ?= a_target_zone
			if l_docking_zone /= Void then
				create l_tab_state.make (state.internal_content, l_docking_zone, l_orignal_direction)
			else
				check only_docking_zone_or_tab_zone: l_tab_zone /= Void end
				create l_tab_state.make_with_tab_zone (state.internal_content, l_tab_zone, l_orignal_direction)
				l_tab_zone.set_content_position (state.internal_content, a_index)
			end

			l_tab_state.set_direction (l_orignal_direction)
			state.change_state (l_tab_state)
			update_last_content_state
		ensure
--			has: a_target_zone.has (content)
--			moved: a_target_zone.parent.has (internal_content.state.zone)
		end

	dock_whole_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Dock whole zone at top of  `a_multi_dock_area'
		require
			a_multi_dock_area_not_void: a_multi_dock_area /= Void
		local
			l_old_stuff: EV_WIDGET
			l_new_container: EV_SPLIT_AREA
		do
			state.tab_zone.parent.prune (state.tab_zone)
			if a_multi_dock_area.full then

				l_old_stuff := a_multi_dock_area.item
				a_multi_dock_area.save_spliter_position (l_old_stuff)
				a_multi_dock_area.prune (l_old_stuff)
			end

			if state.direction = {SD_DOCKING_MANAGER}.dock_left or state.direction = {SD_DOCKING_MANAGER}.dock_right then
				create {SD_HORIZONTAL_SPLIT_AREA} l_new_container
			else
				create {SD_VERTICAL_SPLIT_AREA} l_new_container
			end

			if state.direction = {SD_DOCKING_MANAGER}.dock_left or state.direction = {SD_DOCKING_MANAGER}.dock_top then
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
				a_multi_dock_area.restore_spliter_position (l_old_stuff)
			end
		ensure
			docked: is_top_has_zone (a_multi_dock_area)
		end

	dock_tab_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Dock selected tab at top of `a_multi_dock_area'.
		require
			a_multi_dock_area_not_void: a_multi_dock_area /= Void
		local
			l_docking_state: SD_DOCKING_STATE
		do
--			tab_zone.disable_on_select_tab

			state.tab_zone.prune (state.internal_content, False)
			create l_docking_state.make (state.internal_content, state.direction, state.width_height)
			l_docking_state.dock_at_top_level (a_multi_dock_area)
			state.change_state (l_docking_state)

			update_last_content_state
--			tab_zone.enable_on_select_tab
		ensure
			docked:
		end

	update_last_content_state is
			-- If there only on content left, change it's state to SD_DOCKING_STATE
		local
			l_parent: EV_CONTAINER
			l_docking_state: SD_DOCKING_STATE
			l_split_position: INTEGER
			l_split_area: EV_SPLIT_AREA
			l_widget: EV_WIDGET
		do
			if state.tab_zone.count = 1 then
				l_split_area ?= state.tab_zone.parent
				if l_split_area /= Void then
					l_split_position := l_split_area.split_position
				end
				l_parent := state.tab_zone.parent
				internal_docking_manager.zones.prune_zone (state.tab_zone)

				create l_docking_state.make_for_tab_zone (state.tab_zone.last_content, l_parent, state.direction)

				if state.zone.is_maximized then
					l_docking_state.set_widget_main_area (state.zone.main_area_widget , state.zone.main_area, state.zone.internal_parent, state.zone.internal_parent_split_position)
				end

				state.tab_zone.last_content.change_state (l_docking_state)

				if l_split_area /= Void then
					l_widget ?= l_docking_state.zone
					check l_widget /= Void end
					l_split_area ?= l_widget.parent
					check l_split_area /= Void end
					if l_split_area.minimum_split_position <= l_split_position and l_split_area.maximum_split_position >= l_split_position then
						l_split_area.set_split_position (l_split_position)
					end
				end
				state.zone.destroy
				internal_docking_manager.command.update_title_bar
			end
		ensure
			updated: state.tab_zone.count = 1 implies state.tab_zone.last_content.state /= state
		end

feature -- Query

	state: SD_TAB_STATE
			-- Tab state which current help.	

	is_top_has_zone (a_multi_dock_area: SD_MULTI_DOCK_AREA): BOOLEAN is
			-- If `a_multi_dock_area' has `tab_zone'?
		local
			l_split_area: EV_SPLIT_AREA
		do
			l_split_area ?=	a_multi_dock_area.item
			if l_split_area /= Void then
				Result := l_split_area.has (state.tab_zone)
			end
		end

feature {NONE} -- Implementation

	first_move_to_docking_zone: BOOLEAN;
			-- When moving to a docking zone, first time is different.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager.

invariant
	not_void: state /= Void
	not_void: internal_docking_manager /= Void

end
