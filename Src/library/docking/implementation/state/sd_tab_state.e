indexing
	description: "SD_STATE which manage a SD_TAB_ZONE."
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
			dock_at_top_level,
			content,
			change_title,
			change_pixmap,
			close_window,
			content_count_valid
		end
create
	make,
	make_with_tab_zone

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_target_zone: SD_DOCKING_ZONE; a_direction: INTEGER) is
			-- Creation method
		require
			a_content_not_void: a_content /= Void
			a_content_parent_void: a_content.user_widget.parent = Void
			a_target_zone_not_void: a_target_zone /= Void
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
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
			tab_zone := internal_shared.widget_factory.tab_zone (a_content, a_target_zone)
			internal_shared.docking_manager.add_zone (tab_zone)
			internal_content := a_content
			direction := a_direction

			l_parent.extend (tab_zone)

			create l_target_zone_tab_state.make_with_tab_zone (a_target_zone.content, tab_zone, direction)
			a_target_zone.content.change_state (l_target_zone_tab_state)
			-- At the end, add `a_content', so `a_content' is selected on SD_TAB_ZONE.
			tab_zone.extend (a_content)

			if l_old_parent_split  then
				l_split_parent ?= tab_zone.parent
				check l_split_parent /= Void end
				if l_split_parent.full and then l_split_parent.minimum_split_position <= l_old_split_position and l_split_parent.maximum_split_position >= l_old_split_position then
					l_split_parent.set_split_position (l_old_split_position)
				end
			end
		ensure
			set: a_content = internal_content
			set: direction = a_direction
		end

	make_with_tab_zone (a_content: SD_CONTENT; a_target_zone: SD_TAB_ZONE; a_direction: INTEGER) is
			-- Creation method.
		require
			a_content_not_void: a_content /= Void
			a_target_zone: a_target_zone /= Void
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			create internal_shared
			internal_content := a_content
			tab_zone := a_target_zone
			direction := a_direction
			if internal_content.user_widget.parent /= Void then
				internal_content.user_widget.parent.prune (internal_content.user_widget)
			end
			tab_zone.extend (internal_content)
		ensure
			set: a_content = internal_content
			set: a_target_zone = tab_zone
			set: a_direction = direction
			extended: tab_zone.has (internal_content)
		end

