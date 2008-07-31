indexing
	description: "User resizable popup window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SIZABLE_POPUP_WINDOW

inherit
	SD_WINDOW
		rename
			extend as extend_sizeable_popup_window
		redefine
			initialize
		end

feature {NONE} -- Initialization

	initialize is
			-- Redefine
		local
			l_styles: EV_STOCK_PIXMAPS
		do
			Precursor {SD_WINDOW}
			init_border_box

			create {EV_CELL} internal_padding_box
			internal_border_box.extend (internal_padding_box)
			create l_styles
			internal_padding_box.set_pointer_style (l_styles.standard_cursor)
		end

	init_border_box is
			-- Initialize `internal_border_box'.
		do
			create {EV_VERTICAL_BOX} internal_border_box
			internal_border_box.set_border_width (internal_border_width)
			extend_sizeable_popup_window (internal_border_box)

			internal_border_box.pointer_motion_actions.extend (agent on_border_box_pointer_motion)
			internal_border_box.pointer_button_press_actions.extend (agent on_border_pointer_press)
			internal_border_box.pointer_button_release_actions.extend (agent on_border_pointer_release)
		end

feature -- Command

	extend (a_widget: EV_WIDGET) is
			-- Extend `a_widget'.
		do
			internal_padding_box.extend (a_widget)
		end

	set_pointer_style_for_border (a_pointer_style: EV_POINTER_STYLE) is
			-- Clear pointer styles before dragging on GTK
			-- Otherwise, set pointer style to top window will not work
		require
			not_void: a_pointer_style /= Void
		do
			internal_border_box.set_pointer_style (a_pointer_style)
			internal_padding_box.set_pointer_style (a_pointer_style)
		end

