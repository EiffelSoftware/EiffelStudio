indexing
	description: "SD_HOT_ZONE for SD_DOCKING_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_OLD_DOCKING

inherit
	SD_HOT_ZONE
		redefine
			internal_zone
		end

create
	make

feature {NONE} -- Initlization

	make (a_zone: SD_DOCKING_ZONE; a_docker_mediator: SD_DOCKER_MEDIATOR) is
			-- Creation method.
		require
			a_zone_not_void: a_zone /= Void
		do
			internal_zone := a_zone
			internal_mediator := a_docker_mediator
			create internal_shared
			set_rectangle (create {EV_RECTANGLE}.make (a_zone.screen_x, a_zone.screen_y, a_zone.width, a_zone.height))
		ensure
			set: internal_zone = a_zone
			set: internal_mediator = a_docker_mediator
		end

feature -- Redefine

	update_for_feedback (a_screen_x, a_screen_y: INTEGER; a_dockable: BOOLEAN): BOOLEAN is
			-- Redefine
		local
			l_half_height, l_half_width: INTEGER
			l_left, l_top, l_width, l_height: INTEGER
			l_in_five_hot_area: BOOLEAN
		do
			debug ("docking")
				print ("%NSD_HOT_ZONE_OLD_DOCKING	update_for_pointer_position_feedback ")
			end
			l_in_five_hot_area := internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) or internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y)
				or internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) or internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) or
					internal_rectangle_center.has_x_y (a_screen_x, a_screen_y)
			if l_in_five_hot_area and a_dockable then

				Result := True

				l_half_height := (internal_zone.height * 0.5).ceiling
				l_half_width := (internal_zone.width * 0.5).ceiling
				if internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) then
					l_left := internal_rectangle_top.left
					l_top := internal_rectangle_top.top
					l_width := internal_zone.width
					l_height := l_half_height
					debug ("docking")
						print ("%NSD_HOT_ZONE_OLD_DOCKING	update_for_pointer_position_feedback icons is: " + internal_shared.icons.drag_pointer_up.out)
					end

					set_pointer_style (internal_shared.icons.drag_pointer_up)
				elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) then
					l_left := internal_rectangle_top.left
					l_top := internal_rectangle_bottom.bottom - l_half_height
					l_width := internal_zone.width
					l_height := l_half_height

					set_pointer_style (internal_shared.icons.drag_pointer_down)
				elseif internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) then
					l_left := internal_rectangle_top.left
					l_top := internal_rectangle_top.top
					l_width := l_half_width
					l_height := internal_zone.height

					set_pointer_style (internal_shared.icons.drag_pointer_left)
				elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) then
					l_left := internal_rectangle_right.right - l_half_width
					l_top := internal_rectangle_top.top
					l_width := l_half_width
					l_height := internal_zone.height

					set_pointer_style (internal_shared.icons.drag_pointer_right)
				elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) then
					l_left := internal_zone.screen_x
					l_top := internal_zone.screen_y
					l_width := internal_zone.width
					l_height := internal_zone.height

					set_pointer_style (internal_shared.icons.drag_pointer_center)
				end
				debug ("docking")
					print ("%NSD_HOT_ZONE_OLD_DOCKING on_pointer_motion: " + l_left.out + " " + l_top.out + " " + l_width.out + " " + l_height.out)
				end
				internal_shared.feedback.draw_rectangle (l_left, l_top, l_width, l_height, internal_shared.line_width)
			end
		end

	set_pointer_style (a_pointer_style: EV_POINTER_STYLE) is
			-- Set GLOBAL mouse cursor
			-- On Windows, we can just set pointer style to main window
			-- On GTK, we must set current focused widget top window's pointer style
			-- FIXIT: same as {SD_HOT_ZONE_OLD_MAIN} merge?
		require
			not_void: a_pointer_style /= Void
		local
			l_platform: PLATFORM
			l_window: EV_WINDOW
		do
			create l_platform
			if l_platform.is_windows then
				internal_mediator.docking_manager.main_window.set_pointer_style (a_pointer_style)
			else
				l_window := internal_mediator.caller_top_window

				if {lt_floating_zone: SD_FLOATING_ZONE} l_window then
					lt_floating_zone.set_pointer_style_for_border (a_pointer_style)
				end
				l_window.set_pointer_style (a_pointer_style)
			end
		end

	apply_change  (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine
		local
			l_docking_zone: SD_DOCKING_ZONE
			l_caller: SD_ZONE
			l_in_hot_area: BOOLEAN
		do
			l_caller := internal_mediator.caller
			l_in_hot_area := internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) or internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y)
				or internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) or internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) or
					internal_rectangle_center.has_x_y (a_screen_x, a_screen_y)
			if l_in_hot_area and internal_mediator.is_dockable then

				Result := True

				if internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (internal_zone, {SD_ENUMERATION}.top)
				elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (internal_zone, {SD_ENUMERATION}.bottom)
				elseif internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (internal_zone, {SD_ENUMERATION}.left)
				elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (internal_zone, {SD_ENUMERATION}.right)
				elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) then
					l_docking_zone ?= internal_zone
					check must_be_docking_zone: l_docking_zone /= Void end
					l_caller.state.move_to_docking_zone (l_docking_zone, False)
				end
			end
			internal_shared.feedback.reset_feedback_clearing
		end

	clear_indicator is
			-- Redefine
		do
--			internal_zone.set_pointer_style ((create {EV_STOCK_PIXMAPS}).standard_cursor)
		end

	build_indicator is
			-- Redefine
		do

		end

	update_for_indicator (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine
		do
		end

	update_for_indicator_clear (a_screen_x, a_screen_y: INTEGER) is
			-- Redefine
		do
		end

feature {NONE} -- Implementation

	set_rectangle (a_rect: EV_RECTANGLE) is
			-- Set the rectangle which allow user to dock.
		require
			a_rect_not_void: a_rect /= Void
		local
			l_width: INTEGER
			l_height: INTEGER
		do
			l_width := (a_rect.width * {SD_HOT_ZONE_OLD_MAIN}.hot_zone_size_proportion).ceiling
			create internal_rectangle_left.make (a_rect.left , a_rect.top, l_width, a_rect.height)
			create internal_rectangle_right.make (a_rect.right - l_width, a_rect.top, l_width, a_rect.height)

			l_height := (a_rect.height * {SD_HOT_ZONE_OLD_MAIN}.hot_zone_size_proportion).ceiling
			create internal_rectangle_top.make (a_rect.left, a_rect.top, a_rect.width, l_height)
			create internal_rectangle_bottom.make (a_rect.left, a_rect.bottom - l_height, a_rect.width, l_height)

			internal_rectangle_center := a_rect

		ensure
			a_rect_set: internal_rectangle_center = a_rect
			createed: internal_rectangle_top /= Void and internal_rectangle_bottom /= Void
				and internal_rectangle_left /= Void and internal_rectangle_right /= Void
		end

	internal_zone: SD_ZONE
			-- Caller

	internal_rectangle_left, internal_rectangle_right, internal_rectangle_top, internal_rectangle_bottom, internal_rectangle_center: EV_RECTANGLE
			-- Five rectangle areas which allow user dock a window in this zone.

invariant

	internal_shared_not_void: internal_shared /= Void
	rectangle_not_void: internal_rectangle_left /= Void and internal_rectangle_right /= Void and internal_rectangle_top /= Void and internal_rectangle_bottom /= Void and internal_rectangle_center /= Void

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

