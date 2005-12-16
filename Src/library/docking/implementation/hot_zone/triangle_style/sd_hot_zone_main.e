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

	make (a_docker_mediator: SD_DOCKER_MEDIATOR; a_docking_manager: SD_DOCKING_MANAGER)  is
			-- Creation method.
		require
			a_docker_mediator_not_void: a_docker_mediator /= Void
			a_docking_manager_not_void: a_docking_manager /= Void
		local
			l_area: EV_RECTANGLE
			l_up_width, l_left_width, l_right_width, l_bottom_width: INTEGER
			l_up_height, l_left_height, l_right_height, l_bottom_height: INTEGER
		do
			internal_docking_manager := a_docking_manager
			internal_mediator := a_docker_mediator
			create internal_shared
			check
				internal_shared.icons.arrow_indicator_up_colors.count /= 0
				internal_shared.icons.arrow_indicator_down_colors.count /= 0
				internal_shared.icons.arrow_indicator_left_colors.count /= 0
				internal_shared.icons.arrow_indicator_right_colors.count /= 0
			end

			l_area := internal_docking_manager.query.container_rectangle_screen
			l_up_width := internal_shared.icons.arrow_indicator_up_colors.item (0).count // 3
			l_bottom_width := internal_shared.icons.arrow_indicator_down_colors.item (0).count // 3
			l_left_width := internal_shared.icons.arrow_indicator_left_colors.item (0).count // 3
			l_right_width := internal_shared.icons.arrow_indicator_right_colors.item (0).count // 3

			l_up_height := internal_shared.icons.arrow_indicator_up_colors.count
			l_bottom_height := internal_shared.icons.arrow_indicator_down_colors.count
			l_left_height := internal_shared.icons.arrow_indicator_left_colors.count
			l_right_height := internal_shared.icons.arrow_indicator_right_colors.count

			create top_rectangle.make (l_area.left + l_area.width // 2 - l_up_width // 2, l_area.top, l_up_width, l_up_height)
			create bottom_rectangle.make (l_area.left + l_area.width // 2 - l_bottom_width // 2, l_area.bottom - l_bottom_height, l_bottom_width, l_bottom_height)
			create left_rectangle.make (l_area.left, l_area.top + l_area.height // 2 - l_left_height // 2, l_left_width, l_left_height)
			create right_rectangle.make (l_area.right - l_right_width, l_area.top + l_area.height // 2 - l_right_height // 2, l_right_width, l_right_height)
			type := {SD_SHARED}.type_normal
		ensure
			set: a_docker_mediator = internal_mediator
			set: internal_docking_manager = a_docking_manager
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
				caller.state.dock_at_top_level (internal_docking_manager.query.inner_container_main)
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

	update_for_pointer_position_feedback (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine.
		local
			l_rect: EV_RECTANGLE
		do
			l_rect := internal_docking_manager.query.container_rectangle_screen
			if top_rectangle.has_x_y (a_screen_x, a_screen_y) then
				internal_shared.feedback.draw_transparency_rectangle (l_rect.left, l_rect.top, l_rect.width, (l_rect.height * internal_shared.default_docking_height_rate).ceiling)
			elseif bottom_rectangle.has_x_y (a_screen_x, a_screen_y)  then
				internal_shared.feedback.draw_transparency_rectangle (l_rect.left, l_rect.bottom - (l_rect.height * internal_shared.default_docking_height_rate).ceiling, l_rect.width, (l_rect.height * internal_shared.default_docking_height_rate).ceiling)
			elseif left_rectangle.has_x_y (a_screen_x, a_screen_y) then
				internal_shared.feedback.draw_transparency_rectangle (l_rect.left, l_rect.top, (l_rect.width * internal_shared.default_docking_width_rate).ceiling, l_rect.height)
			elseif right_rectangle.has_x_y (a_screen_x, a_screen_y) then
				internal_shared.feedback.draw_transparency_rectangle (l_rect.right - (l_rect.width * internal_shared.default_docking_width_rate).ceiling, l_rect.top, (l_rect.width * internal_shared.default_docking_width_rate).ceiling, l_rect.height)
			else
				internal_shared.feedback.draw_transparency_rectangle (a_screen_x - internal_mediator.offset_x, a_screen_y - internal_mediator.offset_y, internal_mediator.caller.width, internal_mediator.caller.height)
			end

		ensure then
			must_process:
		end

	update_for_pointer_position_indicator (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine.
		do
			if internal_docking_manager.query.container_rectangle_screen.has_x_y (a_screen_x, a_screen_y) then
				update_indicator_area (top_rectangle, internal_shared.icons.arrow_indicator_up_colors)
				update_indicator_area (bottom_rectangle, internal_shared.icons.arrow_indicator_down_colors)
				update_indicator_area (left_rectangle, internal_shared.icons.arrow_indicator_left_colors)
				update_indicator_area (right_rectangle, internal_shared.icons.arrow_indicator_right_colors)
			else
				-- Clear indicator
			end

		ensure then
			must_process:
		end

	update_for_pointer_position_indicator_clear (a_screen_x, a_screen_y: INTEGER) is
			-- Redefine
		do
			if not internal_docking_manager.query.container_rectangle_screen.has_x_y (a_screen_x, a_screen_y)  then
				clear_indicator
			elseif internal_docking_manager.query.container_rectangle_screen.has_x_y (a_screen_x, a_screen_y)  then
				need_clear := True
			end
		end

	clear_indicator is
			-- Redefine
		do
			if need_clear then
				clear_rect (internal_mediator.orignal_screen, top_rectangle)
				clear_rect (internal_mediator.orignal_screen, bottom_rectangle)
				clear_rect (internal_mediator.orignal_screen, left_rectangle)
				clear_rect (internal_mediator.orignal_screen, right_rectangle)
				need_clear := False
			end
		end

	has_x_y (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine.
		do
			Result := True
		ensure then
			must_true: Result = True
		end

feature {NONE} -- Implementation

	update_indicator_area (a_rect: like top_rectangle; a_pixmap: SPECIAL [SPECIAL [INTEGER]]) is
			-- Update feedback area when pointer in `a_rect'.
		do
			internal_shared.feedback.draw_pixmap_by_colors (a_rect.left, a_rect.top, a_pixmap)
		ensure
			must_process:
		end

	top_rectangle, bottom_rectangle, left_rectangle, right_rectangle: EV_RECTANGLE
			-- Areas which contain four indicator.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

invariant

	internal_shared_not_void: internal_shared /= Void
	top_rectangle_not_void: top_rectangle /= Void
	bottom_rectangle_not_void: bottom_rectangle /= Void
	left_rectangle_not_void: left_rectangle /= Void
	right_rectangle_not_void: right_rectangle /= Void

end
