indexing
	description: "Objects that control SD_DOCKER_SOURCE(s) and SD_HOT_ZONE(s)."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKER_MEDIATOR

create
	make

feature -- Initlization
	
	make (a_caller: like internal_caller) is
			-- Creation method
		do
			create internal_shared
			create hot_zones.make (1)	
--			internal_drag_window_width := a_window_width
--			internal_drag_window_height := a_window_height		
			internal_caller := a_caller
		ensure

		end

feature -- Access

	content: like internal_content is
			-- Get current content which is dragged by user.
		do
			Result := internal_caller.content
		end
	
	capture_enabled: like tracing is
			-- If current tracing pointer motion?
		do
			Result := tracing
		end
		
	generate_hot_zones is
			-- Generate all the hot zones which allow user to dock.
		local
			l_zone_list: ARRAYED_LIST [SD_ZONE]
		do
			l_zone_list := internal_shared.docking_manager.zones
			create hot_zones.make (1)
			generate_hot_zones_imp (l_zone_list)
			if internal_shared.hot_zone_factory.hot_zone_main.type = internal_caller.content.type  then
				hot_zones.extend (internal_shared.hot_zone_factory.hot_zone_main)
			end
			
		end	

feature -- Tracing pointer events
	
	start_tracing_pointer (a_offset_x, a_offset_y: INTEGER) is
			-- Begin to trace mouss positions.
		do
			tracing := True
			generate_hot_zones
			internal_offset_x := a_offset_x
			internal_offset_y := a_offset_y
		end
	
	end_tracing_pointer (a_screen_x, a_screen_y: INTEGER) is
			-- Stop tracing mouse positions.
		local
			changed: BOOLEAN
		do
--			feedback.clear_screen
			tracing := False
			
			from 
				hot_zones.start
			until
				hot_zones.after or changed
			loop
					changed := hot_zones.item.apply_change (a_screen_x, a_screen_y, internal_caller)					
				hot_zones.forth
			end
			
			internal_shared.feedback.clear_screen
		end
		
feature -- Hanlde pointer events

	-- There is no pointer press events, because the caller response for this.
	
	handle_pointer_motion (a_screen_x, a_screen_y: INTEGER) is
			-- When user dragging something for docking, show hot zone which allow to dock.
		local
			l_drawed: BOOLEAN
			l_hot_zone: SD_HOT_ZONE
		do
--			feedback.clear_screen
			notify_outside_pointer_zone (a_screen_x, a_screen_y)
			debug ("larry")
				io.put_string ("%N in docker mediator. handle_pointer_motion. caller_type: " + internal_caller.content.type.out)
			end
			from 
				hot_zones.start
			until
				hot_zones.after or l_drawed
			loop
				l_drawed := hot_zones.item.update_for_pointer_position (Current, a_screen_x, a_screen_y)					

				hot_zones.forth
			end	
			
			
--			hot_zones.finish
--			if l_hot_zone /= hot_zones.item then
				l_drawed := hot_zones.item.update_for_pointer_position (Current, a_screen_x, a_screen_y)
--			end
			
		end
	

	
feature {SD_HOT_ZONE} 
	
	drag_window_width: INTEGER is
			-- The width of dragged window.
		local
			l_widget: EV_WIDGET
		do
			l_widget ?= internal_caller
			check l_widget /= Void end
			Result := l_widget.width
		end
		
	drag_window_height: INTEGER is
			-- The height of dragged window.
		local
			l_widget: EV_WIDGET
		do
			l_widget ?= internal_caller
			check l_widget /= Void end
			Result := l_widget.height
		end
	
	offset_x: INTEGER is
			-- The offset to the dragged window when user start dragging. Used for draw window feedback.
		do
			Result := internal_offset_x
		end
			
	offset_y: INTEGER is
			-- The offset to the dragged window when user start dragging. Used for draw window feedback.
		do
			Result := internal_offset_y
		end
		
feature {NONE} -- Implementation
	

	
--	internal_drag_window_width, internal_drag_window_height: INTEGER
--			-- The width and height of dragged window.
	
	internal_offset_x, internal_offset_y: INTEGER
			-- The offset to the dragged window when user start dragging. Used for draw window feedback.
			
	internal_content: SD_CONTENT
			-- The content current is dragged by user.
	
	tracing: BOOLEAN
			-- Whether is tracing pointer events.

	internal_caller: SD_ZONE
			-- The zone which call this mediator.
	
	hot_zones: SD_ARRAYED_LIST [SD_HOT_ZONE]
			-- The hot zone collctions.
			
	internal_shared: SD_SHARED
			-- All singletons
		
	generate_hot_zones_imp (a_list: ARRAYED_LIST [SD_ZONE]) is
			-- Generate all the hot zones for the windows.
		require
			a_list_not_void: a_list /= Void
		local
			l_hot_zone_source: SD_DOCKER_SOURCE
			l_mutli_zone: SD_MULTI_CONTENT_ZONE
		do
			from 
				a_list.start
			until
				a_list.after
			loop
				l_hot_zone_source ?= a_list.item
				-- Ingore the classes we don't care.
				if l_hot_zone_source /= Void then
					l_mutli_zone ?= a_list.item
					if l_mutli_zone /= Void then
						add_hot_zone_on_type (a_list.item, l_hot_zone_source)
					elseif a_list.item /= internal_caller then
						add_hot_zone_on_type (a_list.item, l_hot_zone_source)			
					end
				end
				a_list.forth
			end
		end
	
	add_hot_zone_on_type (a_zone: SD_ZONE; a_source: SD_DOCKER_SOURCE)is
			-- 
		do
			if a_zone.content.type = internal_caller.content.type then
				a_source.add_hot_zones (Current, hot_zones)
			end
		end
	
	notify_outside_pointer_zone (a_screen_x, a_screen_y: INTEGER) is
			-- Notify all zones in `hot_zones' except `a_zone' for pointer out.
		local
			l_hot_zone_in: SD_HOT_ZONE
		do
			from 
				hot_zones.start
			until
				hot_zones.after or l_hot_zone_in /= Void
			loop
				if hot_zones.item.has_x_y (a_screen_x, a_screen_y) then
					l_hot_zone_in := hot_zones.item
				end
				hot_zones.forth
			end
			
			
			from 
				hot_zones.start
			until
				hot_zones.after
			loop
				if hot_zones.item /= l_hot_zone_in then
					hot_zones.item.pointer_out
				end
				hot_zones.forth
			end
		end	
		
	last_hot_zone: SD_HOT_ZONE
		-- When moving cursor, last SD_HOT_ZONE where cursor in.
end
