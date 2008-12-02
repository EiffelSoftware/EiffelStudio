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
			l_up_height := internal_shared.icons.arrow_indicator_up.height

			l_bottom_width := internal_shared.icons.arrow_indicator_down.width
			l_bottom_height := internal_shared.icons.arrow_indicator_down.height

			l_left_width := internal_shared.icons.arrow_indicator_left.width
			l_left_height := internal_shared.icons.arrow_indicator_left.height

			l_right_width := internal_shared.icons.arrow_indicator_right.width
			l_right_height := internal_shared.icons.arrow_indicator_right.height

			create top_rectangle.make (l_area.left + l_area.width // 2 - l_up_width // 2, l_area.top, l_up_width, l_up_height)
			create bottom_rectangle.make (l_area.left + l_area.width // 2 - l_bottom_width // 2, l_area.bottom - l_bottom_height, l_bottom_width, l_bottom_height)
			create left_rectangle.make (l_area.left, l_area.top + l_area.height // 2 - l_left_height // 2, l_left_width, l_left_height)
			create right_rectangle.make (l_area.right - l_right_width, l_area.top + l_area.height // 2 - l_right_height // 2, l_right_width, l_right_height)

			build_indicator
		ensure
			set: a_docker_mediator = internal_mediator
			set: internal_docking_manager = a_docking_manager
		end

feature  -- Command

	apply_change (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine.
		local
			l_floating_zone: SD_FLOATING_ZONE
			l_caller: SD_ZONE
			l_left: INTEGER
		do
			l_caller := internal_mediator.caller
			if top_rectangle.has_x_y (a_screen_x, a_screen_y) and internal_mediator.is_dockable then
				l_caller.state.set_direction ({SD_ENUMERATION}.top)
				Result := True
			end
			if bottom_rectangle.has_x_y (a_screen_x, a_screen_y) and internal_mediator.is_dockable then
				l_caller.state.set_direction ({SD_ENUMERATION}.bottom)
				Result := True
			end
			if left_rectangle.has_x_y (a_screen_x, a_screen_y) and internal_mediator.is_dockable then
				l_caller.state.set_direction ({SD_ENUMERATION}.left)
				Result := True
			end
			if right_rectangle.has_x_y (a_screen_x, a_screen_y) and internal_mediator.is_dockable then
				l_caller.state.set_direction ({SD_ENUMERATION}.right)
				Result := True
			end

			if Result then
				l_caller.state.dock_at_top_level (internal_docking_manager.query.inner_container_main)
			end

			l_floating_zone ?= l_caller
			debug ("docking")
				print ("%N SD_HOT_ZONE_MAIN apply change Manu. Result: " + Result.out)
			end
			if not Result then
				l_left := a_screen_x - internal_mediator.offset_x
				l_left := left_position (a_screen_x, l_left, l_caller.state.last_floating_width)
				if l_floating_zone = Void then
					l_caller.state.float (l_left, a_screen_y - internal_mediator.offset_y)
				else
					l_floating_zone.set_position (l_left, a_screen_y - internal_mediator.offset_y)
				end
				debug ("docking")
					print ("%N SD_HOT_ZONE_MAIN apply changed l_floating_zone Void?  " + (l_floating_zone = Void).out)
				end
				Result := True
			end
			debug ("docking")
				print ("%N SD_HOT_ZONE_MAIN apply changed Manu end")
			end
		ensure then
			must_process: Result = True
		end

	update_for_feedback (a_screen_x, a_screen_y: INTEGER; a_dockable: BOOLEAN): BOOLEAN is
			-- Redefine.
		local
			l_rect: EV_RECTANGLE
			l_floating_zone: SD_FLOATING_ZONE
			l_width, l_height: INTEGER
			l_left: INTEGER
		do
			l_rect := internal_docking_manager.query.container_rectangle_screen
			if top_rectangle.has_x_y (a_screen_x, a_screen_y) and a_dockable then
				internal_shared.feedback.draw_transparency_rectangle (l_rect.left, l_rect.top, l_rect.width, (l_rect.height * internal_shared.default_docking_height_rate).ceiling)
			elseif bottom_rectangle.has_x_y (a_screen_x, a_screen_y) and a_dockable  then
				internal_shared.feedback.draw_transparency_rectangle (l_rect.left, l_rect.bottom - (l_rect.height * internal_shared.default_docking_height_rate).ceiling, l_rect.width, (l_rect.height * internal_shared.default_docking_height_rate).ceiling)
			elseif left_rectangle.has_x_y (a_screen_x, a_screen_y) and a_dockable then
				internal_shared.feedback.draw_transparency_rectangle (l_rect.left, l_rect.top, (l_rect.width * internal_shared.default_docking_width_rate).ceiling, l_rect.height)
			elseif right_rectangle.has_x_y (a_screen_x, a_screen_y) and a_dockable then
				internal_shared.feedback.draw_transparency_rectangle (l_rect.right - (l_rect.width * internal_shared.default_docking_width_rate).ceiling, l_rect.top, (l_rect.width * internal_shared.default_docking_width_rate).ceiling, l_rect.height)
			else
				l_floating_zone ?= internal_mediator.caller
				if l_floating_zone = Void then
					l_width := internal_mediator.caller.state.last_floating_width
					l_height := internal_mediator.caller.state.last_floating_height
					debug ("docking")
						print ("%N SD_HOT_ZONE_MAIN update_for_feedback 1 l_width: " + l_width.out)
					end
				else
					l_width := l_floating_zone.width
					l_height := l_floating_zone.height
					debug ("docking")
						print ("%N SD_HOT_ZONE_MAIN update_for_feedback 2 l_width: " + l_width.out)
					end
				end

				l_left := a_screen_x - internal_mediator.offset_x
				l_left := left_position (a_screen_x, l_left, l_width)
				internal_shared.feedback.draw_transparency_rectangle (l_left, a_screen_y - internal_mediator.offset_y, l_width, l_height)
			end

		ensure then
			must_process:
		end

	update_for_indicator (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine.
		do
			if internal_docking_manager.query.container_rectangle_screen.has_x_y (a_screen_x, a_screen_y) or internal_shared.show_all_feedback_indicator then

				show_indicator

				if top_rectangle.has_x_y (a_screen_x, a_screen_y) then
					top_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_up_lightening)
				else
					top_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_up)
				end
				if bottom_rectangle.has_x_y (a_screen_x, a_screen_y) then
					bottom_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_down_lightening)
				else
					bottom_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_down)
				end
				if left_rectangle.has_x_y (a_screen_x, a_screen_y) then
					left_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_left_lightening)
				else
					left_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_left)
				end
				if right_rectangle.has_x_y (a_screen_x, a_screen_y) then
					right_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_right_lightening)
				else
					right_indicator.set_pixel_buffer (internal_shared.icons.arrow_indicator_right)
				end
			end
		ensure then
			must_process: True
		end

	update_for_indicator_clear (a_screen_x, a_screen_y: INTEGER) is
			-- Redefine
		do
			if not internal_docking_manager.query.container_rectangle_screen.has_x_y (a_screen_x, a_screen_y)  then
				clear_indicator
			elseif internal_docking_manager.query.container_rectangle_screen.has_x_y (a_screen_x, a_screen_y)  then
				need_clear := True
			end
		end

	show_indicator is
			-- Show indicators if possible.
		do
			if not top_indicator.exists then
				build_indicator
			end
		end

	clear_indicator is
			-- Redefine
		do
			if top_indicator.exists then
				top_indicator.clear
			end
			if bottom_indicator.exists then
				bottom_indicator.clear
			end
			if left_indicator.exists then
				left_indicator.clear
			end
			if right_indicator.exists then
				right_indicator.clear
			end
		end

	build_indicator is
			-- Redeifne
		do
			create top_indicator.make (internal_shared.icons.arrow_indicator_up, internal_shared.feedback.feedback_rect)
			create bottom_indicator.make (internal_shared.icons.arrow_indicator_down, internal_shared.feedback.feedback_rect)
			create left_indicator.make (internal_shared.icons.arrow_indicator_left, internal_shared.feedback.feedback_rect)
			create right_indicator.make (internal_shared.icons.arrow_indicator_right, internal_shared.feedback.feedback_rect)

			top_indicator.set_position (top_rectangle.left, top_rectangle.top)
			bottom_indicator.set_position (bottom_rectangle.left, bottom_rectangle.top)
			left_indicator.set_position (left_rectangle.left, left_rectangle.top)
			right_indicator.set_position (right_rectangle.left, right_rectangle.top)

			top_indicator.show
			bottom_indicator.show
			left_indicator.show
			right_indicator.show
		end

