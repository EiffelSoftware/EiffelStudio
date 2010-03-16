note
	description: "Objects that is the zone when docking at a SD_AUTO_HIDE_PANEL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		redefine
			destroy
		end

	SD_SINGLE_CONTENT_ZONE
		undefine
			on_focus_in,
			on_focus_out
		redefine
			set_focus_color
		end

	SD_RESIZE_SOURCE
		undefine
			copy, is_equal, default_create
		end

create
	make

feature	{NONE} -- Initlization

	make (a_content: SD_CONTENT; a_direction: INTEGER)
			-- Creation method
		require
			a_content_not_void: a_content /= Void
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		do
			create internal_shared
			set_docking_manager (a_content.docking_manager)
			create window.make (a_content.type, {SD_ENUMERATION}.auto_hide)
			internal_direction := a_direction
			internal_content := a_content
			create resize_bar.make (a_direction)

			if a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right then
				init (False)
			else
				init (True)
			end

			window.set_user_widget (internal_content.user_widget)
			window.title_bar.set_title (internal_content.long_title)
			window.title_bar.set_show_normal_max (False)
			window.close_request_actions.extend (agent on_close_request)
			window.stick_actions.extend (agent stick)
			if attached a_content.mini_toolbar as l_mini_toolbar then
				if attached l_mini_toolbar.parent as l_parent then
					l_parent.prune (l_mini_toolbar)
				end
				window.title_bar.extend_custom_area (l_mini_toolbar)
			end

			resize_bar.set_resize_source (Current)
			if a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.top then
				extend_hor_ver_box (window)
				extend_hor_ver_box (resize_bar)
			elseif a_direction = {SD_ENUMERATION}.right or a_direction = {SD_ENUMERATION}.bottom then
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
			-- Direction

	stick
			-- Stick zone
		do
			internal_content.state.stick (content.state.direction)
		end

	resize_bar: SD_RESIZE_BAR
			-- Resize bar at side

	start_resize_operation (a_bar: SD_RESIZE_BAR; a_screen_boundary: EV_RECTANGLE)
			-- <Precursor>
		do
			-- Set the area which allow user to resize the window.
			if internal_direction = {SD_ENUMERATION}.left then
				a_screen_boundary.set_right (docking_manager.query.container_rectangle_screen.right)
				a_screen_boundary.set_left (window.screen_x + minimum_width)
			elseif internal_direction = {SD_ENUMERATION}.right then
				a_screen_boundary.set_right (window.screen_x + window.width - minimum_width)
				a_screen_boundary.set_left (docking_manager.query.container_rectangle_screen.left)
			elseif internal_direction = {SD_ENUMERATION}.top then
				a_screen_boundary.set_bottom (docking_manager.query.container_rectangle_screen.bottom)
				a_screen_boundary.set_top (window.screen_y + minimum_height)
			elseif internal_direction = {SD_ENUMERATION}.bottom then
				a_screen_boundary.set_bottom ((window.screen_y + window.height) - minimum_height)
				a_screen_boundary.set_top (docking_manager.query.container_rectangle_screen.top)
			end
			debug ("docking")
				io.put_string ("%N allow resize area is: " + a_screen_boundary.out)
			end
		end

	end_resize_operation (a_bar: SD_RESIZE_BAR; a_delta: INTEGER)
			-- <Precursor>
		do
			disable_item_expand (resize_bar)
			if internal_direction = {SD_ENUMERATION}.left or internal_direction = {SD_ENUMERATION}.right then
				docking_manager.zones.set_zone_size (Current, width + a_delta, height)
				if a_bar.direction = {SD_ENUMERATION}.right then
					docking_manager.fixed_area.set_item_position (Current, x_position - a_delta, y_position)
				end
			else
				debug ("docking")
					io.put_string ("%N SD_AUTO_HIDE_ZONE before set zone height: " + height.out + " " + ($Current).out)
				end
				docking_manager.zones.set_zone_size (Current, width, height + a_delta)
				debug ("docking")
					io.put_string ("%N SD_AUTO_HIDE_ZONE after set zone height: " + height.out)
				end
				if a_bar.direction = {SD_ENUMERATION}.bottom then
					docking_manager.fixed_area.set_item_position (Current, x_position, y_position - a_delta)
				end
			end
		end

feature {SD_AUTO_HIDE_STATE} -- For user docking

	on_focus_in (a_content: SD_CONTENT)
			-- <Precursor>
		do
			Precursor {SD_SINGLE_CONTENT_ZONE} (a_content)
			window.set_focus_color (True)
		end

	on_focus_out
			-- <Precursor>
		do
			Precursor {SD_SINGLE_CONTENT_ZONE}
			window.set_focus_color (False)
		end

feature -- Query

	window: SD_PANEL
			-- Window

	title: STRING_32
			-- Texts on title bar
		do
			Result := window.title_bar.title
		ensure
			not_void: Result /= Void
		end

	has_focus: BOOLEAN
			-- If `Current' has focus?
		do
			Result := window.title_bar.is_focus_color_enable
		end

feature -- Command

	set_focus_color (a_selection: BOOLEAN)
			-- <Precursor>
		do
			if a_selection then
				window.title_bar.enable_focus_color
			else
				window.title_bar.disable_focus_color
			end
		end

	set_title (a_title: STRING_GENERAL)
			-- Set title of title bar.
		require
			a_title_not_void: a_title /= Void
		do
			window.title_bar.set_title (a_title)
		ensure
			set: window.title_bar.title ~ a_title
		end

	destroy
			-- <Precursor>
		do
			Precursor
			window.title_bar.destroy
			window.destroy
			resize_bar.destroy
			if internal_horizontal_box /= Void then
				horizontal_box.destroy
			end
			pointer_enter_actions.wipe_out
			internal_pointer_enter_actions := Void
		end

invariant

	internal_shared_not_void: internal_shared /= Void

note
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
