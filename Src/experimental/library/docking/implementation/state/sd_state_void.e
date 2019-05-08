note
	description: "SD_STATE when a content initialized, wait for change to other SD_STATE. Or when client programmer called hide, this state remember state"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_STATE_VOID
			--FIXIT: Rename to SD_INITIAL_STATE?
inherit
	SD_SHARED

	SD_STATE_WITH_CONTENT
		redefine
			change_zone_split_area,
			stick,
			float,
			move_to_tab_zone,
			move_to_docking_zone,
			show,
			restore,
			close,
			debug_output
		end

create
	make

feature {NONE}  -- Initlization

	make (a_content: SD_CONTENT; a_docking_manager: SD_DOCKING_MANAGER)
			-- Creation method
		do
			internal_content := a_content
			docking_manager := a_docking_manager
			direction := {SD_ENUMERATION}.left
			last_floating_height := {SD_SHARED}.default_floating_window_height
			last_floating_width := {SD_SHARED}.default_floating_window_width
			initialized := True
		ensure
			content_set: content = a_content
		end

feature -- Command

	set_content (a_content: SD_CONTENT)
			-- Set `internal_content' with `a_content'
		require
			not_void: a_content /= Void
		do
			internal_content := a_content

			-- Just set docking manager if possible
			if a_content.is_docking_manager_attached then
				set_docking_manager (a_content.docking_manager)
			end
		ensure
			set: content = a_content
		end

feature -- Status report

	debug_output: STRING_32
		do
			Result := Precursor
			if attached relative as rel then
				Result.append_string (" rel=")
				Result.append_string (rel.debug_output)
			end
		end

feature  -- States report

	value: INTEGER
		do
			Result := {SD_ENUMERATION}.state_void
		end

