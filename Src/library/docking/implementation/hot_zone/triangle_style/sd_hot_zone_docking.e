indexing
	description: "Objects that represent hot zones when docking in the main container."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_DOCKING

inherit
	SD_HOT_ZONE
		redefine
			has_x_y,
			internal_zone	
		end
create
	make

feature {NONE} -- Initlization
	make (a_zone: SD_DOCKING_ZONE; a_rect: EV_RECTANGLE) is
			-- Creation method.
		require
			a_zone_not_void: a_zone /= Void
		do
			create internal_shared
			internal_zone := a_zone
			set_rectangle (a_rect)
		end
	
	split_area: EV_SPLIT_AREA
	
	internal_zone: SD_DOCKING_ZONE
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
				caller.content.state.move_to_docking_zone (internal_zone)
				Result := True
			end
		end
		
	update_for_pointer_position (a_mediator: SD_DOCKER_MEDIATOR; a_screen_x, a_screen_y: INTEGER):BOOLEAN is
			-- Update feedback when user move the mouse.
		local
			l_x, l_y, l_width, l_height: INTEGER
		do
--			internal_shared.docking_manager.lock_update
			drawn := False
			
			if internal_rectangle.has_x_y (a_screen_x, a_screen_y) then
						
				draw_drag_window_indicator
				
				update_feedback (a_screen_x, a_screen_y, internal_rectangle_left)
				update_feedback (a_screen_x, a_screen_y, internal_rectangle_right)
				update_feedback (a_screen_x, a_screen_y, internal_rectangle_top)
				update_feedback (a_screen_x, a_screen_y, internal_rectangle_bottom)
				update_feedback (a_screen_x, a_screen_y, internal_rectangle_center)
				
				if not drawn then
					l_x := a_screen_x + a_mediator.offset_x
					l_y := a_screen_y + a_mediator.offset_y
					l_width := a_mediator.drag_window_width
					l_height := a_mediator.drag_window_height	
--					feedback.draw_line (l_x, l_y, l_width, l_height)			
				end
				
				Result := True
			end
--			internal_shared.docking_manager.unlock_update
		end
	
	update_feedback (a_screen_x, a_screen_y: INTEGER; a_rect: EV_RECTANGLE) is
			-- Update the feedback when pointer in or out the five rectangle area. If pointer in a rectangle area return True.
		do
			if a_rect.has_x_y (a_screen_x, a_screen_y) then
				if a_rect = internal_rectangle_left then
					--  -
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.right, a_rect.top)
					-- |
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.left, a_rect.top + a_rect.height)
					--  _
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top + a_rect.height, a_rect.left + a_rect.height, a_rect.top + a_rect.height)
					
					if internal_pointer_last_in_area /= internal_pointer_in_left_area then
						internal_shared.feedback.clear_screen
						internal_shared.feedback.draw_transparency_rectangle (internal_rectangle.left, internal_rectangle.top, (internal_rectangle.width* 0.5).ceiling, internal_rectangle.height )
						internal_pointer_last_in_area := internal_pointer_in_left_area						
					end						

				elseif a_rect = internal_rectangle_right then
					-- -
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.right, a_rect.top)
					--  |
					internal_shared.feedback.draw_line (a_rect.right, a_rect.top, a_rect.right, a_rect.top + a_rect.height)
					-- _
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top + a_rect.height, a_rect.left + a_rect.height, a_rect.top + a_rect.height)
					
					if internal_pointer_last_in_area /= internal_pointer_in_right_area then
						internal_shared.feedback.clear_screen
						internal_shared.feedback.draw_transparency_rectangle (internal_rectangle.right - (internal_rectangle.width * 0.5).ceiling, internal_rectangle.top, (internal_rectangle.width* 0.5).ceiling, internal_rectangle.height )
						internal_pointer_last_in_area := internal_pointer_in_right_area						
					end			
			
				elseif a_rect = internal_rectangle_top then
					-- |
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.left, a_rect.bottom)
					--  -
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.right, a_rect.top)
					--   |
					internal_shared.feedback.draw_line (a_rect.right, a_rect.top, a_rect.right, a_rect.bottom)
					
					if internal_pointer_last_in_area /= internal_pointer_in_top_area then
						internal_shared.feedback.clear_screen
						internal_shared.feedback.draw_transparency_rectangle (internal_rectangle .left, internal_rectangle.top, internal_rectangle.width, (internal_rectangle.height * 0.5).ceiling)
						internal_pointer_last_in_area := internal_pointer_in_top_area						
					end
					
				elseif a_rect = internal_rectangle_bottom then
					-- |
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.left, a_rect.bottom)
					--  _
					internal_shared.feedback.draw_line (a_rect.left, a_rect.bottom, a_rect.right, a_rect.bottom)
					--   |
					internal_shared.feedback.draw_line (a_rect.right, a_rect.top, a_rect.right, a_rect.bottom)
					
					if internal_pointer_last_in_area /= internal_pointer_in_bottom_area then
						internal_shared.feedback.clear_screen
						internal_shared.feedback.draw_transparency_rectangle (internal_rectangle .left, internal_rectangle.bottom - (internal_rectangle.height * 0.5).ceiling, internal_rectangle.width, (internal_rectangle.height * 0.5).ceiling)
						internal_pointer_last_in_area := internal_pointer_in_bottom_area						
					end
				elseif a_rect = internal_rectangle_center then
					-- |
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.left, a_rect.bottom)
					--  -
					internal_shared.feedback.draw_line (a_rect.left, a_rect.top, a_rect.right, a_rect.top)
					--   |
					internal_shared.feedback.draw_line (a_rect.right, a_rect.top, a_rect.right, a_rect.bottom)
					--  _
					internal_shared.feedback.draw_line (a_rect.left, a_rect.bottom, a_rect.right, a_rect.bottom)
				end
				drawn := True
			end			
		end
		
	drawn: BOOLEAN 
			-- If alreay drawn the feedback rectangle which represent the window area.
	draw_drag_window_indicator is
			-- Draw dragged window feedback which represent window position.
		do
