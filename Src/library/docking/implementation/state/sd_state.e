indexing
	description: "SD_STATE which manage SD_ZONE baes on different states. A state pattern."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_STATE

feature -- Properties

	docking_manager: SD_DOCKING_MANAGER is
			-- `internal_docking_manager'.
		do
			Result := internal_docking_manager
		end

	content: like internal_content is
			-- `internal_content'.
		do
			Result := internal_content
		end

	extend (a_content: like internal_content) is
			-- Set `internal_content'.
		do
			internal_content := a_content
		end

	direction: INTEGER
			-- Dock top or dock bottom or dock left or dock right? One emueration from {SD_DOCKING_MANAGER}.

	set_direction (a_direction: INTEGER) is
			-- Set `direction'.
		do
			direction := a_direction
		end

	width_height: INTEGER
				-- Width of zone if dock_left or dock_right.
				-- Height of zone if dock_top or dock_bottom.

	width_height_by_direction: INTEGER is
			-- Width of zone if dock left/right, Height of zone if dock top/bottom.
		do
			if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
				Result := zone.width
			else
				Result := zone.height
			end
		end

	set_width_height (a_width_height: INTEGER) is
			-- Set `width_height'.
		require
			a_widht_height_valid: a_width_height >= 0
		do
			width_height := a_width_height
		ensure
			set: width_height = a_width_height
		end

	zone: SD_ZONE is
			-- Zone which is managed by `Current'.
		deferred
		ensure
			not_void: Result /= Void
		end

feature {SD_CONFIG_MEDIATOR, SD_CONTENT}  -- Restore

	set_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Set `internal_docking_manager'.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
		ensure
			set: internal_docking_manager = a_docking_manager
		end

	restore (a_titles: ARRAYED_LIST [STRING]; a_container: EV_CONTAINER; a_direction: INTEGER) is
			-- `titles' is content name. `a_container' is zone parent.
		require
			more_than_one_title: content_count_valid (a_titles)
			a_container_not_void: a_container /= Void
			a_container_not_full: not a_container.full
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		deferred
		end

feature -- Commands

	record_state is
			-- Record current state.
		do
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Perform a restore.
		require
			internal_content_not_void: not content_void
		deferred
		end

	set_focus (a_content: SD_CONTENT) is
			-- Set focus.
		require
			has_content: has (a_content)
		do
			if zone /= Void then
				zone.on_focus_in (a_content)
				docking_manager.property.set_last_focus_content (content)
			end
		end

	show is
			-- Handle show zone.
		do
		end

	hide is
			-- Handle hide zone.
		do
		end

	close is
			-- Handle close zone.
		local
			l_state: SD_STATE_VOID
		do
			internal_docking_manager.command.lock_update (zone, False)
			zone.close
			internal_docking_manager.zones.prune_zone_by_content (internal_content)
			internal_docking_manager.command.remove_empty_split_area
			internal_docking_manager.command.update_title_bar
			internal_docking_manager.command.unlock_update
			create l_state.make (internal_content)
			change_state (l_state)
		end

	stick (a_direction: INTEGER) is
			-- Stick/Unstick a zone.
		do
			internal_docking_manager.command.recover_normal_state
		end

	float (a_x, a_y: INTEGER) is
			-- Make current window floating.
		do
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			-- Change zone position to `a_target_zone''s parent at `a_direction'.
		require
			a_target_zone_not_void: a_target_zone /= Void
		do
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_first: BOOLEAN) is
			-- Move to a SD_DOCKING_ZONE, then a_target_zone and `Current' became SD_TAB_ZONE.
		require
			a_target_zone_not_void: a_target_zone /= Void
		do
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE; a_index: INTEGER) is
			-- Move to a tab zone.
		require
			a_target_zone_not_void: a_target_zone /= Void
		do
		end

	on_normal_max_window is
			-- Handle normal\max zone.
		do
		end

feature -- Properties

	floating_zone: SD_FLOATING_ZONE is
			-- When Current is floating, this is floating zone which Current is in.
			-- Otherwise is Void.
		local
			l_2_parent: EV_CONTAINER
			l_3_parent: EV_CONTAINER
		do
			if zone.parent /= Void then
				l_2_parent := zone.parent.parent
			end
			if l_2_parent /= Void then
				l_3_parent := l_2_parent.parent
			end

			Result ?= l_3_parent
		end

	last_floating_width: INTEGER
			-- Last floating width. (At the beginning the width is default floating width from SD_SHARED.)

	set_last_floating_width (a_width: INTEGER) is
			-- Set `last_floating_width'
		require
			valid: a_width > 0
		do
			last_floating_width := a_width
		ensure
			set: last_floating_width = a_width
		end

	last_floating_height: INTEGER
			-- Last floating height. (At the beginning the height is default floating height from SD_SHARED.)

	set_last_floating_height (a_height: INTEGER) is
			-- Set `last_floating_height'
		require
			valid: a_height > 0
		do
			last_floating_height := a_height
		ensure
			set: last_floating_height = a_height
		end

feature {SD_CONTENT} -- SD_CONTENT called functions.

	change_title (a_title: STRING; a_content: SD_CONTENT) is
			--
		require
			a_title_not_void: a_title /= Void
		do
		end

	change_pixmap (a_pixmap: EV_PIXMAP; a_content: SD_CONTENT) is
			--
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
		end

feature  -- States report

	has (a_content: SD_CONTENT): BOOLEAN is
			-- If Current has `a_content'?
		require
			a_content_not_void: a_content /= Void
		do
			Result := internal_content = a_content
		end

	content_void: BOOLEAN is
			-- If current a_content void?
		do
			Result := internal_content = Void
		end

	content_count_valid (a_titles: ARRAYED_LIST [STRING]): BOOLEAN is
			-- If
		require
			a_titles_not_void: a_titles /= Void
		do
			Result := a_titles.count >= 1
		end

	is_dock_at_top (a_multi_dock_area: SD_MULTI_DOCK_AREA): BOOLEAN is
			-- If `zone' dock at top level of `a_multi_dock_area'?
		local
			l_container: EV_CONTAINER
			l_widget: EV_WIDGET
		do
			l_container ?= a_multi_dock_area.item
			l_widget ?= zone
			check all_zone_is_widget: l_widget /= Void end
			if l_container /= Void then
				Result := l_container.has (l_widget)
			end
		end