feature -- Redefine

	zone: detachable SD_ZONE
			-- <Precursor>
		do
		end

	restore (a_data: SD_INNER_CONTAINER_DATA; a_container: EV_CONTAINER)
			-- <Precursor>
		do
			content.set_visible (False)
			initialized := True
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA)
			-- <Precursor>
		local
			l_docking_state: SD_DOCKING_STATE
		do
			content.set_visible (True)
			docking_manager.command.lock_update (Void, True)
			if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
				create l_docking_state.make (content, direction, (docking_manager.query.container_rectangle.width * {SD_SHARED}.default_docking_width_rate).ceiling)
			else
				create l_docking_state.make (content, direction, (docking_manager.query.container_rectangle.height * {SD_SHARED}.default_docking_height_rate).ceiling)
			end
			l_docking_state.set_docking_manager (docking_manager)
			l_docking_state.dock_at_top_level (a_multi_dock_area)
			change_state (l_docking_state)
			docking_manager.command.unlock_update
		ensure then
			state_changed: content.state /= Current
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER)
			-- <Precursor>
		local
			l_docking_state: SD_DOCKING_STATE
		do
			content.set_visible (True)
			if attached {EV_WIDGET} a_target_zone as lt_widget then
				docking_manager.command.lock_update (lt_widget, False)
			else
				check not_possible: False end
			end
			create l_docking_state.make (content, a_direction, 0)
			l_docking_state.change_zone_split_area (a_target_zone, a_direction)
			change_state (l_docking_state)
			docking_manager.command.unlock_update
		ensure then
			state_changed: content.state /= Current
		end

	stick (a_direction: INTEGER)
			-- <Precursor>
		do
			content.set_visible (True)
			docking_manager.command.lock_update (Void, True)
			change_state (create {SD_AUTO_HIDE_STATE}.make (content, a_direction))
			docking_manager.command.unlock_update
		ensure then
			state_changed: content.state /= Current
		end

	float (a_x, a_y: INTEGER)
			-- <Precursor>
		local
			l_docking_state: SD_DOCKING_STATE
			l_floating_state: SD_FLOATING_STATE
			l_env: EV_ENVIRONMENT
		do
			content.set_visible (True)
			docking_manager.command.lock_update (Void, True)
			create l_floating_state.make (a_x, a_y, docking_manager, True)
			create l_docking_state.make (content, direction, 0)
			l_docking_state.dock_at_top_level (l_floating_state.inner_container)
			change_state (l_docking_state)
			l_floating_state.set_size (last_floating_width, last_floating_height)

			if
				not {PLATFORM}.is_windows and then
					-- Similar to {SD_DOCKING_STATE}.show, we have to do something special for GTK.
					-- See bug#14105.
				attached {SD_FLOATING_ZONE} l_floating_state.zone as l_floating_zone
			then
				create l_env
				if attached l_env.application as l_app then
					l_app.do_once_on_idle (agent set_size_in_idle (last_floating_width, last_floating_height, l_floating_zone))
				else
					check False end -- Implied by application is running
				end
			end

			docking_manager.command.unlock_update
		ensure then
			state_changed: content.state /= Current
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE; a_index: INTEGER)
			-- <Precursor>
		local
			l_tab_state: SD_TAB_STATE
		do
			content.set_visible (True)
			docking_manager.command.lock_update (a_target_zone, False)
			create l_tab_state.make_with_tab_zone (content, a_target_zone, a_target_zone.state.direction)
			if a_index =  1 then
				l_tab_state.zone.set_content_position (content, 1)
			end
			change_state (l_tab_state)
			docking_manager.command.unlock_update
		ensure then
			state_changed: content.state /= Current
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_first: BOOLEAN)
			-- <Precursor>
		local
			l_tab_state: SD_TAB_STATE
		do
			content.set_visible (True)
			docking_manager.command.lock_update (a_target_zone, False)
			create l_tab_state.make (content, a_target_zone, a_target_zone.state.direction)
			if a_first then
				l_tab_state.zone.set_content_position (content, 1)
			end
			change_state (l_tab_state)
			-- If there is only one zone in EV_FIXED, then we
			-- need perform a resize action.
			docking_manager.command.resize (True)
			docking_manager.command.unlock_update
		ensure then
			state_changed: content.state /= Current
		end

	show
			-- <Precursor>
		local
			retried: BOOLEAN
			l_dock_area: SD_MULTI_DOCK_AREA
		do
			if attached relative as l_relative and then (not retried and l_relative.is_visible) then
				if attached l_relative.state.zone as z then
					l_dock_area := docking_manager.query.inner_container_include_hidden (z)
				end

				if l_dock_area /= Void then
					-- We should care about if maximized zone is in the same SD_MULTI_DOCK_AREA with current zone.
					-- If yes, then call recover from normal state of that zone.
					-- If no, then don't call recover from normal state.
					docking_manager.command.recover_normal_state_in (l_dock_area)
				else
					-- We can't find `l_zone', so we restore every zone. This code should not be called.
					docking_manager.command.recover_normal_state
				end

				if attached {SD_TAB_ZONE} l_relative.state.zone as l_tab_zone then
					move_to_tab_zone (l_tab_zone, 0)
				elseif attached {SD_DOCKING_ZONE} l_relative.state.zone as l_docking_zone then
					move_to_docking_zone (l_docking_zone, False)
				end
				if attached {SD_AUTO_HIDE_STATE} l_relative.state as l_auto_hide_state then
					change_state (create {SD_AUTO_HIDE_STATE}.make_with_friend (content, l_relative))
				end
			else
				float (default_screen_x, default_screen_y)
			end

			if content /= Void and then attached content.state.zone as z then
				if attached {EV_WIDGET} z as lt_widget then
					-- Implied by `is_zone_attached'
					if lt_widget.is_displayed then
						call_show_actions
					end
				else
					check is_widget_zone_attached: False end
				end
			end
		rescue
			if not retried then
				retried := True
				retry
			end
		end

	close
			-- <Precursor>
		do
		end

	set_user_widget (a_widget: EV_WIDGET)
			-- <Precursor>
		do
			-- Do nothing
		end

	set_mini_toolbar (a_widget: EV_WIDGET)
			-- <Precursor>
		do
			-- Do nothing
		end

feature {SD_TAB_STATE, SD_AUTO_HIDE_STATE} -- Hide/Show issues when Tab

	set_relative (a_content: SD_CONTENT)
			-- Set `relative' with `a_content'
		require
			a_content_not_void: a_content /= Void
			a_content_valid: content_valid (a_content)
		do
			relative := a_content
		ensure
			set: relative = a_content
		end

	relative: detachable SD_CONTENT
			-- When hide, who is grouped with

feature -- Contract support

	content_valid (a_content: SD_CONTENT): BOOLEAN
			-- If content valid?
		do
			Result := docking_manager.has_content (a_content)
		end

feature {NONE} -- Implementation

	set_size_in_idle (a_width, a_height: INTEGER; a_zone: attached SD_FLOATING_ZONE)
			-- Set `a_zone''s size with `a_width' and `a_height'
		require
			valid: a_width >= 0 and a_height >= 0
		do
			if not a_zone.is_destroyed then
				a_zone.set_width (a_width)
				a_zone.set_height (a_height)
			end
		end

invariant

	direction_valid: initialized implies direction = {SD_ENUMERATION}.top or direction = {SD_ENUMERATION}.bottom
		or direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right

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