--			create l_pic.make_with_pixmap (a_pixmap)
			internal_shared.feedback.draw_pixmap (internal_rectangle.left + internal_rectangle.width // 2 - internal_shared.icons.arrow_indicator_center.width // 2,
			 internal_rectangle.top + internal_rectangle.height // 2 - internal_shared.icons.arrow_indicator_center.height // 2,
			  internal_shared.icons.arrow_indicator_center)
		end
	
	has_x_y (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- 
		do
			Result := internal_rectangle.has_x_y (a_screen_x, a_screen_y)
		end
		
feature {NONE} -- Access

	set_rectangle (a_rect: like internal_rectangle) is
			-- Set the rectangle which allow user to dock.
		require
			a_rect_not_void: a_rect /= Void
		do
			internal_rectangle := a_rect
			
			-- Calculate five rectangle area where allow user to dock a window in this zone.
			create internal_rectangle_left.make (internal_rectangle.left + internal_rectangle.width // 2 - pixmap_center_width // 2 - pixmap_corner_width, internal_rectangle.top + internal_rectangle.height // 2 - pixmap_corner_width // 2, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_right.make (internal_rectangle_left.left + pixmap_corner_width + pixmap_center_width - 1, internal_rectangle_left.top, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_top.make (internal_rectangle_left.left + pixmap_corner_width - 2, internal_rectangle_left.top - pixmap_corner_width + 1, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_bottom.make (internal_rectangle_left.left + pixmap_corner_width - 2, internal_rectangle_left.top + pixmap_corner_width - 2, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_center.make (internal_rectangle_left.right, internal_rectangle_top.bottom, internal_rectangle_right.left - internal_rectangle_left.right, internal_rectangle_bottom.top - internal_rectangle_top.bottom)
			
		ensure
			a_rect_set: a_rect = internal_rectangle
		end

feature {NONE} -- Implementation
	
			
	pixmap_center_width: INTEGER is 27
			-- The width and height of the area in the center figure area.
	pixmap_corner_width: INTEGER is 30
			-- The width and height of the area in the four corner figure areas.
	
	internal_rectangle: EV_RECTANGLE
			-- The rectangle which allow user to dock.
			
	internal_rectangle_left, internal_rectangle_right, internal_rectangle_top, internal_rectangle_bottom, internal_rectangle_center: EV_RECTANGLE
			-- The five rectangle areas which allow user dock a window in this zone.
	
end
