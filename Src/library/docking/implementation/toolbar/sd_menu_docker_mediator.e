indexing
	description: "Manager that control SD_tool_bar_ZONE and SD_tool_bar_HOT_ZONE when user drag a SD_tool_bar_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DOCKER_MEDIATOR

create
	make

feature {NONE} -- Initialization

	make (a_caller: SD_TOOL_BAR_ZONE; a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method
		require
			a_caller_not_void: a_caller /= Void
		do
			create internal_shared
			internal_shared.set_tool_bar_docker_mediator (Current)
			docking_manager := a_docking_manager

			caller := a_caller

			create internal_top_hot_zone.make (docking_manager.tool_bar_container.top, False, Current)
			create internal_bottom_hot_zone.make (docking_manager.tool_bar_container.bottom, False, Current)
			create internal_left_hot_zone.make (docking_manager.tool_bar_container.left, True, Current)
			create internal_right_hot_zone.make (docking_manager.tool_bar_container.right, True, Current)

			internal_top_hot_zone.start_drag
			internal_bottom_hot_zone.start_drag
			internal_left_hot_zone.start_drag
			internal_right_hot_zone.start_drag

			if a_caller.is_floating then
				internal_last_floating := True
			end

			internal_dockable := True
			init_key_actions

			create cancel_actions
		ensure
			set: docking_manager = a_docking_manager
			a_caller_set: a_caller = caller
		end

	init_key_actions is
			-- Initialize key actions.
		local
			l_env: EV_ENVIRONMENT
		do
			internal_key_press_actions := agent on_key_press
			internal_key_release_actions := agent on_key_release

			create l_env
			l_env.application.key_press_actions.extend (internal_key_press_actions)
			l_env.application.key_release_actions.extend (internal_key_release_actions)
		end

feature -- Command

	start_drag (a_screen_x, a_screen_y: INTEGER) is
			-- Handle start drag.
		do
			if not caller.is_floating then
				if not caller.row.is_enough_max_space then
					is_in_orignal_row := True
					orignal_row := caller.row
				end
			end
			debug ("docking")
				print ("%N%N%N---------------------------- SD_TOOL_BAR_DOCKER_MEDIATOR start drag ---------------------------- is_in_orignal_row: " + is_in_orignal_row.out)
			end
		end

	is_resizing_mode: BOOLEAN
			-- If only allow user resiz tool bar zone?

	on_pointer_motion (a_screen_x, a_screen_y: INTEGER) is
			-- Handle user drag tool bar events.
		local
			l_in_four_side: BOOLEAN
		do
			internal_last_screen_x := screen_x
			internal_last_screen_y := screen_y
			screen_x := a_screen_x
			screen_y := a_screen_y

			if not is_resizing_mode then
				if internal_dockable then
					l_in_four_side := on_motion_in_four_side (a_screen_x, a_screen_y, offset_x, offset_y)
				end

				if not l_in_four_side then

					if not internal_last_floating then
						docking_manager.command.lock_update (Void, True)
						caller.assistant.record_docking_state
						caller.float (a_screen_x - offset_x, a_screen_y - offset_y)
						docking_manager.command.unlock_update
					end
					internal_last_floating := True
					caller.set_position (a_screen_x - offset_x, a_screen_y - offset_y)
				else
					internal_last_floating := False
				end
			else
				if not caller.row.is_vertical then
					caller.row.on_pointer_motion (a_screen_x)
				else
					caller.row.on_pointer_motion (a_screen_y)
				end
			end
			switch_to_reszing_mode (a_screen_x, a_screen_y)
		end

	apply_change (a_screen_x, a_screen_y: INTEGER) is
			-- Apply change.
		do
			notify_row (docking_manager.tool_bar_container.top)
			notify_row (docking_manager.tool_bar_container.bottom)
			notify_row (docking_manager.tool_bar_container.left)
			notify_row (docking_manager.tool_bar_container.right)
			clean
		end

	set_offset (a_start_floating: BOOLEAN; a_offset_x, a_offset_y: INTEGER) is
			-- Set offset when start dragging.
		require
			vaild: a_offset_x >= 0 and a_offset_y >= 0
		do
			offset_x := a_offset_x
			offset_y := a_offset_y
			start_floating := a_start_floating
		ensure
			set: offset_x = a_offset_x
			set: offset_y = a_offset_y
			set: start_floating = a_start_floating
		end

feature -- Query

	caller: SD_TOOL_BAR_ZONE
			-- Caller.

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

	screen_x, screen_y: INTEGER
			-- Current pointer position.

	start_floating: BOOLEAN
			-- When start dragging, is it floating state?

	offset_x, offset_y: INTEGER
			-- Offset when start dragging.

	cancel_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Handle user canel dragging event.

feature {NONE} -- Implementation functions

	on_motion_in_four_side (a_screen_x, a_screen_y: INTEGER; a_offset_x, a_offset_y: INTEGER): BOOLEAN is
			-- Handle pointer in four tool bar area.
		local
			l_changed: BOOLEAN
		do
			if internal_left_hot_zone.area_managed.has_x_y (a_screen_x, a_screen_y) then
				l_changed := internal_left_hot_zone.on_pointer_motion (a_screen_x)
				Result := True
			elseif internal_right_hot_zone.area_managed.has_x_y (a_screen_x, a_screen_y)	then
				l_changed := internal_right_hot_zone.on_pointer_motion (a_screen_x)
				Result := True
			elseif internal_top_hot_zone.area_managed.has_x_y (a_screen_x - a_offset_x, a_screen_y - a_offset_y)  then
				l_changed := internal_top_hot_zone.on_pointer_motion (a_screen_y)
				Result := True
			elseif internal_bottom_hot_zone.area_managed.has_x_y (a_screen_x - a_offset_x, a_screen_y - a_offset_y) then
				l_changed := internal_bottom_hot_zone.on_pointer_motion (a_screen_y)
				Result := True
			end
			if Result then
				if not caller.row.is_vertical then
					caller.row.on_pointer_motion (a_screen_x)
				else
					caller.row.on_pointer_motion (a_screen_y)
				end
			end
		ensure
			changed:
		end

	on_key_press (a_widget: EV_WIDGET; a_key: EV_KEY) is
			-- Handle global key press actions.
		do
			inspect
				a_key.code
			when {EV_KEY}.key_ctrl then
				if internal_dockable /= False then
					debug ("docking")
						print ("%N SD_TOOL_BAR_DOCKER_MEDIATOR on_key_press")
					end
					internal_dockable := False
					on_pointer_motion (internal_last_screen_x, internal_last_screen_y)
				end
			when {EV_KEY}.key_escape then
				cancel_tracing_pointer
			else

			end
		end

	on_key_release (a_widget: EV_WIDGET; a_key: EV_KEY) is
			-- Handle global key release actions.
		do
			inspect
				a_key.code
			when {EV_KEY}.key_ctrl then
				debug ("docking")
					print ("%N SD_TOOL_BAR_DOCKER_MEDIATOR on_key_release")
				end
				internal_dockable := True
				on_pointer_motion (internal_last_screen_x, internal_last_screen_y)
			else

			end
		end

	notify_row (a_box: EV_BOX) is
			-- Notify a SD_TOOL_BAR_ROW to apply change.
		require
			a_box_not_void: a_box /= Void
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
		do
			from
				a_box.start
			until
				a_box.after
			loop
				l_tool_bar_row ?= a_box.item
				check l_tool_bar_row /= Void end
				l_tool_bar_row.apply_change
				a_box.forth
			end
		end

	clean is
			-- Clean global key press/release actions.
		local
			l_env: EV_ENVIRONMENT
		do
			create l_env
			l_env.application.key_press_actions.prune_all (internal_key_press_actions)
			l_env.application.key_release_actions.prune_all (internal_key_release_actions)
		end

	cancel_tracing_pointer is
			-- Cancel tracing pointer.
		do
			clean
			cancel_actions.call ([])
		end

	switch_to_reszing_mode (a_screen_x, a_screen_y: INTEGER) is
			-- Swtich to only resize tool bar mode if possible.
		local
			l_pixmaps: EV_STOCK_PIXMAPS
		do
			if is_in_orignal_row then
				if not orignal_row.has (caller) then
					is_in_orignal_row := False
				end
				if motion_count = motion_count_max then
					if is_in_orignal_row then
						is_resizing_mode := True
						create l_pixmaps
						if caller.is_vertical then
							caller.set_pointer_style (l_pixmaps.sizens_cursor)
						else
							caller.set_pointer_style (l_pixmaps.sizewe_cursor)
						end
					end
					-- Do folowing line, so we stop counting.
					is_in_orignal_row := False
				end
				motion_count := motion_count + 1
			end
		end

feature {NONE} -- Implementation attributes.

	orignal_row: SD_TOOL_BAR_ROW
			-- Orignal row when start drag if exist.

	is_in_orignal_row: BOOLEAN
			-- Orignal parent row which `caller' in.

	motion_count_max: INTEGER is 20
			-- Max number start to change to resizing mode.

	motion_count: INTEGER
			-- How many times `on_pointer_motion' is called?

	internal_dockable: BOOLEAN
			-- If `caller' dockable?

	internal_key_press_actions, internal_key_release_actions: PROCEDURE [SD_TOOL_BAR_DOCKER_MEDIATOR, TUPLE [EV_WIDGET, EV_KEY]]
			-- Golbal key press/release action, so we can prune it after dragging.

	internal_last_floating: BOOLEAN
			-- If last pointer motion `caller' is floating?

	internal_shared: SD_SHARED
			-- All singletons.

	internal_top_hot_zone, internal_bottom_hot_zone, internal_left_hot_zone, internal_right_hot_zone: SD_TOOL_BAR_HOT_ZONE
			-- Four area hot zone.

	internal_last_screen_x, internal_last_screen_y: INTEGER
			-- Last pointer position.

invariant

	not_void: internal_shared /= Void
	not_void: internal_top_hot_zone /= Void
	not_void: internal_bottom_hot_zone /= Void
	not_void: internal_left_hot_zone /= Void
	not_void: internal_right_hot_zone /= Void
	not_void: cancel_actions /= Void

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
