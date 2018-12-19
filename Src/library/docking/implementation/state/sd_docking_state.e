note
	description: "SD_INNER_STATE which is docking in SD_MULTI_DOCK_AREA."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_STATE

inherit
	SD_SHARED
	SD_STATE_WITH_CONTENT
		redefine
			stick,
			float,
			change_zone_split_area,
			move_to_docking_zone,
			move_to_tab_zone,
			auto_hide_tab_with,
			restore,
			change_long_title,
			change_short_title,
			change_pixmap,
			change_tab_tooltip,
			show,
			hide,
			record_state
		end

create
	make,
	make_for_tab_zone

create {SD_PLACE_HOLDER_ZONE}
	make_for_place_holder_zone

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_direction: INTEGER; a_width_height: INTEGER)
			-- Creation method
		require
			a_content_not_void: a_content /= Void
			a_content_attached: a_content.is_docking_manager_attached
		do
			make_common (a_content, a_direction, a_width_height)
			zone := widget_factory.docking_zone (a_content)
			docking_manager.zones.add_zone (zone)
			initialized := True
		ensure
			set: internal_content = a_content
			set: direction = a_direction
			set: width_height = a_width_height
		end

	make_for_tab_zone (a_content: SD_CONTENT; a_container: EV_CONTAINER; a_direction: INTEGER)
			-- Creation method for SD_TAB_STATE
		require
			a_content_not_void: a_content /= Void
			a_content_attached: a_content.is_docking_manager_attached
			a_container_not_void: a_container /= Void
			a_container_not_full: not a_container.full
		do
			make (a_content, a_direction, 0)
			a_container.extend (zone)
			initialized := True
		ensure
			extended: a_container.has (zone)
		end

	make_for_place_holder_zone (a_content: SD_CONTENT; a_zone: SD_PLACE_HOLDER_ZONE)
			-- Creation method for SD_PLACE_HOLDER_ZONE
		require
			a_content_not_void: a_content /= Void
			a_content_attached: a_content.is_docking_manager_attached
			a_zone_not_void: a_zone /= Void
			a_zone_not_destroyed: not a_zone.is_destroyed
			a_zone_parented: a_zone.parent /= Void
		local
			l_zones: SD_DOCKING_MANAGER_ZONES
		do
			make_common (a_content, a_content.state.direction, a_content.state.width_height)
			zone := a_zone
			l_zones := docking_manager.zones
			if not l_zones.has_zone (a_zone) then
				l_zones.add_zone (a_zone)
			end

			change_state (Current)

			initialized := True
		end

	make_common (a_content: SD_CONTENT; a_direction: INTEGER; a_width_height: INTEGER)
			-- Initialize common part
		require
			a_content_not_void: a_content /= Void
			a_content_attached: a_content.is_docking_manager_attached
		do
			set_docking_manager (a_content.docking_manager)
			direction := a_direction
			width_height := a_width_height
			internal_content := a_content

			last_floating_height := a_content.state.last_floating_height
			last_floating_width := a_content.state.last_floating_width
		end

feature {SD_TAB_STATE_ASSISTANT} -- Initialization

	set_widget_main_area (a_widget: EV_WIDGET; a_main_area: SD_MULTI_DOCK_AREA; a_parent: EV_CONTAINER; a_split_position: INTEGER)
			-- Set widget and main area which used by normal window
		require
			a_widget_not_void: a_widget /= Void
			a_main_area_not_void: a_main_area /= Void
			a_parent_not_void: a_parent /= Void
		do
			zone.set_max (True)
			zone.set_widget_main_area (a_widget, a_main_area, a_parent, a_split_position)
		end

feature  -- States report

	value: INTEGER
		do
			Result := {SD_ENUMERATION}.docking
		end

