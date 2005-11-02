indexing
	description: "Objects that represent the hot zone when floating."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_FLOATING

inherit
	SD_HOT_ZONE_DOCKING
		rename
			make as make_docking,
			internal_zone as internal_zone_docking
		redefine
			apply_change
		end
create
	make

feature {NONE} -- Initlization
	make (a_zone: SD_FLOATING_ZONE) is
			-- Creation method.
		require
			a_zone_not_void: a_zone /= Void
		do
			create internal_shared
			internal_zone := a_zone
			set_rectangle (create {EV_RECTANGLE}.make (a_zone.screen_x, a_zone.screen_y, a_zone.width, a_zone.height))
		end
		
feature -- Implementation
	internal_zone: SD_FLOATING_ZONE
	
	apply_change  (a_screen_x, a_screen_y: INTEGER; caller: SD_ZONE): BOOLEAN is
			-- Apply change when user dragging a window on a position

		do
			if internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) then
--				caller.content.state.change_zone_split_area (internal_zone, {SD_SHARED}.dock_top)
				Result := True
			elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) then
--				caller.content.state.change_zone_split_area (internal_zone, {SD_SHARED}.dock_bottom)
				Result := True				
			elseif internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) then	
--				caller.content.state.change_zone_split_area (internal_zone, {SD_SHARED}.dock_left)
				Result := True			
			elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) then
--				caller.content.state.change_zone_split_area (internal_zone, {SD_SHARED}.dock_right)
				Result := True
			elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) then
--				caller.content.state.move_to_docking_zone (internal_zone)
				Result := True
			end
		end
--		
--	update_for_pointer_position (a_mediator: SD_DOCKER_MEDIATOR; a_screen_x, a_screen_y: INTEGER): BOOLEAN is
--			-- Update feedback when user move the mouse.
--		do
--		end
--		
--	
--	draw_drag_window_indicator is
--			-- Draw dragged window feedback which represent window position.
--		do
----			feedback.draw_something.....
--		end

end