feature -- Redefine

	restore (a_titles: ARRAYED_LIST [STRING]; a_container: EV_CONTAINER; a_direction: INTEGER) is
			-- Redefine.
		local
			l_content: SD_CONTENT
			l_tab_state: SD_TAB_STATE
			l_first_tab: BOOLEAN
			l_docking_state: SD_DOCKING_STATE
			l_third_time: BOOLEAN
		do
			direction := a_direction
			create internal_shared
			from
				a_titles.start
				l_first_tab := True
			until
				a_titles.after
			loop
				l_content := internal_shared.docking_manager.content_by_title (a_titles.item)
				if l_first_tab then
					create l_docking_state.make_for_tab_zone (l_content, a_container, a_direction)
					l_content.change_state (l_docking_state)
					l_docking_state.set_direction (a_direction)
					l_first_tab := False
				elseif not l_third_time then
 					create l_tab_state.make (l_content, l_docking_state.zone, direction)
					l_content.change_state (l_tab_state)
					l_tab_state.set_direction (a_direction)
					l_third_time := True
				elseif l_third_time then
					create l_tab_state.make_with_tab_zone (l_content, l_tab_state.zone, direction)
					l_content.change_state (l_tab_state)
					l_tab_state.set_direction (a_direction)
				end
				a_titles.forth
			end
		ensure then
			restored:
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Redefine.
		do
			internal_shared.docking_manager.lock_update
			if is_drag_title_bar then
				dock_whole_at_top_level (a_multi_dock_area)
			else
				dock_tab_at_top_level (a_multi_dock_area)
			end
			internal_shared.docking_manager.remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		ensure then
			is_dock_at_top: old a_multi_dock_area.full implies is_dock_at_top (a_multi_dock_area)
		end

	record_state is
			-- Redefine.
		do
		end

	stick_window (a_direction: INTEGER) is
			-- Redefine.
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_auto_hide_panel: SD_AUTO_HIDE_PANEL
		do
			internal_shared.docking_manager.prune_zone (tab_zone)
			l_contents := tab_zone.contents
			from
				l_contents.start
			until
				l_contents.after
			loop
				create l_auto_hide_state.make (l_contents.item, direction)
				l_contents.item.change_state (l_auto_hide_state)
				l_contents.forth
			end
			l_auto_hide_panel:= internal_shared.docking_manager.auto_hide_panel (direction)
			l_auto_hide_panel.set_tab_group (l_contents)
		ensure then
			pruned: not internal_shared.docking_manager.has_zone (tab_zone)
		end

	close_window is
			-- Redefine.
		do
			internal_shared.docking_manager.lock_update
			tab_zone.prune (content)
			if internal_content.internal_close_actions /= Void then
				internal_content.internal_close_actions.call ([])
			end
			update_last_content_state
			internal_shared.docking_manager.remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			-- Redefine.
		local
			l_docking_state: SD_DOCKING_STATE
			l_docking_zone: SD_DOCKING_ZONE
		do
			internal_shared.docking_manager.lock_update
			if not is_drag_title_bar then
				tab_zone.disable_on_select_tab
				tab_zone.prune (internal_content)
				create l_docking_state.make (internal_content, a_direction, tab_zone.width)
				l_docking_state.change_zone_split_area (a_target_zone, a_direction)
				change_state (l_docking_state)
				update_last_content_state
				tab_zone.enable_on_select_tab
			else
				l_docking_zone ?= a_target_zone
				if l_docking_zone /= Void then
					change_zone_split_area_to_docking_zone (l_docking_zone, a_direction)
				end
			end
			internal_shared.docking_manager.unlock_update
		ensure then
			parent_changed:
		end

	float_window (a_x, a_y: INTEGER) is
			-- Redefine.
		local
			l_floating_state: SD_FLOATING_STATE
			l_docking_state: SD_DOCKING_STATE
			l_content: SD_CONTENT
		do
			internal_shared.docking_manager.lock_update
			create l_floating_state.make (a_x, a_y)

			if is_drag_title_bar then
				dock_at_top_level (l_floating_state.inner_container)
				l_floating_state.update_title_bar
			else
				l_content := content
				tab_zone.prune (l_content)
				create l_docking_state.make (l_content, {SD_DOCKING_MANAGER}.dock_left, {SD_SHARED}.title_bar_height)
				l_docking_state.dock_at_top_level (l_floating_state.inner_container)
				l_content.change_state (l_docking_state)

				update_last_content_state
			end
			internal_shared.docking_manager.remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		ensure then
			whole_floated:
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE) is
			-- Redefine.
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_tab_state: SD_TAB_STATE
		do
			internal_shared.docking_manager.lock_update
			tab_zone.disable_on_select_tab
			if is_drag_title_bar then
				internal_shared.docking_manager.prune_zone (tab_zone)

				l_contents := tab_zone.contents
				from
					l_contents.start
				until
					l_contents.after
				loop
					if l_contents.item.user_widget.parent /= Void then
						l_contents.item.user_widget.parent.prune (l_contents.item.user_widget)
					end
					create l_tab_state.make_with_tab_zone (l_contents.item, a_target_zone, direction)
					l_contents.item.change_state (l_tab_state)
					l_contents.forth
				end
				l_tab_state.select_tab (internal_content)
			else
				move_tab_to_tab_zone (a_target_zone)
			end
			tab_zone.enable_on_select_tab
			internal_shared.docking_manager.unlock_update
		ensure then
			moved:
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE) is
			-- Redefine.
		do
			internal_shared.docking_manager.lock_update
			if is_drag_title_bar then
				move_whole_to_docking_zone (a_target_zone)
			else
				move_tab_to_docking_zone (a_target_zone)
			end
			internal_shared.docking_manager.unlock_update
		ensure then
			moved:
		end

feature {SD_CONTENT} -- Redefine

	change_title (a_title: STRING; a_content: SD_CONTENT) is
			-- Redefine.
		do
			tab_zone.set_title (a_title, a_content)
		end

	change_pixmap (a_pixmap: EV_PIXMAP; a_content: SD_CONTENT) is
			-- Redefine.
		do
			tab_zone.set_pixmap (a_pixmap, a_content)
		end

feature -- States report

	content_count_valid (a_titles: ARRAYED_LIST [STRING]): BOOLEAN is
		do
			Result := a_titles.count > 1
		end

	has (a_content: SD_CONTENT): BOOLEAN is
			--
		require
			a_content_not_void: a_content /= Void
		do
			Result := tab_zone.has (a_content)
		end

	top_has_zone (a_multi_dock_area: SD_MULTI_DOCK_AREA): BOOLEAN is
			-- If `a_multi_dock_area' has `tab_zone'?
		local
			l_split_area: EV_SPLIT_AREA
		do
			l_split_area ?=	a_multi_dock_area.item
			if l_split_area /= Void then
				Result := l_split_area.has (tab_zone)
			end
		end

