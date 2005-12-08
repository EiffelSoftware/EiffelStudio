indexing
	description: "SD_HOT_ZONE when pointer in SD_MULTI_DOCK_AREA."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_DOCKING

inherit
	SD_HOT_ZONE
		redefine
			has_x_y,
			internal_zone,
			pointer_out
		end

create
	make

feature {NONE} -- Initlization

	make (a_zone: SD_DOCKING_ZONE; a_rect: EV_RECTANGLE) is
			-- Creation method.
		require
			a_zone_not_void: a_zone /= Void
		do
			create internal_shared
			internal_zone := a_zone
			set_rectangle (a_rect)
		end

feature -- Redefine

	apply_change  (a_screen_x, a_screen_y: INTEGER; caller: SD_ZONE): BOOLEAN is
			-- Redefine.
		do
			if internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) then
				caller.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_top)
				Result := True
			elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) then
				caller.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_bottom)
				Result := True
			elseif internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) then
				caller.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_left)
				Result := True
			elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) then
				caller.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_right)
				Result := True
			elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) then
				caller.state.move_to_docking_zone (internal_zone)
				Result := True
			end
		end

	pointer_out is
			-- Redefine.
		do
			Precursor {SD_HOT_ZONE}
			internal_mouse_in := False
		ensure then
			mouse_not_in: internal_mouse_in = False
		end

	update_for_pointer_position (a_mediator: SD_DOCKER_MEDIATOR; a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine.
		local
			l_x, l_y, l_width, l_height: INTEGER
		do
			drawn := False
			if internal_rectangle.has_x_y (a_screen_x, a_screen_y) then
				if not internal_mouse_in then
					draw_drag_window_indicator
					internal_mouse_in := True
				end
				update_feedback (a_screen_x, a_screen_y, internal_rectangle_left)
				update_feedback (a_screen_x, a_screen_y, internal_rectangle_right)
				update_feedback (a_screen_x, a_screen_y, internal_rectangle_top)
				update_feedback (a_screen_x, a_screen_y, internal_rectangle_bottom)
				update_feedback (a_screen_x, a_screen_y, internal_rectangle_center)

				if not drawn then
					l_x := a_screen_x + a_mediator.offset_x
					l_y := a_screen_y + a_mediator.offset_y
					l_width := a_mediator.drag_window_width
					l_height := a_mediator.drag_window_height
				end

				Result := True
			end
		end

feature {NONE} -- Implementation functions.

	update_feedback (a_screen_x, a_screen_y: INTEGER; a_rect: EV_RECTANGLE) is
			-- Update the feedback when pointer in or out the five rectangle area.
		require
			a_rect_not_void: a_rect /= Void
		local
			x, y: INTEGER
			l_shared: like internal_shared
			l_icons: SD_ICONS_SINGLETON
			l_rect: like internal_rectangle
		do
			l_rect := a_rect
			l_shared := internal_shared
			l_icons := l_shared.icons
			x := l_rect.left + l_rect.width // 2 - l_icons.arrow_indicator_center.width // 2
			y := l_rect.top + l_rect.height // 2 - l_icons.arrow_indicator_center.height // 2

			if a_rect.has_x_y (a_screen_x, a_screen_y) then
				if a_rect = internal_rectangle_left then
--					--  -
--					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.right, a_rect.top)
--					-- |
--					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.left, a_rect.top + a_rect.height)
--					--  _
--					internal_shared.feedback.draw_line (a_rect.left, a_rect.top + a_rect.height, a_rect.left + a_rect.height, a_rect.top + a_rect.height)
--
					if internal_pointer_last_in_area /= internal_pointer_in_left_area then
						internal_shared.feedback.clear_screen
						internal_shared.feedback.draw_transparency_rectangle (internal_rectangle.left, internal_rectangle.top, (internal_rectangle.width* 0.5).ceiling, internal_rectangle.height )
						internal_pointer_last_in_area := internal_pointer_in_left_area
					end
					draw_drag_window_indicator_by_colors (l_icons.arrow_indicator_center_colors_left_lighten)

				elseif a_rect = internal_rectangle_right then
					-- -
--					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.right, a_rect.top)
--					--  |
--					internal_shared.feedback.draw_line (a_rect.right, a_rect.top, a_rect.right, a_rect.top + a_rect.height)
--					-- _
--					internal_shared.feedback.draw_line (a_rect.left, a_rect.top + a_rect.height, a_rect.left + a_rect.height, a_rect.top + a_rect.height)

					if internal_pointer_last_in_area /= internal_pointer_in_right_area then
						internal_shared.feedback.clear_screen
						internal_shared.feedback.draw_transparency_rectangle (internal_rectangle.right - (internal_rectangle.width * 0.5).ceiling, internal_rectangle.top, (internal_rectangle.width* 0.5).ceiling, internal_rectangle.height )
						internal_pointer_last_in_area := internal_pointer_in_right_area
					end
					draw_drag_window_indicator_by_colors (l_icons.arrow_indicator_center_colors_right_lighten)

				elseif a_rect = internal_rectangle_top then
					-- |
--					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.left, a_rect.bottom)
--					--  -
--					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.right, a_rect.top)
--					--   |
--					internal_shared.feedback.draw_line (a_rect.right, a_rect.top, a_rect.right, a_rect.bottom)

					if internal_pointer_last_in_area /= internal_pointer_in_top_area then
						internal_shared.feedback.clear_screen
						internal_shared.feedback.draw_transparency_rectangle (internal_rectangle .left, internal_rectangle.top, internal_rectangle.width, (internal_rectangle.height * 0.5).ceiling)
						internal_pointer_last_in_area := internal_pointer_in_top_area
					end
					draw_drag_window_indicator_by_colors (l_icons.arrow_indicator_center_colors_up_lighten)

				elseif a_rect = internal_rectangle_bottom then
					-- |
