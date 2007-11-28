indexing
	description: "When a content is floating, objects to hold content(s)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FLOATING_ZONE

inherit
	SD_ZONE
		rename
			internal_shared as internal_shared_zone,
			extend_widget as extend_sizeable_popup_window,
			has_widget as has_untitled_dialog,
			is_maximized as is_maximized_zone
		export
			{NONE} all
			{ANY} has_focus, width, height, is_destroyed, is_displayed
			{SD_OPEN_CONFIG_MEDIATOR, SD_DOCKING_MANAGER} destroy
		undefine
			initialize,
			Identifier_path_separator,
			show
		redefine
			type,
			state
		end

	SD_DOCKER_SOURCE
		undefine
			default_create, copy
		end

	SD_SIZABLE_POPUP_WINDOW
		rename
			extend as real_extend_dialog,
			show as show_allow_to_back,
			has as has_untitled_dialog
		export
			{NONE} all
			{ANY} set_position, set_size, screen_x, screen_y
			{SD_DOCKING_MANAGER_COMMAND} accelerators
			{SD_DOCKING_STATE} set_width, set_height
			{SD_DOCKING_MANAGER_COMMAND} hide
		select
			implementation,
			show_allow_to_back
		end

create
	make

feature {NONE} -- Initlization

	make (a_floating_state: SD_FLOATING_STATE) is
			-- Creation method.
		require
			a_floating_state_not_void: a_floating_state /= Void
		do
			internal_floating_state := a_floating_state
			internal_docking_manager := a_floating_state.docking_manager
			create internal_shared
			create internal_shared_zone
			default_create
			create internal_vertical_box
			real_extend_dialog (internal_vertical_box)

			create internal_title_bar.make
			internal_title_bar.enable_baseline
			internal_title_bar.drag_actions.extend (agent on_title_bar_drag)
			internal_title_bar.close_request_actions.extend (agent on_close)
			internal_title_bar.set_show_normal_max (False)
			internal_title_bar.set_show_stick (False)
			pointer_button_release_actions.extend (agent on_pointer_button_release)
			pointer_motion_actions.extend (agent on_pointer_motion)
			create internal_inner_container.make (internal_docking_manager)
			internal_vertical_box.extend (internal_inner_container)
			internal_inner_container.set_parent_floating_zone (Current)
			if internal_floating_state.docking_manager.query.golbal_accelerators /= Void then
				accelerators.append (internal_floating_state.docking_manager.query.golbal_accelerators)
			end
			set_title ("")
			focus_in_actions.extend (agent on_dialog_focus_in)
			focus_out_actions.extend (agent on_dialog_focus_out)
			focus_in_actions.extend (agent (internal_docking_manager.agents).on_top_level_window_focus_in)
			focus_out_actions.extend (agent (internal_docking_manager.agents).on_top_level_window_focus_out)
			resize_actions.extend (agent on_resize)
		end

feature {SD_OPEN_CONFIG_MEDIATOR} -- Save config

	save_content_title (a_config_data: SD_INNER_CONTAINER_DATA) is
		do
			a_config_data.add_title ("SD_FLOATING_ZONE")
		end

