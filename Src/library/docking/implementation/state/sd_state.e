note
	description: "SD_STATE which manage SD_ZONE baes on different states. A state pattern."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_STATE

inherit
	SD_ACCESS

	SD_DOCKING_MANAGER_HOLDER

feature -- Properties

	content: SD_CONTENT
			-- Attached `internal_content'
		require
			set: is_content_set
		local
			l_result: like internal_content
		do
			l_result := internal_content
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		end

	is_content_set: BOOLEAN
			-- If `internal_content' attached?
		do
			Result := internal_content /= Void
		end

	extend (a_content: like internal_content)
			-- Set `internal_content'
		do
			internal_content := a_content
		end

	direction: INTEGER
			-- Dock top or dock bottom or dock left or dock right? One emueration from {SD_DOCKING_MANAGER}

	set_direction (a_direction: INTEGER)
			-- Set `direction'
		do
			direction := a_direction
		end

	width_height: INTEGER
			-- Width of zone if dock_left or dock_right
			-- Height of zone if dock_top or dock_bottom

	width_height_by_direction: INTEGER
			-- Width of zone if dock left/right, Height of zone if dock top/bottom
		do
			if attached {EV_WIDGET} zone as lt_widget then
				if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
					Result := lt_widget.width
				else
					Result := lt_widget.height
				end
			else
				check not_possible: False end
			end
		end

	set_width_height (a_width_height: INTEGER)
			-- Set `width_height'
		require
			a_widht_height_valid: a_width_height >= 0
		do
			width_height := a_width_height
		ensure
			set: width_height = a_width_height
		end

	zone: detachable SD_ZONE
			-- Zone which is managed by `Current'
		require
			ready: is_zone_attached
		deferred
		end

	set_user_widget (a_widget: EV_WIDGET)
			-- After SD_CONTENT changed `user_widget', we update related container's widget
		deferred
		end

	set_mini_toolbar (a_toolbar_widget: EV_WIDGET)
			-- After SD_CONTENT changed `mini_toolbar', we update related container's mini toolbar
		deferred
		end

	change_tab_tooltip (a_tooltip: detachable STRING_GENERAL)
			-- Set notebook tab tooltip if possible
		do
		end

feature {SD_OPEN_CONFIG_MEDIATOR, SD_CONTENT}  -- Restore

	restore (a_data: SD_INNER_CONTAINER_DATA; a_container: EV_CONTAINER)
			-- `titles' is content name
			--
			-- `a_container' is zone parent
		require
			more_than_one_title: attached a_data.titles as lr_titles and then content_count_valid (lr_titles)
			a_container_not_void: a_container /= Void
			a_container_not_full: not a_container.full
			a_direction_valid: a_data.direction = {SD_ENUMERATION}.top or a_data.direction = {SD_ENUMERATION}.bottom
				or a_data.direction = {SD_ENUMERATION}.left or a_data.direction = {SD_ENUMERATION}.right
		do
			content.set_visible (True)
		end

