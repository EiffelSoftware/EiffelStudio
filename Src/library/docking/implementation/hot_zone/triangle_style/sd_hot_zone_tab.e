indexing
	description: "Objects that represent hot zones when docking in the main container."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_TAB

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
	make (a_zone: SD_TAB_ZONE; a_rect: EV_RECTANGLE) is
			-- Creation method.
		require
			a_zone_not_void: a_zone /= Void
		do
			create internal_shared
			internal_zone := a_zone
			set_rectangle (a_rect)
		end
--	
--	split_area: EV_SPLIT_AREA
	
	internal_zone: SD_TAB_ZONE
feature
	
	apply_change  (a_screen_x, a_screen_y: INTEGER; caller: SD_ZONE): BOOLEAN is
			-- Apply change when user dragging a window on a position
		do
			if internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) then
				caller.content.state.change_zone_split_area (internal_zone, {SD_SHARED}.dock_top)
				Result := True
			elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) then
				caller.content.state.change_zone_split_area (internal_zone, {SD_SHARED}.dock_bottom)
				Result := True				
			elseif internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) then	
				caller.content.state.change_zone_split_area (internal_zone, {SD_SHARED}.dock_left)
				Result := True			
			elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) then
				caller.content.state.change_zone_split_area (internal_zone, {SD_SHARED}.dock_right)
				Result := True
			elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) then
				caller.content.state.move_to_tab_zone (internal_zone)
				Result := True
			end
		end
		
end