feature -- Command

	update_title_bar is
			-- Remove/add title bar if `Current' content count changed.
			-- Destroy Current if no zone in.
		local
			l_title_zone: SD_TITLE_BAR_REMOVEABLE
			l_env: EV_ENVIRONMENT
		do
			if not is_destroyed then
				if internal_inner_container.readable and then all_zones.count > 0 then
					count_zone_displayed
					if zone_display_count = 1 then
						l_title_zone ?= only_one_zone_displayed
						check l_title_zone /= Void end
						--  l_zone should not have stick button.
						l_title_zone.set_show_stick (False)

						if only_one_zone_displayed.is_maximized then
							l_title_zone.set_show_normal_max (True)
							extend_title_bar
						else
							l_title_zone.set_show_normal_max (False)
							if internal_vertical_box.has (internal_title_bar) then
								internal_vertical_box.prune_all (internal_title_bar)
							end
						end
					elseif zone_display_count > 1 then
						extend_title_bar
						set_all_title_bar (internal_inner_container.item)
					elseif zone_display_count < 1 then
						hide
					end
				else
					-- No widget in `Current'.
					internal_floating_state.docking_manager.command.prune_inner_container (internal_inner_container)
					internal_floating_state.docking_manager.zones.zones.prune (Current)

					-- We don't call `destroy' directly here, because if window destroy and creating very fast,
					-- Windows will not clear window area after destroy a window.
					create l_env
					l_env.application.do_once_on_idle (agent destroy)
				end
			end
		end

	show is
			-- Show `Current'.
		do
			if internal_shared.allow_window_to_back then
				show_allow_to_back
			else
				show_relative_to_window (internal_floating_state.docking_manager.main_window)
			end
		ensure then
			showed: is_displayed
		end

	set_title_focus (a_focus: BOOLEAN) is
			-- Set title focus color?
		do
			if a_focus then
				internal_title_bar.enable_focus_color
			else
				internal_title_bar.disable_focus_color
			end
		end

	extend (a_content: SD_CONTENT) is
			-- Redefine.
		do
		end

	has (a_content: SD_CONTENT): BOOLEAN is
			-- Redefine.
		do
			Result := has_recursive (a_content.user_widget)
		end

feature -- Properties

	type: INTEGER is
			-- Redefine.
		do
			Result := {SD_ENUMERATION}.tool
		end

	state: SD_STATE is
			-- Redefine.
		local
			l_zone: SD_ZONE
		do
			if internal_inner_container.readable then
				l_zone ?= internal_inner_container.item
			end
			if l_zone /= Void then
				Result := content.state
			else
				Result := internal_floating_state
			end
		end

	inner_container: like internal_inner_container is
			-- Main container which is  a SD_MULTI_DOCK_AREA.
		do
			Result := internal_inner_container
		ensure
			not_void: Result /= Void
		end

	content: SD_CONTENT is
			-- Redefine.
		local
			l_zone: SD_ZONE
		do
			if internal_inner_container.readable then
				l_zone ?= internal_inner_container.item
			end
			if l_zone /= Void then
				Result := l_zone.content
			end
		end

	count_zone_displayed is
			-- If more than one zone displayed?
		require
			readable: inner_container_readable
		local
			l_container: EV_CONTAINER
		do
			zone_display_count := 0
			if internal_inner_container.readable then
				l_container ?= internal_inner_container.item
				if l_container /= Void then
					only_one_zone_displayed := Void
					count_zone_display (l_container)
				end
			end
		end

	inner_container_readable: BOOLEAN is
			-- If `internal_inner_container' readable?
		do
			Result := internal_inner_container.readable
		end

feature {NONE} -- Implementation

	internal_floating_state: SD_FLOATING_STATE
			-- Zone state.

	internal_vertical_box: EV_VERTICAL_BOX
			-- Vertical box which contain `internal_title_bar' and `internal_inner_container'.

	internal_inner_container: SD_MULTI_DOCK_AREA
			-- Main container allow dock SD_ZONEs.

	internal_title_bar: SD_TITLE_BAR
			-- Title bar.

	docker_mediator: SD_DOCKER_MEDIATOR
			-- Docker mediator.

	pointer_press_offset_x, pointer_press_offset_y: INTEGER
			-- When user clicked title bar, x y offset.

	all_zones: ARRAYED_LIST [SD_ZONE] is
			-- All zones in Current.
		do
			create Result.make (1)
			if inner_container.readable then
				all_zones_in_current (inner_container.item, Result)
			end
		ensure
			not_void: Result /= Void
		end

	all_zones_in_current (a_widget: EV_WIDGET; a_zones: ARRAYED_LIST [SD_ZONE]) is
			-- Find all zones in Current.
		require
			a_widget_not_void: a_widget /= Void
			a_zones_not_void: a_zones /= Void
		local
			l_zone: SD_ZONE
			l_split_area: EV_SPLIT_AREA
		do
			l_zone ?= a_widget
			if l_zone /= Void then
				a_zones.extend (l_zone)
			end
			l_split_area ?= a_widget
			if l_split_area /= Void then
				-- When restoring docking widget layout, this function called from `update_title_bar', widget strucutre maybe NOT full two fork tree structure.
				if l_split_area.first /= Void then
					all_zones_in_current (l_split_area.first, a_zones)
				end
				if l_split_area.second /= Void then
					all_zones_in_current (l_split_area.second, a_zones)
				end
			end
		end

	extend_title_bar is
			-- Extend title bar.
		do
			if not internal_vertical_box.has (internal_title_bar) then
				internal_vertical_box.start
				internal_vertical_box.put_left (internal_title_bar)
				internal_vertical_box.disable_item_expand (internal_title_bar)
				internal_title_bar.enable_focus_color
			end
		end

	count_zone_display (a_container: EV_CONTAINER) is
			-- Count zone which is displayed.
		require
			a_container_not_void: a_container /= Void
		local
			l_zone: SD_ZONE
			l_split: EV_SPLIT_AREA
			l_container: EV_CONTAINER
		do
			l_zone ?= a_container
			if l_zone /= Void then
				if l_zone.is_displayed then
					only_one_zone_displayed := l_zone
					zone_display_count := zone_display_count + 1
				end
			else
				l_split ?= a_container
				check must_zone_or_split: l_split /= Void end
				l_container ?= l_split.first
				if l_container /= Void then
					count_zone_display (l_container)
				end
				l_container := Void
				l_container ?= l_split.second
				-- When `open_inner_container_data', if a SD_CONTENT not is_visible, then SD_DOCKING_STATE.hide will execute,
				-- At this time, updated title bar will be called, and l_container maybe void. Because it CONSTRUCTING widget layout.
				if l_container /= Void then
					count_zone_display (l_container)
				end
			end
		end

	set_all_title_bar (a_widget: EV_WIDGET) is
			-- Set all zones' title bar in `Current' show normal\max.
		require
			a_widget_not_void: a_widget /= Void
		local
			l_split: EV_SPLIT_AREA
			l_zone: SD_TITLE_BAR_REMOVEABLE
		do
			l_split ?= a_widget
			l_zone ?= a_widget
			if l_split /= Void then
				set_all_title_bar (l_split.first)
				set_all_title_bar (l_split.second)
			elseif l_zone /= Void then
				l_zone.set_show_normal_max (True)
			end
		end

	zone_display_count: INTEGER
			-- How many zones are displayed?

	only_one_zone_displayed: SD_ZONE
			-- Zone which is only one displayed.