feature -- Command

	select_tab (a_content: SD_CONTENT) is
			-- Enable select one tab.
		require
			has_content: has (a_content)
		do
			tab_zone.select_item (a_content)
		ensure
			selected: tab_zone.selected_item_index = tab_zone.index_of (a_content, 1)
		end

	set_drag_title_bar (a_value: BOOLEAN) is
			-- Set `is_drag_title_bar'.
		do
			is_drag_title_bar := a_value
		ensure
			set: is_drag_title_bar = a_value
		end

feature -- Properties redefine.

	content: SD_CONTENT is
			-- Redefine.
		do
			Result := tab_zone.content
		ensure then
			not_void: Result /= Void
		end

	zone: SD_TAB_ZONE is
			-- Redefine.
		do
			Result := tab_zone
		ensure then
			not_void: Result /= Void
		end

feature {NONE}  -- Implementation functions.

	change_zone_split_area_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_direction: INTEGER) is
			-- Change zone split area to docking zone.
			-- This routine copy from SD_DOCKING_STATE, only change internal_zone to tab_zone.
		require
			a_target_zone_not_void: a_target_zone /= Void
			direction_valid: direction = {SD_DOCKING_MANAGER}.dock_top or direction = {SD_DOCKING_MANAGER}.dock_bottom
				or direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right
		local
			l_new_split_area: EV_SPLIT_AREA
			l_target_zone_parent: EV_CONTAINER
			l_old_zone_parent_type: STRING
			l_target_zone_parent_split_position: INTEGER
			l_target_zone_parent_spliter: EV_SPLIT_AREA
		do
			-- First, remove current internal_zone from old parent split area.	
			if  tab_zone.parent /= Void then
				l_old_zone_parent_type := tab_zone.parent.generating_type
				tab_zone.parent.prune (tab_zone)
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
				create {EV_VERTICAL_SPLIT_AREA} l_new_split_area
			elseif a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
				create {EV_HORIZONTAL_SPLIT_AREA} l_new_split_area
			end
			if a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_left then
				l_new_split_area.set_first (tab_zone)
				l_new_split_area.set_second (a_target_zone)
			else
				l_new_split_area.set_first (a_target_zone)
				l_new_split_area.set_second (tab_zone)
			end
			l_target_zone_parent.extend (l_new_split_area)
			l_new_split_area.set_proportion (0.5)
			if l_target_zone_parent_spliter /= Void and then l_target_zone_parent_spliter.full then
				if l_target_zone_parent_spliter.maximum_split_position >= l_target_zone_parent_split_position and
					l_target_zone_parent_spliter.minimum_split_position <= l_target_zone_parent_split_position then
						l_target_zone_parent_spliter.set_split_position (l_target_zone_parent_split_position)
				end
			end
			internal_shared.docking_manager.inner_container (tab_zone).remove_empty_split_area
		ensure
			changed: a_target_zone.parent.has (tab_zone)
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
		do
			internal_shared.docking_manager.prune_zone (zone)
			if a_target_zone.is_parent_split then
				l_is_split := True
				l_split_position := a_target_zone.parent_split_position
			end
			l_contents := tab_zone.contents
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
					create l_tab_state.make (l_contents.item, a_target_zone, direction)
					l_contents.item.change_state (l_tab_state)
					first_move_to_docking_zone := False
				else
					l_tab_zone ?= l_tab_state.zone
					create l_tab_state.make_with_tab_zone (l_contents.item, l_tab_zone, direction)
				end
				l_tab_state.set_direction (a_target_zone.state.direction)
				l_contents.forth
			end
			l_tab_state.select_tab (internal_content)

			if l_is_split then
				l_split ?= l_tab_state.zone.parent
				check l_split /= Void end
				if l_split.full then
					l_split.set_split_position (l_split_position)
				end
			end
		ensure
--			moved: old a_target_zone.parent.has (tab_zone)
		end

	move_tab_to_docking_zone (a_target_zone: SD_DOCKING_ZONE) is
			-- Move one tab from a tab zone to a docking zone.
		require
			a_target_zone_not_void: a_target_zone /= Void
		local
			l_tab_state: SD_TAB_STATE
		do
			tab_zone.disable_on_select_tab
			tab_zone.prune (internal_content)
			if internal_content.user_widget.parent /= Void then
				internal_content.user_widget.parent.prune (internal_content.user_widget)
			end
			create l_tab_state.make (internal_content, a_target_zone, direction)
			l_tab_state.set_direction (a_target_zone.state.direction)
			change_state (l_tab_state)
			update_last_content_state
			tab_zone.enable_on_select_tab
		ensure
		-- FIXIT: SD_ZONE should inherit from EV_WIDGET
--			moved: a_target_zone.parent.has (internal_content.state.zone)
		end

	move_tab_to_tab_zone (a_target_zone: SD_TAB_ZONE) is
			-- Move selected tab to `a_target_zone'.
		require
			a_target_zone_not_void: a_target_zone /= Void
		local
			l_tab_state: SD_TAB_STATE
		do
			tab_zone.disable_on_select_tab
			tab_zone.prune (internal_content)
			create l_tab_state.make_with_tab_zone (internal_content, a_target_zone, direction)
			change_state (l_tab_state)
			update_last_content_state
			tab_zone.enable_on_select_tab
		ensure