feature -- Commands

	record_state
			-- Record current state
		do
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA)
			-- Perform a restore
		require
			internal_content_not_void: not content_void
		deferred
		end

	set_focus (a_content: SD_CONTENT)
			-- Set focus
		require
			has_content: has (a_content)
		do
			if is_zone_attached and then attached zone as l_zone then
				l_zone.on_focus_in (a_content)
				docking_manager.property.set_last_focus_content (content)
			end
			if attached {EV_WIDGET} zone as lt_widget then
				if is_zone_attached and then not lt_widget.is_displayed then
					-- Maybe current is hidden, we restore zones normal state in that dock area.
					docking_manager.command.recover_normal_state_in_dock_area_of (zone)
				end
			else
				check not_possible: False end
			end
		end

	show
			-- Handle show zone
		do
		end

	hide
			-- Handle hide zone
		do
		end

	close
			-- Handle close zone
		local
			l_state: SD_STATE_VOID
		do
			if is_zone_attached then
				if attached {EV_WIDGET} zone as lt_widget then
					docking_manager.command.lock_update (lt_widget, False)
				else
					check not_possible: False end
				end
			else
				docking_manager.command.lock_update (Void, True)
			end

			if is_zone_attached then
				docking_manager.command.recover_normal_state_in_dock_area_of (zone)
			end

			if content /= docking_manager.zones.place_holder_content then
				add_place_holder
			end

			if is_zone_attached and then attached zone as l_zone then
				l_zone.close
			end
			docking_manager.zones.prune_zone_by_content (content)
			docking_manager.command.remove_empty_split_area
			docking_manager.command.update_title_bar
			docking_manager.command.unlock_update
			create l_state.make
			l_state.set_content (content)
			change_state (l_state)
		end

	stick (a_direction: INTEGER)
			-- Stick/Unstick a zone
		do
			docking_manager.command.recover_normal_state
		end

	float (a_x, a_y: INTEGER)
			-- Make current window floating
		do
		end

	minimize
			-- Minimize if possible
		local
			l_zone: detachable SD_UPPER_ZONE
		do
			if is_zone_attached then
				l_zone ?= zone
				if l_zone /= Void then
					l_zone.minimize
				end
			end
		end

	set_split_proportion (a_proportion: REAL)
			-- Set parent splitter proportion to `a_proportion' if is possible
		local
			l_parent: detachable EV_SPLIT_AREA
		do
			if attached {EV_WIDGET} zone as lt_widget then
				l_parent ?= lt_widget.parent
				if l_parent /= Void then
					l_parent.set_proportion (a_proportion)
				end
			else
				check not_possible: False end
			end
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER)
			-- Change zone position to `a_target_zone''s parent at `a_direction'
		require
			a_target_zone_not_void: a_target_zone /= Void
		do
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_first: BOOLEAN)
			-- Move to a SD_DOCKING_ZONE, then a_target_zone and `Current' became SD_TAB_ZONE
		require
			a_target_zone_not_void: a_target_zone /= Void
		do
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE; a_index: INTEGER)
			-- Move to a tab zone
		require
			a_target_zone_not_void: a_target_zone /= Void
		do
		end

	auto_hide_tab_with (a_target_content: SD_CONTENT)
			-- When `a_tartget_content' is auto hide state, `content''s auto hide tab dock at side of
			-- `a_target_content' auto hide tab
		require
			a_target_content_not_void: a_target_content /= Void
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
		do
			content.set_visible (True)
			docking_manager.command.lock_update (Void, True)
			create l_auto_hide_state.make_with_friend (content, a_target_content)
			content.change_state (l_auto_hide_state)
			docking_manager.command.unlock_update
		end

	on_normal_max_window
			-- Handle normal\max zone
		require
			set: is_zone_attached
		do
			if is_zone_attached and then attached zone as l_zone then
				l_zone.on_normal_max_window
			end
		end

feature -- Properties

	floating_zone: detachable SD_FLOATING_ZONE
			-- When Current is floating, this is floating zone which Current is in
			-- Otherwise is Void
		local
			l_2_parent: detachable EV_CONTAINER
			l_3_parent: detachable EV_CONTAINER
		do
			if attached {EV_WIDGET} zone as lt_widget then
				if attached lt_widget.parent as l_parent then
					l_2_parent := l_parent.parent
				end
				if l_2_parent /= Void then
					l_3_parent := l_2_parent.parent
				end

				Result ?= l_3_parent
			else
				check not_possible: False end
			end
		end

	last_floating_width: INTEGER
			-- Last floating width (At the beginning the width is default floating width from SD_SHARED)

	set_last_floating_width (a_width: INTEGER)
			-- Set `last_floating_width'
		require
			valid: a_width > 0
		do
			last_floating_width := a_width
		ensure
			set: last_floating_width = a_width
		end

	last_floating_height: INTEGER
			-- Last floating height (At the beginning the height is default floating height from SD_SHARED)

	set_last_floating_height (a_height: INTEGER)
			-- Set `last_floating_height'
		require
			valid: a_height > 0
		do
			last_floating_height := a_height
		ensure
			set: last_floating_height = a_height
		end

feature {SD_CONTENT} -- SD_CONTENT called functions.

	change_short_title (a_title: STRING_GENERAL; a_content: SD_CONTENT)
			-- Change short title
		require
			a_title_not_void: a_title /= Void
		do
		end

	change_long_title (a_title: STRING_GENERAL; a_content: SD_CONTENT)
			-- Change long title
		require
			a_title_not_void: a_title /= Void
		do
		end

	change_pixmap (a_pixmap: EV_PIXMAP; a_content: SD_CONTENT)
			-- Change pixmap
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
		end

feature {SD_AUTO_HIDE_STATE} -- Internal calls

	change_state (a_state: SD_STATE)
			-- Changed `content' state to `a_state'
		require
			a_state_not_void: a_state /= Void
		do
			content.change_state (a_state)
			a_state.set_last_floating_height (last_floating_height)
			a_state.set_last_floating_width (last_floating_width)
		ensure
			changed: content.state = a_state
		end

