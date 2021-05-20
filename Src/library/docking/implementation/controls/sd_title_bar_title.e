note
	description: "Title widget used in SD_TITLE_BAR for showing title with desaturation effect."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TITLE_BAR_TITLE

inherit
	EV_DRAWING_AREA

create
	make

feature {NONE} -- Initlization

	make
			-- Creation method
		do
			title := ""
			create internal_shared
			create drag_actions
			default_create

			expose_actions.extend
				(agent (a_x, a_y, a_width, a_height: INTEGER_32)
					do on_expose end)
			pointer_button_press_actions.extend (agent on_pointer_press)
			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_leave_actions.extend (agent on_pointer_leave)
			pointer_motion_actions.extend (agent on_pointer_motion)

				-- Because on Linux, pointer leave actions will not be called after pointer double pressed, so we clear the data manually.
			pointer_double_press_actions.extend
				(agent (a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32)
					do first_press_position := Void end)
		end

feature -- Properties

	title: STRING_32
			-- Text showing on Current

	set_title (a_title: READABLE_STRING_GENERAL)
			-- Set `title' with `a_title'
		require
			not_void: a_title /= Void
		do
			title := a_title.as_string_32
		ensure
			set: title.same_string_general (a_title)
		end

	is_focus_color_enable: BOOLEAN
			-- If focus color enabled?

	set_focus_color_enable (a_bool: BOOLEAN)
			-- Set `is_focus_color_enable'
		do
			is_focus_color_enable := a_bool
		ensure
			set: is_focus_color_enable = a_bool
		end

	is_focused_color: BOOLEAN
			-- If Current use focused color?
			-- Otherwise we use non-focused color

	set_focused_color (a_bool: BOOLEAN)
			-- Set `is_focus_color'
		do
			is_focused_color := a_bool
		ensure
			set: is_focused_color = a_bool
		end

feature -- Command

	refresh
			-- Redraw
		require
			not_destroyed: not is_destroyed
		do
			on_expose
		end

	set_non_focus_active_background_color
			-- Set non focus active background colors
		do
			set_background_color (hightlight_non_focus_color)
			set_foreground_color (internal_shared.non_focused_title_text_color)
		end

	set_focus_background_color
			-- Set focus background colors
		do
			set_background_color (hightlight_color)
			set_foreground_color (internal_shared.focused_title_text_color)
		end

	set_disable_focus_background_color
			-- Set background color for disable status.
		do
			set_background_color (hightlight_gray_color)
			set_foreground_color ((create {SD_COLOR_HELPER}).text_color_by (hightlight_gray_color))
		end

feature -- Query

	drag_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Drag actions

	hightlight_color: EV_COLOR
			-- Highlight color
		do
			Result := internal_shared.focused_color
		end

	hightlight_non_focus_color: EV_COLOR
			-- Highligh nonfocus color
		do
			Result := internal_shared.non_focused_title_color
		end

	hightlight_gray_color: EV_COLOR
			-- Highlight gray color
		do
			Result := internal_shared.non_focused_color
		end

feature {NONE} -- Agents

	on_pointer_press (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			-- Handle pointer press
		do
			if a_button = {EV_POINTER_CONSTANTS}.left then
				create first_press_position.make_with_position (a_screen_x, a_screen_y)
			elseif a_button = {EV_POINTER_CONSTANTS}.right then
				show_menu (True, a_x, a_y)
			end
		ensure
			set: a_button = {EV_POINTER_CONSTANTS}.left implies attached first_press_position
		end

	on_pointer_release (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			-- Handle pointer release
		do
			first_press_position := Void

			if a_button = {EV_POINTER_CONSTANTS}.right then
				show_menu (False, a_x, a_y)
			end
		ensure
			set: first_press_position = Void
		end

	on_pointer_leave
			-- Hanle pointer leave
		do
			first_press_position := Void
		end

	on_pointer_motion (a_x, a_y: INTEGER; tile_a, tile_b, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Handle pointer motion
		local
			l_offset: INTEGER
		do
			if attached first_press_position as l_position then
				l_offset := internal_shared.drag_offset
				-- Only after user pointer moved `l_offset' pixels, then start calling `drag_actions'.
				-- Otherwise, it's too sensitive. See bug#13038
				if (a_screen_x < l_position.x - l_offset or a_screen_x > l_position.x + l_offset) or
					(a_screen_y < l_position.y - l_offset or a_screen_y > l_position.y + l_offset) then
					drag_actions.call ([a_x, a_y, tile_a, tile_b, a_pressure, a_screen_x, a_screen_y])
					first_press_position := Void
				end
			end
		end

feature {NONE} -- Implementation

	show_menu (a_is_pointer_press: BOOLEAN; a_x, a_y: INTEGER)
			-- Show right click menu if exists
		local
			l_platform: PLATFORM
			l_menu: EV_MENU
		do
			create l_platform
			if (l_platform.is_windows and a_is_pointer_press) or (not l_platform.is_windows and not a_is_pointer_press) then
				l_menu := internal_shared.widget_factory.title_area_menu
				if l_menu /= Void then
					l_menu.show_at (Current, a_x, a_y)
				end
			end
		end

	first_press_position: detachable EV_COORDINATE
			-- Is pointer button pressed? If yes, the value means the screen position of first pointer press
			-- Otherwise, the value is void
			-- This flag used for judging whether to call `drag_actions'

	offset_x: INTEGER = 4
			-- The x position start to draw title text

	on_expose
			-- Handle expose actions
		require
			not_destroyed: not is_destroyed
		local
			l_helper: SD_COLOR_HELPER
			l_clipping_width: INTEGER
		do
			start_drawing_session
			create l_helper

			if is_focus_color_enable then
				-- We set background color here, it's for theme changed actions the background color will not update except
				-- After called enable_focus_color

				if is_focused_color then
					set_background_color (hightlight_color)

					set_focus_background_color
					clear
					l_helper.draw_color_change_gradually (Current, hightlight_color, hightlight_gray_color, width - internal_shared.highlight_tail_width, width)
				else
					set_background_color (hightlight_non_focus_color)

					clear
					l_helper.draw_color_change_gradually (Current, hightlight_non_focus_color, hightlight_gray_color, width - internal_shared.highlight_tail_width, width)
					set_non_focus_active_background_color
				end

				l_clipping_width := width - internal_shared.highlight_before_width - internal_shared.highlight_tail_width
				if l_clipping_width >= 0 then
					draw_ellipsed_text_top_left (internal_shared.highlight_before_width + internal_shared.title_bar_text_start_x, internal_shared.title_bar_text_start_y, title, l_clipping_width)
				end
			else
				-- We set background color here, it's for theme changed actions the background color will not update except
				-- After called disable_focus_color
				set_background_color (hightlight_gray_color)
				set_disable_focus_background_color

				clear_for_theme
				l_clipping_width := width - internal_shared.highlight_before_width - internal_shared.highlight_tail_width
				if l_clipping_width >= 0 then
					draw_ellipsed_text_top_left (internal_shared.highlight_before_width + internal_shared.title_bar_text_start_x, internal_shared.title_bar_text_start_y, title, l_clipping_width)
				end

			end
			end_drawing_session
		end

	clear_for_theme
			-- Clear backgroud with theme data
		do
			internal_shared.setter.clear_background_for_theme (Current, create {EV_RECTANGLE}.make (0, 0, width, height))
		end

	internal_shared: SD_SHARED
 		-- All singletons

invariant
	not_void: drag_actions /= Void
	not_void: title /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
