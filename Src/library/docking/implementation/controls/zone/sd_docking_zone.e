indexing
	description: "Objects that represent the zone when docking in the main container."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_ZONE

inherit
	EV_CELL

	SD_SINGLE_CONTENT_ZONE
		rename
			internal_shared as internal_shared_not_used
		undefine
			copy, is_equal, default_create,
			on_focus_in, on_zone_focus_out
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
			create internal_shared
			default_create
			create window.make (a_content.type, Current)
			internal_content := a_content
			window.set_user_widget (internal_content.user_widget)
			window.title_bar.set_title (internal_content.title)
			window.close_actions.extend (agent close_window)
			window.stick_actions.extend (agent stick_window)
			window.drag_actions.extend (agent handle_drag_started)
			window.min_max_action.extend (agent handle_min_max_window)
			window.pointer_double_press_title_bar_actions.extend (agent handle_title_bar_double_press)

			pointer_motion_actions.extend (agent on_pointer_motion)
			pointer_button_release_actions.extend (agent on_pointer_release)
			window.set_stick (True)
			extend (window)

--			init_focus_in (Current)
			on_focus_in (Void)

		end

feature {SD_CONTENT}

	on_focus_in (a_content: SD_CONTENT) is
		--
		do
			Precursor {SD_SINGLE_CONTENT_ZONE} (a_content)
			internal_shared.docking_manager.disable_all_zones_focus_color
			internal_shared.docking_manager.remove_auto_hide_zones
			window.title_bar.enable_focus_color
		end

feature {NONE} -- Implementation

	close_window is
			-- When user clicked the close button.
		do
			internal_content.state.close_window
		end

	handle_min_max_window is
			--
		do
			internal_content.state.min_max_window
		end

	stick_window is
			-- When user clicked the stick button.
		do
			internal_content.state.stick_window ({SD_DOCKING_MANAGER}.dock_left)
		end

	handle_title_bar_double_press is
			--
		do
			handle_min_max_window
		end

	resize_bar: SD_RESIZE_BAR
			-- The resize bar at the side.

	window: SD_WINDOW
			-- The window.



	on_zone_focus_out is
			--
		do
			Precursor {SD_SINGLE_CONTENT_ZONE}
			window.title_bar.disable_focus_color
		end

feature {NONE} -- For redocker.

	handle_drag_started (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Create a SD_DOCKER_MEDIATOR draw feedbacks for user to look where to docking.
		do
			debug ("larry")
				io.put_string ("%N ******** draging window in SD_DOCKING_ZONE " + a_screen_x.out + " " + a_screen_y.out + "and window width height is: " + width.out + " " + height.out)
			end

			create docker_mediator.make (Current)
			docker_mediator.start_tracing_pointer (screen_x -  a_screen_x, screen_y - a_screen_y)
			enable_capture
		end

	on_pointer_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			if docker_mediator /= Void then
				disable_capture
				docker_mediator.end_tracing_pointer (a_screen_x, a_screen_y)
				docker_mediator := Void
			end
		end

	on_pointer_motion (a_x, a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			if docker_mediator /= Void then
				docker_mediator.on_pointer_motion (a_screen_x,  a_screen_y)
				debug ("larry")
					io.put_string ("%N hot zone for docking ! yeah~" + a_screen_x.out + " " + a_screen_y.out)
				end
			end
		end

	docker_mediator: SD_DOCKER_MEDIATOR
			-- The mediator perform dock.	

feature -- Access

	set_title_bar (a_show: BOOLEAN) is
			-- Set whether to show title bar?
		do
			if a_show then
				window.set_title_bar (a_show)
			else
				window.set_title_bar (a_show)
			end
		end

	is_parent_split: BOOLEAN is
			--
		local
			l_split_area: EV_SPLIT_AREA
		do
			l_split_area ?= parent
			Result := l_split_area /= Void
		end

	parent_split_position: INTEGER is
			--
		require
			parent_is_split_area: is_parent_split
		local
			l_split_area: EV_SPLIT_AREA
		do
			l_split_area ?= parent
			Result := l_split_area.split_position
		end

end
