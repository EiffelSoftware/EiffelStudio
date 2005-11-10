indexing
	description: "When a content is floating, this class to hold content(s)."
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
			show as show_allow_to_back
		end

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		require

		do
			create internal_shared
			default_create

			create internal_vertical_box
			internal_vertical_box.set_border_width (2)
			internal_vertical_box.set_background_color ((create {EV_STOCK_COLORS}).grey)
			extend_dialog (internal_vertical_box)

			create internal_title_bar.make (internal_shared.icons.default_icon, "Floating")
			internal_vertical_box.extend (internal_title_bar)
			internal_title_bar.pointer_button_press_actions.extend (agent on_title_bar_pointer_button_press)
			internal_title_bar.pointer_motion_actions.extend (agent on_title_bar_pointer_motion)
			internal_title_bar.pointer_button_release_actions.extend (agent on_title_bar_pointer_button_release)
			internal_title_bar.close_actions.extend (agent on_close_window)

			internal_vertical_box.disable_item_expand (internal_title_bar)

			pointer_button_release_actions.extend (agent handle_pointer_button_release)

			pointer_motion_actions.extend (agent on_pointer_motion)
--			internal_title_bar.drag_actions.extend (agent handle_drag_action)
--			internal_title_bar.pointer_button_release_actions.extend (agent handle_title_bar_pointer_release)
--			internal_vertical_box.extend (a_content.user_widget)

			create internal_inner_container.make
			internal_vertical_box.extend (internal_inner_container)
			internal_inner_container.set_parent_floating_zone (Current)

--			internal_vertical_box.start
--			internal_vertical_box.put_left (internal_title_bar)
--			internal_vertical_box.disable_item_expand (internal_title_bar)

		end




	on_add_action (a_content: SD_CONTENT) is
			-- If `Current' contain zone more then one, add `Current''s title bar.
		do

		end

	on_remove_action (a_content: SD_CONTENT) is
			-- If 'Current' contain zone only one, add `Current''s title bar.
		do

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
					--  l_zone should not have title bar.
					l_title_zone ?= l_zone
					check l_title_zone /= Void end
					l_title_zone.set_title_bar (False)

				else
					--  l_zone should have title bar
					l_split_area ?= internal_inner_container.item
					check l_split_area /= Void end
					l_title_zone ?= l_split_area.first
					if l_title_zone /= Void then
						l_title_zone.set_title_bar (True)
						l_title_zone := Void
					end
					l_title_zone ?= l_split_area.second
					if l_title_zone /= Void then
						l_title_zone.set_title_bar (True)
					end
				end
			else
				-- No widget in `Current'.
				internal_shared.docking_manager.internal_inner_containers.prune_all (internal_inner_container)
				internal_shared.docking_manager.internal_zones.prune (Current)
				destroy
			end
		end

	content: SD_CONTENT is
			--
		local
			l_zone: SD_ZONE
		do
--			internal_contents.start
--			Result := internal_contents.item
			l_zone ?= internal_inner_container.item
			if l_zone /= Void then
				Result := l_zone.content
			end
		end

	set_content (a_content: SD_CONTENT) is
			--
		do

		end

--	internal_contents: ACTIVE_LIST [SD_CONTENT]
--			-- All contents in `Current'.

	extend (a_zone: SD_ZONE) is
			--
		do
--			internal_inner_container.extend (a_zone)
		end

	show is
			--
		do
			if internal_shared.allow_window_to_back then
				show_allow_to_back
			else
				show_relative_to_window (internal_shared.docking_manager.main_window)
			end
		end

	type: INTEGER is
			--
		do
			Result := internal_shared.hot_zone_factory.hot_zone_main.type
		end

	state: SD_STATE is
			--
		do
			Result := internal_floating_state
		end

feature --

	inner_container: like internal_inner_container is
			--
		do
			Result := internal_inner_container
		ensure
			not_void: Result /= Void
		end

feature {NONE}  -- Docking implementation


feature -- States report

feature {NONE} -- Implementation

	internal_floating_state: SD_FLOATING_STATE
			--
	internal_vertical_box: EV_VERTICAL_BOX

	internal_inner_container: SD_MULTI_DOCK_AREA

	internal_title_bar: SD_FLOATING_TITLE_BAR

	pointer_last_position: EV_COORDINATE

	docker_mediator: SD_DOCKER_MEDIATOR

	last_x, last_y: INTEGER
	recorded: BOOLEAN

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
--			set_pointer_style (default_pixmaps.sizeall_cursor)

			if internal_title_bar_pressed then
				debug ("larry")
					io.put_string ("%N SD_FLOATING_ZONE before set position")
				end
--				set_position (a_screen_x - pointer_press_offset_x, a_screen_y - pointer_press_offset_y)
				if docker_mediator = Void or not docker_mediator.capture_enabled  then
					create docker_mediator.make (Current)
					docker_mediator.start_tracing_pointer (pointer_press_offset_x, pointer_press_offset_y)
				else
					docker_mediator.on_pointer_motion (a_screen_x, a_screen_y)
				end

				debug ("larry")
					io.put_string ("%N SD_FLOATING_ZONE on_pointer_motion. set_position " + (a_screen_x - pointer_press_offset_x).out + " " + (a_screen_y - pointer_press_offset_y).out)
				end
			end

		end

	on_close_window is
			--
		do

			prune_all_zone (inner_container.item)
			wipe_out
			destroy
		end

	prune_all_zone (a_widget: EV_WIDGET) is
			--
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

	on_title_bar_pointer_button_press (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			if a_button = 1 then
				internal_title_bar_pressed := True
			end

		end

	on_title_bar_pointer_button_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			if a_button = 1 then
				internal_title_bar_pressed := False
			end

		end

	internal_title_bar_pressed: BOOLEAN

	on_title_bar_pointer_motion (a_x, a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do

			if internal_title_bar_pressed then
				pointer_press_offset_x := a_screen_x - screen_x
				pointer_press_offset_y := a_screen_y - screen_y
				enable_capture
			end
		end

	handle_pointer_button_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			if a_button = 1 and docker_mediator /= Void then
				internal_title_bar_pressed := False
				disable_capture
				debug ("larry")
					io.put_string ("%N SD_FLOATING_ZONE: yeah, released! ")
				end
				docker_mediator.end_tracing_pointer (a_screen_x, a_screen_y)
				docker_mediator := Void
			end
		end

	pointer_press_offset_x, pointer_press_offset_y: INTEGER

end
