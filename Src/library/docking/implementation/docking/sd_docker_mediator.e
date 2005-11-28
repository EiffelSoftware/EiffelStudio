indexing
	description: "Manager that control SD_DOCKER_SOURCE(s) and SD_HOT_ZONE(s)."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKER_MEDIATOR

create
	make

feature -- Initlization

	make (a_caller: like internal_caller) is
			-- Creation method
		require
			a_caller_not_void: a_caller /= Void
		do
			create internal_shared
			internal_shared.docking_manager.recover_normal_state
			internal_shared.hot_zone_factory.set_docker_mediator (Current)
			create hot_zones
			internal_caller := a_caller
		ensure
			set: internal_caller = a_caller
		end

feature -- Query

	content: SD_CONTENT is
			-- Content which is dragged by user.
		do
			Result := internal_caller.content
		ensure
			not_void: Result /= Void
		end

	capture_enabled: like tracing is
			-- If tracing pointer motion?
		do
			Result := tracing
		end

feature -- Hanlde pointer events

	start_tracing_pointer (a_offset_x, a_offset_y: INTEGER) is
			-- Begin to trace mouss positions.
		do
			tracing := True
			generate_hot_zones
			offset_x := a_offset_x
			offset_y := a_offset_y
		ensure
			set: offset_x = a_offset_x and offset_y = a_offset_y
		end

	end_tracing_pointer (a_screen_x, a_screen_y: INTEGER) is
			-- Stop tracing mouse positions.
		local
			changed: BOOLEAN
			l_floating_zone: SD_FLOATING_ZONE
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

			l_floating_zone ?= internal_caller
			if not changed and l_floating_zone /= Void then
				l_floating_zone.set_position (a_screen_x - offset_x, a_screen_y - offset_y)
				debug ("larry")
					io.put_string ("%N SD_DOCKER_MEDIATOR not changed and set floating position")
				end
			end
			internal_shared.feedback.clear_screen
		ensure
			not_tracing: tracing = False
		end

	is_tracing_pointer: BOOLEAN is
			-- If `Current' tracing pointer motion?
		do
			Result := tracing
		end

	on_pointer_motion (a_screen_x, a_screen_y: INTEGER) is
			-- When user dragging something for docking, show hot zone which allow to dock.
		local
			l_drawed: BOOLEAN
		do
			screen_x := a_screen_x
			screen_y := a_screen_y
--			feedback.clear_screen
			notify_outside_pointer_zone (a_screen_x, a_screen_y)
			from
				hot_zones.start
			until
				hot_zones.after or l_drawed
			loop
				l_drawed := hot_zones.item.update_for_pointer_position (Current, a_screen_x, a_screen_y)

				hot_zones.forth
			end
		end

	screen_x, screen_y: INTEGER
			-- Current pointer position.

feature {SD_HOT_ZONE} -- Hot zone infos.

	drag_window_width: INTEGER is
			-- Width of dragged window.
		local
			l_widget: EV_WIDGET
		do
			l_widget ?= internal_caller
			check caller_is_widget: l_widget /= Void end
			Result := l_widget.width
		end

	drag_window_height: INTEGER is
			-- Height of dragged window.
		local
			l_widget: EV_WIDGET
		do
			l_widget ?= internal_caller
			check caller_is_widget: l_widget /= Void end
			Result := l_widget.height
		end

	offset_x: INTEGER
			-- Offset x of `internal_caller' when user start dragging.

	offset_y: INTEGER
			-- Offset y of `internal_caller' when user start dragging.

feature {NONE} -- Implementation functions

	generate_hot_zones is
			-- Generate all hot zones which allow user to dock.
		local
			l_zone_list: ARRAYED_LIST [SD_ZONE]
		do
			l_zone_list := internal_shared.docking_manager.zones

			create hot_zones
			generate_hot_zones_imp (l_zone_list)
			debug ("larry")
				io.put_string ("%N SD_DOCKER_MEDIATOR hot_zone_main.type." + internal_shared.hot_zone_factory.hot_zone_main.type.out + " internal_caller.type " + internal_caller.type.out)
			end
			if internal_shared.hot_zone_factory.hot_zone_main.type = internal_caller.type  then
				hot_zones.extend (internal_shared.hot_zone_factory.hot_zone_main)
				debug ("larry")
					io.put_string ("%N SD_DOCKER_MEDIATOR hot zone main added.")
				end
			end
		ensure
			hot_zones_created: hot_zones /= Void
		end

	generate_hot_zones_imp (a_list: ARRAYED_LIST [SD_ZONE]) is
			-- Generate all the hot zones for the windows.
		require
			a_list_not_void: a_list /= Void
		local
			l_hot_zone_source: SD_DOCKER_SOURCE
			l_mutli_zone: SD_TAB_ZONE
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
					if l_mutli_zone /= Void and then not l_mutli_zone.is_drag_title_bar then
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
		require
			a_zone_not_void: a_zone /= Void
			a_source_not_void: a_source /= Void
		local
			l_floating_zone: SD_FLOATING_ZONE
		do
			l_floating_zone ?= a_zone
			if l_floating_zone = Void then
				if a_zone.type = internal_caller.type then
					a_source.add_hot_zones (Current, hot_zones)
				end
			end
		end

	notify_outside_pointer_zone (a_screen_x, a_screen_y: INTEGER) is
			-- Notify all zones in `hot_zones' except `a_zone' has pointer position.
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

feature {NONE} -- Implementation attributes

	tracing: BOOLEAN
			-- Whether is tracing pointer events.

	internal_caller: SD_ZONE
			-- Zone which call this mediator.

	hot_zones: ACTIVE_LIST [SD_HOT_ZONE]
			-- Hot zones.

	internal_shared: SD_SHARED
			-- All singletons.

	last_hot_zone: SD_HOT_ZONE
			-- When moving cursor, last SD_HOT_ZONE where pointer in.

invariant

	internal_shared_not_void: internal_shared /= Void
	hot_zones_not_void: hot_zones /= Void

end
