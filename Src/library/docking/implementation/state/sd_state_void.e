indexing
	description: "SD_STATE when a content initialized, wait for change to other SD_STATE. Or when client programmer called hide, this state remember state"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_STATE_VOID
			--FIXIT: Rename to SD_INITIAL_STATE?
inherit
	SD_STATE

	redefine
		dock_at_top_level,
		change_zone_split_area,
		stick,
		float,
		move_to_tab_zone,
		move_to_docking_zone,
		show
	end

create
	make

feature {NONE}  -- Initlization

	make (a_content: SD_CONTENT)is
			-- Creation method.
		require
			a_content_not_void: a_content /= Void
		do
			direction := {SD_DOCKING_MANAGER}.dock_left
			internal_content := a_content
			create internal_shared
			internal_docking_manager := a_content.docking_manager
			last_floating_height := internal_shared.default_floating_window_height
			last_floating_width := internal_shared.default_floating_window_width
		ensure
			set: a_content = internal_content
			set: internal_docking_manager = a_content.docking_manager
		end

feature -- Redefine.

	zone: SD_ZONE is
			-- Redefine.
		do
		end

	restore (titles: ARRAYED_LIST [STRING]; a_container: EV_CONTAINER; a_direction: INTEGER) is
			-- Redefine.
		do
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Redefine.
		local
			l_docking_state: SD_DOCKING_STATE
		do
			internal_docking_manager.command.lock_update (Void, True)
			if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
				create l_docking_state.make (internal_content, direction, (internal_docking_manager.query.container_rectangle.width * internal_shared.default_docking_width_rate).ceiling)
			else
				create l_docking_state.make (internal_content, direction, (internal_docking_manager.query.container_rectangle.height * internal_shared.default_docking_height_rate).ceiling)
			end
			l_docking_state.dock_at_top_level (a_multi_dock_area)
			change_state (l_docking_state)
			internal_docking_manager.command.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			-- Redefine.
		local
			l_docking_state: SD_DOCKING_STATE
		do
			internal_docking_manager.command.lock_update (a_target_zone, False)
			create l_docking_state.make (internal_content, a_direction, 0)
			l_docking_state.change_zone_split_area (a_target_zone, a_direction)
			change_state (l_docking_state)
			internal_docking_manager.command.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

	stick (a_direction: INTEGER) is
			-- Redefine.
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
		do
			internal_docking_manager.command.lock_update (Void, True)
			create l_auto_hide_state.make (internal_content, a_direction)
			change_state (l_auto_hide_state)
			internal_docking_manager.command.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

	float (a_x, a_y: INTEGER) is
			-- Redefine.
		local
			l_docking_state: SD_DOCKING_STATE
			l_floating_state: SD_FLOATING_STATE
		do
			internal_docking_manager.command.lock_update (Void, True)
			create l_floating_state.make (a_x, a_y, internal_docking_manager)
			create l_docking_state.make (internal_content, direction, 0)
			l_docking_state.dock_at_top_level (l_floating_state.inner_container)
			change_state (l_docking_state)
			l_floating_state.set_size (last_floating_width, last_floating_height)
			internal_docking_manager.command.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE; a_index: INTEGER) is
			-- Redefine.
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_docking_manager.command.lock_update (a_target_zone, False)
			create l_tab_state.make_with_tab_zone (internal_content, a_target_zone, a_target_zone.state.direction)
			if a_index =  1 then
				l_tab_state.zone.set_content_position (internal_content, 1)
			end
			change_state (l_tab_state)
			internal_docking_manager.command.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_first: BOOLEAN) is
			-- Redefine.
		local
			l_tab_state: SD_TAB_STATE
		do
			internal_docking_manager.command.lock_update (a_target_zone, False)
			create l_tab_state.make (internal_content, a_target_zone, a_target_zone.state.direction)
			if a_first then
				l_tab_state.zone.set_content_position (internal_content, 1)
			end
			change_state (l_tab_state)
			internal_docking_manager.command.unlock_update
		ensure then
			state_changed: internal_content.state /= Current
		end

	show is
			-- Redefine
		local
			l_tab_zone: SD_TAB_ZONE
			l_docking_zone: SD_DOCKING_ZONE
			l_auto_hide_state, l_new_state: SD_AUTO_HIDE_STATE
		do
			if relative /= Void then
				l_tab_zone ?= relative.state.zone
				l_docking_zone ?= relative.state.zone
				if l_tab_zone /= Void then
					move_to_tab_zone (l_tab_zone, 0)
				elseif l_docking_zone /= Void then
					move_to_docking_zone (l_docking_zone, False)
				end
				l_auto_hide_state ?= relative.state
				if l_auto_hide_state /= Void then
					create l_new_state.make_with_friend (internal_content, relative)
					change_state (l_new_state)
				end
			end
		end

feature -- Hide/Show issues when Tab

	set_relative (a_content: SD_CONTENT) is
			-- Set `relative'.
		require
			a_content_not_void: a_content /= Void
			a_content_valid: content_valid (a_content)
		do
			relative := a_content
		ensure
			set: relative = a_content
		end

	relative: SD_CONTENT
			-- When hide, who is group.

feature -- Contract support

	content_valid (a_content: SD_CONTENT): BOOLEAN is
			-- If content valid?
		do
			Result := internal_docking_manager.has_content (a_content)
		end

invariant

	direction_valid: direction = {SD_DOCKING_MANAGER}.dock_top or direction = {SD_DOCKING_MANAGER}.dock_bottom
		or direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right

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
