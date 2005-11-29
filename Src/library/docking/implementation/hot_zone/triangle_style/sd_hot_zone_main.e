indexing
	description: "SD_HOT_ZONE that represent SD_MULTI_DOCK_AREA's hot zone."
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
			a_docker_mediator_not_void: a_docker_mediator /= Void
		local
			l_area: EV_RECTANGLE
		do
			internal_mediator := a_docker_mediator
			create internal_shared
			l_area := internal_shared.docking_manager.container_rectangle_screen
			create top_rectangle.make (l_area.left + l_area.width // 2 - internal_shared.icons.arrow_indicator_up.width // 2, l_area.top, internal_shared.icons.arrow_indicator_up.width, internal_shared.icons.arrow_indicator_up.height)
			create bottom_rectangle.make (l_area.left + l_area.width // 2 - internal_shared.icons.arrow_indicator_down.width // 2, l_area.bottom - internal_shared.icons.arrow_indicator_down.height, internal_shared.icons.arrow_indicator_down.width, internal_shared.icons.arrow_indicator_down.height)
			create left_rectangle.make (l_area.left, l_area.top + l_area.height // 2 - internal_shared.icons.arrow_indicator_left.height // 2, internal_shared.icons.arrow_indicator_left.width, internal_shared.icons.arrow_indicator_left.height)
			create right_rectangle.make (l_area.right - internal_shared.icons.arrow_indicator_right.width, l_area.top + l_area.height // 2 - internal_shared.icons.arrow_indicator_right.height // 2, internal_shared.icons.arrow_indicator_right.width, internal_shared.icons.arrow_indicator_right.height)
			type := {SD_SHARED}.type_normal
		ensure
			set: a_docker_mediator = internal_mediator
		end

feature  -- Redefine

	apply_change (a_screen_x, a_screen_y: INTEGER; caller: SD_ZONE): BOOLEAN is
			-- Redefine.
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
				caller.state.float (a_screen_x - internal_mediator.offset_x, a_screen_y - internal_mediator.offset_y)
				Result := True
			end
		ensure then
--			must_process: Result = True
		end

	update_for_pointer_position (a_mediator: SD_DOCKER_MEDIATOR; a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine.
		local
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
				internal_shared.feedback.draw_transparency_rectangle (a_screen_x - a_mediator.offset_x, a_screen_y - a_mediator.offset_y, internal_shared.default_floating_window_width, internal_shared.default_floating_window_height)
				internal_pointer_last_in_area := internal_pointer_in_main_area
			end
		ensure then
			must_process:
		end

	has_x_y (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine.
		do
			Result := True
		ensure then
			must_true: Result = True
		end

feature {NONE} -- Implementation

	update_indicator_area (a_rect: like top_rectangle; a_pixmap: EV_PIXMAP): BOOLEAN is
			-- Update feedback area when pointer in `a_rect'.
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
		ensure
			must_process:
		end

	pointer_x, pointer_y: INTEGER
			-- Pointer position.


	top_rectangle, bottom_rectangle, left_rectangle, right_rectangle: EV_RECTANGLE
			-- Areas which contain four indicator.

invariant

	internal_shared_not_void: internal_shared /= Void
	top_rectangle_not_void: top_rectangle /= Void
	bottom_rectangle_not_void: bottom_rectangle /= Void
	left_rectangle_not_void: left_rectangle /= Void
	right_rectangle_not_void: right_rectangle /= Void

end
