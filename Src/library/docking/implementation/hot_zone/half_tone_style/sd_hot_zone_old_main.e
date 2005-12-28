indexing
	description: "SD_HOT_ZONE for SD_MULTI_DOCKING_AREA."
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

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			not_void: a_docking_manager /= Void
		local
			l_area: EV_RECTANGLE
			l_width: INTEGER
			l_height: INTEGER
		do
			internal_docking_manager :=  a_docking_manager
			l_area := a_docking_manager.query.container_rectangle_screen
			l_height := (l_area.height * hot_zone_size_proportion).ceiling
			l_width := (l_area.width * hot_zone_size_proportion).ceiling
			create top_rectangle.make (l_area.left, l_area.top - l_height, l_area.width, l_height)
			create bottom_rectangle.make (l_area.left, l_area.bottom + l_height, l_area.width, l_height)
			create left_rectangle.make (l_area.left - l_width, l_area.top, l_width, l_area.height)
			create right_rectangle.make (l_area.right, l_area.top, l_width, l_area.height)
			type := {SD_SHARED}.type_normal
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature  -- Redefine

	apply_change (a_screen_x, a_screen_y: INTEGER; caller: SD_ZONE): BOOLEAN is
			-- Redefine
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
		end

	update_for_pointer_position_feedback (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine
		local
			l_rect: EV_RECTANGLE
		do
			l_rect := internal_docking_manager.query.container_rectangle_screen
			if top_rectangle.has_x_y (a_screen_x, a_screen_y) then
				internal_shared.feedback.draw_rectangle (l_rect.left, l_rect.top, l_rect.width, (l_rect.height * internal_shared.default_docking_height_rate).ceiling, internal_shared.line_width)
			elseif bottom_rectangle.has_x_y (a_screen_x, a_screen_y)  then
				internal_shared.feedback.draw_rectangle (l_rect.left, l_rect.bottom - (l_rect.height * internal_shared.default_docking_height_rate).ceiling, l_rect.width, (l_rect.height * internal_shared.default_docking_height_rate).ceiling, internal_shared.line_width)
			elseif left_rectangle.has_x_y (a_screen_x, a_screen_y) then
				internal_shared.feedback.draw_rectangle (l_rect.left, l_rect.top, (l_rect.width * internal_shared.default_docking_width_rate).ceiling, l_rect.height, internal_shared.line_width)
			elseif right_rectangle.has_x_y (a_screen_x, a_screen_y) then
				internal_shared.feedback.draw_rectangle (l_rect.right - (l_rect.width * internal_shared.default_docking_width_rate).ceiling, l_rect.top, (l_rect.width * internal_shared.default_docking_width_rate).ceiling, l_rect.height, internal_shared.line_width)
			else
				internal_shared.feedback.draw_rectangle (a_screen_x - internal_mediator.offset_x, a_screen_y - internal_mediator.offset_y, internal_mediator.caller.width, internal_mediator.caller.height, internal_shared.line_width)
			end	
			
			debug ("larry")
				print ("SD_HOT_ZONE_OLD_MAIN update for pointer position feedback " + a_screen_x.out + " " + a_screen_y.out)
			end
		end
	
	update_for_pointer_position_indicator (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine
		do
			
		end
		
	update_for_pointer_position_indicator_clear (a_screen_x, a_screen_y: INTEGER) is
			-- Redefine
		do
			
		end
	
	clear_indicator is
			-- Redefine
		do
			
		end
		
feature {NONE} -- Implementation

	pointer_x, pointer_y: INTEGER
			-- Current pointer position on the screen.
		
	top_rectangle, bottom_rectangle, left_rectangle, right_rectangle: EV_RECTANGLE
			-- Area which contain the top indicator.
	
	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which current belong to.	

feature -- Enumeration
	
	hot_zone_size_proportion: REAL is 0.2
			-- Hot zone size proportion of width/height of caller.

invariant
	
	internal_docking_manager_not_void: internal_docking_manager /= Void
	
end
