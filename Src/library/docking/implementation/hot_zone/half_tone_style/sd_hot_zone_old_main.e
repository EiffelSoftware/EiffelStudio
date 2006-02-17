indexing
	description: "SD_HOT_ZONE for SD_MULTI_DOCKING_AREA."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_OLD_MAIN

inherit
	SD_HOT_ZONE
	SD_SHARED
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initlization

	make (a_docker_mediator: SD_DOCKER_MEDIATOR; a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			not_void: a_docker_mediator /= Void
			not_void: a_docking_manager /= Void
		local
			l_area: EV_RECTANGLE
			l_width: INTEGER
			l_height: INTEGER
		do
			create internal_shared
			internal_mediator := a_docker_mediator
			internal_docking_manager :=  a_docking_manager
			l_area := a_docking_manager.query.container_rectangle_screen
			l_height := (l_area.height * hot_zone_size_proportion).ceiling
			l_width := (l_area.width * hot_zone_size_proportion).ceiling
			create top_rectangle.make (l_area.left, l_area.top - l_height, l_area.width, l_height)
			create bottom_rectangle.make (l_area.left, l_area.bottom, l_area.width, l_height)
			create left_rectangle.make (l_area.left - l_width, l_area.top, l_width, l_area.height)
			create right_rectangle.make (l_area.right, l_area.top, l_width, l_area.height)
			type := {SD_SHARED}.type_tool
		ensure
			set: internal_mediator = a_docker_mediator
			set: internal_docking_manager = a_docking_manager
		end

feature  -- Redefine

	apply_change (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine
		local
			l_floating_zone: SD_FLOATING_ZONE
			l_caller: SD_ZONE
		do
			l_caller := internal_mediator.caller
			if top_rectangle.has_x_y (a_screen_x, a_screen_y) and internal_mediator.is_dockable then
				l_caller.state.set_direction ({SD_DOCKING_MANAGER}.dock_top)
				Result := True
			end
			if bottom_rectangle.has_x_y (a_screen_x, a_screen_y) and internal_mediator.is_dockable then
				l_caller.state.set_direction ({SD_DOCKING_MANAGER}.dock_bottom)
				Result := True
			end
			if left_rectangle.has_x_y (a_screen_x, a_screen_y) and internal_mediator.is_dockable then
				l_caller.state.set_direction ({SD_DOCKING_MANAGER}.dock_left)
				Result := True
			end
			if right_rectangle.has_x_y (a_screen_x, a_screen_y) and internal_mediator.is_dockable then
				l_caller.state.set_direction ({SD_DOCKING_MANAGER}.dock_right)
				Result := True
			end

			if Result then
				l_caller.state.dock_at_top_level (internal_docking_manager.query.inner_container_main)
			end

			l_floating_zone ?= l_caller
			if not Result and  l_floating_zone = Void then
				l_caller.state.float (a_screen_x - internal_mediator.offset_x, a_screen_y - internal_mediator.offset_y)
				Result := True
			end

			internal_shared.feedback.reset_feedback_clearing
		end

	update_for_pointer_position_feedback (a_screen_x, a_screen_y: INTEGER; a_dockable: BOOLEAN): BOOLEAN is
			-- Redefine
		local
			l_rect: EV_RECTANGLE
			l_left, l_top, l_width, l_height: INTEGER
		do

			l_rect := internal_docking_manager.query.container_rectangle_screen
			if top_rectangle.has_x_y (a_screen_x, a_screen_y) and a_dockable then
				l_left := l_rect.left
				l_top := l_rect.top
				l_width := l_rect.width
				l_height := (l_rect.height * internal_shared.default_docking_height_rate).ceiling
				internal_docking_manager.main_window.set_pointer_style (internal_shared.icons.drag_pointer_down)
			elseif bottom_rectangle.has_x_y (a_screen_x, a_screen_y) and a_dockable  then
				l_left := l_rect.left
				l_top := l_rect.bottom - (l_rect.height * internal_shared.default_docking_height_rate).ceiling
				l_width := l_rect.width
				l_height := (l_rect.height * internal_shared.default_docking_height_rate).ceiling
				internal_docking_manager.main_window.set_pointer_style (internal_shared.icons.drag_pointer_up)
			elseif left_rectangle.has_x_y (a_screen_x, a_screen_y) and a_dockable then
				l_left := l_rect.left
				l_top := l_rect.top
				l_width := (l_rect.width * internal_shared.default_docking_width_rate).ceiling
				l_height := l_rect.height
				internal_docking_manager.main_window.set_pointer_style (internal_shared.icons.drag_pointer_right)
			elseif right_rectangle.has_x_y (a_screen_x, a_screen_y) and a_dockable then
				l_left := l_rect.right - (l_rect.width * internal_shared.default_docking_width_rate).ceiling
				l_top := l_rect.top
				l_width := (l_rect.width * internal_shared.default_docking_width_rate).ceiling
				l_height := l_rect.height
				internal_docking_manager.main_window.set_pointer_style (internal_shared.icons.drag_pointer_left)
			else
				l_left := a_screen_x - internal_mediator.offset_x
				l_top := a_screen_y - internal_mediator.offset_y
				l_width := internal_mediator.caller.width
				l_height := internal_mediator.caller.height
				internal_docking_manager.main_window.set_pointer_style (internal_shared.icons.drag_pointer_float)
			end

			internal_shared.feedback.draw_rectangle (l_left, l_top, l_width, l_height, internal_shared.line_width)
			Result := True
		end

	clear_indicator is
			-- Redefine
		do
			internal_docking_manager.main_window.set_pointer_style ((create {EV_STOCK_PIXMAPS}).standard_cursor)
		end

	update_for_pointer_position_indicator (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine
		do
		end

	update_for_pointer_position_indicator_clear (a_screen_x, a_screen_y: INTEGER) is
			-- Redefine
		do
		end

feature -- Enumeration

	hot_zone_size_proportion: REAL is 0.1
			-- Hot zone size proportion of current which size is base on main window size.	

feature {NONE} -- Implementation

	top_rectangle, bottom_rectangle, left_rectangle, right_rectangle: EV_RECTANGLE
			-- Area which contain the top indicator.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which current belong to.	

invariant

	internal_docking_manager_not_void: internal_docking_manager /= Void

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