feature -- Query

	has_x_y (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine.
		do
			Result := True
		ensure then
			must_true: Result = True
		end

feature {NONE} -- Implementation

	left_position (a_pointer_screen_x: INTEGER; a_feedback_screen_left: INTEGER; a_feedback_width: INTEGER): INTEGER is
			-- If pointer dragging position out of feedback rect right side, we recalculate left position.
		do
			if a_pointer_screen_x > a_feedback_screen_left + a_feedback_width then
				if last_offset_x = 0 then
					last_offset_x := (Result - a_pointer_screen_x) \\ a_feedback_width
				end
				Result :=  last_offset_x + a_pointer_screen_x
			else
				Result := a_feedback_screen_left
			end
		ensure
			not_out_of_right_side: Result <= a_pointer_screen_x + a_feedback_width
		end

	last_offset_x: INTEGER
			-- Last offset position.

	top_rectangle, bottom_rectangle, left_rectangle, right_rectangle: EV_RECTANGLE
			-- Areas which contain four indicator.

	top_indicator, bottom_indicator, left_indicator, right_indicator: SD_FEEDBACK_INDICATOR
			-- Feedback inidcator at four sides.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

invariant

	internal_shared_not_void: internal_shared /= Void
	top_rectangle_not_void: top_rectangle /= Void
	bottom_rectangle_not_void: bottom_rectangle /= Void
	left_rectangle_not_void: left_rectangle /= Void
	right_rectangle_not_void: right_rectangle /= Void
	not_void: top_indicator /= Void and bottom_indicator /= Void and left_indicator /= Void and right_indicator /= Void

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
