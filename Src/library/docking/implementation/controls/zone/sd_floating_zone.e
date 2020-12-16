note
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
			is_maximized as is_maximized_zone
		export
			{NONE} all
			{ANY} is_floating_zone
		redefine
			type,
			state,
			child_zone_count,
			has_content
		end

	SD_DOCKER_SOURCE
		undefine
			default_create, copy
		end

	SD_SIZABLE_POPUP_WINDOW
		rename
			extend as real_extend_dialog,
			show as show_allow_to_back,
			has as has_untitled_dialog,
			make as make_popup_window
		export
			{NONE} all
			{ANY} set_position, set_size, screen_x, screen_y, is_displayed, is_destroyed, has_focus
			{SD_DOCKING_MANAGER_COMMAND} accelerators
			{SD_DOCKING_STATE, SD_STATE_VOID} set_width, set_height
			{SD_DOCKING_MANAGER_COMMAND} hide
			{SD_HOT_ZONE} set_pointer_style_for_border
			{SD_WIDGET_CLEANER} destroy
		redefine
			hide,
			screen_y,
			screen_x,
			width,
			height,
			set_position,
			set_size
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_docking_manager: SD_DOCKING_MANAGER)
			-- Creation method
		require
			not_void: a_docking_manager /= Void
		do
			set_docking_manager (a_docking_manager)

			create internal_shared

			create internal_shared_zone
			create internal_vertical_box
			create internal_title_bar.make
			create internal_inner_container.make (a_docking_manager)

			make_popup_window

			internal_inner_container.set_docking_manager (docking_manager)
			real_extend_dialog (internal_vertical_box)

			internal_title_bar.enable_baseline
			internal_title_bar.drag_actions.extend (agent on_title_bar_drag)
			internal_title_bar.close_request_actions.extend (agent on_close)
			internal_title_bar.set_show_normal_max (False)
			internal_title_bar.set_show_stick (False)
			pointer_button_release_actions.extend (agent on_pointer_button_release)
			pointer_motion_actions.extend (agent on_pointer_motion)

			internal_vertical_box.extend (internal_inner_container)
			internal_inner_container.set_parent_floating_zone (Current)

			set_title ("")
			focus_in_actions.extend (agent on_dialog_focus_in)
			focus_out_actions.extend (agent on_dialog_focus_out)
			focus_in_actions.extend (agent (docking_manager.agents).on_top_level_window_focus_in)
			focus_out_actions.extend (agent (docking_manager.agents).on_top_level_window_focus_out)
			resize_actions.extend (agent on_resize)
			dpi_changed_actions.extend (agent on_dpi_changed)
		end

feature {SD_FLOATING_STATE} -- Initialization

	set_floating_state (a_floating_state: SD_FLOATING_STATE)
			-- Set `internal_floating_state' with `a_floating_state'
		require
			a_floating_state_not_void: a_floating_state /= Void
			not_set: not is_floating_state_attached
		do
			internal_floating_state := a_floating_state
			if attached floating_state.docking_manager.query.golbal_accelerators as l_accelerators then
				accelerators.append (l_accelerators)
			end
		ensure
			set: internal_floating_state = a_floating_state
		end

feature {SD_OPEN_CONFIG_MEDIATOR} -- Save config

	save_content_title (a_config_data: SD_INNER_CONTAINER_DATA)
			-- <Precursor>
		do
			a_config_data.add_title ("SD_FLOATING_ZONE")
		end

