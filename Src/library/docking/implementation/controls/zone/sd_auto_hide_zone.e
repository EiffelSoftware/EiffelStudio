indexing
	description: "Objects that is the zone when docking at a SD_AUTO_HIDE_PANEL"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_AUTO_HIDE_ZONE

inherit
	SD_HOR_VER_BOX
	SD_SINGLE_CONTENT_ZONE
		undefine
			copy, is_equal, default_create	
		end
	SD_RESIZE_SOURCE
		undefine
			copy, is_equal, default_create	
		end

create
	make

feature	{NONE} -- Initlization

	make (a_content: SD_CONTENT; a_dock_position: INTEGER) is
			-- Creation method. for_dock use enumeration in SD_STATE.
		require
			a_content_not_void: a_content /= Void
--			for_dock_valid: for_dock_valid (for_dock)
		do
			create internal_shared
			if a_dock_position = {SD_SHARED}.dock_left or a_dock_position = {SD_SHARED}.dock_right then
				init (False)
			else
				init (True)
			end
			
			dock_position := a_dock_position
			create window.make (a_content.type, Current)
			internal_content := a_content
			window.set_user_widget (internal_content.user_widget)
			window.title_bar.set_title (internal_content.title)
			window.close_actions.extend (agent close_window)
			window.stick_actions.extend (agent stick_window)

			create resize_bar.make (a_dock_position, Current)
			
			if a_dock_position = {SD_SHARED}.dock_left or a_dock_position = {SD_SHARED}.dock_top then
				extend (window)
				extend (resize_bar)
			elseif a_dock_position = {SD_SHARED}.dock_right or a_dock_position = {SD_SHARED}.dock_bottom then
				extend (resize_bar)	
				extend (window)
			end			
			disable_item_expand (resize_bar)
			
			-- The minimum width is the width of two buttons on the title bar.
			content.user_widget.set_minimum_size (internal_shared.icons.stick.width * 3, internal_shared.icons.stick.height)
--			set_minimum_size (icons.stick.width * 3, icons.stick.height)

			init_focus_in (Current)
		end

feature {NONE} -- Implementation
	
	dock_position: INTEGER 
			-- One enumeration from SD_STATE
			
	close_window is
			-- When user clicked the close button.
		do
			internal_content.state.close_window
		end
		
	stick_window is
			-- When user clicked the stick button.
		do
			internal_content.state.stick_window (content.state.direction)
		end
	
	drag_window is
			-- When user drag the window.
		do
--			internal_content.state.drag_window
		end
		
		
	resize_bar: SD_RESIZE_BAR
			-- The resize bar at the side.
	
	window: SD_WINDOW
			-- The window.

	start_resize_operation (a_bar: SD_RESIZE_BAR; a_screen_boundary: EV_RECTANGLE) is
			-- Start resize operation.
		do
				-- Set the area which allow user to resize the window.
				if dock_position = {SD_SHARED}.dock_left then
					a_screen_boundary.set_right (internal_shared.docking_manager.container_rectangle_screen.right)				
					a_screen_boundary.set_left (window.screen_x + minimum_width)
				elseif dock_position = {SD_SHARED}.dock_right then
					a_screen_boundary.set_right (window.screen_x + window.width - minimum_width)										
					a_screen_boundary.set_left (internal_shared.docking_manager.container_rectangle_screen.left)
				elseif dock_position = {SD_SHARED}.dock_top then
					a_screen_boundary.set_bottom (internal_shared.docking_manager.container_rectangle_screen.bottom)
					a_screen_boundary.set_top (window.screen_y + minimum_height)
				elseif dock_position = {SD_SHARED}.dock_bottom then
					a_screen_boundary.set_bottom (window.screen_y - minimum_height)
					a_screen_boundary.set_top (internal_shared.docking_manager.container_rectangle_screen.top)					
				end

				debug ("larry") 
					io.put_string ("%N allow resize area is: " + a_screen_boundary.out)
				end
		end
		
	end_resize_operation (a_bar: SD_RESIZE_BAR; a_delta: INTEGER) is
			-- End resize operaion.
		do
			disable_item_expand (resize_bar)
			
			if dock_position = {SD_SHARED}.dock_left or dock_position = {SD_SHARED}.dock_right then
				
				internal_shared.docking_manager.set_zone_size (Current, width + a_delta, height)
			
				if a_bar.direction = {SD_SHARED}.dock_right then
					internal_shared.docking_manager.internal_fixed.set_item_position (Current, x_position - a_delta, y_position)
				end
			else
				debug ("larry")
					io.put_string ("%N SD_AUTO_HIDE_ZONE before set zone height: " + height.out + " " + ($Current).out)
				end
				internal_shared.docking_manager.set_zone_size (Current, width, height + a_delta)
				debug ("larry")
					io.put_string ("%N SD_AUTO_HIDE_ZONE after set zone height: " + height.out)
				end
				if a_bar.direction = {SD_SHARED}.dock_bottom then
					internal_shared.docking_manager.internal_fixed.set_item_position (Current, x_position, y_position - a_delta)
				end				
			end

		end
	
feature {NONE} -- For user docking

	handle_focus_in is
			-- 
		do
			internal_shared.docking_manager.disable_all_zones_focus_color
			window.title_bar.enable_focus_color
		end
		
	handle_zone_focus_out is
			-- 
		do
			window.title_bar.disable_focus_color
		end
	
end
