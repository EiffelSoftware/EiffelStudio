indexing
	description: "Objects that represent the main container's hot zone."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_MAIN

inherit
	SD_HOT_ZONE
		redefine

			has_x_y
		end

create
	make

feature {NONE} -- Initlization

	make (a_docker_mediator: SD_DOCKER_MEDIATOR)  is
			-- Creation method.
		require
--			a_owner_not_void: a_owner /= Void
			a_docker_mediator_not_void: a_docker_mediator /= Void
		local
			l_area: EV_RECTANGLE
		do
			internal_mediator := a_docker_mediator
--			internal_zone := a_owner
			create internal_shared
			l_area := internal_shared.docking_manager.container_rectangle_screen
			create top_rectangle.make (l_area.left + l_area.width // 2 - internal_shared.icons.arrow_indicator_up.width // 2, l_area.top, internal_shared.icons.arrow_indicator_up.width, internal_shared.icons.arrow_indicator_up.height)
			create bottom_rectangle.make (l_area.left + l_area.width // 2 - internal_shared.icons.arrow_indicator_down.width // 2, l_area.bottom - internal_shared.icons.arrow_indicator_down.height, internal_shared.icons.arrow_indicator_down.width, internal_shared.icons.arrow_indicator_down.height)
			create left_rectangle.make (l_area.left, l_area.top + l_area.height // 2 - internal_shared.icons.arrow_indicator_left.height // 2, internal_shared.icons.arrow_indicator_left.width, internal_shared.icons.arrow_indicator_left.height)
			create right_rectangle.make (l_area.right - internal_shared.icons.arrow_indicator_right.width, l_area.top + l_area.height // 2 - internal_shared.icons.arrow_indicator_right.height // 2, internal_shared.icons.arrow_indicator_right.width, internal_shared.icons.arrow_indicator_right.height)
		end

feature  -- Implementation for inheritance.

	apply_change (a_screen_x, a_screen_y: INTEGER; caller: SD_ZONE): BOOLEAN is
			-- Apply change when user dragging a window on a position
--		require
--			caller_state_not_void: caller
		local
			l_floating_zone: SD_FLOATING_ZONE
		do
			if top_rectangle.has_x_y (a_screen_x, a_screen_y) then
				caller.state.set_direction ({SD_DOCKING_MANAGER}.dock_top)
				Result := True
			end
			if bottom_rectangle.has_x_y (a_screen_x, a_screen_y) then
				caller.state.set_direction ({SD_DOCKING_MANAGER}.dock_bottom)
				Result := True
			end
			if left_rectangle.has_x_y (a_screen_x, a_screen_y) then
				caller.state.set_direction ({SD_DOCKING_MANAGER}.dock_left)
				Result := True
			end
			if right_rectangle.has_x_y (a_screen_x, a_screen_y) then
				caller.state.set_direction ({SD_DOCKING_MANAGER}.dock_right)
				Result := True
			end

			if Result then
				caller.state.dock_at_top_level (internal_shared.docking_manager.inner_container_main)
			end

			l_floating_zone ?= caller
			if not Result and  l_floating_zone = Void then
				debug ("larry")
					io.put_string ("%N caller: " + caller.out)
				end
				caller.state.float_window (a_screen_x - internal_mediator.offset_x, a_screen_y - internal_mediator.offset_y)
				Result := True
			end

		end

	update_for_pointer_position (a_mediator: SD_DOCKER_MEDIATOR; a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Update feedback when user move the mouse.
		local
--			l_area: EV_RECTANGLE
			l_drawn: BOOLEAN
		do
--			internal_shared.feedback.clear_screen
			-- Draw top one.
			pointer_x := a_screen_x
			pointer_y := a_screen_y
			l_drawn := update_indicator_area (top_rectangle, internal_shared.icons.arrow_indicator_up)
			if not l_drawn then
				l_drawn := update_indicator_area (bottom_rectangle, internal_shared.icons.arrow_indicator_down)
			end
			if not l_drawn then
				l_drawn := update_indicator_area (left_rectangle, internal_shared.icons.arrow_indicator_left)
			end
			if not l_drawn then
				l_drawn := update_indicator_area (right_rectangle, internal_shared.icons.arrow_indicator_right)
			end
			if not l_drawn then
--				internal_shared.feedback.clear_screen
				internal_shared.feedback.draw_transparency_rectangle (a_screen_x - a_mediator.offset_x, a_screen_y - a_mediator.offset_y, internal_shared.default_floating_window_width, internal_shared.default_floating_window_height)
				internal_pointer_last_in_area := internal_pointer_in_main_area
			end
		end



	has_x_y (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- If `Current' area has pointer position `a_screen_x', `a_screen_y'.
		do
			Result := True
		end
feature {NONE} -- Implementation

	pointer_x, pointer_y: INTEGER
			-- Current pointer position on the screen.



	update_indicator_area (a_rect: like top_rectangle; a_pixmap: EV_PIXMAP): BOOLEAN is
			-- Update indicator area which is the area in the area's rectangle.
		local
			l_rect: EV_RECTANGLE
		do
			if a_rect.has_x_y (pointer_x, pointer_y) then
				l_rect := internal_shared.docking_manager.container_rectangle_screen

				if a_rect = top_rectangle then
					-- |
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.left, a_rect.bottom)
					--  -
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.right, a_rect.top)
					--   |
					internal_shared.feedback.draw_line (a_rect.right, a_rect.top, a_rect.right, a_rect.bottom)

					if internal_pointer_last_in_area /= internal_pointer_in_top_area then
						internal_shared.feedback.clear_screen
						internal_shared.feedback.draw_transparency_rectangle (l_rect.left, l_rect.top, l_rect.width, (l_rect.height * internal_shared.default_docking_height_rate).ceiling)
						internal_pointer_last_in_area := internal_pointer_in_top_area
					end

					Result := True
				elseif a_rect = bottom_rectangle then
					-- |
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.left, a_rect.bottom)
					--  _
					internal_shared.feedback.draw_line (a_rect.left, a_rect.bottom, a_rect.right, a_rect.bottom)
					--   |
					internal_shared.feedback.draw_line (a_rect.right, a_rect.top, a_rect.right, a_rect.bottom)

					if internal_pointer_last_in_area /= internal_pointer_in_bottom_area then
						internal_shared.feedback.clear_screen
						internal_shared.feedback.draw_transparency_rectangle (l_rect.left, l_rect.bottom - (l_rect.height * internal_shared.default_docking_height_rate).ceiling, l_rect.width, (l_rect.height * internal_shared.default_docking_height_rate).ceiling)
						internal_pointer_last_in_area := internal_pointer_in_bottom_area
					end

					Result := True
				elseif a_rect = left_rectangle then
					--  -
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.right, a_rect.top)
					-- |
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.left, a_rect.top + a_rect.height)
					--  _
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top + a_rect.height, a_rect.left + a_rect.height, a_rect.top + a_rect.height)

					if internal_pointer_last_in_area /= internal_pointer_in_left_area then
						internal_shared.feedback.clear_screen
						internal_shared.feedback.draw_transparency_rectangle (l_rect.left, l_rect.top, (l_rect.width * internal_shared.default_docking_width_rate).ceiling, l_rect.height)
						internal_pointer_last_in_area := internal_pointer_in_left_area
					end

					Result := True
				elseif a_rect = right_rectangle then
					-- -
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.right, a_rect.top)
					--  |
					internal_shared.feedback.draw_line (a_rect.right, a_rect.top, a_rect.right, a_rect.top + a_rect.height)
					-- _
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top + a_rect.height, a_rect.left + a_rect.height, a_rect.top + a_rect.height)

					if internal_pointer_last_in_area /= internal_pointer_in_right_area then
						internal_shared.feedback.clear_screen
						internal_shared.feedback.draw_transparency_rectangle (l_rect.right - (l_rect.width * internal_shared.default_docking_width_rate).ceiling, l_rect.top, (l_rect.width * internal_shared.default_docking_width_rate).ceiling, l_rect.height)
						internal_pointer_last_in_area := internal_pointer_in_right_area
					end

					Result := True
				end
			else
				internal_shared.feedback.draw_pixmap (a_rect.left, a_rect.top, a_pixmap)
			end
		end

	top_rectangle, bottom_rectangle, left_rectangle, right_rectangle: EV_RECTANGLE
			-- The area which contain the top indicator.


end