feature -- Command

	update_title_bar
			-- Remove/add title bar if `Current' content count changed
			-- Destroy Current if no zone in
		do
			if not is_destroyed then
				if internal_inner_container.readable and then all_zones.count > 0 then
					count_zone_displayed
					if zone_display_count = 1 then
						if attached {SD_TITLE_BAR_REMOVEABLE} only_one_zone_displayed as l_title_zone then
							--  l_zone should not have stick button.
							l_title_zone.set_show_stick (False)

							if attached only_one_zone_displayed as l_only_displayed and then l_only_displayed.is_maximized then
								l_title_zone.set_show_normal_max (True)
								extend_title_bar
							else
								l_title_zone.set_show_normal_max (False)
								if internal_vertical_box.has (internal_title_bar) then
									internal_vertical_box.prune_all (internal_title_bar)
								end
							end
						else
							check is_title_zone: False end
						end
					elseif zone_display_count > 1 then
						extend_title_bar
						set_all_title_bar (internal_inner_container.item)
					elseif zone_display_count < 1 then
						hide
					end
				else
					-- No widget in `Current'.
					floating_state.docking_manager.command.prune_inner_container (internal_inner_container)
					floating_state.docking_manager.zones.zones.prune (Current)

					-- We don't call `destroy' directly here, because if window destroy and creating very fast,
					-- Windows will not clear window area after destroy a window.
					ev_application.do_once_on_idle (agent destroy)
				end
			end
		end

	show
			-- Show `Current'
		require
			set: is_floating_state_attached
		do
			if internal_shared.allow_window_to_back then
				show_allow_to_back
			else
				show_relative_to_window (floating_state.docking_manager.main_window)
			end
		ensure then
			showed: is_displayed
		end

	hide
			-- <Precursor>
		do
			last_screen_x := screen_x
			last_screen_y := screen_y
			last_width := width
			last_height := height
			is_last_size_recorded := True
			is_last_position_recorded := True
			Precursor {SD_SIZABLE_POPUP_WINDOW}
		end

	set_title_focus (a_focus: BOOLEAN)
			-- Set title focus color?
		do
			if a_focus then
				internal_title_bar.enable_focus_color
			else
				internal_title_bar.disable_focus_color
			end
		end

	extend (a_content: SD_CONTENT)
			-- <Precursor>
		do
		end

	has (a_content: SD_CONTENT): BOOLEAN
			-- <Precursor>
		do
			Result := has_recursive (a_content.user_widget)
		end

feature -- Query

	type: INTEGER
			-- <Precursor>
		do
			Result := {SD_ENUMERATION}.tool
		end

	state: SD_STATE
			-- <Precursor>
		do
			if
				internal_inner_container.readable and then
				attached {SD_ZONE} internal_inner_container.item as l_zone
			then
				Result := content.state
			else
				Result := floating_state
			end
		end

	floating_state: SD_FLOATING_STATE
			-- Attached `internal_floating_state'
		require
			set: is_floating_state_attached
		do
			check attached internal_floating_state as s then
				-- Implied by precondition `is_floating_state_attached'
				Result := s
			end
		ensure
			not_void: Result /= Void
		end

	inner_container: like internal_inner_container
			-- Main container which is a SD_MULTI_DOCK_AREA
		do
			Result := internal_inner_container
			check must_contain: has_recursive (Result) end
		ensure
			not_void: Result /= Void
		end

	has_content: BOOLEAN
			-- Has a content?
		do
			if
				internal_inner_container.readable and then
				attached {SD_ZONE} internal_inner_container.item as l_zone
			then
				Result := l_zone.has_content
			end
		end

	content: SD_CONTENT
			-- <Precursor>
		do
			check
				internal_inner_container.readable and then
				attached {SD_ZONE} internal_inner_container.item as l_zone and then
				l_zone.has_content
			then
				-- Implied by preconditon `valid'
				Result := l_zone.content
			end
		end

	child_zone_count: INTEGER
			-- <Precursor>
		do
			count_zone_displayed
			Result := zone_display_count
		end

	count_zone_displayed
			-- If more than one zone displayed?
		require
			readable: inner_container_readable
		do
			zone_display_count := 0
			if internal_inner_container.readable then
				if attached {EV_CONTAINER} internal_inner_container.item as l_container then
					only_one_zone_displayed := Void
					count_zone_display (l_container)
				end
			end
		end

	inner_container_readable: BOOLEAN
			-- If `internal_inner_container' readable?
		do
			Result := internal_inner_container.readable
		end

	last_width, last_height, last_screen_x, last_screen_y: INTEGER
			-- On GTK, `width', `height', `screen_x' and `screen_y' are 0 if Current hidden
			-- See bug#13685 which only happens on GTK

	set_position (a_screen_x, a_screen_y: INTEGER)
			-- <Precursor>
		do
			last_screen_x := a_screen_x
			last_screen_y := a_screen_y
			is_last_position_recorded := True
			Precursor {SD_SIZABLE_POPUP_WINDOW}(a_screen_x, a_screen_y)
		ensure then
			set: last_screen_x = a_screen_x
			set: last_screen_y = a_screen_y
		end

	set_size (a_width, a_height: INTEGER)
			-- <Precursor>
		do
			last_width := a_width
			last_height := a_height
			is_last_size_recorded := True
			Precursor {SD_SIZABLE_POPUP_WINDOW}(a_width, a_height)
		end

	is_last_size_recorded: BOOLEAN
			-- If `last_width' and `last_height' have been set?

	is_last_position_recorded: BOOLEAN
			-- If `last_screen_x' and `last_screen_y' have been set?

	is_last_size_or_position_recorded: BOOLEAN
			-- If any of `last_width', `last_height', `last_screen_x' or `last_screen_y' have been set?

	is_floating_state_attached: BOOLEAN
			-- If `internal_floating_state' attached?
		do
			Result := attached internal_floating_state
		end

	screen_y: INTEGER
			-- <Precursor>
		do
			if not is_displayed and then is_last_position_recorded then
				Result := last_screen_y
			else
				Result := Precursor {SD_SIZABLE_POPUP_WINDOW}
			end
		end

	screen_x: INTEGER
			-- <Precursor>
		do
			if not is_displayed and then is_last_position_recorded then
				Result := last_screen_x
			else
				Result := Precursor {SD_SIZABLE_POPUP_WINDOW}
			end
		end

	width: INTEGER
			-- <Precursor>
		do
			if not is_displayed and then is_last_size_recorded then
				Result := last_width
			else
				Result := Precursor {SD_SIZABLE_POPUP_WINDOW}
			end
		end

	height: INTEGER
			-- <Precursor>
		do
			if not is_displayed and then is_last_size_recorded then
				Result := last_height
			else
				Result := Precursor {SD_SIZABLE_POPUP_WINDOW}
			end
		end