--					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.left, a_rect.bottom)
--					--  _
--					internal_shared.feedback.draw_line (a_rect.left, a_rect.bottom, a_rect.right, a_rect.bottom)
--					--   |
--					internal_shared.feedback.draw_line (a_rect.right, a_rect.top, a_rect.right, a_rect.bottom)

					if internal_pointer_last_in_area /= internal_pointer_in_bottom_area then
						internal_shared.feedback.clear_screen
						internal_shared.feedback.draw_transparency_rectangle (internal_rectangle .left, internal_rectangle.bottom - (internal_rectangle.height * 0.5).ceiling, internal_rectangle.width, (internal_rectangle.height * 0.5).ceiling)
						internal_pointer_last_in_area := internal_pointer_in_bottom_area
					end
					draw_drag_window_indicator_by_colors (l_icons.arrow_indicator_center_colors_bottom_lighten)
				elseif a_rect = internal_rectangle_center then
					-- |
--					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.left, a_rect.bottom)
--					--  -
--					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.right, a_rect.top)
--					--   |
--					internal_shared.feedback.draw_line (a_rect.right, a_rect.top, a_rect.right, a_rect.bottom)
--					--  _
--					internal_shared.feedback.draw_line (a_rect.left, a_rect.bottom, a_rect.right, a_rect.bottom)
					draw_drag_window_indicator_by_colors (l_icons.arrow_indicator_center_colors_center_lighten)
				end
				drawn := True
			end
		ensure
			drawn: a_rect.has_x_y (a_screen_x, a_screen_y) implies drawn = True
		end

	draw_drag_window_indicator is
			-- Draw dragged window feedback which represent window position.
		local
			l_shared: like internal_shared
			l_icons: SD_ICONS_SINGLETON
		do
			l_shared := internal_shared
			l_icons := l_shared.icons
			draw_drag_window_indicator_by_colors (l_icons.arrow_indicator_center_colors)
		end

	draw_drag_window_indicator_by_colors (a_colors: ARRAYED_LIST [TUPLE]) is
			-- Draw dragged window feedback which represent window position.
		require
			a_colors_attached: a_colors /= Void
		local
			x, y: INTEGER
			l_shared: like internal_shared
			l_rect: like internal_rectangle
		do
			l_shared := internal_shared
			l_rect := internal_rectangle
			x := l_rect.left + l_rect.width // 2 - a_colors.count // 2
			y := l_rect.top + l_rect.height // 2 - a_colors.count // 2
			l_shared.feedback.draw_pixmap_by_colors (x, y, a_colors)
		end

	has_x_y (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Does `internal_rectangle' has `a_screen_x' and `a_screen_y'?
		do
			Result := internal_rectangle.has_x_y (a_screen_x, a_screen_y)
		end

	set_rectangle (a_rect: like internal_rectangle) is
			-- Set the rectangle which allow user to dock.
		require
			a_rect_not_void: a_rect /= Void
		do
			internal_rectangle := a_rect
			-- Calculate five rectangle area where allow user to dock a window in this zone.
			create internal_rectangle_left.make (internal_rectangle.left + internal_rectangle.width // 2 - pixmap_center_width // 2 - pixmap_corner_width, internal_rectangle.top + internal_rectangle.height // 2 - pixmap_corner_width // 2, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_right.make (internal_rectangle_left.left + pixmap_corner_width + pixmap_center_width - 1, internal_rectangle_left.top, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_top.make (internal_rectangle_left.left + pixmap_corner_width - 2, internal_rectangle_left.top - pixmap_corner_width + 1, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_bottom.make (internal_rectangle_left.left + pixmap_corner_width - 2, internal_rectangle_left.top + pixmap_corner_width - 2, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_center.make (internal_rectangle_left.right, internal_rectangle_top.bottom, internal_rectangle_right.left - internal_rectangle_left.right, internal_rectangle_bottom.top - internal_rectangle_top.bottom)
		ensure
			set: a_rect = internal_rectangle
			left_rectangle_created: internal_rectangle_left /= Void
			right_rectangle_created: internal_rectangle_right /= Void
			top_rectangle_created: internal_rectangle_top /= Void
			bottom_rectangle_created: internal_rectangle_bottom /= Void
			center_rectangle_created: internal_rectangle_center /= Void
		end

feature {NONE} -- Implementation attributes.

	drawn: BOOLEAN
			-- If alreay drawn the feedback rectangle which represent the window area?

	internal_mouse_in: BOOLEAN
			-- Whether mouse pointer is in `Current' hot zone.

	internal_zone: SD_DOCKING_ZONE
			-- Dokcing zone `Current' belong to.

	pixmap_center_width: INTEGER is 27
			-- Width and height of the area in center figure area.

	pixmap_corner_width: INTEGER is 30
			-- Width and height of the area in four corner figure areas.

	internal_rectangle: EV_RECTANGLE
			-- Rectangle which allow user to dock.

	internal_rectangle_left, internal_rectangle_right, internal_rectangle_top, internal_rectangle_bottom, internal_rectangle_center: EV_RECTANGLE
			-- Five rectangle areas which allow user dock a window in this zone.

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_zone_not_void: internal_zone /= Void
	internal_rectangle_not_void: internal_rectangle /= Void

end
