indexing
	description: "When a content is floating, objects to hold content(s)."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FLOATING_ZONE

inherit
	SD_ZONE
		rename
			internal_shared as internal_shared_zone
		undefine
			default_create, copy
		redefine
			type,
			state
		end

	SD_DOCKER_SOURCE
		undefine
			default_create, copy
		end

	EV_UNTITLED_DIALOG
		rename
			extend as extend_dialog,
			show as show_allow_to_back,
			has as has_untitled_dialog
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
			create internal_shared
			create internal_shared_zone
			default_create
			create internal_vertical_box
			internal_vertical_box.set_border_width (2)
			internal_vertical_box.set_background_color ((create {EV_STOCK_COLORS}).grey)
			extend_dialog (internal_vertical_box)
			create internal_title_bar.make
			internal_title_bar.drag_actions.extend (agent on_title_bar_drag)
			internal_title_bar.close_actions.extend (agent on_close_window)
			internal_title_bar.set_show_min_max (False)
			internal_title_bar.set_show_stick (False)
			pointer_button_release_actions.extend (agent on_pointer_button_release)
			pointer_motion_actions.extend (agent on_pointer_motion)
			create internal_inner_container.make
			internal_vertical_box.extend (internal_inner_container)
			internal_inner_container.set_parent_floating_zone (Current)
		end

feature {SD_CONFIG_MEDIATOR} -- Save config

	save_content_title (a_config_data: SD_INNER_CONTAINER_DATA) is
		do
			a_config_data.add_title ("SD_FLOATING_ZONE")
		end

feature -- Command

	update_title_bar is
			-- Remove/add title bar if `Current' content count changed.
		local
			l_zone: SD_ZONE
			l_title_zone: SD_TITLE_BAR_REMOVEABLE
			l_split_area: EV_SPLIT_AREA
		do
			if internal_inner_container.readable then
				l_zone ?= internal_inner_container.item
				if l_zone /= Void then

					--  l_zone should not have min\max stick button.
					l_title_zone ?= l_zone
					check l_title_zone /= Void end
					l_title_zone.set_show_stick_min_max (False)
					if internal_vertical_box.has (internal_title_bar) then
						internal_vertical_box.prune_all (internal_title_bar)
					end
				else
					if not internal_vertical_box.has (internal_title_bar) then
						internal_vertical_box.start
						internal_vertical_box.put_left (internal_title_bar)
						internal_vertical_box.disable_item_expand (internal_title_bar)
					end
					--  l_zone should have title bar
					l_split_area ?= internal_inner_container.item
					check l_split_area /= Void end
					l_title_zone ?= l_split_area.first
					if l_title_zone /= Void then
						l_title_zone.set_show_stick_min_max (True)
						l_title_zone := Void
					end
					l_title_zone ?= l_split_area.second
					if l_title_zone /= Void then
						l_title_zone.set_show_stick_min_max (True)
					end
				end
			else
				-- No widget in `Current'.
				internal_shared.docking_manager.inner_containers.prune_all (internal_inner_container)
				internal_shared.docking_manager.zones.prune (Current)
				destroy
			end
		end

	show is
			-- Show `Current'.
		do
			if internal_shared.allow_window_to_back then
				show_allow_to_back
			else
				show_relative_to_window (internal_shared.docking_manager.main_window)
			end
		ensure
			showed: is_displayed
		end

feature -- Properties

	type: INTEGER is
			-- Redefine.
		do
			Result := internal_shared.hot_zone_factory.hot_zone_main.type
		end

	state: SD_STATE is
			-- Redefine.
		local
			l_zone: SD_ZONE
		do
			l_zone ?= internal_inner_container.item
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
			l_zone ?= internal_inner_container.item
			if l_zone /= Void then
				Result := l_zone.content
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


	prune_all_zone (a_widget: EV_WIDGET) is
			-- Prune all zone in `Current'
		require
			a_widget_not_void: a_widget /= Void
		local
			l_zone: SD_ZONE
			l_split_area: EV_SPLIT_AREA
		do
			l_zone ?= a_widget
			if l_zone /= Void then
				internal_shared.docking_manager.prune_zone (l_zone)
			end

			l_split_area ?= a_widget
			if l_split_area /= Void then
				prune_all_zone (l_split_area.first)
				prune_all_zone (l_split_area.second)
			end
		end



feature -- Agents

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Forward pointer motion actions to docker mediator.
		do
			docker_mediator.on_pointer_motion (a_screen_x, a_screen_y)
		end

	on_close_window is
			-- Destroy `Current'.
		do
			prune_all_zone (inner_container.item)
			wipe_out
			destroy
		end

	on_title_bar_drag (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Start `docker_mediator'.
		do
				pointer_press_offset_x := a_screen_x - screen_x
				pointer_press_offset_y := a_screen_y - screen_y
				enable_capture
				create docker_mediator.make (Current)
				docker_mediator.start_tracing_pointer (pointer_press_offset_x, pointer_press_offset_y)
		end

	on_pointer_button_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Stop `docker_mediator'.
		do
			if a_button = 1 and docker_mediator /= Void then
				disable_capture
				debug ("larry")
					io.put_string ("%N SD_FLOATING_ZONE: yeah, released! ")
				end
				docker_mediator.end_tracing_pointer (a_screen_x, a_screen_y)
				docker_mediator := Void
			end
		end

end