--			moved: a_target_zone.parent.has (internal_content.state.zone)
		end

	dock_whole_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Dock whole zone at top of  `a_multi_dock_area'
		require
			a_multi_dock_area_not_void: a_multi_dock_area /= Void
		local
			l_old_stuff: EV_WIDGET
			l_new_container: EV_SPLIT_AREA
			l_new_split_position: INTEGER
		do
			tab_zone.parent.prune (tab_zone)
			if a_multi_dock_area.full then

				l_old_stuff := a_multi_dock_area.item
				a_multi_dock_area.save_spliter_position (l_old_stuff)
				a_multi_dock_area.prune (l_old_stuff)
			end

			if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
				create {EV_HORIZONTAL_SPLIT_AREA} l_new_container
				l_new_split_position := (internal_shared.docking_manager.container_rectangle.width * internal_shared.default_docking_width_rate).ceiling
			else
				create {EV_VERTICAL_SPLIT_AREA} l_new_container
				l_new_split_position := (internal_shared.docking_manager.container_rectangle.height * internal_shared.default_docking_height_rate).ceiling
			end

			if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_top then
				l_new_container.set_first ( tab_zone)
				if l_old_stuff /= Void then
					l_new_container.set_second (l_old_stuff)
				end
			else
				l_new_container.set_second (tab_zone)
				if l_old_stuff /= Void then
					l_new_container.set_first (l_old_stuff)
					if direction = {SD_DOCKING_MANAGER}.dock_right or direction = {SD_DOCKING_MANAGER}.dock_bottom then
--						l_new_container.set_split_position (l_new_container.maximum_split_position - l_new_split_position)
						l_new_container.set_split_position (l_new_split_position)
					else
						l_new_container.set_split_position (l_new_split_position)
					end
				end
			end

			a_multi_dock_area.extend (l_new_container)
			if l_old_stuff /= Void then
				a_multi_dock_area.restore_spliter_position (l_old_stuff)
			end
		ensure
			docked: top_has_zone (a_multi_dock_area)
		end

	dock_tab_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Dock selected tab at top of `a_multi_dock_area'.
		require
			a_multi_dock_area_not_void: a_multi_dock_area /= Void
		local
			l_width_height: INTEGER
			l_docking_state: SD_DOCKING_STATE
		do
			tab_zone.disable_on_select_tab
			if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
				l_width_height := (a_multi_dock_area.width * 0.2).ceiling
			else
				l_width_height := (a_multi_dock_area.height * 0.2).ceiling
			end
--			tab_zone.contents.prune (internal_content)
			tab_zone.prune (internal_content)
			create l_docking_state.make (internal_content, direction, l_width_height)
			l_docking_state.dock_at_top_level (a_multi_dock_area)
			change_state (l_docking_state)

			update_last_content_state
			tab_zone.enable_on_select_tab
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
			if tab_zone.count = 1 then
				l_split_area ?= tab_zone.parent
				if l_split_area /= Void then
					l_split_position := l_split_area.split_position
				end
				l_parent := tab_zone.parent
				internal_shared.docking_manager.prune_zone (tab_zone)
				create l_docking_state.make_for_tab_zone (tab_zone.last_content, l_parent, direction)
--				if is_maximized then
--					l_docking_state.set_maximized (is_maximized)
--					l_docking_state.set_main_area_widget_main_area (main_area_widget, main_area)
--				end

				tab_zone.last_content.change_state (l_docking_state)
				tab_zone.last_content.notify_focus_in

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
		ensure
			updated: tab_zone.count = 1 implies tab_zone.last_content.state /= Current
		end

feature {SD_INNER_STATE} -- Internal attibutes.

	tab_zone: SD_TAB_ZONE
			-- SD_TAB_ZONE managed by `Current'.

feature {NONE} -- Implementation attributes.

	first_move_to_docking_zone: BOOLEAN
			-- When move `Current' to a docking zone, first time is different.

	is_drag_title_bar: BOOLEAN
			-- If user dragging title bar? Otherwise user drag a tab.

end