feature {NONE} -- Implementation

	internal_floating_state: detachable SD_FLOATING_STATE
			-- Zone state

	internal_vertical_box: EV_VERTICAL_BOX
			-- Vertical box which contain `internal_title_bar' and `internal_inner_container'

	internal_inner_container: SD_MULTI_DOCK_AREA
			-- Main container allow dock SD_ZONEs

	internal_title_bar: SD_TITLE_BAR
			-- Title bar

	docker_mediator: detachable SD_DOCKER_MEDIATOR
			-- Docker mediator

	pointer_press_offset_x, pointer_press_offset_y: INTEGER
			-- When user clicked title bar, x y offset

	all_zones: ARRAYED_LIST [SD_ZONE]
			-- All zones in Current
		do
			create Result.make (1)
			if inner_container.readable then
				all_zones_in_current (inner_container.item, Result)
			end
		ensure
			not_void: Result /= Void
		end

	all_zones_in_current (a_widget: EV_WIDGET; a_zones: ARRAYED_LIST [SD_ZONE])
			-- Find all zones in Current
		require
			a_widget_not_void: a_widget /= Void
			a_zones_not_void: a_zones /= Void
		do
			if attached {SD_ZONE} a_widget as l_zone then
				a_zones.extend (l_zone)
			end
			if attached {EV_SPLIT_AREA} a_widget as l_split_area then
				-- When restoring docking widget layout, this function called from `update_title_bar', widget strucutre maybe NOT full two fork tree structure.
				if attached l_split_area.first as l_first then
					all_zones_in_current (l_first, a_zones)
				end
				if attached l_split_area.second as l_second then
					all_zones_in_current (l_second, a_zones)
				end
			end
		end

	extend_title_bar
			-- Extend title bar
		do
			if not internal_vertical_box.has (internal_title_bar) then
				internal_vertical_box.start
				internal_vertical_box.put_left (internal_title_bar)
				internal_vertical_box.disable_item_expand (internal_title_bar)
				internal_title_bar.enable_focus_color
			end
		end

	count_zone_display (a_container: EV_CONTAINER)
			-- Count zone which is displayed
		require
			a_container_not_void: a_container /= Void
		do
			if attached {SD_ZONE} a_container as l_zone then
				if attached {EV_WIDGET} l_zone as lt_widget then
					if lt_widget.is_displayed then
						only_one_zone_displayed := l_zone
						zone_display_count := zone_display_count + 1
					end
				else
					check not_possible: False end
				end
			elseif attached {EV_SPLIT_AREA} a_container as l_split then
				if attached {EV_CONTAINER} l_split.first as l_first then
					count_zone_display (l_first)
				end
				-- When `open_inner_container_data', if a SD_CONTENT not is_visible, then SD_DOCKING_STATE.hide will execute,
				-- At this time, updated title bar will be called, and l_container maybe void. Because it CONSTRUCTING widget layout.
				if attached {EV_CONTAINER} l_split.second as l_second then
					count_zone_display (l_second)
				end
			else
				check is_zone_or_split: False end
			end
		end

	set_all_title_bar (a_widget: EV_WIDGET)
			-- Set all zones' title bar in `Current' show normal\max
		require
			a_widget_not_void: a_widget /= Void
		do
			if attached {EV_SPLIT_AREA} a_widget as l_split then
				if attached l_split.first as l_first then
					set_all_title_bar (l_first)
				end
				if attached l_split.second as l_second then
					set_all_title_bar (l_second)
				end
			elseif attached {SD_TITLE_BAR_REMOVEABLE} a_widget as l_zone then
				l_zone.set_show_normal_max (True)
			end
		end

	zone_display_count: INTEGER
			-- How many zones are displayed?

	only_one_zone_displayed: detachable SD_ZONE
			-- Zone which is the only one displayed

