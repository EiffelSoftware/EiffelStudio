note
	description: "SD_HOT_ZONE for SD_DOCKING_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_DOCKING

inherit
	SD_HOT_ZONE
		redefine
			has_x_y
		end

create
	make

feature {NONE} -- Initlization

	make (a_docker_mediator: SD_DOCKER_MEDIATOR; a_zone: SD_DOCKING_ZONE; a_rect: EV_RECTANGLE)
			-- Creation method
		require
			a_zone_not_void: a_zone /= Void
			a_docker_mediator_not_void: a_docker_mediator /= Void
		do
			create internal_shared
			internal_zone := a_zone
			set_rectangle (a_rect)
			internal_mediator := a_docker_mediator

			build_indicator
		ensure
			set: internal_zone = a_zone
			set: internal_mediator = a_docker_mediator
		end

feature -- Redefine

	apply_change  (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- <Precursor>
		local
			l_caller: SD_ZONE
			l_docking_zone: like docking_zone_of
		do
			l_caller := internal_mediator.caller
			if internal_mediator.is_dockable then
				if internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (zone, {SD_ENUMERATION}.top)
					Result := True
				elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (zone, {SD_ENUMERATION}.bottom)
					Result := True
				elseif internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (zone, {SD_ENUMERATION}.left)
					Result := True
				elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (zone, {SD_ENUMERATION}.right)
					Result := True
				elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) or internal_rectangle_title_area.has_x_y (a_screen_x, a_screen_y) then
					l_docking_zone := docking_zone_of (zone)
					check l_docking_zone /= Void end -- Implied by current is hot zone of docking zone
					l_caller.state.move_to_docking_zone (l_docking_zone, False)
					Result := True
				end
			end
		end

	update_for_feedback (a_screen_x, a_screen_y: INTEGER; a_dockable: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
			if a_dockable then
				if internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) then
					update_feedback (a_screen_x, a_screen_y, internal_rectangle_left)
					Result := True
				elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) then
					update_feedback (a_screen_x, a_screen_y, internal_rectangle_right)
					Result := True
				elseif internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) then
					update_feedback (a_screen_x, a_screen_y, internal_rectangle_top)
					Result := True
				elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) then
					update_feedback (a_screen_x, a_screen_y, internal_rectangle_bottom)
					Result := True
				elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) then
					update_feedback (a_screen_x, a_screen_y, internal_rectangle_center)
					Result := True
				elseif internal_rectangle_title_area.has_x_y (a_screen_x, a_screen_y) then
					update_feedback (a_screen_x, a_screen_y, internal_rectangle_title_area)
					Result := True
				end

			end
		end

	update_for_indicator (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- <Precursor>
		do
			if internal_shared.show_all_feedback_indicator then
				draw_drag_window_indicator (a_screen_x, a_screen_y)
			else
				if internal_rectangle.has_x_y (a_screen_x, a_screen_y) then
					draw_drag_window_indicator (a_screen_x, a_screen_y)
					Result := True
					show_indicator
				end
			end
		end

	update_for_indicator_clear (a_screen_x, a_screen_y: INTEGER)
			-- <Precursor>
		do
			if not internal_rectangle.has_x_y (a_screen_x, a_screen_y) then
				clear_indicator
			elseif internal_rectangle.has_x_y (a_screen_x, a_screen_y)  then
				need_clear := True
			end
		end

	show_indicator
			-- Show indicators if possible
		do
			if not internal_indicator.exists then
				build_indicator
			end
		end

	clear_indicator
			-- Clear indicators
		do
			if internal_indicator.exists then
				internal_indicator.clear
			end
		end

	build_indicator
			-- Build indicator
		do
			create internal_indicator.make (internal_shared.icons.arrow_indicator_center, internal_shared.feedback.feedback_rect)
			internal_indicator.set_position (internal_rectangle_left.left, internal_rectangle_top.top)
			internal_indicator.show
		end

feature -- Query

	docking_zone_of (a_zone: SD_ZONE): detachable SD_DOCKING_ZONE
			-- Type convertion
		do
			if attached {like docking_zone_of} a_zone as z then
				Result := z
			end
		end

	zone_type_valid (a_zone: SD_ZONE): BOOLEAN
			-- If `a_zone''s type fit for current class?
		require
			not_void: a_zone /= Void
		do
			Result := docking_zone_of (a_zone) /= Void
		end

feature {NONE} -- Implementation functions

	update_feedback (a_screen_x, a_screen_y: INTEGER; a_rect: EV_RECTANGLE)
			-- Update the feedback when pointer in or out the five rectangle area
		require
			a_rect_not_void: a_rect /= Void
		local
			l_shared: like internal_shared
			l_icons: SD_ICONS_SINGLETON
			l_rect: like internal_rectangle
			l_top_rect, l_bottom_rect: EV_RECTANGLE
		do
			l_rect := a_rect
			l_shared := internal_shared
			l_icons := l_shared.icons

			if a_rect = internal_rectangle_left then
				internal_shared.feedback.draw_transparency_rectangle (internal_rectangle.left, internal_rectangle.top, (internal_rectangle.width* 0.5).ceiling, internal_rectangle.height )
			elseif a_rect = internal_rectangle_right then
				internal_shared.feedback.draw_transparency_rectangle (internal_rectangle.right - (internal_rectangle.width * 0.5).ceiling, internal_rectangle.top, (internal_rectangle.width* 0.5).ceiling, internal_rectangle.height )
			elseif a_rect = internal_rectangle_top then
				internal_shared.feedback.draw_transparency_rectangle (internal_rectangle .left, internal_rectangle.top, internal_rectangle.width, (internal_rectangle.height * 0.5).ceiling)
			elseif a_rect = internal_rectangle_bottom then
				internal_shared.feedback.draw_transparency_rectangle (internal_rectangle .left, internal_rectangle.bottom - (internal_rectangle.height * 0.5).ceiling, internal_rectangle.width, (internal_rectangle.height * 0.5).ceiling)
			elseif a_rect = internal_rectangle_center or a_rect = internal_rectangle_title_area then
				create l_top_rect.make (internal_rectangle.left, internal_rectangle.top, internal_rectangle.width, internal_rectangle.height - internal_shared.title_bar_height)
				create l_bottom_rect.make (internal_rectangle.left + internal_shared.title_bar_height, internal_rectangle.bottom - internal_shared.title_bar_height, internal_shared.title_bar_height * 3, internal_shared.title_bar_height)
				internal_shared.feedback.draw_transparency_rectangle_for_tab (l_top_rect, l_bottom_rect)
			end
		end

	draw_drag_window_indicator (a_screen_x, a_screen_y: INTEGER)
			-- Draw dragged window feedback which represent window position
		local
			l_shared: like internal_shared
			l_icons: SD_ICONS_SINGLETON
			l_x, l_y: INTEGER
		do
			l_shared := internal_shared
			l_icons := l_shared.icons
			check rect_not_void: internal_rectangle /= Void end
			l_x := internal_rectangle.left + internal_rectangle.width // 2 - internal_shared.icons.arrow_indicator_center.width // 2
			l_y := internal_rectangle.top + internal_rectangle.height // 2 - internal_shared.icons.arrow_indicator_center.height // 2
			if internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) then
				internal_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_center_lightening_up)
			elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) then
				internal_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_center_lightening_down)
			elseif internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) then
				internal_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_center_lightening_left)
			elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) then
				internal_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_center_lightening_right)
			elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) then
				internal_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_center_lightening_center)
			else
				internal_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_center)
			end
		end

	has_x_y (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- Does `internal_rectangle' has `a_screen_x' and `a_screen_y'?
		do
			Result := internal_rectangle.has_x_y (a_screen_x, a_screen_y)
		end

	set_rectangle (a_rect: like internal_rectangle)
			-- Set the rectangle which allow user to dock
		require
			a_rect_not_void: a_rect /= Void
		local
			l_docking_zone: like docking_zone_of
		do
			internal_rectangle := a_rect
			-- Calculate five rectangle area where allow user to dock a window in this zone.
			create internal_rectangle_left.make (internal_rectangle.left + internal_rectangle.width // 2 - pixmap_center_width // 2 - pixmap_corner_width, internal_rectangle.top + internal_rectangle.height // 2 - pixmap_corner_width // 2, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_right.make (internal_rectangle_left.left + pixmap_corner_width + pixmap_center_width - 1, internal_rectangle_left.top, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_top.make (internal_rectangle_left.left + pixmap_corner_width - 2, internal_rectangle_left.top - pixmap_corner_width + 1, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_bottom.make (internal_rectangle_left.left + pixmap_corner_width - 2, internal_rectangle_left.top + pixmap_corner_width - 2, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_center.make (internal_rectangle_left.right, internal_rectangle_top.bottom, internal_rectangle_right.left - internal_rectangle_left.right, internal_rectangle_bottom.top - internal_rectangle_top.bottom)

			-- It's not a square, we should adjust it.
			internal_rectangle_top.grow_bottom (-6)
			internal_rectangle_center.set_y (internal_rectangle_center.top - 6)
			internal_rectangle_center.grow_bottom (-3)
			internal_rectangle_bottom.set_y (internal_rectangle_bottom.top - 9)
			internal_rectangle_bottom.grow_bottom (-10)
			internal_rectangle_right.grow_right (-2)

			l_docking_zone := docking_zone_of (zone)
			check l_docking_zone /= Void end -- Implied by current is hot zone of docking zone
			internal_rectangle_title_area := l_docking_zone.title_area
		ensure
			set: a_rect = internal_rectangle
			left_rectangle_created: internal_rectangle_left /= Void
			right_rectangle_created: internal_rectangle_right /= Void
			top_rectangle_created: internal_rectangle_top /= Void
			bottom_rectangle_created: internal_rectangle_bottom /= Void
			center_rectangle_created: internal_rectangle_center /= Void
		end

feature {NONE} -- Implementation attributes

	pixmap_center_width: INTEGER = 34
			-- Width and height of the area in center figure area

	pixmap_corner_width: INTEGER = 36
			-- Width and height of the area in four corner figure areas

	internal_rectangle: EV_RECTANGLE
			-- Rectangle which allow user to dock

	internal_rectangle_left, internal_rectangle_right, internal_rectangle_top, internal_rectangle_bottom, internal_rectangle_center, internal_rectangle_title_area: EV_RECTANGLE
			-- Five rectangle areas which allow user dock a window in this zone

	internal_indicator: SD_FEEDBACK_INDICATOR
			-- Feedback indicator at center of zone

invariant

	internal_docker_mediator_not_void: internal_mediator /= Void
	internal_shared_not_void: internal_shared /= Void
	internal_zone_type_valid: internal_zone /= Void and then zone_type_valid (zone)
	internal_rectangle_not_void: internal_rectangle /= Void
	not_void: internal_indicator /= Void

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
