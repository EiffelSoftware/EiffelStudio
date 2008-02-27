indexing
	description: "Helper for SD_AUTO_HIDE_STATE to deal with animation issues."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_AUTO_HIDE_ANIMATION

inherit
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	SD_ACCESS

create
	make

feature {NONE} -- Initlization

	make (a_auto_hide_state: SD_AUTO_HIDE_STATE; a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method
		require
			not_void: a_auto_hide_state /= Void
			not_void: a_docking_manager /= Void
		do
			state := a_auto_hide_state
			internal_docking_manager := a_docking_manager

			create internal_shared
		ensure
			set: state = a_auto_hide_state
			set: internal_docking_manager = a_docking_manager
		end

feature {SD_AUTO_HIDE_STATE} -- Command

	close_animation is
			-- Close window animation.
		local
			l_rect: EV_RECTANGLE
		do
			remove_moving_timer (True)
			remove_close_timer
			if internal_shared.auto_hide_tab_slide_timer_interval /= 0 then
				if internal_docking_manager.zones.has_zone_by_content (state.content) then
					l_rect := internal_docking_manager.query.fixed_area_rectangle
					if state.direction = {SD_ENUMERATION}.left then
						internal_final_position := l_rect.left - state.zone.width
					elseif state.direction = {SD_ENUMERATION}.right then
						internal_final_position := l_rect.right
					elseif state.direction = {SD_ENUMERATION}.top then
						internal_final_position := l_rect.top - state.zone.height
					elseif state.direction = {SD_ENUMERATION}.bottom then
						internal_final_position := l_rect.bottom
					end
				end
				if state.direction = {SD_ENUMERATION}.left or state.direction = {SD_ENUMERATION}.right then
					state.set_width_height (state.zone.width)
				else
					state.set_width_height (state.zone.height)
				end
				create internal_moving_timer
				internal_moving_timer.actions.extend (agent on_timer_for_moving (False))
				internal_moving_timer.set_interval (internal_shared.auto_hide_tab_slide_timer_interval)
			else
				-- No animation
				internal_docking_manager.command.remove_auto_hide_zones (False)
			end
		end

	show (a_animation: BOOLEAN) is
			-- Show internal widgets.
		local
			l_rect: EV_RECTANGLE
			l_zone: SD_AUTO_HIDE_ZONE
		do
			if not internal_docking_manager.zones.has_zone_by_content (state.content) then
				state.set_width_height (state.max_size_by_zone (state.width_height))
				create l_zone.make (state.content, state.direction)
				state.set_zone (l_zone)

				-- This for Linux, to make sure no flashing when showing the zone.
				l_zone.hide

				-- Before add the zone to the fixed area, first clear the other zones in the area except the main_container.
				internal_docking_manager.command.remove_auto_hide_zones (False)

				internal_docking_manager.zones.add_zone (state.zone)
				create l_rect.make (internal_docking_manager.fixed_area.x_position, internal_docking_manager.fixed_area.y_position,
				internal_docking_manager.fixed_area.width, internal_docking_manager.fixed_area.height)

				-- Set current position and caculate final position.
				internal_docking_manager.fixed_area.extend (state.zone)
				-- Set size.
				internal_set_size (l_rect)
				internal_set_position_and_final_position (l_rect)

				if internal_shared.auto_hide_tab_slide_timer_interval /= 0 then
					create internal_close_timer.make_with_interval ({SD_SHARED}.Auto_hide_delay)
					internal_close_timer.actions.extend (agent on_timer_for_close)
					ev_application.pointer_motion_actions.extend (agent on_pointer_motion)
					internal_motion_procedure := ev_application.pointer_motion_actions.last
					-- First, put the zone in a fixed, make a animation here.

					create internal_moving_timer
					internal_moving_timer.actions.extend (agent on_timer_for_moving (True))
					internal_moving_timer.set_interval (internal_shared.auto_hide_tab_slide_timer_interval)
				else
					inspect
						state.direction
					when {SD_ENUMERATION}.top, {SD_ENUMERATION}.bottom then
						internal_docking_manager.fixed_area.set_item_y_position (state.zone, internal_final_position)
					else
						internal_docking_manager.fixed_area.set_item_x_position (state.zone, internal_final_position)
					end
					state.zone.show
				end

			end
		end

	remove_moving_timer (a_open: BOOLEAN) is
			-- Remove `internal_moving_timer'.
		do
			if internal_moving_timer /= Void then
				internal_moving_timer.actions.wipe_out
				internal_moving_timer.destroy
				internal_moving_timer := Void
			end
			if not a_open then
				internal_docking_manager.zones.prune_zone (state.zone)
				internal_docking_manager.fixed_area.prune (state.zone)
				state.zone.destroy
			end
		ensure
			timer_void: internal_moving_timer = Void
		end

	remove_close_timer is
			-- Remove close timer.
		do
			if internal_close_timer /= Void then
				internal_close_timer.actions.wipe_out
				internal_close_timer.destroy
				internal_close_timer := Void

				ev_application.pointer_motion_actions.start
				ev_application.pointer_motion_actions.prune (internal_motion_procedure)
				internal_motion_procedure := Void
				debug ("docking")
					io.put_string ("%N SD_AUTO_HIDE_STATE on_pointer_motion actions pruned")
				end
			end
		ensure
			timer_void: internal_close_timer = Void
			applcation_pointer_motion_pruned:
		end

feature -- Query

	is_close_timer_exist: BOOLEAN is
			-- If `internal_close_timer' /= Void?
		do
			Result := internal_close_timer /= Void
		end

	state: SD_AUTO_HIDE_STATE
			-- Auto hide state which Current help it's animation issues.

feature {SD_DOCKING_MANAGER_AGENTS} -- Agents

	on_timer_for_close is
			-- Handle close timer event.
		require
			internal_timer_not_void: is_close_timer_exist
		do
			if pointer_outside and not state.zone.has_focus then
				remove_close_timer
				close_animation
			end
		ensure
			timer_void: pointer_outside and not state.zone.has_focus implies internal_close_timer = Void
		end

	on_pointer_motion (a_widget: EV_WIDGET; a_screen_x, a_screen_y: INTEGER) is
			-- Use timer to detect pointer outside zone and tab stub?
		local
			l_rect, l_rect_zone: EV_RECTANGLE
		do
			create l_rect.make (state.tab_stub.screen_x, state.tab_stub.screen_y, state.tab_stub.width, state.tab_stub.height)
			if state.zone /= Void and not state.zone.is_destroyed then
				create l_rect_zone.make (state.zone.screen_x, state.zone.screen_y, state.zone.width, state.zone.height)
				-- During pick and drop target is not correct, so we can't use this:
				-- if not state.tab_stub.has_recursive (a_widget) and not state.zone.has_recursive (a_widget) then
				if not l_rect.has_x_y (a_screen_x, a_screen_y) and not l_rect_zone.has_x_y (a_screen_x, a_screen_y) then
					pointer_outside := True
				else
					pointer_outside := False
				end
			end
		end

	on_timer_for_moving (a_open: BOOLEAN) is
			-- Use timer to play a animation.
		do
			if a_open then
				internal_open_moving
			else
				internal_close_moving
			end
		ensure
			final_position_set:
		end

feature {NONE} -- Implementation functions

	internal_set_position_and_final_position (a_whole_area: EV_RECTANGLE) is
			-- When `internal_show' set first animation position and calculate final position.
		require
			not_void: a_whole_area /= Void
		do
			if state.direction = {SD_ENUMERATION}.left then
				internal_docking_manager.fixed_area.set_item_position (state.zone, a_whole_area.left - state.zone.width, a_whole_area.top)
				internal_final_position := a_whole_area.left
			elseif state.direction = {SD_ENUMERATION}.right then
				internal_docking_manager.fixed_area.set_item_position (state.zone, a_whole_area.right, a_whole_area.top)
				internal_final_position := a_whole_area.right - state.zone.width
			elseif state.direction = {SD_ENUMERATION}.top then
				internal_docking_manager.fixed_area.set_item_position (state.zone, a_whole_area.left, a_whole_area.top - state.zone.height)
				internal_final_position := a_whole_area.top
			elseif state.direction = {SD_ENUMERATION}.bottom then
				internal_docking_manager.fixed_area.set_item_position (state.zone, a_whole_area.left, a_whole_area.bottom)
				internal_final_position := a_whole_area.bottom - state.zone.height
			end
		end

	internal_set_size (a_whole_area: EV_RECTANGLE) is
			-- When show, set size of `zone'
		require
			not_void: a_whole_area /= Void
		do
			if state.direction = {SD_ENUMERATION}.left or state.direction = {SD_ENUMERATION}.right then
				if state.width_height > state.zone.minimum_width then
					internal_docking_manager.fixed_area.set_item_width (state.zone, state.width_height)
				end
				if a_whole_area.height  > state.zone.minimum_height then
					internal_docking_manager.fixed_area.set_item_height (state.zone, a_whole_area.height)
				end
			else
				if a_whole_area.width > state.zone.minimum_width then
					internal_docking_manager.fixed_area.set_item_width (state.zone, a_whole_area.width)
				end
				if state.width_height > state.zone.minimum_height then
					internal_docking_manager.fixed_area.set_item_height (state.zone, state.width_height)
				end
			end
		end

	internal_open_moving is
			-- Zone open animation.
		do
			inspect
				state.direction
			when {SD_ENUMERATION}.left then
				if state.zone.x_position + internal_show_step >= internal_final_position then
					remove_moving_timer (True)
					internal_docking_manager.fixed_area.set_item_x_position (state.zone, internal_final_position)
				else
					internal_docking_manager.fixed_area.set_item_x_position (state.zone, state.zone.x_position + internal_show_step)
				end
			when {SD_ENUMERATION}.right then
				if state.zone.x_position - internal_show_step <= internal_final_position then
					remove_moving_timer (True)
					internal_docking_manager.fixed_area.set_item_x_position (state.zone, internal_final_position)
				else
					internal_docking_manager.fixed_area.set_item_x_position (state.zone, state.zone.x_position - internal_show_step)
				end
			when {SD_ENUMERATION}.top then
				if state.zone.y_position + internal_show_step >= internal_final_position then
					remove_moving_timer (True)
					internal_docking_manager.fixed_area.set_item_y_position (state.zone, internal_final_position)
				else
					internal_docking_manager.fixed_area.set_item_y_position (state.zone, state.zone.y_position + internal_show_step)
				end
			when {SD_ENUMERATION}.bottom then
				if state.zone.y_position - internal_show_step <= internal_final_position then
					remove_moving_timer (True)
					internal_docking_manager.fixed_area.set_item_y_position (state.zone, internal_final_position)
				else
					internal_docking_manager.fixed_area.set_item_y_position (state.zone, state.zone.y_position - internal_show_step)
				end
			end
			if not state.zone.is_displayed then
				state.zone.show
			end
		end

	internal_close_moving is
			-- Zone close animation.
		do
			inspect
				state.direction
			when {SD_ENUMERATION}.left then
				if state.zone.x_position - internal_show_step <= internal_final_position then
					remove_moving_timer (False)
				else
					internal_docking_manager.fixed_area.set_item_x_position (state.zone, state.zone.x_position - internal_show_step)
				end
			when {SD_ENUMERATION}.right then
				if state.zone.x_position + internal_show_step >= internal_final_position then
					remove_moving_timer (False)
				else
					internal_docking_manager.fixed_area.set_item_x_position (state.zone, state.zone.x_position + internal_show_step)
				end
			when {SD_ENUMERATION}.top then
				if state.zone.y_position - internal_show_step <= internal_final_position then
					remove_moving_timer (False)
				else
					internal_docking_manager.fixed_area.set_item_y_position (state.zone, state.zone.y_position - internal_show_step)
				end
			when {SD_ENUMERATION}.bottom then
				if state.zone.y_position + internal_show_step >= internal_final_position then
					remove_moving_timer (False)
				else
					internal_docking_manager.fixed_area.set_item_y_position (state.zone, state.zone.y_position + internal_show_step)
				end
			end
		end

feature {NONE} -- Implementation

	internal_shared: SD_SHARED
			-- All singletons.

	pointer_outside: BOOLEAN
			-- If pointer outside tab stub and zone?

	internal_motion_procedure: PROCEDURE [ANY, TUPLE [EV_WIDGET, INTEGER, INTEGER]]
			-- Motion procedure for animation.

	internal_show_step: INTEGER is 20
			-- Step when tear-off window appear.

	internal_final_position: INTEGER
			-- Final position when a tear-off window should at.

	internal_moving_timer: EV_TIMEOUT
			-- Timer for moving animation.

	internal_close_timer: EV_TIMEOUT
			-- Timer for close window.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager.

invariant
	not_void: state /= Void
	not_void: internal_docking_manager /= Void

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