feature {NONE} -- Agents

	on_dialog_focus_in
			-- Handle Current dialog focus in actions
		local
			l_last_zone: detachable SD_ZONE
			l_zones: like all_zones
		do
			if attached {SD_CONTENT} docking_manager.property.last_focus_content as l_content then
				if l_content.is_state_set and then attached l_content.state as l_state then
					l_last_zone := l_state.zone
					if attached {EV_WIDGET} l_last_zone as lt_widget then
						if not has_recursive (lt_widget) then
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
					else
						check not_possible: False end
					end
				end
			end
		end

	on_dialog_focus_out
			-- Handle Current dialog focus out actions
		local
			l_last_zone: detachable SD_ZONE
		do
			if attached {SD_CONTENT} docking_manager.property.last_focus_content as l_content then
				if l_content.is_state_set and then attached l_content.state as l_state then
					l_last_zone := l_state.zone
					if attached {EV_WIDGET} l_last_zone as lt_widget then
						if not is_destroyed and then has_recursive (lt_widget) then
							internal_title_bar.enable_non_focus_active_color
							l_last_zone.set_non_focus_selection_color
						end
					else
						check not_possible: False end
					end

				end
			end
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Forward pointer motion actions to docker mediator
		do
			debug ("docking")
				print ("%NSD_FLOATING_ZONE on_pointer_motion screen_x, screen_y: " + a_screen_x.out + " " + a_screen_y.out)
			end
			if attached docker_mediator as l_mediator and then l_mediator.is_tracing_pointer then
				l_mediator.on_pointer_motion (a_screen_x, a_screen_y)
			end
		end

	on_close
			-- Handle close request.
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
			z: SD_ZONE
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			l_zones := all_zones
			from
				l_zones.start
			until
				l_zones.after
			loop
				z := l_zones.item
				if attached {SD_MULTI_CONTENT_ZONE} z as l_multi_zone then
					l_contents := l_multi_zone.contents.twin
					from
						l_contents.start
					until
						l_contents.after
					loop
						l_contents.item.close_request_actions.call (Void)
						l_contents.forth
					end
				elseif z.has_content then
					z.content.close_request_actions.call (Void)
				end

				l_zones.forth
			end
		end

	on_title_bar_drag (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Start `docker_mediator'
		local
			l_mediator: like docker_mediator
		do
			-- We should check if `docker_mediator' is void since `on_drag_started' will be called multi times when starting dragging on GTK
			if docker_mediator = Void then
				pointer_press_offset_x := a_screen_x - screen_x
				pointer_press_offset_y := a_screen_y - screen_y
				l_mediator := docking_manager.query.docker_mediator (Current, docking_manager)
				docker_mediator := l_mediator
				enable_capture
				l_mediator.cancel_actions.extend (agent on_cancel_dragging)
				l_mediator.start_tracing_pointer (pointer_press_offset_x, pointer_press_offset_y)
			end
		end

	on_pointer_button_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Stop `docker_mediator'
		do
			if a_button = {EV_POINTER_CONSTANTS}.left and attached docker_mediator as l_mediator then
				disable_capture
				debug ("docking")
					io.put_string ("%N SD_FLOATING_ZONE: yeah, released! ")
				end
				l_mediator.end_tracing_pointer (a_screen_x, a_screen_y)
				docker_mediator := Void
			end
		end

	on_cancel_dragging
			-- Handle cancel dragging from SD_DOCKER_MEDIATOR
		do
			disable_capture
			docker_mediator := Void
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Handle resize actions
		do
			if not is_destroyed then
				if
					internal_inner_container.readable and
					attached {SD_ZONE} internal_inner_container.item as l_zone
				then
					l_zone.set_last_floating_height (a_height)
					l_zone.set_last_floating_width (a_width)
				end
				floating_state.record_state
			end
		end

	on_dpi_changed (a_dpi: NATURAL_32; a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Handle resize actions
		do
			on_resize (a_x, a_y, a_width, a_height)
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