feature {NONE} -- Implementation

	change_state (a_state: SD_STATE) is
			-- Changed `content' state to `a_state'.
		require
			a_state_not_void: a_state /= Void
		do
			internal_content.change_state (a_state)
			a_state.set_last_floating_height (last_floating_height)
			a_state.set_last_floating_width (last_floating_width)
		ensure
			changed: internal_content.state = a_state
		end

	top_split_position (a_direction: INTEGER; a_spliter: EV_SPLIT_AREA): INTEGER is
			-- Calculate top split position  when dock at top.
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
			a_spliter_not_void: a_spliter /= Void
			a_spliter_full: a_spliter.full
		local
			l_main_rect: EV_RECTANGLE
		do

			l_main_rect := internal_docking_manager.query.container_rectangle
			inspect
				a_direction
			when {SD_DOCKING_MANAGER}.dock_top then
				if width_height > a_spliter.minimum_split_position and width_height < a_spliter.maximum_split_position then
					Result := width_height
				else
					if l_main_rect.height /= 0 then
						Result := (l_main_rect.height * internal_shared.default_docking_height_rate).ceiling
					else
						Result := a_spliter.minimum_split_position
					end
				end
			when {SD_DOCKING_MANAGER}.dock_bottom then
				if l_main_rect.height -width_height > a_spliter.minimum_split_position and l_main_rect.height - width_height < a_spliter.maximum_split_position then
					Result := l_main_rect.height -width_height
				else
					if l_main_rect.height /= 0 then
						Result := (l_main_rect.height * (1 - internal_shared.default_docking_height_rate)).ceiling
					else
						Result := a_spliter.maximum_split_position
					end
				end
			when {SD_DOCKING_MANAGER}.dock_left then
				if width_height > a_spliter.minimum_split_position and width_height < a_spliter.maximum_split_position then
					Result :=width_height
				else
					if l_main_rect.width /= 0 then
						Result := (l_main_rect.width * internal_shared.default_docking_width_rate).ceiling
					else
						Result := a_spliter.minimum_split_position
					end
				end
			when {SD_DOCKING_MANAGER}.dock_right then
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

	internal_content: SD_CONTENT
			-- Content managed by `Current'.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

invariant

	not_void: internal_shared /= Void
	valid: last_floating_height > 0
	valid: last_floating_width > 0

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
