indexing
	description: "Objects that represent the zone when docking in SD_MULTI_DOCK_AREA."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_ZONE

inherit
	EV_CELL
		rename
			has as has_cell,
			extend as extend_cell
		select
			implementation
		end

	SD_SINGLE_CONTENT_ZONE
		rename
			internal_shared as internal_shared_not_used,
			extend_widget as extend_cell,
			has_widget as has_cell
		undefine
			on_focus_in,
			on_focus_out,
			close_window
		redefine
			set_max,
			is_maximized
		end

	SD_DOCKER_SOURCE
		undefine
			copy, is_equal, default_create
		end

	SD_TITLE_BAR_REMOVEABLE
		undefine
			copy, is_equal, default_create
		end
create
	make

feature	{NONE} -- Initlization

	make (a_content: SD_CONTENT) is
			-- Creation method.
		require
			a_content_not_void: a_content /= Void
		do
			create internal_shared_not_used
			create internal_shared
			default_create
			create window.make (a_content.type, Current)
			internal_content := a_content
			window.set_user_widget (internal_content.user_widget)
			window.title_bar.set_title (internal_content.title)
			if a_content.mini_toolbar /= Void then
				if a_content.mini_toolbar.parent /= Void then
					a_content.mini_toolbar.parent.prune (a_content.mini_toolbar)
				end
				window.title_bar.custom_area.extend (a_content.mini_toolbar)
			end
			window.close_request_actions.extend (agent close_window)
			window.stick_actions.extend (agent stick_window)
			window.drag_actions.extend (agent on_drag_started)
			window.normal_max_action.extend (agent on_normal_max_window)

			pointer_motion_actions.extend (agent on_pointer_motion)
			pointer_button_release_actions.extend (agent on_pointer_release)
			window.set_stick (True)
			extend_cell (window)
		ensure
			added: has_cell (window)
		end

feature {SD_DOCKING_STATE} -- Initlization

	set_widget_main_area (a_widget: EV_WIDGET; a_main_area: SD_MULTI_DOCK_AREA; a_parent: EV_CONTAINER; a_split_position: INTEGER) is
			-- Set widget and main area which used for normal window.
		require
			a_widget_not_void: a_widget /= Void
			a_main_area_not_void: a_main_area /= Void
			a_parent_not_void: a_parent /= Void
		do
			main_area_widget := a_widget
			main_area := a_main_area
			internal_parent := a_parent
			internal_parent_split_position := a_split_position
		ensure
			set: main_area_widget = a_widget and main_area = a_main_area and internal_parent = a_parent and internal_parent_split_position = a_split_position
		end

feature {SD_CONTENT}

	on_focus_in (a_content: SD_CONTENT) is
		-- Redefine.
		do
			Precursor {SD_SINGLE_CONTENT_ZONE} (a_content)
			internal_shared.docking_manager.disable_all_zones_focus_color
			internal_shared.docking_manager.remove_auto_hide_zones
			window.title_bar.enable_focus_color
		end

feature -- Command

	set_show_stick_min_max (a_show: BOOLEAN) is
			-- Set whether to show title bar?
		do
			if a_show then
				window.set_show_stick_min_max (a_show)
			else
				window.set_show_stick_min_max (a_show)
			end
		end

	set_title (a_title: STRING) is
			-- Set title.
		do
			window.title_bar.set_title (a_title)
		end

	set_max (a_max: BOOLEAN) is
			-- Redefine.
		do
			window.title_bar.set_max (a_max)
		end

feature -- Query

	title: STRING is
			-- Title.
		do
			Result := window.title_bar.title
		end

	is_parent_split: BOOLEAN is
			-- Is parent a split area?
		local
			l_split_area: EV_SPLIT_AREA
		do
			l_split_area ?= parent
			Result := l_split_area /= Void
		end

	parent_split_position: INTEGER is
			-- If parent is split area, get split position.
		require
			parent_is_split_area: is_parent_split
		local
			l_split_area: EV_SPLIT_AREA
		do
			l_split_area ?= parent
			Result := l_split_area.split_position
		end

	is_maximized: BOOLEAN is
			-- Redefine.
		do
			Result := window.title_bar.is_max
		end

feature {NONE} -- For redocker.

	on_drag_started (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Create a SD_DOCKER_MEDIATOR, start hanlde pointer motion.
		do
			debug ("larry")
				io.put_string ("%N ******** draging window in SD_DOCKING_ZONE " + a_screen_x.out + " " + a_screen_y.out + "and window width height is: " + width.out + " " + height.out)
			end
			create docker_mediator.make (Current)
			docker_mediator.start_tracing_pointer (a_screen_x - screen_x, a_screen_y - screen_y)

			enable_capture
		end

	on_pointer_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Stop SD_DOCKER_MEDIATOR.
		do
			if docker_mediator /= Void then
				disable_capture
				docker_mediator.end_tracing_pointer (a_screen_x, a_screen_y)
				docker_mediator := Void
			end
		end

	on_pointer_motion (a_x, a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Forward pointer motion datas to SD_DOCKER_MEDIATOR.
		do
			if docker_mediator /= Void then
				docker_mediator.on_pointer_motion (a_screen_x,  a_screen_y)
				debug ("larry")
					io.put_string ("%N hot zone for docking ! yeah~" + a_screen_x.out + " " + a_screen_y.out)
				end
			end
		end

	docker_mediator: SD_DOCKER_MEDIATOR
			-- Mediator perform dock.	

feature {NONE} -- Implementation

	stick_window is
			-- Stick window.
		do
			internal_content.state.stick_window ({SD_DOCKING_MANAGER}.dock_left)
		end

--	on_title_bar_double_press is
--			-- Min max widow if is allowed.
--		do
--			if window.title_bar.is_show_normal_max then
--				on_normal_max_window
--			end
--		end

	close_window is
			-- Redefine
		do
			internal_shared.docking_manager.lock_update
			Precursor {SD_SINGLE_CONTENT_ZONE}
			internal_shared.docking_manager.prune_zone (Current)
			internal_shared.docking_manager.unlock_update
		end

	resize_bar: SD_RESIZE_BAR
			-- Resize bar at the side.

	window: SD_WINDOW
			-- Window.

	on_focus_out is
			-- Redefine.
		do
			Precursor {SD_SINGLE_CONTENT_ZONE}
			window.title_bar.disable_focus_color
		end

invariant

	internal_shared_not_void: internal_shared /= Void
	window_not_void: window /= Void

end
