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

	DEBUG_OUTPUT

feature -- Properties

	direction: INTEGER
			-- Dock top or dock bottom or dock left or dock right? One enumeration from {SD_DOCKING_MANAGER}

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
			-- Zone which is managed by `Current' (if any).
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

	change_tab_tooltip (a_tooltip: detachable READABLE_STRING_GENERAL)
			-- Set notebook tab tooltip if possible
		do
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

	show
			-- Handle show zone
		do
		end

	hide
			-- Handle hide zone
		do
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
		do
			if attached {SD_UPPER_ZONE} zone as z then
				z.minimize
			end
		end

	set_split_proportion (a_proportion: REAL)
			-- Set parent splitter proportion to `a_proportion' if is possible
		do
			if attached {EV_WIDGET} zone as lt_widget then
				if attached {EV_SPLIT_AREA} lt_widget.parent as l_parent then
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

	on_normal_max_window
			-- Handle normal\max zone
		require
			set: attached zone
		do
			if attached zone as l_zone then
				l_zone.on_normal_max_window
			end
		end

feature -- Properties

	floating_zone: detachable SD_FLOATING_ZONE
			-- When Current is floating, this is floating zone which Current is in
			-- Otherwise is Void
		local
			l_parent: detachable EV_CONTAINER
		do
			if attached {EV_WIDGET} zone as lt_widget then
				l_parent := lt_widget.parent
				if l_parent /= Void then
					l_parent := l_parent.parent
				end
				if
					l_parent /= Void and then
					attached {SD_FLOATING_ZONE} l_parent.parent as l_floating_zone
				then
					Result := l_floating_zone
				end
			else
				check not_possible: False end
			end
		end

	last_floating_width: INTEGER
			-- Last floating width (At the beginning the width is default floating width from SD_SHARED)

	set_last_floating_width (a_width: INTEGER)
			-- Set `last_floating_width'
		require
			valid: a_width >= 0
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
			valid: a_height >= 0
		do
			last_floating_height := a_height
		ensure
			set: last_floating_height = a_height
		end

feature {SD_CONTENT} -- SD_CONTENT called functions.

	change_short_title (a_title: READABLE_STRING_GENERAL; a_content: SD_CONTENT)
			-- Change short title
		require
			a_title_not_void: a_title /= Void
		do
		end

	change_long_title (a_title: READABLE_STRING_GENERAL; a_content: SD_CONTENT)
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

feature  -- Status report

	value: INTEGER
			-- State value, see {SD_ENUMERATION} -- State
		deferred
		ensure
			valid: (create {SD_ENUMERATION}).is_state_valid (Result)
		end

	content_void: BOOLEAN
			-- If current a_content void?
		deferred
		end

	content_count_valid (a_titles: ARRAYED_LIST [READABLE_STRING_GENERAL]): BOOLEAN
			-- If `a_titles' vaild?
		require
			a_titles_not_void: a_titles /= Void
		do
			Result := a_titles.count >= 1
		end

	is_dock_at_top (a_multi_dock_area: SD_MULTI_DOCK_AREA): BOOLEAN
			-- If `zone' dock at top level of `a_multi_dock_area'?
		do
			if
				attached {EV_WIDGET} zone as l_widget and then
				attached {EV_CONTAINER} a_multi_dock_area.item as l_container
			then
				Result := l_container.has (l_widget)
			end
		end

feature {NONE} -- Implementation

	add_place_holder
			-- Adde editor place holder if possible
			-- Call this before editor zone closed
		local
			l_mutli_dock_area: SD_MULTI_DOCK_AREA
		do
				-- If it's a eidtor zone, and it's the last editor zone, then we put the SD_PLACE_HOLDER_ZONE in.
			if attached zone as l_zone then -- Maybe it's auto hide state, zone = Void.
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
			if attached zone as l_zone and then l_zone.type = {SD_ENUMERATION}.editor then
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
						Result := (l_main_rect.height * {SD_SHARED}.default_docking_height_rate).ceiling
					else
						Result := a_spliter.minimum_split_position
					end
				end
			when {SD_ENUMERATION}.bottom then
				if l_main_rect.height -width_height > a_spliter.minimum_split_position and l_main_rect.height - width_height < a_spliter.maximum_split_position then
					Result := l_main_rect.height -width_height
				else
					if l_main_rect.height /= 0 then
						Result := (l_main_rect.height * (1 - {SD_SHARED}.default_docking_height_rate)).ceiling
					else
						Result := a_spliter.maximum_split_position
					end
				end
			when {SD_ENUMERATION}.left then
				if width_height > a_spliter.minimum_split_position and width_height < a_spliter.maximum_split_position then
					Result :=width_height
				else
					if l_main_rect.width /= 0 then
						Result := (l_main_rect.width * {SD_SHARED}.default_docking_width_rate).ceiling
					else
						Result := a_spliter.minimum_split_position
					end
				end
			when {SD_ENUMERATION}.right then
				if l_main_rect.width - width_height > a_spliter.minimum_split_position and l_main_rect.width - width_height < a_spliter.maximum_split_position then
					Result :=  l_main_rect.width -width_height
				else
					if l_main_rect.width /= 0 then
						Result := (l_main_rect.width * (1 - {SD_SHARED}.default_docking_width_rate)).ceiling
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

	update_floating_zone_visible (a_zone: SD_ZONE; a_show_floating: BOOLEAN)
			-- When `restore' for docking and tab state, we should update parent floating zone visible.
		require
			not_void: a_zone /= Void
		local
			l_inner_container: SD_MULTI_DOCK_AREA
			l_parent_floating_zone: SD_FLOATING_ZONE
		do
			l_inner_container := docking_manager.query.inner_container (a_zone)
			l_parent_floating_zone := l_inner_container.parent_floating_zone
			if
				attached l_parent_floating_zone and then
				not l_parent_floating_zone.is_displayed and then
				a_show_floating
			then
				l_parent_floating_zone.show
			end
		end

feature -- Contract support

	initialized: BOOLEAN
			-- If ready to be used?

feature -- Status report

	debug_output: STRING_32
		do
			create Result.make_empty
			Result.append_string_general ("dir=")
			inspect
				direction
			when {SD_ENUMERATION}.top then
				Result.append_string_general ("top")
			when {SD_ENUMERATION}.left then
				Result.append_string_general ("left")
			when {SD_ENUMERATION}.bottom then
				Result.append_string_general ("bottom")
			when {SD_ENUMERATION}.right then
				Result.append_string_general ("right")
			else
				Result.append_integer (direction)
			end
		end

invariant

	last_floating_height_valid: initialized implies last_floating_height >= 0
	last_floating_width_valid: initialized implies last_floating_width >= 0

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
