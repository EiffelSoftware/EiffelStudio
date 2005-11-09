indexing
	description: "Objects that control SD_MENU_ZONEs when user drag a SD_MENU_ZONE."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_DOCKER_MEDIATOR

create
	make

feature {NONE} -- Initialization

	make (a_caller: SD_MENU_ZONE) is
			-- Creation method
		require
			a_caller_not_void: a_caller /= Void
		do
			create internal_shared
			internal_menus := internal_shared.docking_manager.menu_manager.menus
			
			internal_caller := a_caller
			
			create internal_top_manager.make (internal_shared.docking_manager.menu_container.top, False, Current)
			create internal_bottom_manager.make (internal_shared.docking_manager.menu_container.bottom, False, Current)
			create internal_left_manager.make (internal_shared.docking_manager.menu_container.left, True, Current)
			create internal_right_manager.make (internal_shared.docking_manager.menu_container.right, True, Current)
			
			internal_top_manager.start_drag 
			internal_bottom_manager.start_drag 
			internal_left_manager.start_drag
			internal_right_manager.start_drag
			
			if a_caller.is_floating then
				internal_last_floating := True
			end

		ensure
			a_caller_set: a_caller = internal_caller
		end

feature -- Basic operations
		
	on_pointer_motion (a_screen_x, a_screen_y: INTEGER) is
			-- Handle user drag menu events.
		local
			l_in_four_side: BOOLEAN
--			l_floating_menu: SD_FLOATING_MENU_ZONE
		do
				
			l_in_four_side := on_motion_in_four_side (a_screen_x, a_screen_y)

			if not l_in_four_side then
				
				if not internal_last_floating then
					caller.float			
				end

				internal_last_floating := True
				caller.set_position (a_screen_x, a_screen_y)
			
			else
				internal_last_floating := False
			end
					
		end

	apply_change (a_screen_x, a_screen_y: INTEGER) is
			-- 
		local
--			l_menu_container: EV_BOX
		do
			notify_row (internal_shared.docking_manager.menu_container.top)
			notify_row (internal_shared.docking_manager.menu_container.bottom)
			notify_row (internal_shared.docking_manager.menu_container.left)
			notify_row (internal_shared.docking_manager.menu_container.right)
		end
	
feature -- Access

	caller: like internal_caller is
			-- 
		do
			Result := internal_caller
		ensure
			not_void: Result /= Void
		end
		
feature {NONE} -- Implementation
	
	internal_last_floating: BOOLEAN
			-- 
				
	on_motion_in_four_side (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- 
		local
			l_changed: BOOLEAN
		do
			if internal_left_manager.area_managed.has_x_y (a_screen_x, a_screen_y) then
				l_changed := internal_left_manager.on_pointer_motion (a_screen_x)
				Result := True
			elseif internal_right_manager.area_managed.has_x_y (a_screen_x, a_screen_y)	then
				l_changed := internal_right_manager.on_pointer_motion (a_screen_x)
				Result := True
			elseif internal_top_manager.area_managed.has_x_y (a_screen_x, a_screen_y)  then
				l_changed := internal_top_manager.on_pointer_motion (a_screen_y)
				Result := True
			elseif internal_bottom_manager.area_managed.has_x_y (a_screen_x, a_screen_y) then
				l_changed := internal_bottom_manager.on_pointer_motion (a_screen_y)
				Result := True
			end		
			if Result then
				if not internal_caller.row.is_vertical then
					internal_caller.row.set_item_position (internal_caller, a_screen_x)			
				else
					internal_caller.row.set_item_position (internal_caller, a_screen_y)
				end				
			end	
			debug ("larry")
				internal_shared.feedback.draw_red_rectangle (internal_top_manager.area_managed.left, internal_top_manager.area_managed.top, internal_top_manager.area_managed.width, internal_top_manager.area_managed.height)
				internal_shared.feedback.draw_red_rectangle (internal_bottom_manager.area_managed.left, internal_bottom_manager.area_managed.top, internal_bottom_manager.area_managed.width, internal_bottom_manager.area_managed.height)
				
				internal_shared.feedback.draw_red_rectangle (internal_left_manager.area_managed.left, internal_left_manager.area_managed.top, internal_left_manager.area_managed.width, internal_left_manager.area_managed.height)
				internal_shared.feedback.draw_red_rectangle (internal_right_manager.area_managed.left, internal_right_manager.area_managed.top, internal_right_manager.area_managed.width, internal_right_manager.area_managed.height)
			end	
			
		end
		
	notify_row (a_box: EV_BOX) is
			-- 
		local
			l_menu_row: SD_MENU_ROW
		do
			from 
				a_box.start
			until
				a_box.after
			loop
				l_menu_row ?= a_box.item
				check l_menu_row /= Void end
				l_menu_row.apply_change
				a_box.forth
			end			
		end
		
	internal_menus: ARRAYED_LIST [SD_MENU_ZONE]
			-- All SD_MENU_ZONEs in current system
	internal_shared: SD_SHARED
			-- All singletons
	internal_caller: SD_MENU_ZONE
			-- Caller
	
	internal_top_manager, internal_bottom_manager, internal_left_manager, internal_right_manager: SD_MENU_AREA_MANAGER

end
