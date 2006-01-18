indexing
	description: "Objects that is the zone when docking at a SD_AUTO_HIDE_PANEL"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_AUTO_HIDE_ZONE

inherit
	SD_HOR_VER_BOX
		rename
			has as has_hor_ver_box,
			extend as extend_hor_ver_box,
			has_focus as has_focus_vertical_box
		select
			pointer_enter_actions,
			implementation,
			item_vertical_box,
			count_vertical_box,
			linear_representation_vertical_box,
			set_extend,
			prune_vertical_box,
			wipe_out_vertical_box,
			cl_put,
			prune_all,
			set_background_color,
			background_color
		end

	SD_SINGLE_CONTENT_ZONE
		rename
			extend_widget as extend_vertical_box,
			has_widget as has_vertical_box,
			has_focus as has_focus_vertical_box
		undefine
			on_focus_in,
			on_focus_out,
			pointer_enter_actions,
			set_background_color,
			background_color
		redefine
			set_title_bar_selection_color
		end

	SD_RESIZE_SOURCE
		undefine
			copy, is_equal, default_create
		end

create
	make

feature	{NONE} -- Initlization

	make (a_content: SD_CONTENT; a_direction: INTEGER) is
			-- Creation method.
		require
			a_content_not_void: a_content /= Void
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			create internal_shared
			internal_docking_manager := a_content.docking_manager
			if a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
				init (False)
			else
				init (True)
			end
			internal_direction := a_direction
			create window.make (a_content.type, Current)
			internal_content := a_content
			window.set_user_widget (internal_content.user_widget)
			window.title_bar.set_title (internal_content.long_title)
			window.title_bar.set_show_normal_max (False)
			window.close_request_actions.extend (agent on_close_request)
			window.stick_actions.extend (agent stick)
			if a_content.mini_toolbar /= Void then
				if a_content.mini_toolbar.parent /= Void then
					a_content.mini_toolbar.parent.prune (a_content.mini_toolbar)
				end
				window.title_bar.extend_custom_area (a_content.mini_toolbar)
			end
			create resize_bar.make (a_direction, Current)

			if a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_top then
				extend_hor_ver_box (window)
				extend_hor_ver_box (resize_bar)
			elseif a_direction = {SD_DOCKING_MANAGER}.dock_right or a_direction = {SD_DOCKING_MANAGER}.dock_bottom then
				extend_hor_ver_box (resize_bar)
				extend_hor_ver_box (window)
			end
			disable_item_expand (resize_bar)

			-- The minimum width is the width of two buttons on the title bar.
			content.user_widget.set_minimum_size (internal_shared.icons.stick.width * 3, internal_shared.icons.stick.height)
		ensure
			set: internal_docking_manager = a_content.docking_manager
		end

feature {NONE} -- Implementation

	internal_direction: INTEGER
			-- Direction.

	stick is
			-- Stick zone.
		do
			internal_content.state.stick (content.state.direction)
		end

	resize_bar: SD_RESIZE_BAR
			-- Resize bar at side.

	window: SD_WINDOW
			-- Window.

	start_resize_operation (a_bar: SD_RESIZE_BAR; a_screen_boundary: EV_RECTANGLE) is
			-- Redefine.
		do
			-- Set the area which allow user to resize the window.
			if internal_direction = {SD_DOCKING_MANAGER}.dock_left then
				a_screen_boundary.set_right (internal_docking_manager.query.container_rectangle_screen.right)
				a_screen_boundary.set_left (window.screen_x + minimum_width)
			elseif internal_direction = {SD_DOCKING_MANAGER}.dock_right then
				a_screen_boundary.set_right (window.screen_x + window.width - minimum_width)
				a_screen_boundary.set_left (internal_docking_manager.query.container_rectangle_screen.left)
			elseif internal_direction = {SD_DOCKING_MANAGER}.dock_top then
				a_screen_boundary.set_bottom (internal_docking_manager.query.container_rectangle_screen.bottom)
				a_screen_boundary.set_top (window.screen_y + minimum_height)
			elseif internal_direction = {SD_DOCKING_MANAGER}.dock_bottom then
				a_screen_boundary.set_bottom ((window.screen_y + window.height) - minimum_height)
				a_screen_boundary.set_top (internal_docking_manager.query.container_rectangle_screen.top)
			end
			debug ("docking")
				io.put_string ("%N allow resize area is: " + a_screen_boundary.out)
			end
		end

	end_resize_operation (a_bar: SD_RESIZE_BAR; a_delta: INTEGER) is
			-- Redefine.
		do
			disable_item_expand (resize_bar)
			if internal_direction = {SD_DOCKING_MANAGER}.dock_left or internal_direction = {SD_DOCKING_MANAGER}.dock_right then
				internal_docking_manager.zones.set_zone_size (Current, width + a_delta, height)
				if a_bar.direction = {SD_DOCKING_MANAGER}.dock_right then
					internal_docking_manager.fixed_area.set_item_position (Current, x_position - a_delta, y_position)
				end
			else
				debug ("docking")
					io.put_string ("%N SD_AUTO_HIDE_ZONE before set zone height: " + height.out + " " + ($Current).out)
				end
				internal_docking_manager.zones.set_zone_size (Current, width, height + a_delta)
				debug ("docking")
					io.put_string ("%N SD_AUTO_HIDE_ZONE after set zone height: " + height.out)
				end
				if a_bar.direction = {SD_DOCKING_MANAGER}.dock_bottom then
					internal_docking_manager.fixed_area.set_item_position (Current, x_position, y_position - a_delta)
				end
			end
		end

feature {NONE} -- For user docking

	on_focus_in (a_content: SD_CONTENT)is
			-- Redefine.
		do
			Precursor {SD_SINGLE_CONTENT_ZONE} (a_content)
			window.set_focus_color (True)
		end

	on_focus_out is
			-- Redefine.
		do
			Precursor {SD_SINGLE_CONTENT_ZONE}
			window.set_focus_color (False)
		end

feature -- Query

	has_focus: BOOLEAN is
			-- If `Current' has focus?
		do
			Result := window.title_bar.is_focus_color_enable
		end

feature -- Command

	set_title_bar_selection_color (a_selection: BOOLEAN) is
			-- Redefine.
		do
			if a_selection then
				window.title_bar.enable_focus_color
			else
				window.title_bar.disable_focus_color
			end
		end

invariant

	internal_shared_not_void: internal_shared /= Void

end
