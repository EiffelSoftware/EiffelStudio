indexing
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

	make is
			-- Creation method
		do
			default_create
			title := ""

			create internal_shared
			expose_actions.force_extend (agent on_expose)

			pointer_button_press_actions.force_extend (agent on_pointer_press)
			pointer_button_release_actions.force_extend (agent on_pointer_release)
			pointer_leave_actions.force_extend (agent on_pointer_leave)
			pointer_motion_actions.extend (agent on_pointer_motion)

			create drag_actions
		end

feature -- Properties

	title: STRING
			-- Text showing on Current.

	set_title (a_title: STRING) is
			-- Set `title' with `a_title'.
		require
			not_void: a_title /= Void
		do
			title := a_title
		ensure
			set: title = a_title
		end

	is_focus_color_enable: BOOLEAN
			-- If focus color enabled?

	set_focus_color_enable (a_bool: BOOLEAN) is
			-- Set `is_focus_color_enable'
		do
			is_focus_color_enable := a_bool
		ensure
			set: is_focus_color_enable = a_bool
		end

	is_focused_color: BOOLEAN
			-- If Current use focused color?
			-- Otherwise we use non-focused color.

	set_focused_color (a_bool: BOOLEAN) is
			-- Set `is_focus_color'
		do
			is_focused_color := a_bool
		ensure
			set: is_focused_color = a_bool
		end

feature -- Command

	refresh is
			-- Redraw
		do
			on_expose
		end

	set_non_focus_active_background_color is
			-- Set non focus active background colors
		local
			l_text_color: EV_COLOR
		do
			set_background_color (hightlight_non_focus_color)
			l_text_color := internal_shared.non_focused_title_text_color
			set_foreground_color (l_text_color)
		end

	set_focus_background_color is
			-- Set focus background colors
		local
			l_text_color: EV_COLOR
		do
			set_background_color (hightlight_color)
			l_text_color := internal_shared.focused_title_text_color
			set_foreground_color (l_text_color)
		end

	set_disable_focus_background_color is
			-- Set background color for disable status.
		local
			l_text_color: EV_COLOR
			l_color_helper: SD_COLOR_HELPER
		do
			create l_color_helper
			set_background_color (hightlight_gray_color)

			l_text_color := l_color_helper.text_color_by (hightlight_gray_color)
			set_foreground_color (l_text_color)
		end

feature -- Query

	drag_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Drag actions

	hightlight_color: EV_COLOR is
			-- Highlight color.
		do
			Result := internal_shared.focused_color
		end

	hightlight_non_focus_color: EV_COLOR is
			-- Highligh nonfocus color.
		do
			Result := internal_shared.non_focused_title_color
		end

	hightlight_gray_color: EV_COLOR is
			-- Highlight gray color.
		do
			Result := internal_shared.non_focused_color
		end

feature {NONE} -- Agents

	on_pointer_press is
			-- Handle pointer press.
		do
			pressed := True
		ensure
			set: pressed = True
		end

	on_pointer_release is
			-- Handle pointer release.
		do
			pressed := False
		ensure
			set: pressed = False
		end

	on_pointer_leave is
			-- Hanle pointer leave.
		do
			pressed := False
		end

	on_pointer_motion (a_x, a_y: INTEGER; tile_a, tile_b, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Handle pointer motion.
		do
			if pressed then
				drag_actions.call ([a_x, a_y, tile_a, tile_b, a_pressure, a_screen_x, a_screen_y])
				pressed := False
			end
		end

feature {NONE} -- Implementation

	pressed: BOOLEAN
			-- Is pointer button pressed?

	offset_x: INTEGER is 4
			-- The x position start to draw title text.

	on_expose is
			-- Handle expose actions.
		local
			l_helper: SD_COLOR_HELPER
			l_clipping_width: INTEGER
		do
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

					set_non_focus_active_background_color
					clear
					l_helper.draw_color_change_gradually (Current, hightlight_non_focus_color, hightlight_gray_color, width - internal_shared.highlight_tail_width, width)
				end

				l_clipping_width := width - internal_shared.highlight_before_width - internal_shared.highlight_tail_width
				if l_clipping_width >= 0 then
					draw_ellipsed_text_top_left (internal_shared.highlight_before_width + internal_shared.drawing_area_icons_start_x, internal_shared.drawing_area_icons_start_y, title, l_clipping_width)
				end
			else
				-- We set background color here, it's for theme changed actions the background color will not update except
				-- After called disable_focus_color
				set_background_color (hightlight_gray_color)
				set_disable_focus_background_color

				clear
				l_clipping_width := width - internal_shared.highlight_before_width - internal_shared.highlight_tail_width
				if l_clipping_width >= 0 then
					draw_ellipsed_text_top_left (internal_shared.highlight_before_width + internal_shared.drawing_area_icons_start_x, internal_shared.drawing_area_icons_start_y, title, l_clipping_width)
				end

			end
		end

	internal_shared: SD_SHARED
 		-- All singletons

invariant
	not_void: drag_actions /= Void
	not_void: title /= Void

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