feature  -- States report

	has (a_content: SD_CONTENT): BOOLEAN
			-- If Current has `a_content'?
		require
			a_content_not_void: a_content /= Void
		do
			Result := internal_content = a_content
		end

	content_void: BOOLEAN
			-- If current a_content void?
		do
			Result := internal_content = Void
		end

	content_count_valid (a_titles: ARRAYED_LIST [STRING_GENERAL]): BOOLEAN
			-- If `a_titles' vaild?
		require
			a_titles_not_void: a_titles /= Void
		do
			Result := a_titles.count >= 1
		end

	is_dock_at_top (a_multi_dock_area: SD_MULTI_DOCK_AREA): BOOLEAN
			-- If `zone' dock at top level of `a_multi_dock_area'?
		local
			l_container: detachable EV_CONTAINER
			l_widget: detachable EV_WIDGET
		do
			l_container ?= a_multi_dock_area.item
			l_widget ?= zone
			check all_zone_is_widget: l_widget /= Void end
			if l_container /= Void then
				Result := l_container.has (l_widget)
			end
		end

	is_zone_attached: BOOLEAN
			-- If `zone' attached ?
		do
			Result := True
		end

feature {NONE} -- Implementation

	add_place_holder
			-- Adde editor place holder if possible
			-- Call this before editor zone closed
		local
			l_mutli_dock_area: SD_MULTI_DOCK_AREA
		do
			-- If it's a eidtor zone, and it's the last editor zone, then we put the SD_PLACE_HOLDER_ZONE in.
			if is_zone_attached and then attached zone as l_zone then -- Maybe it's auto hide state, zone = Void.
				l_mutli_dock_area := docking_manager.query.inner_container (l_zone)
				if l_mutli_dock_area.editor_zone_count = 1 and l_zone.content.type = {SD_ENUMERATION}.editor then
					check not_has: not docking_manager.has_content (docking_manager.zones.place_holder_content) end
					docking_manager.contents.extend (docking_manager.zones.place_holder_content)
					check is_editor: l_zone.content.type = {SD_ENUMERATION}.editor end
					docking_manager.zones.place_holder_content.set_relative (l_zone.content, {SD_ENUMERATION}.top)
				end
			end
		end

	del_place_holder
			-- Del editor place holder if possible
			-- Call this after zone added
		local
			l_mutli_dock_area: SD_MULTI_DOCK_AREA
		do
			-- If it's a eidtor zone, and it's the last editor zone, then we put the SD_PLACE_HOLDER_ZONE in.
			if is_zone_attached and then attached zone as l_zone and then l_zone.type = {SD_ENUMERATION}.editor then
				l_mutli_dock_area := docking_manager.query.inner_container (l_zone)
				if l_mutli_dock_area.editor_zone_count > 1 and then docking_manager.has_content (docking_manager.zones.place_holder_content) then
					docking_manager.zones.place_holder_content.close
				end
			end
		end

	top_split_position (a_direction: INTEGER; a_spliter: EV_SPLIT_AREA): INTEGER
			-- Calculate top split position  when dock at top
		require
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
			a_spliter_not_void: a_spliter /= Void
			a_spliter_full: a_spliter.full
		local
			l_main_rect: EV_RECTANGLE
		do

			l_main_rect := docking_manager.query.container_rectangle
			inspect
				a_direction
			when {SD_ENUMERATION}.top then
				if width_height > a_spliter.minimum_split_position and width_height < a_spliter.maximum_split_position then
					Result := width_height
				else
					if l_main_rect.height /= 0 then
						Result := (l_main_rect.height * internal_shared.default_docking_height_rate).ceiling
					else
						Result := a_spliter.minimum_split_position
					end
				end
			when {SD_ENUMERATION}.bottom then
				if l_main_rect.height -width_height > a_spliter.minimum_split_position and l_main_rect.height - width_height < a_spliter.maximum_split_position then
					Result := l_main_rect.height -width_height
				else
					if l_main_rect.height /= 0 then
						Result := (l_main_rect.height * (1 - internal_shared.default_docking_height_rate)).ceiling
					else
						Result := a_spliter.maximum_split_position
					end
				end
			when {SD_ENUMERATION}.left then
				if width_height > a_spliter.minimum_split_position and width_height < a_spliter.maximum_split_position then
					Result :=width_height
				else
					if l_main_rect.width /= 0 then
						Result := (l_main_rect.width * internal_shared.default_docking_width_rate).ceiling
					else
						Result := a_spliter.minimum_split_position
					end
				end
			when {SD_ENUMERATION}.right then
				if l_main_rect.width - width_height > a_spliter.minimum_split_position and l_main_rect.width - width_height < a_spliter.maximum_split_position then
					Result :=  l_main_rect.width -width_height
				else
					if l_main_rect.width /= 0 then
						Result := (l_main_rect.width * (1 - internal_shared.default_docking_width_rate)).ceiling
					else
						Result := a_spliter.maximum_split_position
					end
				end
			end
			debug ("docking")
				io.put_string ("%N SD_STATE top_split_position: a_spliter.minimum_split_position " + a_spliter.minimum_split_position.out + " a_spliter.maximum_split_position " + a_spliter.maximum_split_position.out)
				io.put_string ("%N                      Result: " + Result.out)
			end
			if Result < a_spliter.minimum_split_position then
				Result := a_spliter.minimum_split_position
			elseif Result > a_spliter.maximum_split_position then
				Result := a_spliter.maximum_split_position
			end
		ensure
			result_valid: Result >= a_spliter.minimum_split_position and Result <= a_spliter.maximum_split_position
		end

	restore_minimize
			-- Restore minimize state
		local
			l_upper_zone: detachable SD_UPPER_ZONE
		do
			l_upper_zone ?= content.state.zone
			if l_upper_zone /= Void then
				l_upper_zone.minimize_for_restore
			end
		end

	update_floating_zone_visible (a_zone: SD_ZONE; a_show_floating: BOOLEAN)
			-- When `restore' for docking and tab state, we should update parent floating zone visible
		require
			not_void: a_zone /= Void
		local
			l_inner_container: SD_MULTI_DOCK_AREA
			l_parent_floating_zone: detachable SD_FLOATING_ZONE
		do
			l_inner_container := docking_manager.query.inner_container (a_zone)
			l_parent_floating_zone := l_inner_container.parent_floating_zone
			if l_parent_floating_zone /= Void and then not l_parent_floating_zone.is_displayed then
				if a_show_floating then
					l_parent_floating_zone.show
				end
			end
		end

	call_show_actions
			-- Call content's show actions if possible
		require
			exists: content.state.zone /= Void
			displayed: attached {EV_WIDGET} content.state.zone as lt_widget implies lt_widget.is_displayed
		do
			if not docking_manager.property.is_opening_config then
				content.show_actions.call (Void)
			end
		end

	internal_content: detachable SD_CONTENT
			-- Content managed by `Current'

	internal_shared: SD_SHARED
			-- All singletons

feature -- Contract support

	initialized: BOOLEAN
			-- If ready to be used?

invariant

	internal_shared_not_void: initialized implies internal_shared /= Void
	last_floating_height_valid: initialized implies last_floating_height >= 0
	last_floating_width_valid: initialized implies last_floating_width >= 0

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
