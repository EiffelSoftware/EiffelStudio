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
			auto_hide_tab_with,
			restore,
			zone,
			change_title,
			change_pixmap,
			change_tab_tooltip,
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
			initialized := True
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

	restore (a_data: SD_INNER_CONTAINER_DATA; a_container: EV_CONTAINER) is
			-- Redefine.
		local
			l_content: SD_CONTENT
			l_titles: ARRAYED_LIST [STRING_GENERAL]
		do
			create internal_shared
			l_titles := a_data.titles
			l_titles.start
			l_content := internal_docking_manager.query.content_by_title_for_restore (l_titles.item)

			-- If we don't find SD_CONTENT, ignore it.
			if l_content /= Void then
				internal_content := l_content
				Precursor {SD_STATE} (a_data, a_container)
				make (l_content, {SD_ENUMERATION}.left, 1)
				a_container.extend (zone)
				change_state (Current)
				direction := a_data.direction
			end

			if a_data.is_minimized then
				restore_minimize
			end

			-- When SD_OPEN_CONFIG_MEDIATOR.open_inner_container_data, `zone' maybe void.
			if zone /= Void then
				update_floating_zone_visible (zone, a_data.is_visible)
			end
			initialized := True
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

	change_title (a_title: STRING_GENERAL; a_content: SD_CONTENT) is
			-- Redefine.
		do
			zone.set_title (a_title)
		ensure then
			set: zone.title = a_title
		end

	change_pixmap (a_pixmap: EV_PIXMAP; a_content: SD_CONTENT) is
			-- Refine
		do
			zone.set_pixmap (a_pixmap)
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Redefine.
		local
			l_old_stuff: EV_WIDGET
			l_old_spliter: EV_SPLIT_AREA
			l_new_container: EV_SPLIT_AREA
			l_retried: BOOLEAN
			l_called: BOOLEAN
			l_main_container: SD_MULTI_DOCK_AREA
		do
			if not l_retried then
				internal_docking_manager.command.lock_update (zone, False)

				-- Only in this case, del editor place holder make sense.
				del_place_holder

				record_state
				if zone.parent /= Void then
					zone.parent.prune (zone)
					l_main_container := internal_docking_manager.query.inner_container (zone)
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

				if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
					create {SD_HORIZONTAL_SPLIT_AREA} l_new_container
				else
					create {SD_VERTICAL_SPLIT_AREA} l_new_container
				end

				a_multi_dock_area.extend (l_new_container)

				if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.top then
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
				internal_docking_manager.query.inner_container_main.update_middle_container
				if l_main_container /= Void then
					l_main_container.update_visible
				end
				internal_docking_manager.command.resize (True)
				internal_docking_manager.command.unlock_update
				internal_docking_manager.command.unlock_update
			end
		ensure then
			is_dock_at_top: old a_multi_dock_area.full implies is_dock_at_top (a_multi_dock_area)
		rescue
			if not l_retried then
				internal_docking_manager.command.unlock_update
				if l_called then
					internal_docking_manager.command.unlock_update
				end
				l_retried := True
				retry
			end
		end

	stick (a_direction: INTEGER) is
				-- Redefine.
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
			l_width_height: INTEGER
		do
			internal_docking_manager.command.lock_update (zone, False)
			Precursor {SD_STATE} (a_direction)
			-- We must do it before the widget off-screen on GTK.
			l_width_height := width_height_by_direction
			-- Change current content's zone to a SD_AUTO_HIDE_ZONE.
			internal_docking_manager.zones.prune_zone (zone)

			-- Change state.
			create l_auto_hide_state.make_with_size (internal_content, a_direction, l_width_height)
			l_auto_hide_state.set_width_height (l_width_height)
			change_state (l_auto_hide_state)
			internal_docking_manager.query.inner_container_main.remove_empty_split_area
			internal_docking_manager.query.inner_container_main.update_middle_container
			-- We have to clear last focus content. Otherwise, when user select it in ctrl + tab dialog, it will not appear.
			-- See bug#13101
			internal_docking_manager.property.set_last_focus_content (Void)
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
				create l_floating_state.make (a_x, a_y, internal_docking_manager, True)
				l_floating_state.set_size (last_floating_width, last_floating_height)
				dock_at_top_level (l_floating_state.inner_container)
				l_floating_state.update_title_bar
				l_orignal_multi_dock_area.update_title_bar
				internal_docking_manager.command.remove_empty_split_area
				internal_docking_manager.command.unlock_update
			end
			internal_docking_manager.command.update_title_bar

			internal_docking_manager.query.inner_container_main.recover_normal_for_only_one
			-- After floating, left minmized editor zones in SD_MULTI_DOCK_AREA, then we
			-- have to resize.
			internal_docking_manager.command.resize (True)
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
				internal_docking_manager.query.inner_container_main.update_middle_container
				internal_docking_manager.command.unlock_update
				internal_docking_manager.command.unlock_update
			end
		ensure then
			parent_changed: old zone.parent /= zone.parent
		rescue
			if not l_retried then
				internal_docking_manager.command.unlock_update
				if l_called then
					internal_docking_manager.command.unlock_update
				end
				l_retried := True
				retry
			end
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

	auto_hide_tab_with (a_target_content: SD_CONTENT) is
			-- Redefine
		do
			if zone /= Void then
				internal_docking_manager.command.lock_update (zone, False)
				internal_docking_manager.command.recover_normal_state
				internal_docking_manager.command.remove_auto_hide_zones (False)
				internal_docking_manager.zones.prune_zone (zone)
				internal_docking_manager.command.remove_empty_split_area
				internal_docking_manager.command.update_title_bar
				internal_docking_manager.command.unlock_update
			end
			Precursor {SD_STATE} (a_target_content)
		end

	show is
			-- Redefine.
		local
			l_multi_dock_area: SD_MULTI_DOCK_AREA
			l_state_void: SD_STATE_VOID
			l_platform: PLATFORM
			l_floating_zone: SD_FLOATING_ZONE
			l_is_main_container: BOOLEAN
			l_old_screen_x, l_old_screen_y: INTEGER
		do
			l_multi_dock_area := internal_docking_manager.query.inner_container (zone)
			l_is_main_container :=  l_multi_dock_area /= Void and then internal_docking_manager.query.is_main_inner_container (l_multi_dock_area)

			docking_manager.command.recover_normal_state_in_dock_area_of (zone)

			zone.show
			show_all_split_parent (zone)
			docking_manager.command.resize (False)

			if not l_is_main_container then
				l_floating_zone := l_multi_dock_area.parent_floating_zone
				create l_platform
				if not l_platform.is_windows then
					-- On GTK, windows size will not be remembered after hide.
					l_floating_zone.set_width (last_floating_width)
					l_floating_zone.set_height (last_floating_height)
					-- On GTK, screen y is not correct after shown sometimes, see bug#12375.
					-- We have to set it again later.
					l_old_screen_y := l_floating_zone.screen_y
					l_old_screen_x := l_floating_zone.screen_x
				end
				l_floating_zone.show
				if not l_platform.is_windows then
					l_floating_zone.set_position (l_old_screen_x, l_old_screen_y)
				end
				l_multi_dock_area.update_title_bar
			else
				l_multi_dock_area.update_middle_container
			end

			if not zone.is_displayed then
				-- `parent_floating_zone' doesn't exist on screen anymore, it was destroyed when open_config (from SD_CONFIG_MEDIATOR),
				-- and current content doesn't have layout information restored when open_config, so let it use SD_STATE_VOID's default behavior.
				create l_state_void.make (content)
				change_state (l_state_void)
				l_state_void.show
			end
		end

	hide is
			-- Redefine.
		local
			l_multi_dock_area: SD_MULTI_DOCK_AREA
			l_spliter: EV_SPLIT_AREA
		do
			Precursor {SD_STATE}
			if not zone.is_displayed or zone.is_maximized then
				internal_docking_manager.command.recover_normal_state_in_dock_area_of (zone)
			end

			zone.hide
			l_spliter ?= zone.parent
			if l_spliter /= Void and then l_spliter.is_displayed then
				if l_spliter.full and then (not l_spliter.first.is_displayed and not l_spliter.second.is_displayed) then
					l_spliter.hide
				end
			end

			l_multi_dock_area := internal_docking_manager.query.inner_container (zone)
			if l_multi_dock_area /= Void then
				if not internal_docking_manager.query.is_main_inner_container (l_multi_dock_area) then
					l_multi_dock_area.update_title_bar
				else
					l_multi_dock_area.update_middle_container
				end
			end
			docking_manager.command.resize (False)
		end

	set_user_widget (a_widget: EV_WIDGET) is
			-- Redefine
		do
			zone.update_user_widget
		end

	change_tab_tooltip (a_text: STRING_GENERAL) is
			-- Redefine
		local
			l_upper: SD_DOCKING_ZONE_UPPER
			l_tab: SD_NOTEBOOK_TAB
		do
			l_upper ?= zone
			if l_upper /= Void then
				l_tab := l_upper.notebook.tab_by_content (content)
				if l_tab /= Void then
					l_tab.set_tool_tip (a_text)
				end
			end
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
			if a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom then
				create {SD_VERTICAL_SPLIT_AREA} l_new_split_area
			elseif a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right then
				create {SD_HORIZONTAL_SPLIT_AREA} l_new_split_area
			end
			if a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.left then
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

	show_all_split_parent (a_zone: SD_ZONE) is
			-- Show all spliter parent of `a_zone' to make sure `a_zone' will displayed.
		require
			not_void: a_zone /= Void
		local
			l_spliter: EV_SPLIT_AREA
			l_widget: EV_WIDGET
		do
			from
				l_widget := a_zone
				l_spliter ?= l_widget.parent
			until
				l_spliter = Void
			loop
				if l_spliter /= Void and then not l_spliter.is_displayed then
					l_spliter.show
				end
				l_widget := l_widget.parent
				l_spliter ?= l_widget.parent
			end
		end

invariant

	internal_zone_not_void: initialized implies zone /= Void

indexing
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
