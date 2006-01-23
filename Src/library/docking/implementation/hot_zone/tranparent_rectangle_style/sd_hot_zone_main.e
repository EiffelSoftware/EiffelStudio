indexing
	description: "SD_HOT_ZONE that represent SD_MULTI_DOCK_AREA's hot zone."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

			l_area := internal_docking_manager.query.container_rectangle_screen
			l_up_width := internal_shared.icons.arrow_indicator_up.width
			l_bottom_width := internal_shared.icons.arrow_indicator_down.width
			l_left_width := internal_shared.icons.arrow_indicator_left.width
			l_right_width := internal_shared.icons.arrow_indicator_right.width

			l_up_height := internal_shared.icons.arrow_indicator_up.height
			l_bottom_height := internal_shared.icons.arrow_indicator_down.height
			l_left_height := internal_shared.icons.arrow_indicator_left.height
			l_right_height := internal_shared.icons.arrow_indicator_right.height

			create top_rectangle.make (l_area.left + l_area.width // 2 - l_up_width // 2, l_area.top, l_up_width, l_up_height)
			create bottom_rectangle.make (l_area.left + l_area.width // 2 - l_bottom_width // 2, l_area.bottom - l_bottom_height, l_bottom_width, l_bottom_height)
			create left_rectangle.make (l_area.left, l_area.top + l_area.height // 2 - l_left_height // 2, l_left_width, l_left_height)
			create right_rectangle.make (l_area.right - l_right_width, l_area.top + l_area.height // 2 - l_right_height // 2, l_right_width, l_right_height)
			type := {SD_SHARED}.type_tool
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
				debug ("docking")
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
				if top_rectangle.has_x_y (a_screen_x, a_screen_y) then
					internal_shared.feedback.draw_pixmap_with_mask (top_rectangle.left, top_rectangle.top, internal_shared.icons.arrow_indicator_up_lightening, internal_shared.icons.arrow_indicator_up_mask, internal_mediator.orignal_screen)
				else
					internal_shared.feedback.draw_pixmap_with_mask (top_rectangle.left, top_rectangle.top, internal_shared.icons.arrow_indicator_up, internal_shared.icons.arrow_indicator_up_mask, internal_mediator.orignal_screen)
				end
				if bottom_rectangle.has_x_y (a_screen_x, a_screen_y) then
					internal_shared.feedback.draw_pixmap_with_mask (bottom_rectangle.left, bottom_rectangle.top, internal_shared.icons.arrow_indicator_down_lightening, internal_shared.icons.arrow_indicator_down_mask, internal_mediator.orignal_screen)
				else
					internal_shared.feedback.draw_pixmap_with_mask (bottom_rectangle.left, bottom_rectangle.top, internal_shared.icons.arrow_indicator_down, internal_shared.icons.arrow_indicator_down_mask, internal_mediator.orignal_screen)
				end
				if left_rectangle.has_x_y (a_screen_x, a_screen_y) then
					internal_shared.feedback.draw_pixmap_with_mask (left_rectangle.left, left_rectangle.top, internal_shared.icons.arrow_indicator_left_lightening, internal_shared.icons.arrow_indicator_left_mask, internal_mediator.orignal_screen)
				else
					internal_shared.feedback.draw_pixmap_with_mask (left_rectangle.left, left_rectangle.top, internal_shared.icons.arrow_indicator_left, internal_shared.icons.arrow_indicator_left_mask, internal_mediator.orignal_screen)
				end
				if right_rectangle.has_x_y (a_screen_x, a_screen_y) then
					internal_shared.feedback.draw_pixmap_with_mask (right_rectangle.left, right_rectangle.top, internal_shared.icons.arrow_indicator_right_lightening, internal_shared.icons.arrow_indicator_right_mask, internal_mediator.orignal_screen)
				else
					internal_shared.feedback.draw_pixmap_with_mask (right_rectangle.left, right_rectangle.top, internal_shared.icons.arrow_indicator_right, internal_shared.icons.arrow_indicator_right_mask, internal_mediator.orignal_screen)
				end

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

indexing
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