feature -- Redefine

	restore (a_data: SD_INNER_CONTAINER_DATA; a_container: EV_CONTAINER)
			-- <Precursor>
		do
			-- create internal_shared
			if attached a_data.titles as l_titles then
				l_titles.start
					-- If we don't find SD_CONTENT, ignore it.
				if attached docking_manager.query.content_by_title_for_restore (l_titles.item) as l_content then
					internal_content := l_content
					Precursor (a_data, a_container)
					make (l_content, a_data.direction, 1)
					a_container.extend (zone)
					change_state (Current)
				end
			else
				check from_precondition_more_than_one_title: False end
			end

			if a_data.is_minimized then
				restore_minimize
			end

			-- When SD_OPEN_CONFIG_MEDIATOR.open_inner_container_data, `zone' maybe void
			-- since Current is initialized by {INTERNAL}.new_instance_of
--			if is_zone_attached and then zone /= Void then
				update_floating_zone_visible (zone, a_data.is_visible)
--			end
			initialized := True
		end

	record_state
			-- <Precursor>
		local
			l_floating_zone: like floating_zone
		do
			l_floating_zone := floating_zone
			if l_floating_zone /= Void then
				check valid_height: l_floating_zone.height > 0 end
				check valid_width: l_floating_zone.width > 0 end
				last_floating_height := l_floating_zone.height
				last_floating_width := l_floating_zone.width
			end
		end

	change_long_title (a_title: READABLE_STRING_GENERAL; a_content: SD_CONTENT)
			-- <Precursor>
		do
			if attached content as l_content and then l_content.type = {SD_ENUMERATION}.tool then
				zone.set_title (a_title)
			end
		ensure then
			set: attached content as l_content and then l_content.type = {SD_ENUMERATION}.tool and then a_title /= Void
			 implies zone.title.same_string_general (a_title)
		end

	change_short_title (a_title: READABLE_STRING_GENERAL; a_content: SD_CONTENT)
			-- <Precursor>
		do
			if attached content as l_content and then l_content.type = {SD_ENUMERATION}.editor then
				zone.set_title (a_title)
			end
		ensure then
			set: attached content as l_content and then l_content.type = {SD_ENUMERATION}.editor and then a_title /= Void
			 implies zone.title.same_string_general (a_title)
		end

	change_pixmap (a_pixmap: EV_PIXMAP; a_content: SD_CONTENT)
			-- <Precursor>
		do
			zone.set_pixmap (a_pixmap)
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA)
			-- <Precursor>
		local
			l_old_stuff: detachable EV_WIDGET
			l_old_spliter: detachable EV_SPLIT_AREA
			l_new_container: EV_SPLIT_AREA
			l_retried: BOOLEAN
			l_called: BOOLEAN
			l_main_container: detachable SD_MULTI_DOCK_AREA
		do
			if not l_retried then
				docking_manager.command.lock_update (zone, False)

				-- Only in this case, del editor place holder make sense
				del_place_holder

				record_state
				if attached zone.parent as l_parent then
					l_parent.prune (zone)
					l_main_container := docking_manager.query.inner_container (zone)
				end

				docking_manager.command.lock_update (Void, True)
				l_called := True

				if a_multi_dock_area.full then
					l_old_stuff := a_multi_dock_area.item
					if attached {EV_SPLIT_AREA} l_old_stuff as spl then
						l_old_spliter := spl
						a_multi_dock_area.save_spliter_position (l_old_spliter, generating_type.name_32)
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
					a_multi_dock_area.restore_spliter_position (l_old_spliter, generating_type.name_32)
				end
				docking_manager.command.remove_empty_split_area
				docking_manager.command.update_title_bar
				docking_manager.query.inner_container_main.update_middle_container
				if l_main_container /= Void then
					l_main_container.update_visible
				end
				docking_manager.command.resize (True)
				docking_manager.command.unlock_update
				docking_manager.command.unlock_update
			end
		ensure then
			is_dock_at_top: old a_multi_dock_area.full implies is_dock_at_top (a_multi_dock_area)
		rescue
			if not l_retried then
				docking_manager.command.unlock_update
				if l_called then
					docking_manager.command.unlock_update
				end
				l_retried := True
				retry
			end
		end

	stick (a_direction: INTEGER)
			-- <Precursor>
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
			l_width_height: INTEGER
		do
			docking_manager.command.lock_update (zone, False)
			Precursor (a_direction)
			-- We must do it before the widget off-screen on GTK
			l_width_height := width_height_by_direction
			-- Change current content's zone to a SD_AUTO_HIDE_ZONE
			docking_manager.zones.prune_zone (zone)

			-- Change state
			create l_auto_hide_state.make_with_size (content, a_direction, l_width_height)
			l_auto_hide_state.set_width_height (l_width_height)
			change_state (l_auto_hide_state)
			docking_manager.query.inner_container_main.remove_empty_split_area
			docking_manager.query.inner_container_main.update_middle_container
			-- We have to clear last focus content. Otherwise, when user select it in ctrl + tab dialog, it will not appear.
			-- See bug#13101
			docking_manager.property.set_last_focus_content (Void)
			docking_manager.command.unlock_update
		ensure then
			state_changed: content.state /= Current
		end

	float (a_x, a_y: INTEGER)
			-- <Precursor>
		local
			l_floating_state: SD_FLOATING_STATE
			l_orignal_multi_dock_area: SD_MULTI_DOCK_AREA
		do
			l_orignal_multi_dock_area := docking_manager.query.inner_container (zone)
			if l_orignal_multi_dock_area.has (zone) and attached l_orignal_multi_dock_area.parent_floating_zone as l_floating_zone then
				l_floating_zone.set_position (a_x, a_y)
			else
				docking_manager.command.lock_update (zone, False)
				create l_floating_state.make (a_x, a_y, docking_manager, True)
				l_floating_state.set_size (last_floating_width, last_floating_height)
				dock_at_top_level (l_floating_state.inner_container)
				l_floating_state.update_title_bar
				l_orignal_multi_dock_area.update_title_bar
				docking_manager.command.remove_empty_split_area
				docking_manager.command.unlock_update
			end
			docking_manager.command.update_title_bar

			docking_manager.query.inner_container_main.recover_normal_for_only_one
			-- After floating, left minmized editor zones in SD_MULTI_DOCK_AREA, then we
			-- have to resize
			docking_manager.command.resize (True)
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER)
			-- <Precursor>
		local
			l_called: BOOLEAN
			l_retried: BOOLEAN
		do
			if not l_retried then
				docking_manager.command.lock_update (zone, False)

				record_state
				if attached zone.parent as l_parent then
					l_parent.prune (zone)
				end
				if attached {EV_WIDGET} a_target_zone as lt_target_widget then
					docking_manager.command.lock_update (lt_target_widget, False)
				else
					check not_possible: False end
				end

				l_called := True

				change_zone_split_area_to_zone (a_target_zone, a_direction)
				docking_manager.command.update_title_bar
				docking_manager.query.inner_container_main.update_middle_container
				docking_manager.command.unlock_update
				docking_manager.command.unlock_update
			end
		ensure then
			parent_changed: old zone.parent /= zone.parent
		rescue
			if not l_retried then
				docking_manager.command.unlock_update
				if l_called then
					docking_manager.command.unlock_update
				end
				l_retried := True
				retry
			end
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_first: BOOLEAN)
			-- <Precursor>
		do
			move_to_zone_internal (a_target_zone, a_first)
		ensure then
			state_changed: content.state /= Current
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE; a_index: INTEGER)
			-- <Precursor>
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

	auto_hide_tab_with (a_target_content: SD_CONTENT)
			-- <Precursor>
		do
			docking_manager.command.lock_update (zone, False)
			docking_manager.command.recover_normal_state
			docking_manager.command.remove_auto_hide_zones (False)
			docking_manager.zones.prune_zone (zone)
			docking_manager.command.remove_empty_split_area
			docking_manager.command.update_title_bar
			docking_manager.command.unlock_update
			Precursor (a_target_content)
		end

	show
			-- <Precursor>
		local
			l_multi_dock_area: SD_MULTI_DOCK_AREA
			l_state_void: SD_STATE_VOID
			l_platform: PLATFORM
			l_is_main_container: BOOLEAN
			l_old_screen_x, l_old_screen_y: INTEGER
		do
			l_multi_dock_area := docking_manager.query.inner_container (zone)
			l_is_main_container :=  l_multi_dock_area /= Void and then docking_manager.query.is_main_inner_container (l_multi_dock_area)

			docking_manager.command.recover_normal_state_in_dock_area_of (zone)

			zone.show
			show_all_split_parent (zone)
			docking_manager.command.resize (False)

			if attached l_multi_dock_area then
				if not l_is_main_container then
					if attached l_multi_dock_area.parent_floating_zone as l_floating_zone then
						create l_platform
						if not l_platform.is_windows then
							-- On GTK, windows size will not be remembered after hide
							l_floating_zone.set_width (last_floating_width)
							l_floating_zone.set_height (last_floating_height)
							-- On GTK, screen y is not correct after shown sometimes, see bug#12375
							-- We have to set it again later.
							l_old_screen_y := l_floating_zone.screen_y
							l_old_screen_x := l_floating_zone.screen_x
						end
						l_floating_zone.show
						if not l_platform.is_windows then
							l_floating_zone.set_position (l_old_screen_x, l_old_screen_y)
						end
					end
					l_multi_dock_area.update_title_bar
				else
					l_multi_dock_area.update_middle_container
				end
			end

			if zone.is_displayed then
				call_show_actions
			else
				-- `parent_floating_zone' doesn't exist on screen anymore, it was destroyed when open_config (from SD_CONFIG_MEDIATOR),
				-- and current content doesn't have layout information restored when open_config, so let it use SD_STATE_VOID's default behavior.
				create l_state_void.make (content, docking_manager)
				change_state (l_state_void)
				l_state_void.show
			end
		end

	hide
			-- <Precursor>
		do
			Precursor
			if not zone.is_displayed or zone.is_maximized then
				docking_manager.command.recover_normal_state_in_dock_area_of (zone)
			end

			zone.hide
			if
				attached {EV_SPLIT_AREA} zone.parent as l_spliter and then
				l_spliter.is_displayed and then
				attached l_spliter.first as l_first and then
				attached l_spliter.second as l_second and then
				not l_first.is_displayed and then
				not l_second.is_displayed
			then
				l_spliter.hide
			end

			if attached docking_manager.query.inner_container (zone) as l_multi_dock_area then
				if not docking_manager.query.is_main_inner_container (l_multi_dock_area) then
					l_multi_dock_area.update_title_bar
				else
					l_multi_dock_area.update_middle_container
				end
			end
			docking_manager.command.resize (False)
		end

	set_user_widget (a_widget: EV_WIDGET)
			-- <Precursor>
		do
			zone.update_user_widget
		end

	set_mini_toolbar (a_toolbar_widget: EV_WIDGET)
			-- <Precursor>
		do
			zone.update_mini_toolbar
		end

	change_tab_tooltip (a_text: detachable READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			if
				attached {SD_DOCKING_ZONE_UPPER} zone as l_upper and then
				attached l_upper.notebook.tab_by_content (content) as l_tab
			then
				l_tab.set_tool_tip (a_text)
			end
		end

	zone: SD_DOCKING_ZONE
			-- <Precursor>

feature {NONE} -- Implementation

	move_to_zone_internal (a_target_zone: SD_ZONE; a_first: BOOLEAN)
			-- Move to a zone
		local
			l_tab_state: detachable SD_TAB_STATE
			l_original_direction: INTEGER
		do
			docking_manager.command.lock_update (zone, False)
			docking_manager.zones.prune_zone (zone)
			l_original_direction := a_target_zone.state.direction

			if attached {EV_WIDGET} a_target_zone as lt_widget then
				docking_manager.command.lock_update (lt_widget, False)
			else
				check not_possible: False end
			end
			if attached {SD_DOCKING_ZONE} a_target_zone as l_docking_zone then
				create l_tab_state.make (content, l_docking_zone, l_original_direction)
			elseif attached {SD_TAB_ZONE} a_target_zone as l_tab_zone then
				create l_tab_state.make_with_tab_zone (content, l_tab_zone, l_original_direction)
			else
				check only_allow_two_type_zone: False end
			end
			if a_first and l_tab_state /= Void then
				l_tab_state.zone.set_content_position (content, 1)
			end
			docking_manager.command.unlock_update
			if l_tab_state /= Void then
				l_tab_state.set_direction (l_original_direction)
			end
			docking_manager.command.remove_empty_split_area
			if l_tab_state /= Void then
				change_state (l_tab_state)
			end
			docking_manager.command.unlock_update
			docking_manager.command.update_title_bar
		end

	change_zone_split_area_to_zone (a_target_zone: SD_ZONE; a_direction: INTEGER)
			-- Change zone parent split area to docking zone
		require
			a_target_zone_not_void: a_target_zone /= Void
		local
			l_new_split_area: detachable EV_SPLIT_AREA
			l_target_zone_parent: detachable EV_CONTAINER
			l_target_zone_parent_split_position: INTEGER
			l_target_zone_parent_spliter: detachable EV_SPLIT_AREA
		do
			-- First, remove current zone from old parent split area
			if attached {EV_WIDGET} a_target_zone as lt_widget then
				l_target_zone_parent := lt_widget.parent

				if attached lt_widget.parent as l_parent then
					-- Remember target zone parent split position
					if attached {EV_SPLIT_AREA} lt_widget.parent as spl then
						l_target_zone_parent_spliter := spl
						l_target_zone_parent_split_position := l_target_zone_parent_spliter.split_position
					end
					l_parent.prune (lt_widget)
				end

				check l_target_zone_parent /= Void and then not l_target_zone_parent.full end
					-- Then, insert current zone to new split area base on  `a_direction'.
				if a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom then
					create {SD_VERTICAL_SPLIT_AREA} l_new_split_area
				else
					check a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right end
					create {SD_HORIZONTAL_SPLIT_AREA} l_new_split_area
				end
				if a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.left then
					l_new_split_area.set_first (zone)
					l_new_split_area.set_second (lt_widget)
				else
					l_new_split_area.set_first (lt_widget)
					l_new_split_area.set_second (zone)
				end
				if attached l_target_zone_parent then
					l_target_zone_parent.extend (l_new_split_area)
				end

				if l_target_zone_parent_spliter /= Void and then (l_target_zone_parent_spliter.full and
					 l_target_zone_parent_spliter.minimum_split_position <= l_target_zone_parent_split_position and
					 	l_target_zone_parent_spliter.maximum_split_position >= l_target_zone_parent_split_position) then
					l_target_zone_parent_spliter.set_split_position (l_target_zone_parent_split_position)
				end
				-- If we don't resize here and content is in top level,
				-- content's widget will be minimum size
				docking_manager.command.resize (False)

				l_new_split_area.set_proportion ({REAL_32} 0.5)
				set_direction (a_target_zone.state.direction)
				docking_manager.command.remove_empty_split_area
			else
				check not_possible: False end
			end
		ensure
			changed:
		end

	show_all_split_parent (a_zone: SD_ZONE)
			-- Show all spliter parent of `a_zone' to make sure `a_zone' will displayed
		require
			not_void: a_zone /= Void
		local
			l_widget: detachable EV_WIDGET
		do
			if attached {EV_WIDGET} a_zone as w then
				l_widget := w
				from
				until
					not attached {EV_SPLIT_AREA} l_widget.parent as l_spliter
				loop
					if not l_spliter.is_displayed then
						l_spliter.show
					end
					l_widget := l_spliter
				end
			else
				check a_zone_is_widget: False end
			end
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