feature {NONE} -- Agents

	on_dialog_focus_in is
			-- Handle Current dialog focus in actions.
		local
			l_last_zone: SD_ZONE
			l_zones: like all_zones
		do
			if internal_docking_manager.property.last_focus_content /= Void then
				l_last_zone := internal_docking_manager.property.last_focus_content.state.zone
				if not has_recursive (l_last_zone) then
					l_zones := all_zones
					if l_zones.count > 0 then
						-- If the first content is not visible, it means the floating zone is showing for the first time.
						if l_zones.first.content.is_visible then
							l_zones.first.content.set_focus
						end
					end
				else
					l_last_zone.set_focus_color (True)
				end
				internal_title_bar.enable_focus_color
			end
		end

	on_dialog_focus_out is
			-- Handle Current dialog focus out actions.
		local
			l_last_zone: SD_ZONE
		do
			if internal_docking_manager.property.last_focus_content /= Void then
				l_last_zone := internal_docking_manager.property.last_focus_content.state.zone
				if not is_destroyed and then has_recursive (l_last_zone) then
					internal_title_bar.enable_non_focus_active_color
					l_last_zone.set_non_focus_selection_color
				end
			end
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Forward pointer motion actions to docker mediator.
		do
			debug ("docking")
				print ("%NSD_FLOATING_ZONE on_pointer_motion screen_x, screen_y: " + a_screen_x.out + " " + a_screen_y.out)
			end
			if docker_mediator /= Void and then docker_mediator.is_tracing_pointer then
				docker_mediator.on_pointer_motion (a_screen_x, a_screen_y)
			end
		end

	on_close is
			-- Handle close request.
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_multi_zone: SD_MULTI_CONTENT_ZONE
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			create l_zones.make (1)
			l_zones := all_zones
			from
				l_zones.start
			until
				l_zones.after
			loop
				l_multi_zone ?= l_zones.item
				if l_multi_zone /= Void then
					l_contents := l_multi_zone.contents.twin
					from
						l_contents.start
					until
						l_contents.after
					loop
						l_contents.item.close_request_actions.call (Void)
						l_contents.forth
					end
				else
					l_zones.item.content.close_request_actions.call (Void)
				end

				l_zones.forth
			end
		end

	on_title_bar_drag (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Start `docker_mediator'.
		do
			pointer_press_offset_x := a_screen_x - screen_x
			pointer_press_offset_y := a_screen_y - screen_y
			docker_mediator := internal_docking_manager.query.docker_mediator (Current, internal_docking_manager)
			enable_capture
			docker_mediator.cancel_actions.extend (agent on_cancel_dragging)
			docker_mediator.start_tracing_pointer (pointer_press_offset_x, pointer_press_offset_y)
		end

	on_pointer_button_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Stop `docker_mediator'.
		do
			if a_button = 1 and docker_mediator /= Void then
				disable_capture
				debug ("docking")
					io.put_string ("%N SD_FLOATING_ZONE: yeah, released! ")
				end
				docker_mediator.end_tracing_pointer (a_screen_x, a_screen_y)
				docker_mediator := Void
			end
		end

	on_cancel_dragging is
			-- Handle cancel dragging from SD_DOCKER_MEDIATOR.
		do
			disable_capture
			docker_mediator := Void
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle resize actions.
		local
			l_zone: SD_ZONE
		do
			if internal_inner_container.readable then
				l_zone ?= internal_inner_container.item
			end
			if l_zone /= Void then
				l_zone.set_last_floating_height (a_height)
				l_zone.set_last_floating_width (a_width)
			end
			internal_floating_state.record_state
		end

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
