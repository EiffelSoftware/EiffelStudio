indexing
	description: "Manager that control SD_TOOL_BAR_ZONE and SD_TOOL_BAR_HOT_ZONE when user drag a SD_TOOL_BAR_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DOCKER_MEDIATOR

inherit
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	SD_ACCESS
	
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

			init_key_actions

			create cancel_actions
		ensure
			set: docking_manager = a_docking_manager
			a_caller_set: a_caller = caller
		end

	init_key_actions is
			-- Initialize key actions.
		do
			internal_key_press_actions := agent on_key_press
			internal_key_release_actions := agent on_key_release

			ev_application.key_press_actions.extend (internal_key_press_actions)
			ev_application.key_release_actions.extend (internal_key_release_actions)
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

			focus_out_agent := agent on_focus_out
			ev_application.focus_out_actions.extend (focus_out_agent)
		end

	is_resizing_mode: BOOLEAN
			-- If only allow user resiz tool bar zone?

	on_pointer_motion (a_screen_x, a_screen_y: INTEGER) is
			-- Handle user drag tool bar events.
		local
			l_in_four_side: BOOLEAN
		do
			if not docking_manager.tool_bar_manager.is_locked then
				internal_last_screen_x := screen_x
				internal_last_screen_y := screen_y
				screen_x := a_screen_x
				screen_y := a_screen_y

				if not is_resizing_mode then
					if internal_dockable  then
						-- Vertical easy drag area is different from horizontal easy drag area.
						-- Otherwise, horizontal tool bar row hot area will cover vertical easy drag area, so there is no vertical easy drag area.
						if not is_vertical_easy_drag_area (a_screen_y) then
							l_in_four_side := on_motion_in_four_side (a_screen_x, a_screen_y, offset_x, offset_y)
						end
					end
					if not l_in_four_side then
						if not caller.is_floating then
							float_tool_bar_zone (a_screen_x, a_screen_y)
						end
						if caller.is_floating then
							caller.set_position (a_screen_x - offset_x, a_screen_y - offset_y)
						end
					end
				else
					if not caller.row.is_vertical then
						caller.row.on_pointer_motion (a_screen_x)
					else
						caller.row.on_pointer_motion (a_screen_y)
					end
				end
				switch_to_reszing_mode (a_screen_x, a_screen_y)
			else
				if caller.is_floating then
					caller.set_position (a_screen_x - offset_x, a_screen_y - offset_y)
				end
			end
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

	set_ignore_focus_out_actions (a_bool: BOOLEAN) is
			-- Set `ignore_next_focus_out' with True.
		do
			ignore_focus_out_actions := a_bool
		ensure
			set: ignore_focus_out_actions = a_bool
		end

	clean is
			-- Clean global key press/release actions.
		do
			ev_application.key_press_actions.prune_all (internal_key_press_actions)
			ev_application.key_release_actions.prune_all (internal_key_release_actions)

			ev_application.focus_out_actions.prune_all (focus_out_agent)
			caller := Void
			cancel_actions.call ([])
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
				-- For left vertical bar, we should first check if it's in horizontal easy drag area.
				-- Otherwise, user can't drag to the top of the horizontal tool bar area easily.
				if not is_horizontal_easy_drag_area (a_screen_x) then
					l_changed := internal_left_hot_zone.on_pointer_motion (a_screen_x, a_screen_y)
				end
				Result := True
			elseif internal_right_hot_zone.area_managed.has_x_y (a_screen_x, a_screen_y)	then
				l_changed := internal_right_hot_zone.on_pointer_motion (a_screen_x, a_screen_y)
				Result := True
			elseif internal_top_hot_zone.area_managed.has_x_y (a_screen_x, a_screen_y - a_offset_y) then
				l_changed := internal_top_hot_zone.on_pointer_motion (a_screen_x, a_screen_y)
				Result := True
			elseif internal_bottom_hot_zone.area_managed.has_x_y (a_screen_x, a_screen_y - a_offset_y) then
				l_changed := internal_bottom_hot_zone.on_pointer_motion (a_screen_x, a_screen_y)
				Result := True
			end
			if Result and then caller.row /= Void then
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
			when {EV_KEY_CONSTANTS}.key_ctrl then
				on_pointer_motion (internal_last_screen_x, internal_last_screen_y)
			when {EV_KEY_CONSTANTS}.key_escape then
				clean
			else

			end
		end

	on_key_release (a_widget: EV_WIDGET; a_key: EV_KEY) is
			-- Handle global key release actions.
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.key_ctrl then
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

	switch_to_reszing_mode (a_screen_x, a_screen_y: INTEGER) is
			-- Swtich to only resize tool bar mode if possible.
		local
			l_pixmaps: EV_STOCK_PIXMAPS
		do
			if is_in_orignal_row then
				if not orignal_row.has (caller.tool_bar) then
					is_in_orignal_row := False
				end
				if motion_count = motion_count_max then
					if is_in_orignal_row then
						is_resizing_mode := True
						create l_pixmaps
						if caller.is_vertical then
							caller.tool_bar.set_pointer_style (l_pixmaps.sizens_cursor)
						else
							caller.tool_bar.set_pointer_style (l_pixmaps.sizewe_cursor)
						end
					end
					-- Do folowing line, so we stop counting.
					is_in_orignal_row := False
				end
				motion_count := motion_count + 1
			end
		end

	float_tool_bar_zone (a_screen_x, a_screen_y: INTEGER) is
			-- Float tool bar zone base on `a_screen_x' and `a_screen_y' if possible.
		require
			not_floating: not caller.is_floating
		local
			l_should_float: BOOLEAN
			l_env: EV_ENVIRONMENT
			l_platform: PLATFORM
		do
			-- We should detect if user dragging at the beginning of a tool bar row/column
			-- This is let user easily drag a tool bar to the begnning of a row/column
			l_should_float := not is_easy_drag_area (a_screen_x, a_screen_y)

			if l_should_float then
				docking_manager.command.lock_update (Void, True)
				caller.assistant.record_docking_state

				create l_platform
				if not l_platform.is_windows then
					-- On windows, following disable/enable capture lines is not needed,
					-- But on Gtk, we need first disable capture then enable capture,
					-- because it's off-screen widget, it'll not have capture until it show again.
					caller.tool_bar.disable_capture
				end

				-- Ignore next two focus out actions, this one is caused by the floating tool bar getting focus.
				set_ignore_focus_out_actions (True)
				caller.float (a_screen_x - offset_x, a_screen_y - offset_y, True)
				set_ignore_focus_out_actions (False)

				if not l_platform.is_windows then
					-- We can't enable capture immediately, seems GTK window is not ready at this point.
					-- enable capture not fully working at this point (only capture events when pointer in main window), see bug#12542 problem 1.
					-- caller.tool_bar.enable_capture
					create l_env
					l_env.application.do_once_on_idle (agent
															local
																l_screen: EV_SCREEN
																l_position: EV_COORDINATE
															do
																if caller /= Void and then
																	caller.tool_bar /= Void and then
																	not caller.tool_bar.is_destroyed then
																	caller.tool_bar.enable_capture

																	-- Set floating tool bar to current pointer position.
																	create l_screen
																	l_position := l_screen.pointer_position
																	on_pointer_motion (l_position.x, l_position.y)
																end
															end
														)
				end

				docking_manager.command.unlock_update
			else
				caller.row.set_item_position_relative (caller.tool_bar, 0)
				caller.row.reposition
			end
		end

	is_easy_drag_area (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- If `a_screen_x', `a_screen_y' in easy drag area?
			-- We made a area sepcial at the beginning of tool bar row, in this area
			-- user can easily drag a tool bar to the begining of tool bar row.
			-- Otherwise, user must drag a tool bar very carefully.
		require
			not_floating: not caller.is_floating
		do
			if not caller.is_vertical then
				Result := is_horizontal_easy_drag_area (a_screen_x)
			else
				Result := is_vertical_easy_drag_area (a_screen_y)
			end
		end

	is_horizontal_easy_drag_area (a_screen_x: INTEGER): BOOLEAN is
			-- If `a_screen_x' in caller's horizontal easy drag area?
		local
			l_top_container: EV_CONTAINER
		do
			if not caller.is_floating and not caller.is_vertical then
					l_top_container := docking_manager.top_container
				if a_screen_x >= l_top_container.screen_x - easy_drag_offset and
					a_screen_x <= l_top_container.screen_x + easy_drag_offset then
					Result := True
				else
					Result := False
				end
			end

		end

	is_vertical_easy_drag_area (a_screen_y: INTEGER): BOOLEAN is
			-- If `a_screen_y' in caller's vertical easy drag area?
		local
			l_main_container: SD_MAIN_CONTAINER
		do
			l_main_container := docking_manager.main_container
			if not caller.is_floating and caller.is_vertical then
				if a_screen_y - offset_y >= l_main_container.left_bar.screen_y - easy_drag_offset and
					a_screen_y - offset_y <= l_main_container.left_bar.screen_y then
					Result := True
				else
					Result := False
				end
			end
		end

	on_focus_out (a_widget: EV_WIDGET) is
			-- Handle focus out actions.
		local
			l_platform: PLATFORM
		do
			create l_platform
			-- We ignore focus out actions on Linux is ok since on Linux when enable capture it's full capture, atl + tab, alt + f1 etc. not work (not like Windows).
			if l_platform.is_windows then
				if not ignore_focus_out_actions then
					clean
				end
			end
		end

feature {NONE} -- Implementation attributes.

	focus_out_agent: PROCEDURE [SD_TOOL_BAR_DOCKER_MEDIATOR, TUPLE [EV_WIDGET]]
			-- Focus out agent.

	ignore_focus_out_actions: BOOLEAN
			-- Times for ignore `on_focus_out' action?
			-- We use it when dragging tool bar is changing from docking to floating, or changing from floating to docking.

	orignal_row: SD_TOOL_BAR_ROW
			-- Orignal row when start drag if exist.

	is_in_orignal_row: BOOLEAN
			-- Orignal parent row which `caller' in.

	motion_count_max: INTEGER is 40
			-- Max number start to change to resizing mode.

	easy_drag_offset: INTEGER is 50
			-- Left user can easily drag to the begin of a tool bar row.

	motion_count: INTEGER
			-- How many times `on_pointer_motion' is called?

	internal_dockable: BOOLEAN is
			-- If `caller' dockable?
		do
			Result := not ev_application.ctrl_pressed
		end

	internal_key_press_actions, internal_key_release_actions: PROCEDURE [SD_TOOL_BAR_DOCKER_MEDIATOR, TUPLE [EV_WIDGET, EV_KEY]]
			-- Golbal key press/release action, so we can prune it after dragging.

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