feature {NONE} -- Implementation

	on_border_box_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle border box pointer motion.
		do
			if not internal_border_box.has_capture then
				on_border_pointer_motion_no_capture (a_x, a_y)
			else
				inspect
					internal_pointer_direction
				when {SD_ENUMERATION}.top_left then
					resize_top_left (a_screen_x, a_screen_y)
				when {SD_ENUMERATION}.top_right then
					resize_right (a_screen_x)
					resize_top (a_screen_y)
				when {SD_ENUMERATION}.bottom_left then
					resize_bottom (a_screen_y)
					resize_left (a_screen_x)
				when {SD_ENUMERATION}.bottom_right then
					resize_right (a_screen_x)
					resize_bottom (a_screen_y)
				when {SD_ENUMERATION}.left then
					resize_left (a_screen_x)
				when {SD_ENUMERATION}.right then
					resize_right (a_screen_x)
				when {SD_ENUMERATION}.top then
					resize_top (a_screen_y)
				when {SD_ENUMERATION}.bottom then
					resize_bottom (a_screen_y)
				else
					-- It maybe just initialized Current.
				end
			end
		end

	resize_left (a_screen_x: INTEGER) is
			-- Resize width base on `a_screen_x' when pointer is at left side.
		local
			l_size: INTEGER
		do
			l_size := fixed_point_x - a_screen_x
			if l_size > 0 and l_size >= minimum_width then
				set_x_position (a_screen_x)
				set_width (l_size)
			else
				set_x_position (fixed_point_x - minimum_width)
				set_width (minimum_width)
			end
		end

	resize_right (a_screen_x: INTEGER) is
			-- Resize width base on `a_screen_x' when pointer is at right side.
		local
			l_size: INTEGER
		do
			l_size := a_screen_x - screen_x
			if l_size > 0 then
				set_width (l_size)
			else
				set_width (minimum_width)
			end
		end

	resize_top (a_screen_y: INTEGER) is
			-- Resize height base on `a_screen_y' when pointer is at top side.
		local
			l_size: INTEGER
		do

			l_size := fixed_point_y - a_screen_y
			if l_size > 0 and l_size >= minimum_height then
				set_y_position (a_screen_y)
				set_height (l_size)
			else
				set_y_position (fixed_point_y - minimum_height)
				set_height (minimum_height)
			end

		end

	resize_top_left (a_screen_x, a_screen_y: INTEGER) is
			-- Resize at top left side.
			-- On Linux, the efficiency of UI is not enough (compare with Windows), we can't just simply call `resize_top' and `resize_left', otherwise there will be incorrect size.
		local
			l_width, l_height, l_x, l_y: INTEGER
		do
				l_height := fixed_point_y - a_screen_y
				if l_height > 0 and l_height >= minimum_height then
					l_y := a_screen_y
				else
					l_y := fixed_point_y - minimum_height
					l_height := minimum_height
				end

				l_width := fixed_point_x - a_screen_x
				if l_width > 0 and l_width >= minimum_width then
					l_x := a_screen_x
				else
					l_x := fixed_point_x - minimum_width
					l_width := minimum_width
				end

				set_position (l_x, l_y)
				set_size (l_width, l_height)
		end

	resize_bottom (a_screen_y: INTEGER) is
			-- Resize height base on `a_screen_y' when pointer is at bottom side.
		local
			l_size: INTEGER
		do
			l_size := a_screen_y - screen_y
			if l_size > 0 then
				set_height (l_size)
			else
				set_height (minimum_height)
			end
		end

	on_border_pointer_motion_no_capture (a_x, a_y: INTEGER) is
			-- Handle pointer motion actions when not has capture.
		require
			not_capture: not internal_border_box.has_capture
		do
			if is_border_left (a_x) then
				if is_border_bottom (a_y) then
					internal_pointer_direction := {SD_ENUMERATION}.bottom_left
				elseif is_border_top (a_y) then
					internal_pointer_direction := {SD_ENUMERATION}.top_left
				else
					internal_pointer_direction := {SD_ENUMERATION}.left
				end
			elseif is_border_right (a_x) then
				if is_border_bottom (a_y) then
					internal_pointer_direction := {SD_ENUMERATION}.bottom_right
				elseif is_border_top (a_y) then
					internal_pointer_direction := {SD_ENUMERATION}.top_right
				else
					internal_pointer_direction := {SD_ENUMERATION}.right
				end
			elseif is_border_top (a_y) then
				if is_border_left (a_x) then
					internal_pointer_direction := {SD_ENUMERATION}.top_left
				elseif is_border_right (a_x) then
					internal_pointer_direction := {SD_ENUMERATION}.top_right
				else
					internal_pointer_direction := {SD_ENUMERATION}.top
				end
			else
				if is_border_left (a_x) then
					internal_pointer_direction := {SD_ENUMERATION}.bottom_left
				elseif is_border_right (a_x) then
					internal_pointer_direction := {SD_ENUMERATION}.bottom_right
				else
					internal_pointer_direction := {SD_ENUMERATION}.bottom
				end
			end

			set_pointer_style_of_widget (internal_pointer_direction, internal_border_box)
		end

	set_pointer_style_of_widget (a_direction: INTEGER; a_widget: EV_WIDGET) is
			-- Set `a_widget' pointer sytle base on `a_direction'
		require
			not_void: a_widget /= Void
		local
			l_styles: EV_STOCK_PIXMAPS
		do
			create l_styles
			if a_direction = {SD_ENUMERATION}.bottom_right or a_direction = {SD_ENUMERATION}.top_left then
				a_widget.set_pointer_style (l_styles.sizenwse_cursor)
			elseif a_direction = {SD_ENUMERATION}.bottom_left or a_direction = {SD_ENUMERATION}.top_right then
				a_widget.set_pointer_style (l_styles.sizenesw_cursor)
			elseif a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right then
				a_widget.set_pointer_style (l_styles.sizewe_cursor)
			else
				a_widget.set_pointer_style (l_styles.sizens_cursor)
			end
		end

	is_border_left (a_x: INTEGER): BOOLEAN is
			-- If `a_x' at border left side?
		do
			Result := (0 <= a_x and a_x <= internal_border_width * border_width_factor)
		end

	is_border_right (a_x: INTEGER): BOOLEAN is
			-- If `a_x' at border right side?	
		do
			Result := ((internal_border_box.width - internal_border_width * border_width_factor) <= a_x and a_x <= internal_border_box.width)
		end

	is_border_top (a_y: INTEGER): BOOLEAN is
			-- If `a_y' at border top side?
		do
			Result := (0 <= a_y and a_y <= internal_border_width * border_width_factor)
		end

	is_border_bottom (a_y: INTEGER): BOOLEAN is
			-- If `a_y' at border bottom side?
		do
			Result := ((internal_border_box.height - internal_border_width * border_width_factor) <= a_y and a_y <= internal_border_box.height)
		end

	on_border_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer press actions.
		do
			if a_button = 1 then
				-- We set it for Linux, if end user dragging window border fast, for the moment pointer in `internal_padding_box' we make sure pointer style is correct.
				set_pointer_style_of_widget (internal_pointer_direction, internal_padding_box)
				fixed_point_y := screen_y + height
				fixed_point_x := screen_x + width

				setter.before_enable_capture
				internal_border_box.enable_capture
			end
		end

	on_border_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release actions.
		local
			l_stock_pixmaps: EV_STOCK_PIXMAPS
		do
			if internal_border_box.has_capture then
				internal_border_box.disable_capture
				setter.after_disable_capture
				create l_stock_pixmaps
				internal_padding_box.set_pointer_style (l_stock_pixmaps.standard_cursor)
			end
		end

	setter: SD_SYSTEM_SETTER is
			-- Smart Docking library system setter.
		once
			create {SD_SYSTEM_SETTER_IMP} Result
		end

	border_width_factor: INTEGER is 3
			-- The factor when calculation border width.

	fixed_point_y: INTEGER
		-- When dragging at top side, which y position the bottom side of border have to be.

	fixed_point_x: INTEGER
		-- When dragging at left side, which x position the right side of border have to be.

	internal_border_box: EV_BOX
			-- Border box surround target tool bar.

	internal_padding_box: EV_CONTAINER
			-- Contianer within `internal_border_box'

	internal_border_width: INTEGER is
			-- Border width.		
		local
			l_platform: PLATFORM
		once
			create l_platform
			if l_platform.is_windows then
				Result := 2
			else
				Result := 3
			end
		end

	internal_pointer_direction: INTEGER;
			-- Pointer direction, one value of SD_DOCKING_MANAGER dock_top, dock_bottom, dock_left, dock_right.
			-- Used when user dragging Current border.			

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
